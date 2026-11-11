# A knitr engine for `racket` chunks (Morrison-Lab/mcs#131).
#
# knitr has no Racket engine, and neither does Quarto, so a page that runs
# Racket code registers this one in a hidden setup chunk;
# the include `chapters/_subfiles/_racket-setup.qmd` does that.
#
# Each chunk runs in a fresh `racket` process (`tools/racket-eval.rkt`),
# which first replays the page's earlier `racket` chunks with their output
# discarded, so a chunk can use what an earlier one defined, as R chunks can.
# The page shows the chunk's code, then the value of each top-level form that
# is not void, printed as the Racket REPL prints it.
#
# A chunk that raises an error stops the render,
# unless it sets `#| error: true`, in which case the page shows Racket's
# message.

register_racket_engine <- function(evaluator) {
  evaluator <- normalizePath(evaluator, mustWork = TRUE)
  racket <- Sys.which("racket")
  if (!nzchar(racket)) {
    stop(
      "The `racket` executable is not on PATH. ",
      "Install Racket (Debian/Ubuntu: `apt-get install racket`) to render ",
      "pages with racket chunks."
    )
  }
  # The code of the chunks evaluated so far, keyed by the document being knit.
  history <- new.env(parent = emptyenv())

  engine <- function(options) {
    code <- options$code
    if (!isTRUE(options$eval)) {
      no_output <- character()
      return(knitr::engine_output(options, code, no_output))
    }
    doc <- knitr::current_input(dir = TRUE)
    if (is.null(doc)) doc <- ""
    prior <- history[[doc]]
    if (is.null(prior)) prior <- character()

    prior_file <- tempfile(fileext = ".rkt")
    chunk_file <- tempfile(fileext = ".rkt")
    on.exit(unlink(c(prior_file, chunk_file)), add = TRUE)
    writeLines(prior, prior_file)
    writeLines(code, chunk_file)

    args <- shQuote(c(evaluator, prior_file, chunk_file))
    # system2() warns on a non-zero exit status; the status is checked below.
    out <- suppressWarnings(
      system2(racket, args, stdout = TRUE, stderr = TRUE)
    )
    status <- attr(out, "status")
    failed <- !is.null(status) && status != 0
    if (failed && !isTRUE(options$error)) {
      message_text <- paste(out, collapse = "\n")
      stop(
        "racket chunk '", options$label, "' failed:\n", message_text,
        call. = FALSE
      )
    }
    attr(out, "status") <- NULL
    history[[doc]] <- c(prior, code)
    # The project's `comment: "#>"` suits R, where `#` starts a comment.
    # In Racket `#>` is not a comment, so prefix output with `;` instead,
    # and a reader who copies a collapsed chunk can still run it.
    if (identical(options$comment, "#>")) options$comment <- ";"
    knitr::engine_output(options, code, out)
  }

  knitr::knit_engines$set(racket = engine)
  invisible(engine)
}
