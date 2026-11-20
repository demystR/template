# book-template

The shared skeleton for every book in the [demystR](https://demystr.github.io) series:
the bookdown set-up, the demystR theme, the build-and-deploy workflow, the licence and
the folder layout. Start each new book from it with **Use this template**.

## Starting a new book

1. On this repo's page, click **Use this template > Create a new repository**, choose the
   `demystR` organisation, and name it after the book (`nhst`, `glmm`, ...).
2. Rename `book.Rproj` to `<name>.Rproj`, and set `book_filename` in `_bookdown.yml` to
   the same name.
3. In `index.Rmd`, set the title and description and write the overview.
4. Replace `1a-first-chapter.Rmd` with the real chapters, and list them in order under
   `rmd_files` in `_bookdown.yml`.
5. Rewrite this README for the book (what it covers, its chapters, its data).
6. In the new repo's **Settings > Pages**, set **Source** to **GitHub Actions**. The next
   push to `main` builds the book and publishes it.
7. Add the book to the series homepage, `demystR.github.io`.

## Render locally

```r
install.packages(c("bookdown", "tidyverse", "downlit", "xml2"))
bookdown::render_book("index.Rmd", "bookdown::bs4_book")
```

The rendered HTML is written to `docs/`, which is not committed. On every push to
`main`, `.github/workflows/deploy.yml` installs R and the packages, renders the book and
deploys `docs/` to GitHub Pages. `downlit` and `xml2` are listed there because
`bs4_book` needs them and they are not installed with bookdown.

## Conventions

- Each idea gets an **equation, a picture and the code**, usually in that order.
- Data handling and figures use the **tidyverse** (`read_csv()`, `dplyr` pipelines with
  `|>`, `ggplot2`). Models use the **base-R** functions (`lm()`, `glm()`, `optim()`, ...).
- Each book **stands alone**, with its own ready-made functions in `R/`, and links to the
  other books where it builds on them.

## Structure

- `index.Rmd`: overview, who the book is for, how it is organised, licence.
- `1a-first-chapter.Rmd`: a placeholder chapter. Files are named by part and position
  (`1a`, `1b`, ..., `2a`, ..., `A-` for appendices), and each chapter has an `{#id}`.
- `_bookdown.yml`: chapter order and output folder. `_output.yml`: the `bs4_book` format
  and theme.
- `_common.R`: run before every chapter. Sets chunk options and the ggplot theme, loads
  the tidyverse and every file in `R/`, defines `run_chunk()`, and copies `data/`, `R/`
  and `exercises/` into `docs/` so the book can link to them.
- `R/`: the book's ready-made functions, under chapter headings.
- `data/`: data used in the book. Put the scripts that make them in `data-raw/`.
- `exercises/`: one `.Rmd` per chapter (`1a-first-chapter-exercises.Rmd`) and
  `my_functions.R`, the reader's own toolbox that the exercise files build up.
- `include/`: the shared demystR theme. `demystR.css` sets the colours, fonts and
  callout boxes (`summary-box`, `note`), `header.html` adds the favicon, and
  `demystR-footer.html` puts the series line and licence in the footer. Keep these the
  same in every book: change them here first, then copy to each book.
- `book.css`: this book's own rules, such as the list of unwritten chapters shown in
  grey italics in the contents.

## Licence

Text, figures and data: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
Code: MIT. See [LICENSE.md](LICENSE.md).
