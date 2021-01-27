#lang racket
(require rackunit)
(require rackunit/text-ui)

; Function square to preforms square calculation
(define (square x) (* x x))

; Function fib compute the Fibonacci numbers
(define (fib n)
  (fib-iter 1 0 0 1 n))

; Function fib-iter recall the transformation to the state variables a and b
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
	((even? count)
	 (fib-iter a
		   b
		   (+ (square p) (square q))      ; compute p'
		   (+ (* 2 p q) (square q))       ; compute q'
		   (/ count 2)))
	(else
	  (fib-iter (+ (* b q) (* a q) (* a p))
		    (+ (* b p) (* a q))
		    p
		    q
		    (- count 1)))))

; Test
(define lab2
  (test-suite
   "Lab2"
   (test-case "fib"
              (check-equal? (fib 0)
              0)
              (check-equal? (fib 1)
              1)
              (check-equal? (fib 9)
              34)
              (check-equal? (fib 10)
              55)
              (check-equal? (fib 100)
              354224848179261915075)
              )))

(when (not (eq? (run-tests lab2) 0))
    (exit 1))



                    