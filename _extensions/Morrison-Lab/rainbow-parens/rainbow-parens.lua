--[[
rainbow-parens filter: colour matching brackets by nesting depth in HTML output.

The filter only attaches a script and a stylesheet to HTML pages; the
colouring happens in the browser, in two places:

- math: a MathJax render action colours each ( [ { and its partner after
  MathJax parses the TeX, so \left( ... \right) and plain ( ... ) both count;
- code: brackets in highlighted code blocks (R, Python, Racket, any language
  Quarto highlights) are wrapped in coloured spans, skipping strings,
  comments and character literals.

PDF, Word and every other non-HTML format are untouched, so they stay black.

Settings, in document or project metadata (all optional):

  rainbow-parens:
    math: true           # colour brackets in math (default true)
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

local function as_strings(value)
  local out = {}
  if value == nil then
    return out
  end
  if pandoc.utils.type(value) == "List" or type(value) == "table" then
    for _, item in ipairs(value) do
      out[#out + 1] = pandoc.utils.stringify(item)
    end
    return out
  end
  out[1] = pandoc.utils.stringify(value)
  return out
end

local function settings(meta)
  local raw = meta["rainbow-parens"]
  if raw == false then
    return nil
  end
  local math, code = true, ALL
  -- A metadata map has pandoc type "table"; a bare word is "Inlines".
  if pandoc.utils.type(raw) == "table" then
    if raw.math == false then
      math = false
    elseif raw.math ~= nil and raw.math ~= true then
      fail("`math` must be true or false, got "
        .. pandoc.utils.stringify(raw.math))
    end
    if raw.code == false then
      code = {}
    elseif raw.code == true then
      code = ALL
    elseif raw.code ~= nil then
      code = as_strings(raw.code)
    end
  elseif raw ~= nil and raw ~= true then
    fail("expected true, false or a table of settings, got "
      .. pandoc.utils.stringify(raw))
  end
  return { math = math, code = code }
end

local function escape_attr(text)
  return (text:gsub("&", "&amp;"):gsub('"', "&quot;"):gsub("<", "&lt;"))
end

function Meta(meta)
  if not quarto.doc.is_format("html") then
    return nil
  end
  local s = settings(meta)
  if s == nil then
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
    version = "0.1.0",
    -- A classic (non-module, non-deferred) script, so it runs before the
    -- deferred MathJax script and can register its render action.
    scripts = { "rainbow-parens.js" },
    stylesheets = { "rainbow-parens.css" },
  })
  return nil
end
