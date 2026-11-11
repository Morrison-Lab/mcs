#lang racket/base
;; Evaluate one knitr `racket` chunk, as DrRacket's interactions window would.
;;
;; Usage: racket racket-eval.rkt PRIOR-FILE CHUNK-FILE
;;
;; PRIOR-FILE holds the code of the page's earlier `racket` chunks.
;; It is evaluated first, with its output discarded, so a chunk can use what
;; an earlier one defined. CHUNK-FILE is the chunk itself: each top-level form
;; is evaluated in turn, and every value that is not void is printed the way
;; the REPL prints it (`'(1 2 3)`, `"text"`, `#t`).
;;
;; An error in the chunk prints Racket's message on standard output and exits
;; with status 1, so the knitr engine (tools/racket-engine.R) can stop the
;; render, or show the message when the chunk sets `error: true`.
;; An error in PRIOR-FILE is skipped: the chunk that raised it has already
;; been shown or has already stopped the render.

(require racket/port)

(define args (current-command-line-arguments))
(unless (= (vector-length args) 2)
  (raise-user-error 'racket-eval "usage: racket racket-eval.rkt PRIOR-FILE CHUNK-FILE"))
(define prior-file (vector-ref args 0))
(define chunk-file (vector-ref args 1))

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

;; Earlier chunks: run for their definitions, silently.
(parameterize ([current-output-port (open-output-nowhere)]
               [current-error-port (open-output-nowhere)])
  (for-each-form prior-file
                 (lambda (form)
                   (with-handlers ([exn:fail? void])
                     (eval-form form)))))

;; This chunk: run and print, stopping at the first error.
(with-handlers ([exn:fail?
                 (lambda (e)
                   (flush-output)
                   (printf "~a\n" (exn-message e))
                   (exit 1))])
  (for-each-form chunk-file
                 (lambda (form)
                   (print-values (eval-form form))))
  (flush-output))
