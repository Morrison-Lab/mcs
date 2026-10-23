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

-- Record each id that `file` defines, with its title, as found on `page`.
-- Includes are followed relative to the file that holds them.
local function scan(file, page, found, seen)
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
    if include then
      scan(path.normalize(path.join({ here, include })), page, found, seen)
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

-- Index every rendered page: the root pages and chapters/. An id defined on
-- more than one page maps to all of them, so a citation can say so.
local function build_index(root)
  local index = {}
  local skip = excluded_pages(root)
  for _, dir in ipairs({ "", "chapters" }) do
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
  local index = build_index(root)

  local here = {}
  local function note(el)
    if el.identifier and el.identifier ~= "" then
      here[el.identifier] = true
    end
  end
  doc:walk({ Div = note, Header = note, Span = note, Image = note })

  -- A PDF or Word handout is read away from the site, so it links to the
  -- published page; a web page or slide deck links relatively.
  local html = FORMAT:match("html") or FORMAT:match("revealjs")
  local site = site_url(root)
  local depth = select(2, current:gsub("/", ""))

  return doc:walk({
    Cite = function(cite)
      local away = {}
      for _, c in ipairs(cite.citations) do
        local pages = index[c.id]
        -- `here` misses theorem-type divs, which Quarto has already made
        -- custom nodes, so also ask the index whether this page has the id.
        local on_this_page = here[c.id]
        for _, p in ipairs(pages or {}) do
          on_this_page = on_this_page or p.page == current
        end
        if pages and not on_this_page then
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
      local pages = index[id]
      if #pages > 1 then
        local names = {}
        for _, p in ipairs(pages) do
          table.insert(names, p.page)
        end
        warn(id .. " is defined on several pages (" .. table.concat(names, ", ")
          .. "); linking to " .. pages[1].page)
      end
      local entry = pages[1]
      local page_html = entry.page:gsub("%.qmd$", ".html")
      local href
      if html or not site then
        href = string.rep("../", depth) .. page_html .. "#" .. id
      else
        href = site .. page_html .. "#" .. id
      end
      local label = PREFIXES[id:match("^(%a+)%-")] or "See"
      if entry.title ~= "" then
        label = label .. ": " .. entry.title
      end
      return pandoc.Link({ pandoc.Str(label) }, href)
    end,
  })
end
