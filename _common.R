# Shared set-up, run before every chapter (see before_chapter_script in _bookdown.yml).

options(width = 80, digits = 3)

knitr::opts_chunk$set(
  message = FALSE,
  warning = FALSE,
  fig.align = "center",
  fig.width = 7,
  fig.height = 4,
  out.width = "100%"   # scale every figure to the width of the page
)

set.seed(1)

suppressPackageStartupMessages(library(tidyverse))
theme_set(theme_minimal(base_size = 13))

# The book's ready-made functions: every .R file in R/.
for (file in list.files("R", pattern = "\\.R$", full.names = TRUE)) source(file)

# Run a later chunk's code silently. Chapters show the equation, then the figure, then
# the code; a figure chunk uses this to get the values that the code chunk below it
# computes. Code chunks set their own seeds, so running them twice gives the same numbers.
run_chunk <- function(label) {
  invisible(eval(parse(text = knitr::knit_code$get(label)), envir = knitr::knit_global()))
}

# webexercises is optional; without it, quiz boxes show as plain fields.
if (requireNamespace("webexercises", quietly = TRUE)) {
  library(webexercises)
} else {
  fitb <- function(answer, width = "10em", ...) {
    paste0("<input type=\"text\" disabled=\"disabled\" placeholder=\"answer\" style=\"width:",
           width, ";\">")
  }
  mcq <- function(answer, ...) {
    options <- paste0("<option>", as.character(answer), "</option>", collapse = "")
    paste0("<select disabled=\"disabled\"><option></option>", options, "</select>")
  }
  hide <- function(button_text = "Solution") paste0("<details><summary>", button_text, "</summary>")
  unhide <- function() "</details>"
}

# Chunk option webex.hide = "Button text" folds a chunk behind a button, using hide().
knitr::knit_hooks$set(webex.hide = function(before, options, envir) {
  if (before) {
    if (is.character(options$webex.hide)) hide(options$webex.hide) else hide()
  } else {
    unhide()
  }
})

# Copy the data, functions and exercises into docs/ so the book can link to them.
for (folder in c("data", "R", "exercises")) {
  files <- setdiff(list.files(folder, full.names = TRUE), file.path(folder, ".gitkeep"))
  if (length(files) == 0) next
  dir.create(file.path("docs", folder), recursive = TRUE, showWarnings = FALSE)
  file.copy(files, file.path("docs", folder), overwrite = TRUE)
}
