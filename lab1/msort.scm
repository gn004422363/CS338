#lang racket
(require rackunit)
(require rackunit/text-ui)
; The function metge takes two lists: fst and snd
; It merges two list in sorted order
; If first list is null, return second list. If seond list is null, return first list.
; Otherwise, iterate call funciton split to sort the list
; If the first element in fst list is less than the first element in snd list,
; the output merge list will start will fst's element.
; Otherwise the output merge list will start with snd's element.
(define (merge fst snd)
  (cond
    ((null? fst) snd)
    ((null? snd) fst)
    (else
     (let ((x (car fst)) (y (car snd)))
       (if (< x y) (cons x (merge (cdr fst) snd))
           (cons y (merge fst (cdr snd))))))))
; Test
; It return fst list because snd list has no element
(merge '(1 2 3) '())
; It return snd list because fst list has no element
(merge '() '(4 5 6))
; The output merge list begin with fst's elemenet because the first elemetn in fst is less than snd's element
(merge '(1 2 9) '(4 7 6))
; The output merge list begin with snd's elemenet because the first elemetn in snd is less than fst element
(merge '(99 33 11) '(22 44 66))

; Test
(check-equal? (merge '(1 2 3) '()) '(1 2 3))
(check-equal? (merge '() '(4 5 6)) '(4 5 6))
(check-equal? (merge '(1 2 9) '(4 7 6)) '(1 2 4 7 6 9))
(check-equal? (merge '(99 33 11) '(22 44 66)) '(22 44 66 99 33 11))

; The function split take a list: list
; It splits into two sub lists
; If list is null, return a list of list. Return seond element of the list, if list is not null.
; Otherwise, iterative the function split and take out the seoncd element of the list.
(define (split lis)
  (cond
    ((null? lis) (cons '() '()))
    ((null? (cdr lis)) (cons (list (car lis)) '()))
    (else
     (let ((a (car lis)) (b (car (cdr lis))) (c (split (cdr (cdr lis)))))
       (cons (cons a (car c)) (cons b (cdr c)))))))
; Test
; It returns null list within a list because lis is null list
(split '())
; It splits 73 out because it is the seoncd element in lis
(split '(35 73))
; It splits 35 out because it is the seoncd element in lis
(split '(73 35))
; It splits 2 4 6 8 out because they are the seoncd element in lis
(split '(1 2 3 4 5 6 7 8 9))
; It splits 2 out because it is the seoncd element in lis
(split '(1 2 3))
; It splits 11 66 out because they are the seoncd element in lis
(split '(22 11 33 66))

; Test
(check-equal? (split '()) '(()))
(check-equal? (split '(35 73)) '((35) 73))
(check-equal? (split '(73 35)) '((73) 35))
(check-equal? (split '(1 2 3 4 5 6 7 8 9)) '((1 3 5 7 9) 2 4 6 8))
(check-equal? (split '(1 2 3)) '((1 3) 2))
(check-equal? (split '(22 11 33 66)) '((22 33) 11 66))

; The function msort takes a list: lis
; It takes the list and sorted inorder
; Return null list, if list is empty. Return list, if the list has only one element.
; Otherwise, it splits list into sublists and sort the list. Then merge two splitted sorted lists.
(define (msort lis)
  (cond
    ((null? lis) '())
    ((null? (cdr lis)) lis)
    (else
     (let* ((c (split lis)) (fst (car c)) (snd (cdr c)))
       (merge (msort fst) (msort snd))))))
; Test
; The function return a list in sorted order
(msort '(0 5 8 3 9 5 0 199 245 662 124))
(msort '(-8 3 7532 -9 -2 857 95))
(msort '(9 8 2 7 1 5 0 -1 -3 -6 -8))

; Test
(check-equal? (msort '(0 5 8 3 9 5 0 199 245 662 124)) '(0 0 3 5 5 8 9 124 199 245 662))
(check-equal? (msort '(-8 3 7532 -9 -2 857 95)) '(-9 -8 -2 3 95 857 7532))
(check-equal? (msort '(9 8 2 7 1 5 0 -1 -3 -6 -8)) '(-8 -6 -3 -1 0 1 2 5 7 8 9))
