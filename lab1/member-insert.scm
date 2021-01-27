#lang racket
(require rackunit)
(require rackunit/text-ui)
; The member function has two arguments: a element (x) and a list (L)
; The function checks the element, whether present in the list of not.
; Return true if the element present in the list. Else return false.
(define (member x L)
  (cond
    ((null? L) #f)
    ((equal? x (car L)) #t)
    (else (member x (cdr L)))))
; Test function
; It will return true because 9 is in the list
(member 9 '(1 7 2 3 9))
; It will return false because 2 not in the list
(member 2 '(8 9 3 7 1))
; The insert function has two arguments: a element (x) and a list (L)
; The function inserts the element into the list, if the element it is not in the list
; This function checkes the element, whether include or using the function member
; Return same list if the element exist in the list. Otherwise, return the new list with the new element.
(define (insert x L)
  (if (member x L) L
      (cons x L)))
; Test function
; It return same list because 3 already exist
(insert 3 '(8 0 2 1 6 3))
; It return a new list because 0 doesn't exist in the list.
(insert 0 '(5 3 4 1 6 4 8 7))
; Test
(check-equal? (member 9 '(1 7 2 3 9)) #t)
(check-equal? (member 2 '(8 9 3 7 1)) #f)
(check-equal? (insert 3 '(8 0 2 1 6 3)) '(8 0 2 1 6 3))
(check-equal? (insert 0 '(5 3 4 1 6 4 8 7)) '(0 5 3 4 1 6 4 8 7))