;type your name after the colon: Yixuan Song

#lang racket
(require rackunit)
(require rackunit/text-ui)
(require racket/format) ; needed to use ~a to convert integers to strings

; Instructor supplied functions
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

#| Also, here is an example of a useful utility function (I used it in the supplied dimacs function, but you may
also wish to use it in the cnf function you implement yourself) 

input contract: E is the representation of the logical expression, expr
output contract: (noANDs? E) returns #t if there are no conjunctions in expr, and #f otherwise.  |#
(define/contract (noANDs? E)
  (-> legal? boolean?)
  (cond
    [(or (is-variable? E) (is-constant? E)) #t]
    [(is-AND? E) #f]
    [(is-NOT? E) (noANDs? (second E))]
    [else (and (noANDs? (second E)) (noANDs? (third E)))]))

; Question 1: write a function according to the specifications below
; input contract: E is the representation of the logical expression, expr
; output contract: (cnf? E) returns #t if expr is CNF, and #f otherwise
; Examples: (cnf? '(AND (OR X (OR Y (NOT Z))) (AND (NOT X) TRUE))) should return #t since "(x ∨ y ∨ ¬z) ∧ x ∧ true" is in CNF,
; also, (cnf? '(AND (OR X Y) (OR X (AND Y Z)))) should return #f since "(x ∨ y) ∧ (x ∨ (y ∧ z))" is not in CNF 
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
; note that any helpers must occur before the ;end as well 
;end

; Question 2: write a function according to the specifications below
; input contract: E is the representation of the logical expression, expr
; output contract: (makeCNF E) returns a representation of expr in CNF
; Requirements: the best way to implement this would be to first create helper functions nnf? and makeNNF? and then use those.
; Examples:  (makeCNF '(IMPLIES P (AND Q R))) would be '(AND (OR (NOT P) Q) (OR (NOT P) R))

(define (AND E F)
  (cond
    [(or (equal? E F) (equal? F 'TRUE)) E]
    [(equal? E 'TRUE) F]
    [(or (equal? E (NOT F)) (equal? E 'FALSE) (equal? F 'FALSE)) 'FALSE]
    [else (list 'AND E F)]))
(define (OR E F)
  (cond
    [(or (equal? E F) (equal? F 'FALSE)) E]
    [(equal? E 'FALSE) F]
    [(or (equal? E (NOT F)) (equal? E 'TRUE) (equal? F 'TRUE)) 'TRUE]
    [else (list 'OR E F)]))
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
    [(is-AND? E) (if (and (nnf? (second E)) (nnf? (third E)))
                   (AND (second E) (third E))
                   (makeNNF (AND (makeNNF (second E)) (makeNNF (third E)))))]
    [(is-OR? E) (if (and (nnf? (second E)) (nnf? (third E)))
                   (OR (second E) (third E))
                   (makeNNF (OR (makeNNF (second E)) (makeNNF (third E)))))]
    [(is-XOR? E) (AND (OR (second E) (third E)) (NOT (AND (second E) (third E))))]
    [(is-IMPLIES? E) (OR (NOT (second E))(third E))]
    [(is-EQUIV? E) (OR (AND (second E) (third E))(AND (NOT (second E)) (NOT (third E))))]))
(define/contract (makeCNF E)
  (-> legal? cnf?)
  (cond
    [(not (nnf? E)) (makeCNF (makeNNF E))]
    [(cnf? E) E]
    [(is-AND? E) (AND (makeCNF (second E)) (makeCNF (third E)))]
    [(is-OR? E) (cond
                  [(is-AND? (second E)) (AND (makeCNF (OR (third E) (second (second E)))) (makeCNF (OR (third E) (third (second E)))))]
                  [(is-AND? (third E)) (AND (makeCNF (OR (second E) (second (third E)))) (makeCNF (OR (second E) (third (third E)))))]
                  [(and (or (is-OR? (third E)) (is-OR? (second E))) (noANDs? (second E)) (noANDs? (third E))) E]
                  [(makeCNF (OR (makeCNF (second E)) (makeCNF (third E))))])]))

        ; after your definition note that any helpers must occur before the ;end as well

;end

; Here are some unit tests. Look carefully at any tests your code does not pass, as it can point you to bugs.
; Note that the client wants their answers in precisely these forms, so coming up with answers that are "equivalent" to these
; will not suffice to pass the tests. e.g. If your output comes out to be (OR B A) rather than (OR A B) you will need to
; adjust your code accordingly.

(define-test-suite cnf?-suite
  (test-equal? "" (cnf? 'P) #t)
  (test-equal? "" (cnf? 'FALSE) #t)
  (test-equal? "" (cnf? '(NOT FALSE)) #f)
  (test-equal? "" (cnf? '(NOT P)) #t)
  (test-equal? "" (cnf? '(NOT (NOT P))) #f)
  (test-equal? "" (cnf? '(OR P Q)) #t)
  (test-equal? "" (cnf? '(XOR P Q)) #f)
  (test-equal? "" (cnf? '(AND P Q)) #t)
  (test-equal? "" (cnf? '(IMPLIES P Q)) #f)
  (test-equal? "" (cnf? '(EQUIV P Q)) #f)
  (test-equal? "" (cnf? '(OR P (NOT Q))) #t)
  (test-equal? "" (cnf? '(NOT (OR P Q))) #f)
  (test-equal? "" (cnf? '(AND (AND (OR L (OR M N)) (OR P (OR Q R))) (OR S (OR T W)))) #t);
  (test-equal? "" (cnf? '(AND (OR (OR L M) N) (AND (OR (OR P Q) R) (OR (OR S T) W)))) #t)
  (test-equal? "" (cnf? '(AND (OR (OR L M) N) (AND (OR (OR P Q) R) (OR (AND S T) W)))) #f)
  (test-equal? "" (cnf? '(OR (OR (OR (XOR P Q) R) S) T)) #f);
  (test-equal? "" (cnf? '(AND (AND (AND (AND P (NOT Q)) R) S) T)) #t);
  (test-equal? "" (cnf? '(AND (AND (AND (AND P (NOT (NOT Q))) R) S) T)) #f)
  (test-equal? "" (cnf? '(AND (OR x (OR y (NOT z))) (AND (NOT x) TRUE))) #t)
  (test-equal? "" (cnf? '(AND (OR x y) (OR x (AND y z)))) #f))
(define Q1Pts (- 20 (run-tests cnf?-suite 'verbose)))

(define-test-suite cnf-suite
  (test-equal? "" (makeCNF 'TRUE) 'TRUE)
  (test-equal? "" (makeCNF 'P) 'P)
  (test-equal? "" (makeCNF '(NOT P)) '(NOT P))
  (test-equal? "" (makeCNF '(NOT TRUE)) 'FALSE)
  (test-equal? "" (makeCNF '(NOT (NOT P))) 'P)
  (test-equal? "" (makeCNF '(OR P Q)) '(OR P Q))
  (test-equal? "" (makeCNF '(AND P Q)) '(AND P Q))
  (test-equal? "" (makeCNF '(NOT (AND P Q))) '(OR (NOT P) (NOT Q)))
  (test-equal? "" (makeCNF '(XOR P Q)) '(AND (OR P Q) (OR (NOT P) (NOT Q))))
  (test-equal? "" (makeCNF '(NOT (XOR (XOR P Q) R)));
    '(AND(AND(OR(OR(NOT P)Q)R)(OR(OR(NOT Q)P)R))(AND(OR(NOT R)(OR P Q))(OR(NOT R)(OR(NOT P)(NOT Q))))))
  (test-equal? "" (makeCNF '(IMPLIES P Q)) '(OR (NOT P) Q))
  (test-equal? "" (makeCNF '(NOT (IMPLIES P Q))) '(AND P (NOT Q)))
  (test-equal? "" (makeCNF '(IMPLIES P (IMPLIES Q R))) '(OR (NOT P) (OR (NOT Q) R)))
  (test-equal? "" (makeCNF '(IMPLIES (IMPLIES P Q) R)) '(AND (OR P R) (OR (NOT Q) R)));
  (test-equal? "" (makeCNF '(EQUIV P Q)) '(AND (OR (NOT P) Q) (OR (NOT Q) P)));
  (test-equal? "" (makeCNF '(NOT (XOR P Q))) '(AND (OR (NOT P) Q) (OR (NOT Q) P)));
  (test-equal? "" (makeCNF '(NOT (EQUIV P Q))) '(AND (OR P Q) (OR (NOT P) (NOT Q))))
  (test-equal? "" (makeCNF '(OR (AND S (NOT FALSE)) (IMPLIES Q (EQUIV TRUE (NOT (NOT (NOT Q))))))) '(AND(AND(OR S
      (OR(NOT Q)(OR FALSE(NOT Q))))(OR S(OR(NOT Q)(OR Q TRUE))))(AND(OR TRUE(OR(NOT Q)(OR FALSE(NOT Q))))(OR TRUE
      (OR(NOT Q)(OR Q TRUE))))))
  (test-equal? "" (makeCNF '(OR (OR (OR (AND L M) (AND N P)) (AND Q R)) (AND S T))) ' (AND(AND(AND(AND(OR(OR(OR L N)
       Q)S)(OR(OR(OR L N)Q)T))(AND(OR(OR(OR L N)R)S)(OR(OR(OR L N)R)T)))(AND(AND(OR(OR(OR L P)Q)S)(OR(OR(OR L P)Q)T))
      (AND(OR(OR(OR L P)R)S)(OR(OR(OR L P)R)T))))(AND(AND(AND(OR(OR(OR M N)Q)S)(OR(OR(OR M N)Q)T))(AND(OR(OR(OR M N)
       R)S)(OR(OR(OR M N)R)T)))(AND(AND(OR(OR(OR M P)Q)S)(OR(OR(OR M P)Q)T))(AND(OR(OR(OR M P)R)S)(OR(OR(OR M P)R)T))))))
  (test-equal? "" (makeCNF '(OR (OR (AND X (AND P Q)) (AND Y (AND R S))) (AND A (AND B C)))) '(AND(AND(AND(OR(OR X Y)
      A)(AND(OR(OR X Y)B)(OR(OR X Y)C)))(AND(AND(OR(OR X R)A)(AND(OR(OR X R)B)(OR(OR X R)C)))(AND(OR(OR X S)A)(AND
      (OR(OR X S)B)(OR(OR X S)C)))))(AND(AND(AND(OR(OR P Y)A)(AND(OR(OR P Y)B)(OR(OR P Y)C)))(AND(AND(OR(OR P R)A)
      (AND(OR(OR P R)B)(OR(OR P R)C)))(AND(OR(OR P S)A)(AND(OR(OR P S)B)(OR(OR P S)C)))))(AND(AND(OR(OR Q Y)A)(AND
      (OR(OR Q Y)B)(OR(OR Q Y)C)))(AND(AND(OR(OR Q R)A)(AND(OR(OR Q R)B)(OR(OR Q R)C)))(AND(OR(OR Q S)A)(AND(OR
      (OR Q S)B)(OR(OR Q S)C)))))))))
(define cnfPts (- 20 (run-tests cnf-suite 'verbose)))
(display "Q1 passed ")(display Q1Pts)(display "/20\n")
(display "Q2 passed ")(display cnfPts)(display "/20\n")

#|  APPENDIX:  this next part has nothing for you to implement.  It is simply for you to use together with your
cnf function when running SAT Solvers.

The first 5 functions are just utility helper functions to the mother function, makeDIMACS.
input contract for makeDIMACS: E represents a logical expression in CNF form, with nonzero integers as the
variables.  In actual usage, the makeCNF function you write would be used first, in order to insure the input
contract is satisfied. Note that (makeDIMACS E) has no output, but it displays to the console the DIMACS form
of E. Example: suppose you wanted to say that exactly one of 1,2,3 was true in DIMACS. Then you could enter
(makeDIMACS (makeCNF '(AND (XOR (OR 1 2) 3) (NOT (AND 1 2))))) which would display in the console
1 2 3 0
-1 -3 0
-2 -3 0
-1 -2 0
and then that could be copied into a SAT Solver. note that you are not responsible for fully understanding the
makeDIMACS code since it utilizes string manipulations which are not part of the cs270 content  |#
(define (lineHelp E) (string-append (drill (second E)) " "(drill (third E))))
(define (drill E) (if (is-NOT? E) (string-append "-" (~a (second E))) (if (integer? E) (~a E) (lineHelp E))))
(define (line E) (string-append (drill E) " 0\n"))
(define (dimBuild E) (if (noANDs? E) (line E) (string-append (dimBuild (second E)) (dimBuild (third E)))))
(define (makeDIMACS E) (display (dimBuild E)))