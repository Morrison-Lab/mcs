# A knitr engine for `racket` chunks (Morrison-Lab/mcs#131).
#
# knitr has no Racket engine, and neither does Quarto, so a page that runs
# Racket code registers this one in a hidden setup chunk;
# the include `chapters/_subfiles/_racket-setup.qmd` does that.
#
# Each chunk runs in a fresh `racket` process (`tools/racket-eval.rkt`),
# which first replays the page's earlier `racket` chunks with their output
# discarded, so a chunk can use what an earlier one defined, as R chunks can.
# The page shows each top-level form of the chunk followed by its value,
# printed as the Racket REPL prints it, as R chunks show each expression.
#
# A chunk that raises an error stops the render,
# unless it sets `#| error: true`, in which case the page shows Racket's
# message.

register_racket_engine <- function(evaluator) {
  evaluator <- normalizePath(evaluator, mustWork = TRUE)
  # racket_pieces() and racket_form_marker live beside the evaluator.
  tools_dir <- dirname(evaluator)
  pieces_file <- file.path(tools_dir, "racket-pieces.R")
  helpers <- new.env()
  sys.source(pieces_file, envir = helpers)
  racket <- Sys.which("racket")
  if (!nzchar(racket)) {
    stop(
      "The `racket` executable is not on PATH. ",
      "Install Racket (Debian/Ubuntu: `apt-get install racket`) to render ",
      "pages with racket chunks."
    )
  }
  # The code of each chunk evaluated so far, one string per chunk,
  # keyed by the document being knit.
  history <- new.env(parent = emptyenv())

  engine <- function(options) {
    code <- paste(options$code, collapse = "\n")
    if (!isTRUE(options$eval)) {
      no_output <- character()
      return(knitr::engine_output(options, code, no_output))
    }
    doc <- knitr::current_input(dir = TRUE)
    if (is.null(doc)) doc <- ""
    prior <- get0(doc, envir = history, inherits = FALSE)
    if (is.null(prior)) prior <- character()

    # Each earlier chunk goes in its own file, so that replay can stop a
    # chunk at its first error, as the chunk stopped when it ran.
    new_prior_file <- function(i) tempfile("prior", fileext = ".rkt")
    prior_files <- vapply(seq_along(prior), new_prior_file, character(1))
    chunk_file <- tempfile(fileext = ".rkt")
    on.exit(unlink(c(prior_files, chunk_file)), add = TRUE)
    for (i in seq_along(prior)) {
      writeChar(prior[i], prior_files[i], eos = NULL)
    }
    # No trailing newline, so positions match `code` exactly.
    writeChar(code, chunk_file, eos = NULL)

    args <- shQuote(c(evaluator, chunk_file, prior_files))
    # system2() warns on a non-zero exit status; the status is checked below.
    out <- suppressWarnings(
      system2(racket, args, stdout = TRUE, stderr = TRUE)
    )
    status <- attr(out, "status")
    failed <- !is.null(status) && status != 0
    if (failed && !isTRUE(options$error)) {
      shown <- out[!startsWith(out, helpers$racket_form_marker)]
      message_text <- paste(shown, collapse = "\n")
      stop(
        "racket chunk '", options$label, "' failed:\n", message_text,
        call. = FALSE
      )
    }
    attr(out, "status") <- NULL
    assign(doc, c(prior, code), envir = history)
    # The project's `comment: "#>"` suits R, where `#` starts a comment.
    # In Racket `#>` is not a comment, so prefix output with `;` instead,
    # and a reader who copies a collapsed chunk can still run it.
    if (identical(options$comment, "#>")) options$comment <- ";"

    pieces <- helpers$racket_pieces(code, out)
    if (isFALSE(options$echo)) {
      is_source <- vapply(pieces, inherits, logical(1), what = "source")
      pieces <- pieces[!is_source]
    }
    if (identical(options$results, "hide")) {
      is_output <- vapply(pieces, is.character, logical(1))
      pieces <- pieces[!is_output]
    }
    knitr::engine_output(options, out = pieces)
  }

  knitr::knit_engines$set(racket = engine)
  invisible(engine)
}
