#lang racket

(require racket/trace)

(define (mul a b)
  (define (iter count acc)
    (if (zero? count)
        acc
        (iter (- count 1) (+ acc a))))
  (iter b 0))

(trace mul)
(mul 343 799)

