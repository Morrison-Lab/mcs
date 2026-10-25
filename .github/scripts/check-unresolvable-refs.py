#!/usr/bin/env python3
"""Flag cross-references that Quarto cannot resolve.

Two kinds reach the rendered page as literal or broken text without any
render warning:

- an ``@id`` reference inside math (``$...$`` or ``$$...$$``), which Quarto
  passes to the math renderer untouched, so it prints as ``@id``;
- an ``@sec-`` reference when some output format leaves sections
  unnumbered (here the PDF handout, though the website numbers them), which
  prints as "Section" with no number there. Link the section instead, as
  ``[text](#sec-id)``.

Issue: Morrison-Lab/mcs#29. The check belongs in Morrison-Lab/gha in the end,
beside check-fform-paren, so every lab site gets it.

Usage: check-unresolvable-refs.py [FILE ...]
With no files, checks every .qmd file under chapters/ and the repository root.
Exits 1 if it finds any, and prints each as FILE:LINE: message.
"""

import pathlib
import re
import sys

import yaml

REF = re.compile(r"(?<![\w.\\])@[a-z]+-[\w-]+")
SEC_REF = re.compile(r"(?<![\w.\\])@sec-[\w-]+")
FENCE = re.compile(r"^\s*(```|~~~)")
DISPLAY = re.compile(r"\$\$(.+?)\$\$", re.S)
INLINE = re.compile(r"(?<![\\$])\$(?!\$)(.+?)(?<![\\$])\$(?!\$)")


def numbered_sections(root):
    """Return True only if every output format numbers its sections.

    A format left unnumbered (here, the PDF handout) prints an @sec- reference
    as "Section" with no number, even when the website numbers its sections.
    """
    formats = {}
    for name in ("_quarto.yml", "_quarto-website.yml"):
        path = root / name
        if not path.exists():
            continue
        config = yaml.safe_load(path.read_text()) or {}
        for fmt, opts in (config.get("format") or {}).items():
            merged = formats.setdefault(fmt, {})
            merged.update(opts if isinstance(opts, dict) else {})
    if not formats:
        return False
    return all(opts.get("number-sections") is True for opts in formats.values())


def strip_code(text):
    """Blank out fenced code blocks and inline code, keeping line numbers."""
    out = []
    in_fence = False
    for line in text.split("\n"):
        if FENCE.match(line):
            in_fence = not in_fence
            out.append("")
            continue
        if in_fence:
            out.append("")
            continue
        out.append(re.sub(r"`[^`]*`", lambda m: " " * len(m.group()), line))
    return "\n".join(out)


def page_numbers_sections(text, default):
    """Honour a page's own number-sections setting in its front matter."""
    m = re.match(r"---\n(.*?)\n---\n", text, re.S)
    if not m:
        return default
    try:
        meta = yaml.safe_load(m.group(1)) or {}
    except yaml.YAMLError:
        return default
    value = meta.get("number-sections")
    return default if value is None else bool(value)


def check(path, site_numbered):
    text = strip_code(path.read_text())
    problems = []

    def line_of(pos):
        return text.count("\n", 0, pos) + 1

    spans = []
    for m in DISPLAY.finditer(text):
        spans.append((m.start(), m.end()))
        for r in REF.finditer(m.group(1)):
            problems.append((line_of(m.start(1) + r.start()),
                             f"{r.group()} is inside display math, where Quarto does not resolve it; cite it in the prose"))
    masked = DISPLAY.sub(lambda m: "\n" * m.group().count("\n"), text)
    for m in INLINE.finditer(masked):
        for r in REF.finditer(m.group(1)):
            problems.append((line_of(m.start(1) + r.start()),
                             f"{r.group()} is inside inline math, where Quarto does not resolve it; cite it in the prose"))
    # A reference inside inline math is reported above already.
    prose = INLINE.sub(lambda m: " " * len(m.group()), masked)
    if not page_numbers_sections(text, site_numbered):
        for r in SEC_REF.finditer(prose):
            problems.append((line_of(r.start()),
                             f"{r.group()} renders as 'Section' with no number in a format that does not number sections (the PDF handout); "
                             f"link it as [text](#{r.group()[1:]})"))
    return sorted(problems)


def main(argv):
    root = pathlib.Path(__file__).resolve().parents[2]
    files = [pathlib.Path(a) for a in argv] or sorted(
        list(root.glob("*.qmd")) + list((root / "chapters").rglob("*.qmd")))
    site_numbered = numbered_sections(root)
    count = 0
    for path in files:
        if path.suffix != ".qmd" or not path.exists():
            continue
        for line, message in check(path, site_numbered):
            print(f"{path}:{line}: {message}")
            count += 1
    if count:
        print(f"{count} cross-reference(s) that cannot resolve.")
        return 1
    print(f"Checked {len(files)} file(s); no unresolvable cross-references.")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
