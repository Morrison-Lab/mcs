# Split the output of tools/racket-eval.rkt into knitr's pieces (mcs#131).
# Used by the racket engine in tools/racket-engine.R, which sources this file.

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
  ends[length(ends)] <- nchar(code)
  # A chunk with no complete form, such as comments alone or code Racket
  # cannot read, is shown as written, followed by any message.
  if (length(ends) == 0) {
    source_piece <- structure(list(src = code), class = "source")
    pieces <- list(source_piece)
    if (length(preamble) > 0) {
      preamble_text <- paste0(preamble, "\n", collapse = "")
      pieces <- c(pieces, list(preamble_text))
    }
    return(pieces)
  }
  pieces <- list()
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
  pieces
}
