#lang racket/base
;; Evaluate one knitr `racket` chunk, as DrRacket's interactions window would.
;;
;; Usage: racket racket-eval.rkt CHUNK-FILE [PRIOR-FILE ...]
;;
;; Each PRIOR-FILE holds the code of one of the page's earlier `racket`
;; chunks, in page order. They are evaluated first, with their output
;; discarded, so a chunk can use what an earlier one defined. CHUNK-FILE is
;; the chunk itself: each top-level form is evaluated in turn, and every
;; value that is not void is printed the way the REPL prints it
;; (`'(1 2 3)`, `"text"`, `#t`).
;;
;; An error in the chunk, while reading or evaluating, prints Racket's
;; message on standard output and exits with status 1, so the knitr engine
;; (tools/racket-engine.R) can stop the render, or show the message when the
;; chunk sets `error: true`.
;; An error in a PRIOR-FILE stops that file where the error is, as it stopped
;; the chunk when the chunk itself ran, and replay goes on with the next
;; file: that chunk has already been shown or has already stopped the render.

(require racket/port)

(define args (vector->list (current-command-line-arguments)))
(when (null? args)
  (raise-user-error 'racket-eval
                    "usage: racket racket-eval.rkt CHUNK-FILE [PRIOR-FILE ...]"))
(define chunk-file (car args))
(define prior-files (cdr args))

;; The chunks are written in `#lang racket`, so evaluate them there.
(define ns (make-base-empty-namespace))
(parameterize ([current-namespace ns])
  (namespace-require 'racket))

;; Read every top-level form of `file`, then call `handle` on each in turn.
(define (for-each-form file handle)
  (call-with-input-file file
    (lambda (in)
      (port-count-lines! in)
      (let loop ()
        (define form (read-syntax file in))
        (unless (eof-object? form)
          (handle form)
          (loop))))))

(define (eval-form form)
  (parameterize ([current-namespace ns])
    (call-with-values (lambda () (eval form)) list)))

(define (print-values vs)
  (parameterize ([current-namespace ns])
    (for ([v (in-list vs)])
      (unless (void? v)
        ((current-print) v)))))

;; Earlier chunks: run for their definitions, silently,
;; each one up to its first error.
(parameterize ([current-output-port (open-output-nowhere)]
               [current-error-port (open-output-nowhere)])
  (for ([file (in-list prior-files)])
    (with-handlers ([exn:fail? void])
      (for-each-form file eval-form))))

;; Start a new line unless the output is already at the start of one,
;; so that output from `display` cannot run into the next marker.
(port-count-lines! (current-output-port))
(define (end-line)
  (define-values (line col pos) (port-next-location (current-output-port)))
  (unless (eqv? col 0)
    (newline)))

;; This chunk: run and print, stopping at the first error.
;; Before each form, print a marker line: the ASCII unit separator character
;; (U+001F) and the position of the form's last character in CHUNK-FILE,
;; counted in characters from 1. The engine uses the markers to show each
;; form's output right after the form.
(define marker (string (integer->char #x1F)))
(with-handlers ([exn:fail?
                 (lambda (e)
                   (flush-output)
                   (end-line)
                   (printf "~a\n" (exn-message e))
                   (exit 1))])
  (for-each-form chunk-file
                 (lambda (form)
                   (printf "~a~a\n" marker
                           (+ (syntax-position form) (syntax-span form) -1))
                   (print-values (eval-form form))
                   (end-line)))
  (flush-output))
