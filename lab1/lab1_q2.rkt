#lang racket
(require rackunit)
(require rackunit/text-ui)
; Part 2, i
; tail-fact is a tail recursive function
; The function fact take one element: n
; return 1 if n is zero. Otherwise iterarive call function fact
(define (tail-fact n [acc 1])
  (cond
    [(= n 0) 1]
    [(= n 1) acc]
      [else (tail-fact (- n 1) (* n acc))]
      ))
(display "Factorial Tail Recursive\n")
(tail-fact 0)
(tail-fact 1)
(tail-fact 2)
(tail-fact 5)
(check-equal? (tail-fact 0) 1)
(check-equal? (tail-fact 1) 1)
(check-equal? (tail-fact 2) 2)
(check-equal? (tail-fact 5) 120)

; fact is a non-tail recursive function
(define (fact n)
    (if (= n 0)
        1
        (* n (fact (- n 1)))))
; Print function
(display "Factorial Non Tail Recursive\n")
(fact 0)
(fact 1)
(fact 2)
(fact 5)
(check-equal? (fact 0) 1)
(check-equal? (fact 1) 1)
(check-equal? (fact 2) 2)
(check-equal? (fact 5) 120)

; Part 2, ii
; non-expt is a non-tail recursive function
; The function power take one element: n
; Return 1 if n equals 1. Otherwise iterative call the function with n - 1
; and add each step multiple 2.
(define (power n)
  (*
   (cond
     ((= n 1) 1)
     (else (power (- n 1)))
     )
   2
   ))

; Call the function
(display "Exponential Non Tail Recursive\n")
(power 10)
(power 5)

; expt is a tail recursive function
; The function expt take one element: n
; Return 1 if n is zero. Otherwise 2call the function with n - 1
(define (expt n)
      (if (= n 0)
        1
        (* 2 (expt (- n 1)))
        ))
; Print function
(display "Exponential Tail Recursive\n")
(expt 0)
(expt 1)
(expt 2)
(expt 10)
(check-equal? (expt 0) 1)
(check-equal? (expt 1) 2)
(check-equal? (expt 2) 4)
(check-equal? (expt 10) 1024)

; Part 2, iii
; The function compose takes 3 elements: g f x
; It used the expt and fact function to construc 2^n!
(define (compose g f x) (g (f x)))
(display "compose\n")
(compose expt fact 1)
(compose expt fact 2)
(compose expt fact 3)
(check-equal? (compose expt fact 1) 2)
(check-equal? (compose expt fact 2) 4)
(check-equal? (compose expt fact 3) 64)




