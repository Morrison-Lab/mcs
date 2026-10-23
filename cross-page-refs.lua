-- Turn a cross-reference to a div on another page into a link to that page.
--
-- Quarto resolves `@def-foo` only when `#def-foo` is on the page being
-- rendered; on a website it renders any other `@def-foo` as "?@def-foo".
-- The shared definitions included from the `mds` submodule cite each other
-- this way (`_def-quantifier.qmd` cites @def-predicate), and a chapter that
-- includes one definition rarely includes the definitions it cites.
--
-- This filter runs before Quarto's own cross-reference filter. It indexes
-- the ids that every rendered page of the site defines, following includes,
-- and replaces a citation of an id that is not on the current page, but is
-- on another page, with a link such as "Definition: Predicate". Citations of
-- ids on the current page, and of bibliography keys, are left to Quarto.
--
-- The mds definitions also link to each other as `[text](#def-foo)`, and to
-- other mds pages as `[text](number-systems.qmd#def-foo)`. Those links break
-- here too, so the filter points each at the page of this site that defines
-- the id. An id that no page here defines, cited or linked, goes to the
-- published mds page that defines it, which the filter finds by indexing the
-- mds pages the same way.

local path = pandoc.path

local PREFIXES = {
  def = "Definition",
  thm = "Theorem",
  lem = "Lemma",
  cor = "Corollary",
  prp = "Proposition",
  cnj = "Conjecture",
  exm = "Example",
  exr = "Exercise",
  rem = "Remark",
  sol = "Solution",
  sec = "Section",
  fig = "Figure",
  tbl = "Table",
}

local function warn(message)
  quarto.log.warning("cross-page-refs: " .. message)
end

local function read_file(file)
  local f = io.open(file, "r")
  if not f then
    return nil
  end
  local text = f:read("a")
  f:close()
  return text
end

local function exists(file)
  local f = io.open(file, "r")
  if f then
    f:close()
  end
  return f ~= nil
end

-- Record each id that `file` defines, with its title, as found on `page`.
-- Includes are followed relative to the file that holds them, or else
-- relative to the page, which is how the mds pages write theirs
-- (`mds/_subfiles/...`, through mds's `mds -> .` link).
local function scan(file, page, found, seen, page_dir)
  page_dir = page_dir or path.directory(file)
  if seen[file] then
    return
  end
  seen[file] = true
  local text = read_file(file)
  if not text then
    warn("cannot read " .. file .. ", included from " .. page
      .. "; is a submodule missing?")
    return
  end
  -- A commented-out include, such as an outtake, is not on the page.
  text = text:gsub("<!%-%-.-%-%->", "")
  local here = path.directory(file)
  local lines = {}
  for line in (text .. "\n"):gmatch("(.-)\n") do
    table.insert(lines, line)
  end
  for i, line in ipairs(lines) do
    local include = line:match("{{<%s*include%s+(%S+)%s*>}}")
    -- The math macros define no ids, and mds's own copy is a nested
    -- submodule that a non-recursive checkout leaves empty.
    if include and not include:match("latex%-macros/") then
      local target = path.normalize(path.join({ here, include }))
      if not exists(target) then
        target = path.normalize(path.join({ page_dir, include }))
      end
      scan(target, page, found, seen, page_dir)
    end
    local id = line:match("^%s*:::+%s*{#(%a+%-[%w%-_]+)")
    local title
    if id then
      title = line:match('title="([^"]*)"')
      local nxt = lines[i + 1]
      if not title and nxt then
        title = nxt:match("^#+%s+(.-)%s*$")
      end
    else
      local text_, hid = line:match("^#+%s+(.-)%s*{#(sec%-[%w%-_]+)")
      if hid then
        id, title = hid, text_
      end
    end
    if id and not found[id] then
      found[id] = title or ""
    end
  end
end

-- The pages the website config excludes from the render, such as
-- `- "!references.qmd"`; an id on one of them has no page to link to.
local function excluded_pages(root)
  local out = {}
  local text = read_file(path.join({ root, "_quarto-website.yml" })) or ""
  for name in text:gmatch("\n%s*%-%s*[\"']?!([^\"'%s]+%.qmd)") do
    out[name] = true
  end
  return out
end

-- Index every rendered page in `dirs` under `root`. An id defined on more
-- than one page maps to all of them, so a citation can say so.
local function build_index(root, dirs)
  local index = {}
  local skip = excluded_pages(root)
  for _, dir in ipairs(dirs) do
    local full = dir == "" and root or path.join({ root, dir })
    local entries = pandoc.system.list_directory(full)
    table.sort(entries)
    for _, name in ipairs(entries) do
      local page = dir == "" and name or (dir .. "/" .. name)
      if name:match("%.qmd$") and not name:match("^_") and not skip[page] then
        local found = {}
        scan(path.normalize(path.join({ root, page })), page, found, {})
        for id, title in pairs(found) do
          index[id] = index[id] or {}
          table.insert(index[id], { page = page, title = title })
        end
      end
    end
  end
  return index
end

-- The site-url, read from the project files: a filter does not see the
-- project's `website:` keys.
local function site_url(root)
  for _, name in ipairs({ "_quarto-website.yml", "_quarto.yml" }) do
    local text = read_file(path.join({ root, name }))
    local url = text and text:match("\n%s*site%-url:%s*[\"']?([^%s\"']+)")
    if url then
      return (url:gsub("/*$", "/"))
    end
  end
  return nil
end

function Pandoc(doc)
  local root = quarto.project.directory
  local input = quarto.doc.input_file
  if not root then
    -- A single file rendered outside the project has no other pages.
    return doc
  end
  root = path.normalize(root)
  -- Pages are named with "/" in links, whatever the platform.
  local current = path.make_relative(path.normalize(input), root)
    :gsub(path.separator, "/")
  local index = build_index(root, { "", "chapters" })
  local mds_root = path.join({ root, "mds" })
  local mds_index = build_index(mds_root, { "" })
  local mds_site = site_url(mds_root)

  local here = {}
  local function note(el)
    if el.identifier and el.identifier ~= "" then
      here[el.identifier] = true
    end
  end
  doc:walk({ Div = note, Header = note, Span = note, Image = note })

  -- `here` misses theorem-type divs, which Quarto has already made custom
  -- nodes, so also ask the index whether this page has the id.
  local function on_this_page(id)
    if here[id] then
      return true
    end
    for _, p in ipairs(index[id] or {}) do
      if p.page == current then
        return true
      end
    end
    return false
  end

  -- A PDF or Word handout is read away from the site, so it links to the
  -- published page; a web page or slide deck links relatively.
  local html = FORMAT:match("html") or FORMAT:match("revealjs")
  local site = site_url(root)
  local depth = select(2, current:gsub("/", ""))

  -- The page that defines `id`, here or else in mds, and the link to it.
  -- `named` is the page a link names, such as "algebra.qmd"; mds includes
  -- one subfile on several pages, so the named page wins when it has the id.
  local function resolve(id, named)
    local pages = index[id]
    local base
    if pages then
      base = (html or not site) and string.rep("../", depth) or site
      if #pages > 1 then
        local names = {}
        for _, p in ipairs(pages) do
          table.insert(names, p.page)
        end
        warn(id .. " is defined on several pages (" .. table.concat(names, ", ")
          .. "); linking to " .. pages[1].page)
      end
    else
      pages = mds_index[id]
      base = mds_site
    end
    if not pages or not base then
      return nil
    end
    local entry = pages[1]
    for _, p in ipairs(pages) do
      if p.page == named then
        entry = p
      end
    end
    return base .. entry.page:gsub("%.qmd$", ".html") .. "#" .. id, entry
  end

  -- An mds citation is followed only for the div types the scan sees in
  -- full here too; an id such as a chunk-labelled figure on this site
  -- would otherwise be taken for an mds one of the same name.
  local function in_mds(id)
    local prefix = id:match("^(%a+)%-")
    return mds_index[id] ~= nil and prefix ~= "fig" and prefix ~= "tbl"
      and prefix ~= "sec"
  end

  return doc:walk({
    Cite = function(cite)
      local away = {}
      for _, c in ipairs(cite.citations) do
        if (index[c.id] or in_mds(c.id)) and not on_this_page(c.id) then
          table.insert(away, c.id)
        end
      end
      if #away == 0 then
        return nil
      end
      if #cite.citations ~= 1 then
        warn("cannot link " .. table.concat(away, ", ") .. " in a citation"
          .. " with several keys; cite each id on its own")
        return nil
      end
      local id = away[1]
      local href, entry = resolve(id)
      if not href then
        warn("cannot link " .. id .. ": mds has no site-url")
        return nil
      end
      local label = PREFIXES[id:match("^(%a+)%-")] or "See"
      if entry.title ~= "" then
        label = label .. ": " .. entry.title
      end
      -- A title can hold markup, such as math in "$\sqrt{2}$ is irrational",
      -- so read the label as Markdown rather than keep it as one string.
      local inlines = { pandoc.Str(label) }
      local parsed = pandoc.read(label, "markdown").blocks[1]
      if parsed and parsed.content then
        inlines = parsed.content
      end
      return pandoc.Link(inlines, href)
    end,

    -- A link to `#id` that this page lacks, or to `page.qmd#id` where
    -- `page.qmd` does not exist beside the current page: in practice both
    -- come from mds text included here. An unresolved `#id` is left alone
    -- without a warning, since the scan does not see every kind of anchor
    -- (`#refs`, a chunk label).
    Link = function(link)
      local file, id = link.target:match("^([^#]*)#(.+)$")
      if not id then
        return nil
      end
      if file == "" then
        if on_this_page(id) then
          return nil
        end
      elseif not file:match("%.qmd$") or file:match("^%a+:") then
        return nil
      else
        local dir = path.directory(path.join({ root, current }))
        if exists(path.join({ dir, file })) then
          return nil
        end
      end
      local href = resolve(id, file ~= "" and file or nil)
      if not href then
        if file ~= "" then
          warn("cannot resolve the link to " .. link.target
            .. " on any page of this site or of mds")
        end
        return nil
      end
      link.target = href
      return link
    end,
  })
end
