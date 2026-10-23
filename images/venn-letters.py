"""Draw the Venn diagram of the letters of LOGIC and MAGIC (chapters/sets.qmd)."""
import sys

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import Circle, Rectangle

out = sys.argv[1]

fig, ax = plt.subplots(figsize=(6, 3.6), dpi=200)
ax.set_xlim(0, 10)
ax.set_ylim(0.6, 6)
ax.set_aspect("equal")
ax.axis("off")

ax.add_patch(Rectangle((0.2, 0.7), 9.6, 5.1, fill=False, lw=1.5))
ax.text(9.6, 5.5, "S", ha="right", va="top", fontsize=13, style="italic")

# shade the overlap L n M by clipping a filled M circle to L
overlap = Circle((6.1, 3.2), 2.2, color="#9ecae1", zorder=0)
ax.add_patch(overlap)
overlap.set_clip_path(Circle((3.9, 3.2), 2.2, transform=ax.transData))

for center in ((3.9, 3.2), (6.1, 3.2)):
    ax.add_patch(Circle(center, 2.2, fill=False, lw=1.5))

ax.text(2.3, 5.25, "L", fontsize=14, style="italic")
ax.text(7.5, 5.25, "M", fontsize=14, style="italic")

for x, letters in ((2.8, ["L", "O"]), (5.0, ["G", "I", "C"]), (7.2, ["M", "A"])):
    ys = [3.2 + 0.6 * (len(letters) - 1) / 2 - 0.6 * i for i in range(len(letters))]
    for y, letter in zip(ys, letters):
        ax.text(x, y, letter, ha="center", va="center", fontsize=13)

fig.savefig(out, bbox_inches="tight", facecolor="white")
print("wrote", out)
