--[[
rainbow-parens filter: color matching brackets by nesting depth in HTML output.

The filter only attaches a script and a stylesheet to HTML pages; the
coloring happens in the browser, in two places:

- math: a MathJax render action colors each ( [ { and its partner after
  MathJax parses the TeX, so \left( ... \right) and plain ( ... ) both count;
- code: brackets in highlighted code blocks (R, Python, Racket, any language
  Quarto highlights) are wrapped in colored spans, skipping strings,
  comments and character literals.

PDF, Word and every other non-HTML format are untouched, so they stay black.

Settings, in document or project metadata (all optional):

  rainbow-parens:
    math: true           # color brackets in math (default true)
    code: true           # true: every highlighted code block (default);
                         # false: none; a list such as [r, racket]: only
                         # code blocks in those languages

`rainbow-parens: false` turns the extension off for a page.
]]

-- "*" stands for every language, in the <meta> tag the script reads.
local ALL = { "*" }

-- error() alone is not enough: Quarto 1.11.9 logs a Lua filter error and
-- still writes the output and exits 0, so exit nonzero explicitly.
local function fail(message)
  io.stderr:write("rainbow-parens: " .. message .. "\n")
  os.exit(1)
end

local KEYS = { math = true, code = true }

-- A language name as Pandoc writes it into a code block's class.
local function language(item)
  local name = pandoc.utils.stringify(item)
  if not name:match("^[%w_+#.-]+$") then
    fail("`code` languages must be single words such as r or racket, got '"
      .. name .. "'")
  end
  return name
end

local function code_setting(value)
  if value == nil or value == true then
    return ALL
  end
  if value == false then
    return {}
  end
  local kind = pandoc.utils.type(value)
  if kind == "List" then
    local out = {}
    for _, item in ipairs(value) do
      out[#out + 1] = language(item)
    end
    return out
  end
  if kind == "Inlines" or kind == "string" then
    return { language(value) }
  end
  fail("`code` must be true, false or a list of languages")
end

local function settings(meta)
  local raw = meta["rainbow-parens"]
  if raw == false then
    return nil
  end
  if raw == nil or raw == true then
    return { math = true, code = ALL }
  end
  -- A metadata map has pandoc type "table"; a bare word is "Inlines".
  if pandoc.utils.type(raw) ~= "table" then
    fail("expected true, false or a table of settings, got "
      .. pandoc.utils.stringify(raw))
  end
  for key in pairs(raw) do
    if not KEYS[key] then
      fail("unknown setting `" .. tostring(key) .. "`; expected math or code")
    end
  end
  if raw.math ~= nil and raw.math ~= true and raw.math ~= false then
    fail("`math` must be true or false, got " .. pandoc.utils.stringify(raw.math))
  end
  return { math = raw.math ~= false, code = code_setting(raw.code) }
end

-- The version in _extension.yml, so the dependency's folder name follows
-- each release without a second copy of the number here.
local function extension_version()
  local path = pandoc.path.join({
    pandoc.path.directory(PANDOC_SCRIPT_FILE), "_extension.yml",
  })
  local file = io.open(path, "r")
  if not file then
    fail("cannot read " .. path)
  end
  local text = "\n" .. file:read("a")
  file:close()
  local version = text:match("\nversion:%s*([%w.+-]+)")
  if not version then
    fail("no version in " .. path)
  end
  return version
end

local function escape_attr(text)
  return (text:gsub("&", "&amp;"):gsub('"', "&quot;"):gsub("<", "&lt;"))
end

function Meta(meta)
  -- Validate in every format, so a bad value fails a PDF render too.
  local s = settings(meta)
  if s == nil or not quarto.doc.is_format("html") then
    return nil
  end
  -- The settings travel as <meta> tags, which the script reads when MathJax
  -- typesets and when the page has loaded.
  quarto.doc.include_text("in-header", string.format(
    '<meta name="rainbow-parens" data-math="%s" data-code="%s">',
    s.math and "true" or "false",
    escape_attr(table.concat(s.code, " "))
  ))
  quarto.doc.add_html_dependency({
    name = "rainbow-parens",
    version = extension_version(),
    -- A classic (non-module, non-deferred) script, so it runs before the
    -- deferred MathJax script and can register its render action.
    scripts = { "rainbow-parens.js" },
    stylesheets = { "rainbow-parens.css" },
  })
  return nil
end
