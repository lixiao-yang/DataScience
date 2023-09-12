#lang racket
(define (prepend-recursive x L)
  (if (null? L)
      '()
      (cons (cons x (first L))
            (prepend-recursive x (rest L)) 
      )))

(define (prepend-non-recursive x L)
  (map (lambda (y) (append (list x) y)) L))

(define (gray_code n)
  (if (= n 1)
      '((0) (1))
      (append 
       (prepend-recursive 0 (gray_code (- n 1)))
       (prepend-recursive 1 (my-reverse (gray_code (- n 1)))))))

(define (my-reverse L)
  (if (null? L)
      '()
      (append (my-reverse (rest L)) (list (first L)))))

; Test
(display (my-reverse '(1 2 3 4 5)))
(prepend-recursive 0 '((0 0) (0 1) (1 1) (1 0)))

; Test
(display (gray_code 3))

(equal? (gray_code 2) '((0 0) (0 1) (1 1) (1 0)))


(equal? (prepend-recursive 0 '()) '())
(equal? (prepend-recursive 0 '((0) (1))) '((0 0) (0 1)))
(equal? (prepend-recursive 0 '((0 0) (0 1) (1 1) (1 0))) '((0 0 0) (0 0 1) (0 1 1) (0 1 0)))
(equal? (prepend-recursive 1 '((0) (1))) '((1 0) (1 1)))
(equal? (prepend-recursive 1 '((0 0) (0 1) (1 1) (1 0))) '((1 0 0) (1 0 1) (1 1 1) (1 1 0)))

(equal? (prepend-non-recursive 0 '()) '())
(equal? (prepend-non-recursive 0 '((0) (1))) '((0 0) (0 1)))
(equal? (prepend-non-recursive 0 '((0 0) (0 1) (1 1) (1 0))) '((0 0 0) (0 0 1) (0 1 1) (0 1 0)))
(equal? (prepend-non-recursive 1 '((0) (1))) '((1 0) (1 1)))
(equal? (prepend-non-recursive 1 '((0 0) (0 1) (1 1) (1 0))) '((1 0 0) (1 0 1) (1 1 1) (1 1 0)))
