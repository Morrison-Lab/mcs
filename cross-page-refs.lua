-- Turn a cross-reference to a div on another page into a link to that page.
--
-- Quarto resolves `@def-foo` only when `#def-foo` is on the page being
-- rendered; on a website it renders any other `@def-foo` as "?@def-foo".
-- The shared definitions included from the `mds` submodule cite each other
-- this way (`_def-quantifier.qmd` cites @def-predicate), and a chapter that
-- includes one definition rarely includes the definitions it cites.
--
-- This filter runs before Quarto's own cross-reference filter. It indexes
-- the ids that every page of the site defines, following includes, and
-- replaces a citation of an id that is not on the current page, but is on
-- another page, with a link such as "Definition: Predicate". Citations of
-- ids on the current page, and of bibliography keys, are left to Quarto.

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
  eq = "Equation",
}

local function read_file(path)
  local f = io.open(path, "r")
  if not f then
    return nil
  end
  local text = f:read("a")
  f:close()
  return text
end

local function dirname(path)
  return path:match("^(.*)/[^/]*$") or "."
end

-- Collapse "a/b/../c" to "a/c", so paths compare equal.
-- A leading "/" is kept, so an absolute path stays absolute.
local function normalize(path)
  local parts = {}
  for part in path:gmatch("[^/]+") do
    if part == ".." and #parts > 0 and parts[#parts] ~= ".." then
      table.remove(parts)
    elseif part ~= "." then
      table.insert(parts, part)
    end
  end
  local lead = path:sub(1, 1) == "/" and "/" or ""
  return lead .. table.concat(parts, "/")
end

-- Record each id that `text` defines, with its title, as found on `page`.
-- Includes are followed relative to the file that holds them.
local function scan(path, page, index, seen)
  if seen[path] then
    return
  end
  seen[path] = true
  local text = read_file(path)
  if not text then
    return
  end
  -- A commented-out include, such as an outtake, is not on the page.
  text = text:gsub("<!%-%-.-%-%->", "")
  local here = dirname(path)
  local lines = {}
  for line in (text .. "\n"):gmatch("(.-)\n") do
    table.insert(lines, line)
  end
  for i, line in ipairs(lines) do
    local include = line:match("{{<%s*include%s+(%S+)%s*>}}")
    if include then
      scan(normalize(here .. "/" .. include), page, index, seen)
    end
    local id = line:match("^%s*:::+%s*{#([%a]+%-[%w%-_]+)")
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
    if id and index[id] == nil then
      index[id] = { page = page, title = title }
    end
  end
end

-- Index every page the site renders: the root pages and chapters/.
local function build_index(root)
  local index = {}
  for _, dir in ipairs({ "", "chapters" }) do
    local full = dir == "" and root or (root .. "/" .. dir)
    local ok, entries = pcall(pandoc.system.list_directory, full)
    if ok then
      for _, name in ipairs(entries) do
        if name:match("%.qmd$") and not name:match("^_") then
          local page = dir == "" and name or (dir .. "/" .. name)
          scan(normalize(root .. "/" .. page), page, index, {})
        end
      end
    end
  end
  return index
end

-- A relative path from the directory of page `from` to page `to`, both
-- given relative to the project root.
local function relative(from, to)
  local depth = select(2, from:gsub("/", ""))
  return string.rep("../", depth) .. to
end

function Pandoc(doc)
  local root = quarto and quarto.project and quarto.project.directory
  local input = quarto and quarto.doc and quarto.doc.input_file
  if not root or not input then
    return doc
  end
  root = normalize(root)
  local current = normalize(input):sub(#root + 2)
  local index = build_index(root)

  local here = {}
  local function note(el)
    if el.identifier and el.identifier ~= "" then
      here[el.identifier] = true
    end
  end
  doc:walk({ Div = note, Header = note, Span = note, Image = note })

  local html = FORMAT:match("html") or FORMAT:match("revealjs")
  -- A PDF or Word handout is read away from the site, so it links to the
  -- published page. A filter does not see the project's `website:` keys,
  -- so read `site-url` from the project files.
  local site
  for _, name in ipairs({ "_quarto-website.yml", "_quarto.yml" }) do
    local text = read_file(root .. "/" .. name)
    site = site or (text and text:match("\n%s*site%-url:%s*[\"']?([^%s\"']+)"))
  end
  site = site and site:gsub("/*$", "/") or nil

  return doc:walk({
    Cite = function(cite)
      if #cite.citations ~= 1 then
        return nil
      end
      local id = cite.citations[1].id
      local entry = index[id]
      if here[id] or not entry or entry.page == current then
        return nil
      end
      local page_html = entry.page:gsub("%.qmd$", ".html")
      local href
      if html or not site then
        href = relative(current, page_html) .. "#" .. id
      else
        href = site .. page_html .. "#" .. id
      end
      local prefix = PREFIXES[id:match("^(%a+)%-")] or "See"
      local label = prefix
      if entry.title and entry.title ~= "" then
        label = prefix .. ": " .. entry.title
      end
      return pandoc.Link({ pandoc.Str(label) }, href)
    end,
  })
end
