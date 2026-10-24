"""Draw the state diagrams of chapters/automata.qmd.

Usage: python3 images/automata-figures.py images/
"""
import math
import re
import sys
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import Circle, FancyArrowPatch

out_dir = Path(sys.argv[1])

NODE_RADIUS = 0.42
LINE = dict(lw=1.5, color="black")
LABEL = dict(fontsize=13, ha="center", va="center", family="monospace", zorder=4)
POINT = dict(LABEL, fontsize=28, family="serif")
GAP = 0.3  # distance from an arrow to its label


def put_label(ax, x, y, text):
    """Write a transition label centred at (x, y); a point is drawn large so that it can be seen."""
    if text == ".":
        ax.text(x, y + 0.08, ".", **POINT)
    elif text == "d,.":
        ax.text(x - 0.12, y, "d,", **LABEL)
        ax.text(x + 0.2, y + 0.08, ".", **POINT)
    else:
        ax.text(x, y, text, **LABEL)


def state_name(label):
    """Print q0 as q with subscript 0; leave words such as closed as they are."""
    m = re.fullmatch(r"([a-z])(\d)", label)
    return rf"${m.group(1)}_{m.group(2)}$" if m else label


def state(ax, xy, label, accepting=False, radius=NODE_RADIUS):
    ax.add_patch(Circle(xy, radius, fill=True, fc="white", ec="black", lw=1.4, zorder=2))
    if accepting:
        ax.add_patch(Circle(xy, radius * 0.82, fill=False, ec="black", lw=1.2, zorder=3))
    size = 15 if len(label) < 4 else 11
    ax.text(xy[0], xy[1], state_name(label), ha="center", va="center", fontsize=size, zorder=3)


def start_arrow(ax, xy, angle=180, radius=NODE_RADIUS):
    """An arrow from nowhere into the initial state, coming in from the direction angle."""
    a = math.radians(angle)
    tip = (xy[0] + radius * math.cos(a), xy[1] + radius * math.sin(a))
    tail = (xy[0] + (radius + 0.7) * math.cos(a), xy[1] + (radius + 0.7) * math.sin(a))
    ax.add_patch(FancyArrowPatch(tail, tip, arrowstyle="-|>", mutation_scale=16,
                                 shrinkA=0, shrinkB=0, zorder=1, **LINE))


def transition(ax, start, end, text, rad=0.0, radius=NODE_RADIUS, side=1):
    """An arrow from start to end, labeled beside the arrow, not on it.

    A curved arrow is labeled on the outside of its bend; a straight one on its
    left (side=1) or right (side=-1), looking from start to end.
    """
    ax.add_patch(
        FancyArrowPatch(
            start,
            end,
            arrowstyle="-|>",
            mutation_scale=16,
            connectionstyle=f"arc3,rad={rad}",
            shrinkA=radius * 72 / 2.0 + 1,
            shrinkB=radius * 72 / 2.0 + 1,
            zorder=1,
            **LINE,
        )
    )
    # The midpoint of matplotlib's arc3 curve is the chord midpoint plus rad / 2 times (dy, -dx),
    # so a positive rad bends the arrow to the right of its direction.
    dx, dy = end[0] - start[0], end[1] - start[1]
    norm = math.hypot(dx, dy)
    mx = (start[0] + end[0]) / 2 + rad * dy / 2
    my = (start[1] + end[1]) / 2 - rad * dx / 2
    right = (dy / norm, -dx / norm)
    s = (1 if rad > 0 else -1) if rad != 0 else -side
    put_label(ax, mx + s * GAP * right[0], my + s * GAP * right[1], text)


def self_loop(ax, xy, text, angle=90, radius=NODE_RADIUS):
    """A transition from the state at xy back to itself, pointing away at angle (degrees)."""
    a = math.radians(angle)
    spread = math.radians(30)
    start = (xy[0] + radius * math.cos(a + spread), xy[1] + radius * math.sin(a + spread))
    end = (xy[0] + radius * math.cos(a - spread), xy[1] + radius * math.sin(a - spread))
    ax.add_patch(
        FancyArrowPatch(start, end, arrowstyle="-|>", mutation_scale=16,
                        connectionstyle="arc3,rad=-2.4", shrinkA=0, shrinkB=0, zorder=1, **LINE)
    )
    # The loop reaches about 2.1 radii from the centre, since its size scales with the radius.
    d = 2.6 * radius + 0.25 + 0.13 * len(text) * abs(math.cos(a))
    put_label(ax, xy[0] + d * math.cos(a), xy[1] + d * math.sin(a), text)


def finish(fig, ax, name, xlim, ylim):
    ax.set_xlim(*xlim)
    ax.set_ylim(*ylim)
    ax.set_aspect("equal")
    ax.axis("off")
    fig.savefig(out_dir / name, bbox_inches="tight", facecolor="white")
    plt.close(fig)


# The door (exm-door-diagram), and the door as a DFA with accepting state open (exm-door-dfa).
DOOR = {"closed": (0, 0), "open": (3.4, 0), "locked": (-3.4, 0)}
R = 0.74
for name, accepting in [("automata-door.png", set()), ("automata-door-dfa.png", {"open"})]:
    fig, ax = plt.subplots(figsize=(6.4, 2.8), dpi=200)
    for label, xy in DOOR.items():
        state(ax, xy, label, accepting=label in accepting, radius=R)
    start_arrow(ax, DOOR["closed"], angle=270, radius=R)
    transition(ax, DOOR["closed"], DOOR["open"], "o", rad=-0.3, radius=R)
    transition(ax, DOOR["open"], DOOR["closed"], "c", rad=-0.3, radius=R)
    transition(ax, DOOR["closed"], DOOR["locked"], "l", rad=-0.3, radius=R)
    transition(ax, DOOR["locked"], DOOR["closed"], "u", rad=-0.3, radius=R)
    self_loop(ax, DOOR["closed"], "c,u", angle=90, radius=R)
    self_loop(ax, DOOR["open"], "o,l,u", angle=0, radius=R)
    self_loop(ax, DOOR["locked"], "o,c,l", angle=180, radius=R)
    finish(fig, ax, name, (-7.0, 7.0), (-1.8, 2.8))

# Every a followed by a b (exm-pairs-dfa), and its complement (exm-pairs-complement).
PAIRS = {"q0": (0, 0), "q1": (2.6, 0), "q2": (5.2, 0)}
for name, accepting in [("automata-pairs.png", {"q0"}),
                        ("automata-pairs-complement.png", {"q1", "q2"})]:
    fig, ax = plt.subplots(figsize=(5.4, 2.2), dpi=200)
    for label, xy in PAIRS.items():
        state(ax, xy, label, accepting=label in accepting)
    start_arrow(ax, PAIRS["q0"])
    self_loop(ax, PAIRS["q0"], "b")
    transition(ax, PAIRS["q0"], PAIRS["q1"], "a", rad=-0.35)
    transition(ax, PAIRS["q1"], PAIRS["q0"], "b", rad=-0.35)
    transition(ax, PAIRS["q1"], PAIRS["q2"], "a")
    self_loop(ax, PAIRS["q2"], "a,b")
    finish(fig, ax, name, (-1.4, 6.0), (-1.2, 1.8))

# Decimal numerals (sol-decimal-numeral).
NUM = {"n0": (0, 1.8), "n1": (2.6, 1.8), "n2": (5.2, 1.8), "n3": (7.8, 1.8), "n4": (3.9, -0.8)}
fig, ax = plt.subplots(figsize=(6.6, 3.6), dpi=200)
for label, xy in NUM.items():
    state(ax, xy, label, accepting=label in {"n1", "n3"})
start_arrow(ax, NUM["n0"])
transition(ax, NUM["n0"], NUM["n1"], "d")
self_loop(ax, NUM["n1"], "d")
transition(ax, NUM["n1"], NUM["n2"], ".")
transition(ax, NUM["n2"], NUM["n3"], "d")
self_loop(ax, NUM["n3"], "d")
transition(ax, NUM["n0"], NUM["n4"], ".", rad=0.2)
transition(ax, NUM["n2"], NUM["n4"], ".", side=1)
transition(ax, NUM["n3"], NUM["n4"], ".", rad=-0.2)
self_loop(ax, NUM["n4"], "d,.", angle=270)
finish(fig, ax, "automata-numeral.png", (-1.4, 8.6), (-2.8, 3.1))

# The number of 0s modulo 3 (exm-zeros-mod-3).
ZEROS = {"t0": (0, 0), "t1": (2.4, 1.7), "t2": (4.8, 0)}
fig, ax = plt.subplots(figsize=(4.6, 3.2), dpi=200)
for label, xy in ZEROS.items():
    state(ax, xy, label, accepting=label == "t2")
start_arrow(ax, ZEROS["t0"])
self_loop(ax, ZEROS["t0"], "1", angle=270)
self_loop(ax, ZEROS["t1"], "1", angle=90)
self_loop(ax, ZEROS["t2"], "1", angle=270)
transition(ax, ZEROS["t0"], ZEROS["t1"], "0")
transition(ax, ZEROS["t1"], ZEROS["t2"], "0")
transition(ax, ZEROS["t2"], ZEROS["t0"], "0")
finish(fig, ax, "automata-zeros-mod-3.png", (-1.4, 5.6), (-1.8, 3.1))

# Watching for 110 (exm-table-language).
W = {"p0": (0, 0), "p1": (2.6, 0), "p2": (5.2, 0), "p3": (7.8, 0)}
fig, ax = plt.subplots(figsize=(6.4, 2.6), dpi=200)
for label, xy in W.items():
    state(ax, xy, label, accepting=label == "p3")
start_arrow(ax, W["p0"])
self_loop(ax, W["p0"], "0")
transition(ax, W["p0"], W["p1"], "1", rad=-0.35)
transition(ax, W["p1"], W["p0"], "0", rad=-0.35)
transition(ax, W["p1"], W["p2"], "1")
self_loop(ax, W["p2"], "1")
transition(ax, W["p2"], W["p3"], "0")
self_loop(ax, W["p3"], "0,1")
finish(fig, ax, "automata-110.png", (-1.4, 8.6), (-1.3, 1.9))
