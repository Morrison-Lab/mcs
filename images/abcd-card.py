"""Draw the ABCD voting card that the syllabus links (chapters/syllabus.qmd).

A landscape US letter page in four colored quarters, one letter each.
Students fold it in half twice so that one quarter faces the front.
The colors are from the Okabe-Ito palette, which stays distinct under
the common kinds of color blindness, and each quarter also shows its
letter, so the card works when printed in black and white.

Usage: python3 images/abcd-card.py images/abcd-card.pdf
"""
import sys

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle

out = sys.argv[1]

# letter, fill color, text color, lower-left corner of its quarter
quarters = [
    ("A", "#E69F00", "black", (0, 1)),
    ("B", "#56B4E9", "black", (1, 1)),
    ("C", "#009E73", "white", (0, 0)),
    ("D", "#CC79A7", "black", (1, 0)),
]

fig = plt.figure(figsize=(11, 8.5))
ax = fig.add_axes([0, 0, 1, 1])
ax.set_xlim(0, 2)
ax.set_ylim(0, 2)
ax.axis("off")

for letter, fill, ink, (x, y) in quarters:
    ax.add_patch(Rectangle((x, y), 1, 1, color=fill, lw=0))
    ax.text(
        x + 0.5, y + 0.5, letter,
        ha="center", va="center", color=ink,
        fontsize=260, fontweight="bold", family="DejaVu Sans",
    )

# fold lines
ax.plot([1, 1], [0, 2], color="white", lw=3, ls=(0, (6, 4)))
ax.plot([0, 2], [1, 1], color="white", lw=3, ls=(0, (6, 4)))

fig.savefig(out, metadata={"CreationDate": None, "Creator": None, "Producer": None})
