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

# The marker that tools/racket-eval.rkt prints before each form's output.
racket_form_marker <- "\x1f"

# Split the evaluator's output into knitr's alternating source and output
# pieces: each marker line gives the position of a form's last character in
# `code`, and the lines after it, up to the next marker, are its output.
racket_pieces <- function(code, out) {
  is_marker <- startsWith(out, racket_form_marker)
  marker_lines <- out[is_marker]
  end_text <- substring(marker_lines, 2L)
  ends <- as.integer(end_text)
  group <- cumsum(is_marker)
  output_group <- factor(group[!is_marker], levels = seq_along(ends))
  outputs <- split(out[!is_marker], output_group)
  # Text before the first marker is a message from Racket itself.
  preamble <- out[group == 0]

  # Any text after the last form, such as a trailing comment, goes with it.
  if (length(ends) > 0) ends[length(ends)] <- nchar(code)
  pieces <- list()
  if (length(preamble) > 0) {
    preamble_text <- paste0(preamble, "\n", collapse = "")
    pieces <- list(preamble_text)
  }
  # Consecutive forms with no output, such as definitions, stay one piece of
  # source, so the blank lines between them survive.
  start <- 1L
  for (i in seq_along(ends)) {
    has_output <- length(outputs[[i]]) > 0
    if (!has_output && i < length(ends)) next
    src <- substr(code, start, ends[i])
    src <- sub("^\n+", "", src)
    src <- sub("\n+$", "", src)
    source_piece <- structure(list(src = src), class = "source")
    pieces <- c(pieces, list(source_piece))
    if (has_output) {
      output_text <- paste0(outputs[[i]], "\n", collapse = "")
      pieces <- c(pieces, list(output_text))
    }
    start <- ends[i] + 1L
  }
  # A chunk of comments alone has no forms, and is shown as written.
  if (length(ends) == 0) {
    source_piece <- structure(list(src = code), class = "source")
    pieces <- c(pieces, list(source_piece))
  }
  pieces
}

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
    code <- paste(options$code, collapse = "\n")
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
    # No trailing newline, so positions match `code` exactly.
    writeChar(code, chunk_file, eos = NULL, useBytes = FALSE)

    args <- shQuote(c(evaluator, prior_file, chunk_file))
    # system2() warns on a non-zero exit status; the status is checked below.
    out <- suppressWarnings(
      system2(racket, args, stdout = TRUE, stderr = TRUE)
    )
    status <- attr(out, "status")
    failed <- !is.null(status) && status != 0
    if (failed && !isTRUE(options$error)) {
      shown <- out[!startsWith(out, racket_form_marker)]
      message_text <- paste(shown, collapse = "\n")
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

    pieces <- racket_pieces(code, out)
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
