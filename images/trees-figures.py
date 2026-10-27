"""Draw the trees of chapters/trees.qmd.

Usage: python3 images/trees-figures.py images/
"""
import math
import sys
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import Circle, FancyArrowPatch

out_dir = Path(sys.argv[1])

NODE_RADIUS = 0.36
LINE = dict(lw=1.6, color="black")
TIMES = "\u00d7"
MINUS = "\u2212"


def node(ax, xy, label, radius=None):
    r = radius or NODE_RADIUS
    ax.add_patch(Circle(xy, r, fill=True, fc="white", ec="black", lw=1.4, zorder=2))
    ax.text(xy[0], xy[1], label, ha="center", va="center", fontsize=13, zorder=3)


def edge(ax, start, end, radius=None, style="solid"):
    r = radius or NODE_RADIUS
    if style == "solid":
        kw = dict(LINE)
    elif style == "thick":
        kw = dict(lw=3.4, color="black")
    else:
        kw = dict(lw=1.2, color="#888888", linestyle=(0, (4, 3)))
    ax.add_patch(
        FancyArrowPatch(
            start,
            end,
            arrowstyle="-",
            shrinkA=r * 72 / 2.0,
            shrinkB=r * 72 / 2.0,
            zorder=1,
            **kw,
        )
    )


def finish(fig, ax, name, xlim, ylim):
    ax.set_xlim(*xlim)
    ax.set_ylim(*ylim)
    ax.set_aspect("equal")
    ax.axis("off")
    fig.savefig(out_dir / name, bbox_inches="tight", facecolor="white")
    plt.close(fig)


def draw(ax, pos, edges, labels=True):
    for label, xy in pos.items():
        node(ax, xy, label if labels else "")
    for u, v in edges:
        edge(ax, pos[u], pos[v])


# The pipes between seven houses (exr-pipes).
PIPES = {"p": (0, 1.2), "r": (0, -0.4), "q": (1.3, 0.4), "s": (2.8, 0.4), "t": (4.3, 0.4), "u": (5.6, 1.2), "w": (5.6, -0.4)}
fig, ax = plt.subplots(figsize=(4.6, 1.9), dpi=200)
draw(ax, PIPES, [("p", "q"), ("q", "r"), ("q", "s"), ("s", "t"), ("t", "u"), ("t", "w")])
finish(fig, ax, "trees-pipes.png", (-0.6, 6.2), (-1.0, 1.8))

# Three graphs: a tree T, a graph H with a cycle, and a forest F (exm-trees-or-not).
fig, ax = plt.subplots(figsize=(7.4, 2.3), dpi=200)
T = {"a": (0, 1.4), "b": (0.8, 0.5), "c": (0, -0.4), "d": (1.9, 0.5), "e": (2.7, -0.4)}
draw(ax, T, [("a", "b"), ("b", "c"), ("b", "d"), ("d", "e")])
H = {k: (x + 4.0, y) for k, (x, y) in {"a": (0, 1.4), "b": (0.8, 0.5), "c": (0.8, -0.6), "d": (1.9, 0.0), "e": (2.7, 1.0)}.items()}
draw(ax, H, [("a", "b"), ("b", "c"), ("c", "d"), ("d", "b"), ("d", "e")])
F = {k: (x + 8.0, y) for k, (x, y) in {
    "a": (0, 1.2), "b": (0, -0.2), "c": (1.1, 1.2), "d": (1.1, -0.2),
    "e": (2.9, 0.5), "f": (2.2, 1.4), "g": (3.8, 1.2), "h": (2.9, -0.6)}.items()}
draw(ax, F, [("c", "d"), ("e", "f"), ("e", "g"), ("e", "h")])
for x, name in [(1.35, "T"), (5.35, "H"), (9.9, "F")]:
    ax.text(x, -1.45, name, ha="center", fontsize=13, style="italic")
finish(fig, ax, "trees-or-not.png", (-0.6, 12.4), (-1.8, 1.9))

# The phone tree of the club, rooted at a (exr-phone-calls), and rooted at c (exm-rerooted).
PHONE_EDGES = [("a", "b"), ("a", "c"), ("a", "d"), ("b", "e"), ("b", "f"), ("d", "g"), ("g", "h")]
for name, pos, height in [
    ("trees-phone.png",
     {"a": (0, 0), "b": (-2.0, -1.3), "c": (0, -1.3), "d": (2.0, -1.3),
      "e": (-2.8, -2.6), "f": (-1.2, -2.6), "g": (2.0, -2.6), "h": (2.0, -3.9)}, 3),
    ("trees-phone-c.png",
     {"c": (0, 0), "a": (0, -1.3), "b": (-1.3, -2.6), "d": (1.3, -2.6),
      "e": (-2.1, -3.9), "f": (-0.5, -3.9), "g": (1.3, -3.9), "h": (1.3, -5.2)}, 4),
]:
    fig, ax = plt.subplots(figsize=(4.0, 1.0 + 0.9 * height), dpi=200)
    draw(ax, pos, PHONE_EDGES)
    for k in range(height + 1):
        ax.text(3.6, -1.3 * k, f"level {k}", ha="left", va="center", fontsize=10)
    finish(fig, ax, name, (-3.4, 5.0), (-1.3 * height - 0.6, 0.6))


def binary_positions(tree, x, y, dx, dy=1.2, out=None):
    """tree = (label, left, right); returns {key: (x, y)} and the edges, keyed by path."""
    if out is None:
        out = ({}, [])
    pos, edges = out
    key = f"{len(pos)}"
    pos[key] = (tree[0], (x, y))
    for child, sign in [(tree[1], -1), (tree[2], 1)]:
        if child is not None:
            ckey = f"{len(pos)}"
            binary_positions(child, x + sign * dx, y - dy, dx / 2, dy, out)
            edges.append((key, ckey))
    return out


def draw_binary(ax, tree, x, y, dx, dy=1.2, radius=None):
    pos, edges = binary_positions(tree, x, y, dx, dy)
    for key, (label, xy) in pos.items():
        node(ax, xy, label, radius)
    for u, v in edges:
        edge(ax, pos[u][1], pos[v][1], radius)


# The five binary trees with three vertices (sol-three-vertices).
fig, ax = plt.subplots(figsize=(7.0, 2.0), dpi=200)
leaf = ("", None, None)
SHAPES = [
    ("", ("", leaf, None), None),
    ("", ("", None, leaf), None),
    ("", leaf, leaf),
    ("", None, ("", leaf, None)),
    ("", None, ("", None, leaf)),
]
for i, shape in enumerate(SHAPES):
    draw_binary(ax, shape, 2.6 * i, 0, 0.7, dy=0.9, radius=0.2)
finish(fig, ax, "trees-three-vertices.png", (-1.5, 11.8), (-2.1, 0.4))

# The binary tree B (exm-binary-tree).
B = ("m", ("f", ("c", None, None), ("h", None, ("j", None, None))),
          ("t", ("r", ("p", None, None), None), ("w", None, None)))
fig, ax = plt.subplots(figsize=(4.4, 2.9), dpi=200)
draw_binary(ax, B, 0, 0, 2.2)
finish(fig, ax, "trees-binary.png", (-3.8, 3.8), (-4.2, 0.5))

# A left child and a right child (exm-left-right).
fig, ax = plt.subplots(figsize=(3.4, 1.6), dpi=200)
draw_binary(ax, ("x", ("y", None, None), None), 0, 0, 0.9)
draw_binary(ax, ("x", None, ("y", None, None)), 3.4, 0, 0.9)
finish(fig, ax, "trees-left-right.png", (-1.4, 4.8), (-1.7, 0.5))

# The expression tree of (7 - 2) x (3 + 4 x 2) (exm-expression-tree).
EXPR = (TIMES, (MINUS, ("7", None, None), ("2", None, None)),
               ("+", ("3", None, None), (TIMES, ("4", None, None), ("2", None, None))))
fig, ax = plt.subplots(figsize=(4.2, 2.9), dpi=200)
draw_binary(ax, EXPR, 0, 0, 2.4)
finish(fig, ax, "trees-expression.png", (-4.1, 4.7), (-4.2, 0.5))

# The town graph W: towns a to f around g (exr-fewest-roads), with spanning trees drawn thick.
HUB = {"a": (0, 2), "b": (1.73, 1), "c": (1.73, -1), "d": (0, -2), "e": (-1.73, -1), "f": (-1.73, 1), "g": (0, 0)}
HUB_EDGES = [("a", "b"), ("b", "c"), ("c", "d"), ("d", "e"), ("e", "f"), ("f", "a"), ("g", "a"), ("g", "c"), ("g", "e")]
for name, tree in [
    ("trees-hub.png", None),
    ("trees-hub-spanning.png", [("a", "b"), ("b", "c"), ("c", "g"), ("g", "e"), ("e", "d"), ("e", "f")]),
    ("trees-hub-bfs.png", [("a", "b"), ("a", "f"), ("a", "g"), ("b", "c"), ("f", "e"), ("c", "d")]),
    ("trees-hub-dfs.png", [("a", "b"), ("b", "c"), ("c", "d"), ("d", "e"), ("e", "f"), ("e", "g")]),
]:
    fig, ax = plt.subplots(figsize=(2.9, 3.1), dpi=200)
    for label, xy in HUB.items():
        node(ax, xy, label)
    chosen = None if tree is None else {frozenset(e) for e in tree}
    for u, v in HUB_EDGES:
        if chosen is None:
            style = "solid"
        else:
            style = "thick" if frozenset((u, v)) in chosen else "dashed"
        edge(ax, HUB[u], HUB[v], style=style)
    finish(fig, ax, name, (-2.3, 2.3), (-2.6, 2.6))
