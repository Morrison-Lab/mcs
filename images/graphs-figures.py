"""Draw the graphs of chapters/graphs.qmd.

Usage: python3 images/graphs-figures.py images/
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


def node(ax, xy, label, radius=None):
    r = radius or NODE_RADIUS
    ax.add_patch(Circle(xy, r, fill=True, fc="white", ec="black", lw=1.4, zorder=2))
    size = 13 if len(label) < 6 else 11
    ax.text(xy[0], xy[1], label, ha="center", va="center", fontsize=size, zorder=3)


def edge(ax, start, end, rad=0.0, directed=False, radius=None):
    r = radius or NODE_RADIUS
    style = "-|>" if directed else "-"
    ax.add_patch(
        FancyArrowPatch(
            start,
            end,
            arrowstyle=style,
            mutation_scale=16,
            connectionstyle=f"arc3,rad={rad}",
            shrinkA=r * 72 / 2.0,
            shrinkB=r * 72 / 2.0,
            zorder=1,
            **LINE,
        )
    )


def loop(ax, xy, angle, directed=False, radius=None):
    """Draw an edge from the vertex at xy back to itself, pointing away at angle (degrees)."""
    r = radius or NODE_RADIUS
    a = math.radians(angle)
    spread = math.radians(28)
    start = (xy[0] + r * math.cos(a - spread), xy[1] + r * math.sin(a - spread))
    end = (xy[0] + r * math.cos(a + spread), xy[1] + r * math.sin(a + spread))
    ax.add_patch(
        FancyArrowPatch(
            start,
            end,
            arrowstyle="-|>" if directed else "-",
            mutation_scale=16,
            connectionstyle="arc3,rad=2.4",
            shrinkA=0,
            shrinkB=0,
            zorder=1,
            **LINE,
        )
    )


def finish(fig, ax, name, xlim, ylim):
    ax.set_xlim(*xlim)
    ax.set_ylim(*ylim)
    ax.set_aspect("equal")
    ax.axis("off")
    fig.savefig(out_dir / name, bbox_inches="tight", facecolor="white")
    plt.close(fig)


# The office graph G (exm-office-graph) and the graph H left after two cables are cut
# (exr-cut-cables).
OFFICE = {"a": (0, 1), "b": (1.6, 2), "c": (1.6, 0), "d": (3.2, 2), "e": (3.2, 0), "f": (4.8, 1)}
OFFICE_EDGES = [("a", "b"), ("a", "c"), ("b", "c"), ("b", "d"), ("c", "e"), ("d", "e"), ("d", "f"), ("e", "f")]
for name, edges in [
    ("graphs-office.png", OFFICE_EDGES),
    ("graphs-office-cut.png", [e for e in OFFICE_EDGES if e not in [("b", "d"), ("c", "e")]]),
]:
    fig, ax = plt.subplots(figsize=(4.4, 2.4), dpi=200)
    for label, xy in OFFICE.items():
        node(ax, xy, label)
    for u, v in edges:
        edge(ax, OFFICE[u], OFFICE[v])
    finish(fig, ax, name, (-0.6, 5.4), (-0.6, 2.6))

# The office graph drawn in columns by distance from a (exm-office-distance).
LEVELS = {"a": (0, 1), "b": (1.8, 2), "c": (1.8, 0), "d": (3.6, 2), "e": (3.6, 0), "f": (5.4, 1)}
fig, ax = plt.subplots(figsize=(4.8, 2.9), dpi=200)
for label, xy in LEVELS.items():
    node(ax, xy, label)
for u, v in OFFICE_EDGES:
    edge(ax, LEVELS[u], LEVELS[v])
for k, x in enumerate([0, 1.8, 3.6, 5.4]):
    ax.text(x, -0.85, f"distance {k}", ha="center", fontsize=10)
finish(fig, ax, "graphs-office-levels.png", (-0.8, 6.2), (-1.1, 2.6))

# A loop and two parallel edges (exm-loop-parallel).
fig, ax = plt.subplots(figsize=(4.6, 1.8), dpi=200)
SPOTS = {"p": (0, 0), "q": (1.8, 0), "r": (3.6, 0), "s": (5.4, 0)}
for label, xy in SPOTS.items():
    node(ax, xy, label)
loop(ax, SPOTS["p"], 90)
edge(ax, SPOTS["p"], SPOTS["q"])
edge(ax, SPOTS["q"], SPOTS["r"], rad=0.35)
edge(ax, SPOTS["q"], SPOTS["r"], rad=-0.35)
edge(ax, SPOTS["r"], SPOTS["s"])
finish(fig, ax, "graphs-loop-parallel.png", (-0.6, 6.0), (-0.8, 1.3))

# The bridges of Konigsberg as a graph (exm-konigsberg).
fig, ax = plt.subplots(figsize=(3.6, 3.6), dpi=200)
LAND = {"A": (0, 0), "B": (0, 2.2), "C": (0, -2.2), "D": (2.6, 0)}
for label, xy in LAND.items():
    node(ax, xy, label)
for rad in (0.3, -0.3):
    edge(ax, LAND["A"], LAND["B"], rad=rad)
    edge(ax, LAND["A"], LAND["C"], rad=rad)
edge(ax, LAND["A"], LAND["D"])
edge(ax, LAND["B"], LAND["D"])
edge(ax, LAND["C"], LAND["D"])
finish(fig, ax, "graphs-konigsberg.png", (-0.9, 3.3), (-2.8, 2.8))

# Links between four web pages (exm-web-links).
fig, ax = plt.subplots(figsize=(4.4, 3.4), dpi=200)
R = 0.72
PAGES = {"home": (0, 2.6), "about": (3.8, 2.6), "blog": (0, 0), "contact": (3.8, 0)}
for label, xy in PAGES.items():
    node(ax, xy, label, radius=R)
edge(ax, PAGES["home"], PAGES["about"], directed=True, radius=R)
edge(ax, PAGES["home"], PAGES["blog"], rad=0.25, directed=True, radius=R)
edge(ax, PAGES["blog"], PAGES["home"], rad=0.25, directed=True, radius=R)
loop(ax, PAGES["blog"], 225, directed=True, radius=R)
edge(ax, PAGES["blog"], PAGES["contact"], directed=True, radius=R)
edge(ax, PAGES["about"], PAGES["contact"], directed=True, radius=R)
edge(ax, PAGES["contact"], PAGES["home"], directed=True, radius=R)
finish(fig, ax, "graphs-web.png", (-1.6, 4.7), (-1.6, 3.5))

# Three triangles in a row (exm-triangles).
fig, ax = plt.subplots(figsize=(5.0, 2.2), dpi=200)
TRI = {"1": (0, 1.4), "2": (0, 0), "3": (1.3, 0.7), "4": (2.6, 1.4), "5": (3.9, 0.7), "6": (5.2, 1.4), "7": (5.2, 0)}
for label, xy in TRI.items():
    node(ax, xy, label)
for u, v in [("1", "2"), ("2", "3"), ("3", "1"), ("3", "4"), ("4", "5"), ("5", "3"), ("5", "6"), ("6", "7"), ("7", "5")]:
    edge(ax, TRI[u], TRI[v])
finish(fig, ax, "graphs-triangles.png", (-0.6, 5.8), (-0.6, 2.0))

# An envelope (exr-envelope).
fig, ax = plt.subplots(figsize=(2.8, 3.4), dpi=200)
ENV = {"v": (0, 0), "w": (2.4, 0), "x": (0, 2.4), "y": (2.4, 2.4), "z": (1.2, 3.8)}
for label, xy in ENV.items():
    node(ax, xy, label)
for u, v in [("v", "w"), ("v", "x"), ("w", "y"), ("x", "y"), ("v", "y"), ("w", "x"), ("x", "z"), ("y", "z")]:
    edge(ax, ENV[u], ENV[v])
finish(fig, ax, "graphs-envelope.png", (-0.6, 3.0), (-0.6, 4.4))

# The cube graph on the bit strings of length 3 (exm-cube-bipartite).
# Strings with an even number of 1s are shaded, to show the two parts.
fig, ax = plt.subplots(figsize=(3.8, 3.8), dpi=200)
R = 0.45
CUBE = {
    "000": (0, 0), "100": (3.6, 0), "010": (0, 3.6), "110": (3.6, 3.6),
    "001": (1.0, 1.0), "101": (2.6, 1.0), "011": (1.0, 2.6), "111": (2.6, 2.6),
}
for label, xy in CUBE.items():
    shade = "#d0d0d0" if label.count("1") % 2 == 0 else "white"
    ax.add_patch(Circle(xy, R, fill=True, fc=shade, ec="black", lw=1.4, zorder=2))
    ax.text(xy[0], xy[1], label, ha="center", va="center", fontsize=11, zorder=3)
for u in CUBE:
    for v in CUBE:
        if u < v and sum(x != y for x, y in zip(u, v)) == 1:
            edge(ax, CUBE[u], CUBE[v], radius=R)
finish(fig, ax, "graphs-cube.png", (-0.7, 4.3), (-0.7, 4.3))
