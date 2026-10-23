# Contributing to the CSCI 201 notes

These are the lecture notes for CSCI 201, math for computer science.
Style and conventions live in [CLAUDE.md](CLAUDE.md) and [`.github/copilot-instructions.md`](.github/copilot-instructions.md);
this file covers the workflow.

Never commit an answer to anything that is graded:
assessments, solutions and labs belong in the private `Morrison-Lab/mcsg` repository.

## Workflow

1. Clone with the submodules, or fetch them after cloning:

   ```bash
   git submodule update --init --recursive
   ```

2. Create a branch for your work:

   ```bash
   git checkout -b <topic>
   ```

3. Edit or add pages.
   A chapter is `chapters/<topic>.qmd`, with its units in `chapters/_subfiles/<topic>/`, one div per file.
   Add each new chapter to both the navbar and the sidebar in `_quarto-website.yml`, in course order.

4. Preview your changes locally:

   ```bash
   quarto preview
   ```

   or render just the page you changed:

   ```bash
   quarto render chapters/<topic>.qmd --to html
   ```

5. Commit, push, and open a pull request.
   Each pull request gets a preview build, and the checks below.

## Checks

- **Spelling**: add legitimate words to `inst/WORDLIST` rather than disabling the check.
- **Links**: an automated link checker runs on every pull request and weekly.
  Prefer HTTPS and permanent links, and fix a broken link rather than excluding it in `lychee.toml`.
  If you have checked every link in your pull request by hand, the **`links checked by hand`** label skips the check for that pull request.
- **Bibliography DOIs** and **non-standard characters**: fix the flagged source rather than relaxing the check.

## Images

Put figures in `images/` and reference them from a figure div:

```markdown
::: {#fig-label}
![](images/your-image.png)

Caption text.
:::
```

## Citations

Add BibTeX entries to `references.bib` and cite them in the text as `@key`.
Cite only sources you have read; never invent a citation.

## Questions

Open an issue in the repository.
