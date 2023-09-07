#lang racket
(define (is-constant? E) (or (equal? E 'TRUE) (equal? E 'FALSE)))
(define (is-variable? E) (not (or (list? E) (is-constant? E) (equal? E 'OR) (equal? E 'AND)
                        (equal? E 'NOT) (equal? E 'IMPLIES) (equal? E 'EQUIV) (equal? E 'XOR))))
(define (is-OR? E) (and (list? E) (equal? (length E) 3)(equal? (first E) 'OR) (legal? (second E)) (legal? (third E))))
(define (is-XOR? E) (and (list? E) (equal? (length E) 3)(equal? (first E) 'XOR)(legal? (second E)) (legal? (third E))))
(define (is-AND? E) (and (list? E) (equal? (length E) 3) (equal? 'AND (first E))(legal? (second E)) (legal? (third E))))
(define (is-NOT? E) (and (list? E) (equal? (length E) 2)(equal? 'NOT (first E))(legal? (second E))))
(define (is-IMPLIES? E) (and (list? E) (equal? (length E) 3)(equal? 'IMPLIES (first E))(legal? (second E)) (legal? (third E))))
(define (is-EQUIV? E) (and (list? E) (equal? (length E) 3)(equal? 'EQUIV (first E))(legal? (second E)) (legal? (third E))))
(define (legal? E)(or (is-constant? E)(is-variable? E)(is-OR? E)(is-XOR? E)(is-AND? E)(is-NOT? E)(is-IMPLIES? E)(is-EQUIV? E)))
(define/contract (noANDs? E)
  (-> legal? boolean?)
  (cond
    [(or (is-variable? E) (is-constant? E)) #t]
    [(is-AND? E) #f]
    [(is-NOT? E) (noANDs? (second E))]
    [else (and (noANDs? (second E)) (noANDs? (third E)))]))
(define/contract (nnf? E)
  (-> legal? boolean?)
  (cond
    [(or (is-variable? E) (is-constant? E)) #t]
    [(is-NOT? E) (is-variable? (second E))]
    [(or (is-OR? E) (is-AND? E)) (and (nnf? (second E)) (nnf? (third E)))]
    [else #f]))
(define/contract (cnf? E)
  (-> legal? boolean?)
  (cond
    [(or (is-variable? E) (is-constant? E)) #t]
    [(is-NOT? E) (is-variable? (second E))]
    [(is-OR? E) (and (noANDs? (second E)) (nnf? (second E)) (noANDs? (third E)) (nnf? (third E)))]
    [(is-AND? E) (and (cnf? (second E)) (cnf? (third E)))]
    [else #f]))
(define (AND E F) (list 'AND E F))
(define (andNNF E F)
  (cond
    [(or (equal? E 'FALSE) (equal? F 'FALSE)) 'FALSE]
    [(or (equal? F 'TRUE) (equal? E F) (makeNNF E))]
    [(equal? E 'TRUE) (makeNNF F)]
    [(andNNF (makeNNF E) (makeNNF F))]))

(define (OR E F)
  (cond
    [(or (equal? E 'TRUE) (equal? F 'TRUE)) 'TRUE]
    [(equal? E 'FALSE) (makeNNF F)]
    [(or (equal? F 'FALSE) (equal? E F)) (makeNNF E)]
    [(list 'OR (makeNNF E) (makeNNF F))]))
(define (NOT E)
  (cond
    [(is-variable? E) (list 'NOT E)]
    [(equal? E 'TRUE) 'FALSE]
    [(equal? E 'FALSE) 'TRUE]
    [(is-NOT? E) (makeNNF (second E))]
    [(is-AND? E) (OR (NOT (makeNNF (second E))) (NOT (makeNNF (third E))))]
    [(is-OR? E) (AND (NOT (makeNNF (second E))) (NOT (makeNNF (third E))))]
    [else (NOT (makeNNF E))]))
(define (makeNNF E)
  (cond
    [(or (is-variable? E) (is-constant? E)) E]
    [(is-NOT? E) (NOT (second E))]
    [(is-AND? E) (AND (second E) (third E))]
    [(is-OR? E) (OR (second E) (third E))]
    [(is-XOR? E) (AND (OR (makeNNF (second E)) (makeNNF (third E))) (NOT (AND (makeNNF (second E)) (makeNNF (third E)))))]
    [(is-IMPLIES? E) (OR (NOT (makeNNF (second E)))(makeNNF (third E)))]
    [(is-EQUIV? E) (OR (AND (makeNNF (second E)) (makeNNF (third E)))(AND (NOT (makeNNF (second E))) (NOT (makeNNF (third E)))))]))
(define/contract (makeCNF E)
  (-> legal? cnf?)
  (cond
    [(not (nnf? E)) (makeCNF (makeNNF E))]
    [(cnf? E) E]
    [(is-AND? E) (if (or (equal? (second E) 'TRUE)(equal? (third E) 'TRUE)(equal? (second E) 'FALSE)(equal? (third E) 'FALSE)(equal? (second E)(NOT (third E)))(equal? (second E)(third E)))
                     (makeCNF (makeNNF E)) (AND (makeCNF (second E)) (makeCNF (third E))))]
    [(is-OR? E) (cond
                  [(or (equal? (second E) 'TRUE)(equal? (third E) 'TRUE)(equal? (second E) 'FALSE)(equal? (third E) 'FALSE)(equal? (second E)(NOT (third E)))(equal? (second E)(third E))) (makeCNF (makeNNF E))]
                  [(is-AND? (second E)) (AND (makeCNF (OR (third E) (second (second E)))) (makeCNF (OR (third E) (third (second E)))))]
                  [(is-AND? (third E)) (AND (makeCNF (OR (second E) (second (third E)))) (makeCNF (OR (second E) (third (third E)))))]
                  [(and (noANDs? (second E)) (noANDs? (third E))) E]
                  [(makeCNF (OR (makeCNF (second E)) (makeCNF (third E))))])]))








