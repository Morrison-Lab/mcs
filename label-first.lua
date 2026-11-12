-- Move the \label of a remark or solution to the start of its environment
-- in LaTeX output.
--
-- Quarto writes the label of a #rem- or #sol- div last, after the div's
-- content:
--
--   \begin{refremark}[Title]
--   ... content ...
--   \label{rem-foo}
--   \end{refremark}
--
-- callouty-theorem wraps every remark and solution in a breakable callout
-- box. When such a box ends at the foot of a page, it can split just
-- before that trailing \label; the last part then holds nothing but the
-- label, it is dropped, and every cross-reference to the div prints "??"
-- (Morrison-Lab/mcs#129: "Remark ??" in the propositional logic handout).
-- A label written right after \begin{...}[Title] stays with the title,
-- in the first part of the box.
--
-- Runs after Quarto has rendered its theorem nodes to LaTeX. There, an
-- environment's blocks are a Para or Plain that opens with the raw
-- "\begin{refremark}" and "[" ... "]" title, the content, a Plain holding
-- only the raw "\label{...}", and a RawBlock "\end{refremark}".

if not FORMAT:match("latex") then
  return {}
end

local function is_raw(el, pattern)
  return el and (el.t == "RawInline" or el.t == "RawBlock")
    and (el.format == "latex" or el.format == "tex")
    and el.text:match(pattern) ~= nil
end

-- The "\label{...}" of a Plain that holds nothing else, or nil.
local function lone_label(block)
  if block and (block.t == "Plain" or block.t == "Para")
      and #block.content == 1
      and is_raw(block.content[1], "^%s*\\label{[^}]+}%s*$") then
    return block.content[1]
  end
  return nil
end

local function move_label(blocks)
  local n = #blocks
  if n < 3 or not is_raw(blocks[n], "^%s*\\end{ref%a+}%s*$") then
    return nil
  end
  local label = lone_label(blocks[n - 1])
  local first = blocks[1]
  if not label or not (first.t == "Para" or first.t == "Plain")
      or not is_raw(first.content[1], "^\\begin{ref%a+}$") then
    return nil
  end
  -- After the optional title, "[" ... "]", if there is one.
  local at = 2
  if is_raw(first.content[2], "^%[$") then
    for k = 3, #first.content do
      if is_raw(first.content[k], "^%]$") then
        at = k + 1
        break
      end
    end
  end
  first.content:insert(at, pandoc.RawInline("latex", label.text))
  blocks:remove(n - 1)
  return blocks
end

return {
  { Blocks = move_label }
}
