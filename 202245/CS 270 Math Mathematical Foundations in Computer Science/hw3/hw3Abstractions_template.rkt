;type your name after the colon:

#lang racket
(require rackunit)
(require rackunit/text-ui)
#| Questions 1 & 2 are about creating an abstraction for logic expressions. Questions 3-5 are about
an abstraction which represents polynomials. Each of these five questions are worth ten points (regardless
of how many unit tests there are).  Keep in mind that even if you have a solution to a question that passes
19/20 unit tests for that function, you are unlikely to get any credit for that answer since even failing
one unit test means that your function doesn't work properly. This racket portion is just 50% of the
assignment.  There are two other questions involving the SAT Solver which is submitted on a different pdf.
|#

; Instructor supplied functions for Questions 1-2
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

; Question 1: write a function according to the specifications below
; input contract: E is the representation of the logical expression, expr
; output contract: (nnf? E) returns #t if expr is NNF, and #f otherwise
; Examples: (nnf? '(AND (OR X (OR Y (NOT Z))) (AND (NOT X) TRUE))) should return #t since "(x ∨ y ∨ ¬z) ∧ x ∧ true" is in NNF,
; also, (nnf? '(XOR X Y)) and (nnf? (NOT (OR X Y))) should both return #f since "x ⊕ y" and "¬(x ∨ y)" aren't in NNF 

(define/contract (nnf? E)
  (-> legal? boolean?)
  #f) ; delete this False line and put your implementation here on these lines. do NOT delete the ;end comment after your definition
  

; Question 2: write a function according to the specifications below
; input contract: E is the representation of the logical expression, expr
; output contract: (makeNNF E) returns a representation of expr in NNF
; Requirements: when given a choice between returning a DNF or a CNF form, the CNF form should
;               be chosen.
; Examples: (makeNNF '(IMPLIES (AND (NOT P) Q) R)) would be '(OR (OR P (NOT Q)) R) since
;           (¬P∧Q)→R would be (P∨¬Q)∨R in nnf.  Similarly, (makeNNF '(XOR P Q)) should return
;           '(AND (OR P Q) (OR (NOT P) (NOT Q))) since (P∨Q)∧(¬P∨¬Q) is a cnf and hence nnf
;           version of P⊕Q
; Hint: XOR and EQUIV are negations of each other and so your implementation should perform that reduction.
;       in other words, ¬(P⊕Q) should first be simplified to P↔Q and similarly, the first step for ¬(P↔Q) would be to make it P⊕Q

(define/contract (makeNNF E)
  (-> legal? nnf?)
  'FALSE) ; delete this False line and put your implementation here on these lines. do NOT delete the ;end comment after your definition

;end

; Here are some unit tests. Look carefully at any tests your code does not pass, as it can point you to bugs.
; Note that the client wants their answers in precisely these forms, so coming up with answers that are "equivalent" to these
; will not suffice to pass the tests. e.g. If your output comes out to be (OR B A) rather than (OR A B) you will need to
; adjust your code accordingly.
(define-test-suite nnf?-suite
  (test-equal? "" (nnf? 'P) #t)
  (test-equal? "" (nnf? 'FALSE) #t)
  (test-equal? "" (nnf? '(NOT FALSE)) #f)
  (test-equal? "" (nnf? '(NOT P)) #t)
  (test-equal? "" (nnf? '(NOT (NOT P))) #f)
  (test-equal? "" (nnf? '(OR P Q)) #t)
  (test-equal? "" (nnf? '(XOR P Q)) #f)
  (test-equal? "" (nnf? '(AND P Q)) #t)
  (test-equal? "" (nnf? '(IMPLIES P Q)) #f)
  (test-equal? "" (nnf? '(EQUIV P Q)) #f)
  (test-equal? "" (nnf? '(OR P (NOT Q))) #t)
  (test-equal? "" (nnf? '(NOT (OR P Q))) #f)
  (test-equal? "" (nnf? '(AND (AND (OR L (OR M N)) (OR P (OR Q R))) (OR S (OR T W)))) #t)
  (test-equal? "" (nnf? '(AND (OR (OR L M) N) (AND (OR (OR P Q) R) (OR (OR S T) W)))) #t)
  (test-equal? "" (nnf? '(AND (OR (OR L M) N) (AND (OR (OR P Q) R) (OR (AND S T) W)))) #t)
  (test-equal? "" (nnf? '(OR (OR (OR (XOR P Q) R) S) T)) #f)
  (test-equal? "" (nnf? '(AND (AND (AND (AND P (NOT Q)) R) S) T)) #t)
  (test-equal? "" (nnf? '(AND (AND (AND (AND P (NOT (NOT Q))) R) S) T)) #f)
  (test-equal? "" (nnf? '(AND (OR x (OR y (NOT z))) (AND (NOT x) TRUE))) #t)
  (test-equal? "" (nnf? '(AND (OR x y) (OR x (AND y z)))) #t))
(define Q1Pts (- 20 (run-tests nnf?-suite 'verbose)))

(define-test-suite make-suite
  (test-equal? "" (makeNNF 'TRUE) 'TRUE)
  (test-equal? "" (makeNNF 'P) 'P)
  (test-equal? "" (makeNNF '(NOT P)) '(NOT P))
  (test-equal? "" (makeNNF '(NOT TRUE)) 'FALSE)
  (test-equal? "" (makeNNF '(NOT (NOT P))) 'P)
  (test-equal? "" (makeNNF '(OR P Q)) '(OR P Q))
  (test-equal? "" (makeNNF '(AND P Q)) '(AND P Q))
  (test-equal? "" (makeNNF '(NOT (AND P Q))) '(OR (NOT P) (NOT Q)))
  (test-equal? "" (makeNNF '(XOR P Q)) '(AND (OR P Q) (OR (NOT P) (NOT Q))))
  (test-equal? "" (makeNNF '(NOT (XOR (XOR P Q) R)))
    '(AND (OR (AND (OR (NOT P) Q) (OR (NOT Q) P)) R)(OR (NOT R) (AND (OR P Q) (OR (NOT P) (NOT Q))))))
  (test-equal? "" (makeNNF '(IMPLIES P Q)) '(OR (NOT P) Q))
  (test-equal? "" (makeNNF '(NOT (IMPLIES P Q))) '(AND P (NOT Q)))
  (test-equal? "" (makeNNF '(IMPLIES P (IMPLIES Q R))) '(OR (NOT P) (OR (NOT Q) R)))
  (test-equal? "" (makeNNF '(IMPLIES (IMPLIES P Q) R)) '(OR (AND P (NOT Q)) R))
  (test-equal? "" (makeNNF '(EQUIV P Q)) '(AND (OR (NOT P) Q) (OR (NOT Q) P)))
  (test-equal? "" (makeNNF '(NOT (XOR P Q))) '(AND (OR (NOT P) Q) (OR (NOT Q) P)))
  (test-equal? "" (makeNNF '(NOT (EQUIV P Q))) '(AND (OR P Q) (OR (NOT P) (NOT Q))))
  (test-equal? "" (makeNNF '(OR (AND S (NOT FALSE)) (IMPLIES Q (EQUIV TRUE (NOT (NOT (NOT Q)))))))
               '(OR (AND S TRUE) (OR (NOT Q) (AND (OR FALSE (NOT Q)) (OR Q TRUE)))))
  (test-equal? "" (makeNNF '(OR (OR (OR (AND L M) (AND N P)) (AND Q R)) (AND S T)))
               '(OR (OR (OR (AND L M) (AND N P)) (AND Q R)) (AND S T)))
  (test-equal? "" (makeNNF '(OR (OR (AND X (AND P Q)) (AND Y (AND R S))) (AND A (AND B C))))
               '(OR (OR (AND X (AND P Q)) (AND Y (AND R S))) (AND A (AND B C)))))
(define makePts (- 20 (run-tests make-suite 'verbose)))

#| Questions 3-5: polynomial multiplication
   This section creates a representation in Racket of (single variable) polynomials,
   which we shall call a polyList.  We have abstracted away the algebraic notion of
   them as functions and do not bother with their graphs etc.  Instead, we focus on
   them purely as a collection of terms.  We have provided below the necessary predicate
   definitions of these structures (Note: in future assignments you will be responsible
   for implementing your own predicates, but for now just read these to make sure you
   fully understand what they are doing).

   The basic idea is that a term is a list of two integers (the second nonnegative)
   representing the coefficient and power. For example, the term (3 4) is the abstraction for
   the algebraic term 3x^4, and the polyList ((1 2) (-3 1) (5 0)) represents the polynomial
   x^2 - 3x + 5.  Note that our definition of polyList insists that the terms be in decreasing
   order of power and that duplicate powers are not permitted. We also don't permit a term with
   a coefficent of zero, so we treat the polyList '() as being the constant function zero.
   
   Your end goal for this problem is to create a function representing the multiplication
   of two polynomials. The best way to accomplish this is to create two helper functions, which
   deal with the addition and multiplication of terms, detailed below.  (Note: in future
   assignments you will be responsible for deciding on your own what helpers to create that would
   be useful, but for now this framework has been provided for you).  |#

; Input Contract: T is any racket object
; Output Contract: term? is the defining predicate for a term.
;        In other words (term? T) returns #t if T is a term, and is #f otherwise.
; Note: null is NOT a term, since it does not consist of exactly two integers
; Note: think about why it is important to check in the order list? then equal?, then integer?
(define/contract (term? T) (-> any/c boolean?)
  (and (not (null? T)) (list? T) (equal? (length T) 2) (integer? (first T))
       (integer? (second T)) (>= (second T) 0) (not (zero? (first T)))))

; Input Contract: P is any racket object
; Output Contract: polyList? is the defining predicate for a polyList.
;        In other words (polyList? P) returns #t if P is a polyList, and is #f otherwise.
; Note: although it is more standard for there to be one cond case for #t and
;       another cond case for #f, for this implementation it has been split up into two parts
;       for easier readability (make sure you understand what is going on in each line)
(define/contract (polyList? P) (-> any/c boolean?)
  (cond
    ; checks to make sure the polyList is comprised of terms
    [(null? P) #t]
    [(not (and (list? P) (term? (first P)))) #f]
    ; checks to make sure it is in descending order with no duplicate powers
    [(null? (rest P)) #t]
    [(not (and (term? (second P)) (> (second (first P)) (second (second P))))) #f]
    [else (polyList? (rest P))]))

; Now that we have our predicates, we can express the types for our contracts and you are now
; ready to begin implementing your helper functions.

; Question 3: adding a single term into a polynomial
; Input contract: T is a term representing the polynomial term t ,
;                 P is a polyList representing the polynomial p
; Output contract: (addTerm T P) is the polyList representing the polynomial t(x)+p(x)
; Examples: (addTerm '(3 4) '((1 7) (5 2))) would be ((1 7) (3 4) (5 2))
;           since 3x^4+(x^7+5x^2)=x^7+3x^4+5x^2
;           and (addTerm '(3 4) '((1 7) (5 4))) would be ((1 7) (8 4))
;           since  3x^4+(x^7+5x^4)=x^7+8x^4

(define/contract (addTerm T P) (-> term? polyList? polyList?)
  null) ; delete the null and put your implementation here on these lines. do NOT delete the ;end comment after your definition
  

;Test Bed
(display "Question 3 addTerm Tests\n")
(define-test-suite test_addterm
  (test-equal? "" (addTerm '(3 4) '((1 7) (5 2) (-1 0))) '((1 7) (3 4) (5 2) (-1 0)))
  (test-equal? "" (addTerm '(3 2) '((1 7) (5 2) (-1 0))) '((1 7) (8 2) (-1 0)))
  (test-equal? "" (addTerm '(-5 2) '((1 7) (5 2) (-1 0))) '((1 7) (-1 0))))
(define q3_score (- 3 (run-tests test_addterm)))

; Question 4: multiplying a single term into a polynomial
; Input contract: T is a term representing the polynomial term t ,
;                 P is a polyList representing the polynomial p
; Output contract: (multTerm T P) is the polyList representing the polynomial t(x)*p(x)
; Example: (multTerm '(3 4) '((1 7) (5 2))) would be ((3 11) (15 6))
;          since (3x^4)*(x^7+5x^2)=3x^11+15x^6
(define/contract (multTerm T P) (-> term? polyList? polyList?)
  null) ; delete the null and put your implementation here on these lines. do NOT delete the ;end comment after your definition
  

;Test Bed
(display "Question 4 multTerm Tests\n")
(define-test-suite test_multterm
  (test-equal? "" (multTerm '(3 4) '((1 7) (5 2) (-1 0))) '((3 11) (15 6) (-3 4)))
  (test-equal? "" (multTerm '(3 2) '((1 7) (5 2) (-1 0))) '((3 9) (15 4) (-3 2)))
  (test-equal? "" (multTerm '(3 1) '((1 7) (5 2) (-1 0))) '((3 8) (15 3) (-3 1))))
(define q4_score (- 3 (run-tests test_multterm)))

; Question 5: multiplying polynomials
; Input contract: P and Q are polyLists representing polynomials p and q respectively
; Output contract: (multPolys P Q) is the polyList representing the polynomial p(x)*q(x)
; Example: (multPolys '((3 4)(1 2) ) '((3 5) (2 4))) would be ((9 9) (6 8) (3 7) (2 6))
;          since (3x^4 +x^2)*(3x^5+2x^4)=9x^9+6x^8+3x^7+2x^6
; Requirements: this function should be done NONrecursively by using addTerm and multTerm.
;          You may make additional helper functions, but no others are actually needed

(define/contract (multPolys P Q) (-> polyList? polyList? polyList?)
  null) ; delete the null and put your implementation here on these lines. do NOT delete the ;end comment after your definition
  

;Test Bed
(display "Question 5 multPolys Tests\n")
(define-test-suite test_multPolys
  (test-equal? "" (multPolys '((1 2)(-6 1)(2 0)) '((2 3)(4 2)(-3 1)(-1 0))) '((2 5)(-8 4)(-23 3)(25 2)(-2 0)))
  (test-equal? "" (multPolys '((2 3)(4 2)(-3 1)(-1 0)) '((1 2)(-6 1)(2 0))) '((2 5)(-8 4)(-23 3)(25 2)(-2 0)))
  (test-equal? "" (multPolys '((1 2)(-5 1)(2 0)) '((3 2)(-4 1)(-1 0))) '((3 4)(-19 3)(25 2)(-3 1)(-2 0))))
(define q5_score (- 3 (run-tests test_multPolys)))

;---------------------------------------------------------------------
(display "------Test Summary------\n")
(display "Q1: passed ")(display Q1Pts)(display "/20\n")
(display "Q2: passed ")(display makePts)(display "/20\n")
(display "Q3: Passed ")(display q3_score)(display "/3\n")
(display "Q4: Passed ")(display q4_score)(display "/3\n")
(display "Q5: Passed ")(display q5_score)(display "/3\n")