#lang racket
;Huffman Encoding and Decoding Implementation from SICP
(require rackunit)
(require rackunit/text-ui)

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (decode bits tree)
(define (decode-1 bits current-branch)
  (if (null? bits)
      '()
      (let ((next-branch
             (choose-branch (car bits) current-branch)))
        (if (leaf? next-branch)
            (cons (symbol-leaf next-branch)
                  (decode-1 (cdr bits) tree))
            (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))


(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (element-of-set? x set)
  (cond ((empty? set) false)
        ((eq? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair) ; symbol
                               (cadr pair)) ; frequency
                    (make-leaf-set (cdr pairs))))))

;Used to generate the nodes and leaves of the huffman tree by comparing frequency of letters
;; and generating the trees based on which frequency is greater and smaller by recursively calling the
;; successive-merge with the make-code-tree generating the tree and nodes.
(define (successive-merge leaf-set)
  (if (empty? (cdr leaf-set))
      (car leaf-set)
      (successive-merge
       (adjoin-set (make-code-tree (car leaf-set)
                                   (cadr leaf-set))
                   (cddr leaf-set)))))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

;;Takes as an input the message as a list and a tree as a list of pairs.
; Traverses through the tree and generates a list consisting of 1 and 0
; when a character is found until the wanted cahracter is found before
;repeating the process for the final encoded message.
(define (encode-symbol letter tree)
  (if (leaf? tree)
      empty
      (let ((left (left-branch tree))
        (right (right-branch tree)))
        (cond ((element-of-set? letter (symbols left))
               (cons 0 (encode-symbol letter left)))
              ((element-of-set? letter (symbols right))
               (cons 1 (encode-symbol letter right)))
              (else (error "character not in tree"))))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define fig12 '((F 27) (E 23) (D 22) (C 12) (B 9) (A 7)))
(define tree (generate-huffman-tree fig12))
(define input '(B A D F A D E C))

(define encoded-message (encode input tree))
(define decoded (decode encoded-message tree))

tree
encoded-message
decoded

(define hw2
  (test-suite
   "HW2"
   (test-case "encode"
    (check-equal? tree
                  '(((leaf D 22) (leaf E 23) (D E) 45) ((leaf F 27) ((leaf C 12) ((leaf A 7) (leaf B 9) (A B) 16) (C A B) 28) (F C A B) 55) (D E F C A B) 100)
                  "tree")
    
    (check-equal? encoded-message
                  '(1 1 1 1 1 1 1 0 0 0 1 0 1 1 1 0 0 0 0 1 1 1 0)
                  "encoded")
    
    (check-equal? decoded
                  input
                  "decoded"))
   
   
   ))

(when (not (eq? (run-tests hw2) 0))
   (exit 1))