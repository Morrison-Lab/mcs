"""Draw the arrow diagram and directed graphs of chapters/relations.qmd.

Usage: python3 images/relations-figures.py images/
"""
import math
import sys
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import Circle, Ellipse, FancyArrowPatch

out_dir = Path(sys.argv[1])

NODE_RADIUS = 0.42
ARROW = dict(arrowstyle="-|>", mutation_scale=16, lw=1.4, color="black")


def node(ax, xy, label):
    ax.add_patch(Circle(xy, NODE_RADIUS, fill=True, fc="white", ec="black", lw=1.4, zorder=2))
    ax.text(xy[0], xy[1], label, ha="center", va="center", fontsize=13, zorder=3)


def arrow(ax, start, end, rad=0.0):
    ax.add_patch(
        FancyArrowPatch(
            start,
            end,
            connectionstyle=f"arc3,rad={rad}",
            shrinkA=NODE_RADIUS * 72 / 2.0,
            shrinkB=NODE_RADIUS * 72 / 2.0,
            zorder=1,
            **ARROW,
        )
    )


def loop(ax, xy, angle):
    """Draw an arrow from the node at xy back to itself, pointing away at angle (degrees)."""
    a = math.radians(angle)
    spread = math.radians(28)
    start = (xy[0] + NODE_RADIUS * math.cos(a - spread), xy[1] + NODE_RADIUS * math.sin(a - spread))
    end = (xy[0] + NODE_RADIUS * math.cos(a + spread), xy[1] + NODE_RADIUS * math.sin(a + spread))
    ax.add_patch(
        FancyArrowPatch(
            start,
            end,
            connectionstyle="arc3,rad=2.4",
            shrinkA=0,
            shrinkB=0,
            zorder=1,
            **ARROW,
        )
    )


def finish(fig, ax, name):
    ax.set_aspect("equal")
    ax.axis("off")
    fig.savefig(out_dir / name, bbox_inches="tight", facecolor="white")
    plt.close(fig)


# Arrow diagram of the relation H from words to letters (exm-arrow-diagram).
fig, ax = plt.subplots(figsize=(5, 3.6), dpi=200)
words = {"cat": (0, 2.4), "dog": (0, 1.2), "owl": (0, 0)}
letters = {"c": (4, 2.7), "d": (4, 1.8), "o": (4, 0.9), "t": (4, 0)}
ax.add_patch(Ellipse((0, 1.2), 1.6, 4.0, fill=False, lw=1.2, ls="--"))
ax.add_patch(Ellipse((4, 1.35), 1.6, 4.3, fill=False, lw=1.2, ls="--"))
ax.text(0, 3.55, "W", ha="center", fontsize=14, style="italic")
ax.text(4, 3.85, "L", ha="center", fontsize=14, style="italic")
for label, xy in {**words, **letters}.items():
    node(ax, xy, label)
for w, x in [("cat", "c"), ("cat", "t"), ("dog", "d"), ("dog", "o"), ("owl", "o")]:
    arrow(ax, words[w], letters[x])
ax.set_xlim(-1.2, 5.2)
ax.set_ylim(-1.0, 4.2)
finish(fig, ax, "relations-word-letters.png")

# Directed graph of the relation "beats" (exm-relation-digraph).
fig, ax = plt.subplots(figsize=(4, 3.6), dpi=200)
NODE_RADIUS = 0.75
game = {"rock": (0, 0), "paper": (3.6, 0), "scissors": (1.8, 2.9)}
for label, xy in game.items():
    node(ax, xy, label)
for a, b in [("rock", "scissors"), ("scissors", "paper"), ("paper", "rock")]:
    arrow(ax, game[a], game[b])
ax.set_xlim(-1.0, 4.6)
ax.set_ylim(-1.0, 3.8)
finish(fig, ax, "relations-beats.png")

# Directed graph of the relation "shares a letter with" (exm-shares-letter).
fig, ax = plt.subplots(figsize=(6, 2.6), dpi=200)
NODE_RADIUS = 0.45
animals = {"cat": (0, 0), "cow": (2.4, 0), "dog": (4.8, 0), "pig": (7.2, 0)}
for label, xy in animals.items():
    node(ax, xy, label)
    loop(ax, xy, 90)
for a, b in [("cat", "cow"), ("cow", "dog"), ("dog", "pig")]:
    arrow(ax, animals[a], animals[b], rad=-0.3)
    arrow(ax, animals[b], animals[a], rad=-0.3)
ax.set_xlim(-0.8, 8.0)
ax.set_ylim(-0.9, 1.6)
finish(fig, ax, "relations-shares-letter.png")
