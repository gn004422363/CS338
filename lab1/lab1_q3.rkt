#lang racket
(require rackunit)
(require rackunit/text-ui)
; Part 3, i
; The function range has three elements: start, step, and stop.
; It returns the list of integers that is equal to start:step:stop
; Return empty list if start is less than end.
; Otherwuse, add the first elelemnt.
; Call the fucntion if the start less than end
(define (range r)
  (append
   (cond
     ((> (list-ref r 0) (list-ref r 2)) '())
     (else (list (list-ref r 0)))
     )
   (if (< (list-ref r 0) (list-ref r 2))
       (range (list (+ (list-ref r 0) (list-ref r 1)) (list-ref r 1) (list-ref r 2))) '())
   )
  )
;call the function
(range '(0 2 7))
(range '(2 2 0))
(range '(1 2 3))

; Test Cases
(check-equal? (range '(0 2 7))
                  '(0 2 4 6))
(check-equal? (range '(2 2 0))
                  '())
(check-equal? (range '(1 2 3))
                  '(1 3))
    

; Part 3, ii
(define (seq (start step end))
  seq(
      seq((
           if(((start+n*step) <= end),(start+n*step),exit(1))), (start, step,end)), (1,1,n)))

(seq (lambda (x) (* x x)) '(0 2 7))yyyyy

