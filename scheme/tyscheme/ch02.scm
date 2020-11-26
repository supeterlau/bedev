#lang sicp
; https://ds26gte.github.io/tyscheme/index-Z-H-4.html

(display (boolean? #t))
(newline)

(display (not #t))
(newline)

(display (rational? 3.1416))
(newline)

(display (rational? 3.1416+2i))
(newline)

(display (eqv? 42 42.0))
(newline)

; ERROR
;(display (= 42 "42.0"))
;(newline)

(display (char-upcase #\a))
(newline)

(define xyz 999)
(display xyz)
(newline)

(set! xyz #\c)
(display xyz)
(newline)

(display (string-append "Who" " " "are" " " "you"))
(newline)

(display (vector 1 2 3 51 0))
(newline)


