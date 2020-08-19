#lang sicp

; (+ 21 35 12 7)
; 
; (+ (* 3 5) (- 10 9))
; 
; (define size 2)
; 
; (* 5 size)
; 
; (define pi 3.14149)
; 
; (define radius 10)
; 
; (* pi (* radius radius))
; 
(define (square x) (* x x))
 
 (square (square 3))
; 
 (define (sum-of-squares x y)
   (+ (square x) (square y)))
; 
 (sum-of-squares 4 6)
; 
 ; 1.1.6
 
 (define (abs1 x)
   (cond ((< x 0) (- x))
         ((= x 0) (0))
         ((> x 0) (x))))
 
 (abs1 -10)
 
 (define (abs2 x)
   (cond ((< x 0) (- x))
         (else x)))
 
 (abs2 -19)
 
 (define (abs3 x)
   (if (< x 0)
       (- x)
       x))
 
 (abs3 -16)
 (define (>= x y)
   (not (< x y)))
; 
; 1.1.7

; (define (square x) (* x x))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

; |guess * guess - x| < 0.001
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(sqrt 9)
