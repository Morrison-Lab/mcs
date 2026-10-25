#!/usr/bin/env python3
"""Self-test for check-unresolvable-refs.py, so a vacuous pass cannot hide."""

import importlib.util
import pathlib
import tempfile

here = pathlib.Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location("checker", here / "check-unresolvable-refs.py")
checker = importlib.util.module_from_spec(spec)
spec.loader.exec_module(checker)

CASES = [
    # (source, site numbers every format, expected number of findings)
    ("Text $x$ (@def-floor) is fine.\n", False, 0),
    ("$$\na && \\text{(by @rem-size)}\n$$\n", False, 1),
    ("Inline $y = @def-bad$ here.\n", False, 1),
    ("See @sec-traversals.\n", False, 1),
    ("See @sec-traversals.\n", True, 0),
    ("See [traversals](#sec-traversals).\n", False, 0),
    ("```\n$@def-code$ and @sec-code\n```\n", False, 0),
    ("Mail me at a@sec-x.org, cost \\$5 and \\$6.\n", False, 0),
    ("---\nnumber-sections: true\n---\nSee @sec-a.\n", False, 0),
]

failures = 0
with tempfile.TemporaryDirectory() as tmp:
    for i, (source, numbered, expected) in enumerate(CASES):
        path = pathlib.Path(tmp) / f"case{i}.qmd"
        path.write_text(source)
        found = checker.check(path, numbered)
        if len(found) != expected:
            failures += 1
            print(f"case {i}: expected {expected} finding(s), got {found}")

real = checker.numbered_sections(here.parents[1])
print(f"numbered_sections on this repository: {real}")
if failures:
    raise SystemExit(f"{failures} case(s) failed")
print(f"All {len(CASES)} cases passed.")
