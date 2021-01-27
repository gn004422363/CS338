#lang racket
(require rackunit)
(require rackunit/text-ui)
; The function maxmin has a list input
; It output a list with max and min values.
; This function run over the list and dtermine the maximum and minimum value, then it returns them as a list
(define (maxmin L)
  (cond
    ((null? L) '()) ;; empty list represents error
    ((null? (cdr L)) (list (car L) (car L))) ;; list of 2 items
    (else (let ((mmtemp (maxmin (cdr L)))
                (first (car L)))
            (cond
              ((> first (car mmtemp))
               (cons first (cdr mmtemp)))
              ((< first (car (cdr mmtemp)))
               (list (car mmtemp) first))
              (else mmtemp))))))
; Call function
; It return (9 0) beacuse they are the max and min elemnt in the list
(maxmin '(5 9 2 1 0 8))
; It return (874 15) beacuse they are the max and min elemnt in the list
(maxmin '(15 99 874 23 51 32 55))

; Test
(check-equal? (maxmin '(5 9 2 1 0 8)) '(9 0))
(check-equal? (maxmin '(15 99 874 23 51 32 55)) '(874 15))
