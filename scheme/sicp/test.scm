#lang sicp


(inc 42)

((lambda (x) (+ x 2)) 5)

; error
; ((lambda x (+ x 12)) 5)

(define (factorial n)
  (if (= 0 n)
      1
      (* n (factorial (- n 1)))))

(factorial 10)

(= 1 1) ; => #t


