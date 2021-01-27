#lang racket
; Part 4
; The fucntion B take two elements n and k
; Return 0 if n <= 0, k >= 0, or n >= k.
; Return 1 if k equal to zero or k equal to n.
; Otherwise, recursively calls the function B.
(require rackunit)
(require rackunit/text-ui)
(define (B n k)
  (if (and (>= n 0) (>= k 0) (>= n k))
      (if (or (= k 0) (= k n))
          1
          (+ (B (- n 1) (- k 1))
             (B (- n 1) k)))
      0))
; Return 0 because n less than k
(B 1 2)
; Return 1 because k equal to 0
(B 8 0)
; Return 1 becuase n equal to k
(B 5 5)
; The element n and k pass two if conditionals
(B 7 3)
; The element n and k pass two if conditionals
(B 6 2)

(check-equal? (B 1 2) 0)
(check-equal? (B 8 0) 1)
(check-equal? (B 5 5) 1)
(check-equal? (B 7 3) 35)
(check-equal? (B 6 2) 15)