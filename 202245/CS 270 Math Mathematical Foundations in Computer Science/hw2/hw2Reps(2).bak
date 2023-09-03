;type your name after the colon:
#lang racket

;The following two lines are required to test the code.
(require rackunit)
(require rackunit/text-ui)

#| CS 270  Homework 2
Create By Professor Bruce Char, Professor Mark Boady, Professor Jeremy Johnson, and Steve Earth

Complete each of the below functions. Tests given are not resigned to be comprehensive.
They will give you an idea if your code is write, but they do not test all possible cases.
Think about your design. When grading, we may add additional tests for your functions.
Each of the ten questions is worth ten points for a total of 100.

Important Rules:
0. Run your code before submitting it; if it crashes, A ZERO MAY BE GIVEN FOR THE ASSIGNMENT.
1. You may not use any loop constructs; if used, your answer will get a zero.
2. All these functions must be implemented recursively unless otherwise indicated --
 you will receive a zero if there is no recursion (similarly, you will receive a zero if the
directions forbid recursion and you implement the definition recursively).
Note that for some questions, recursive helper functions are allowed
(in which case, the grader will still give credit even with the main function not being recursive).
Although no helper functions need to be created for this assignment.
3. You may not use any Racket commands not discussed in class. If used, your answer will get a zero.
As a general rule, you should only be using functions taught in class (otherwise you are likely missing
the point of the question and endangering your score).
4. Using If/Cond to pass the specific tests provided instead of following the instructions will always
result in a zero for that question.  Do not assume that simply because your code passes all the example
unit tests here then that means you get 100%; we will be testing with input beyond the examples.
The graders will still obey the input contracts.
5. While you are encouraged to create your own comments, NEVER delete any provided comments
(they are used at touchstones by the autograder).
6. This assignment is all about getting familiar with Booleans (i.e. True/False, represented in Racket as #t/#f)
and other abstract representations. Nowhere on this assignment should you be using integers! If you find yourself
using numbers (such as 0s or 1s) or doing any arithmetic operations (such as addition, multiplication, quotient,
remainder etc), then you taking a wrong (and very inefficient) approach to that problem.
|#

; PART ONE: LIST PROCESSING
; =========================

;Question 1: predicate for all symbols being q
; Write a recursive function all_q to check if a list of symbols contains all q symbols.
; Input:  L is a list of symbols (possibly empty)
; Output: (all_q L) a boolean value which is false if and only if L contains a symbol which isn't q
(define (all_q? L)
  null); replace this null here with the lines of your code

(define-test-suite test_all_q
  (test-equal? "" (all_q? '(q)) #t)
  (test-equal? "" (all_q? '(b)) #f)
  (test-equal? "" (all_q? '(b c)) #f)
  (test-equal? "" (all_q? '(c q)) #f)
  (test-equal? "" (all_q? '(q t)) #f)
  (test-equal? "" (all_q? '(q q)) #t)
  (test-equal? "" (all_q? '(q x q)) #f)
  (test-equal? "" (all_q? '(q q q)) #t)
  (test-equal? "" (all_q? '(q q q q q q q q)) #t)
  (test-equal? "" (all_q? '(q q q q w q q q)) #f))
(display "Question 1 all_q (10 points)\n")
(define q1_score (- 10 (run-tests test_all_q 'verbose)))

; Question 2: predicate checking for the existence of a q in a list
; Write a recursive function all_q to check if a list of symbols contains at least one q symbol.
; Input:  L is a list of symbols (possibly empty)
; Output: (at_least_one_q L) is a boolean which is true if and only if L contains a symbol q.
(define (at_least_one_q? L)
  null); replace this null here with the lines of your code

(define-test-suite test_at_least_one_q
  (test-equal? "" (at_least_one_q? '(q)) #t)
  (test-equal? "" (at_least_one_q? '(b)) #f)
  (test-equal? "" (at_least_one_q? '(x y)) #f)
  (test-equal? "" (at_least_one_q? '(v q)) #t)
  (test-equal? "" (at_least_one_q? '(q q)) #t)
  (test-equal? "" (at_least_one_q? '(x x d)) #f)
  (test-equal? "" (at_least_one_q? '(c t q)) #t)
  (test-equal? "" (at_least_one_q? '(q q q)) #t)
  (test-equal? "" (at_least_one_q? '(q w q q)) #t)
  (test-equal? "" (at_least_one_q? '(x y d w)) #f))
(display "Question 2 at_least_one_q (10 points)\n")
(define q2_score (- 10 (run-tests test_at_least_one_q 'verbose)))

; Question 3: predicate for a q singleton
; Input:  L is a list of symbols (possibly empty).
; Output: (exactly_one_q L) is true if and only if L contains exactly one q.
; Hint: it is helpful to call one of the functions you already wrote for this hw,
; since attempting to count up the number of q's is an extremely inefficient approach.
(define (exactly_one_q? L)
  null); replace this null here with the lines of your code

(define-test-suite test_exactly_one_q
  (test-equal? "" (exactly_one_q? '(a b)) #f)
  (test-equal? "" (exactly_one_q? '(c q)) #t)
  (test-equal? "" (exactly_one_q? '(q d)) #t)
  (test-equal? "" (exactly_one_q? '(q q)) #f)
  (test-equal? "" (exactly_one_q? '(d e f)) #f)
  (test-equal? "" (exactly_one_q? '(x h q)) #t)
  (test-equal? "" (exactly_one_q? '(i q j)) #t)
  (test-equal? "" (exactly_one_q? '(k q q)) #f)
  (test-equal? "" (exactly_one_q? '(q l m)) #t)
  (test-equal? "" (exactly_one_q? '(q n q)) #f)
  (test-equal? "" (exactly_one_q? '(q q y)) #f)
  (test-equal? "" (exactly_one_q? '(q q q)) #f))
(display "Question 3 exactly_one_q (10 points)\n")
(define q3_score (- 12 (run-tests test_exactly_one_q 'verbose)))


; Question 4: predicate for their being an odd quantity of qs
; Write a recursive function odd_amt_q to check if a list of symbols contains an odd number of q symbols.
; Input:  L is a list of symbols (possibly empty).
; Output: (odd_amt_q L) is true if and only if the amount of q's in L is odd.
; Hint: if you are counting the total number of q's, then you are not going about it in a good way.
;       it is inefficient to do any arithmetic (adding, remaindering) in your implementation
(define (odd_amt_q? L)
  null); replace this null here with the lines of your code

(define-test-suite test_odd_amt_q
  (test-equal? "" (odd_amt_q? '(q)) #t)
  (test-equal? "" (odd_amt_q? '(h i)) #f)
  (test-equal? "" (odd_amt_q? '(k q)) #t)
  (test-equal? "" (odd_amt_q? '(q z)) #t)
  (test-equal? "" (odd_amt_q? '(t f b)) #f)
  (test-equal? "" (odd_amt_q? '(u w q)) #t)
  (test-equal? "" (odd_amt_q? '(q r q)) #f)
  (test-equal? "" (odd_amt_q? '(q q q)) #t)
  (test-equal? "" (odd_amt_q? '(x q q)) #f)
  (test-equal? "" (odd_amt_q? '(q q q q)) #f))
(display "Question 4 odd_amt_q (10 points)\n")
(define q4_score (- 10 (run-tests test_odd_amt_q 'verbose)))


; Question 5: nonrecursive odd q's
; Solve question 4 again. This time you may NOT write a recursive function.
; Do not write helper functions for this question (use λ instead, if need be).
; Input:  L is a list of symbols (possibly empty).
; Output: (odd_amt_q_nonrec L) is true if and only if the amount of q's in L is odd.
(define (odd_amt_q_nonrec L)
  null); replace this null here with the lines of your code

(define-test-suite test_odd_amt_q_v2
  (test-equal? "" (odd_amt_q_nonrec '(q)) #t)
  (test-equal? "" (odd_amt_q_nonrec '(h i)) #f)
  (test-equal? "" (odd_amt_q_nonrec '(k q)) #t)
  (test-equal? "" (odd_amt_q_nonrec '(q z)) #t)
  (test-equal? "" (odd_amt_q_nonrec '(t f b)) #f)
  (test-equal? "" (odd_amt_q_nonrec '(u w q)) #t)
  (test-equal? "" (odd_amt_q_nonrec '(q r q)) #f)
  (test-equal? "" (odd_amt_q_nonrec '(q q q)) #t)
  (test-equal? "" (odd_amt_q_nonrec '(q x q)) #f)
  (test-equal? "" (odd_amt_q_nonrec '(q q q q)) #f))
(display "Question 15 odd_amt_q_nonrec (10 points)\n")
(define q5_score (- 10 (run-tests test_odd_amt_q_v2 'verbose)))

#| PART TWO: PNUMS
   ===============

recall from class that Peano numbers, known as "pNums", have two constructors,
one of which, succ, is recursive. And "DubNums" have three constructors, two of
which ("double" and "double-plus1") are recursive.

1)  Peano arithmetic

    In words:  A number is either zero, or, recursively, the successor of a number is a number.
    Formally,  pNum := pzero|(succ pNum)

2)  DubNum arithmetic

    In words:  A DubNum is either zero, or recursively, doubling
    a (nonzero) number or doubling a number and adding one gives a dubNum.

    Formally,  DubNum := dubzero|(double X)|(double-plus1 Y), where Y is any DubNum, and X is any nonzero DubNum

    We can interpret dubnums by assigning zero to the number zero
    and if B is a dubnum representing the integer value b, than
    (double B) has value 2b and (double-plus1 B) has value 2b+1.

    Note that it might seem like there is more than one way to construct dubnums with
    the same value.  E.G.  (double dubzero) would have the same value as zero, so our
    definition of double prevents constructions such as '(double (double dubzero))

    When recursively processing either types of numbers, you must
    handle cases corresponding to the different constructors.  Recursive
    calls must have inputs whose size is smaller, where size is the
    number of constructors needed to build the number.

    In this second part of this assignment you will write recursive functions to arithmetic operations on a
    *representation* of the integers, using Peano numbers (aka "rock arithmetic"). And then in the third part,
    you will write recursive functions to do arithmetic on a different (better)
    representation of the integers, called DubNums (the official recursive definition is given above).

Below are some instructor defined functions. read them over to make sure you understand them:
pzero? is the peano equivalent of the racket function zero?
pnum? is the predicate determining if the input is a legal peano number
succ returns the successor of a peano number.  in other words, if N is the peano number representing n,
then (succ N) is the peano number representing n+1
lastly, when N is the peano number representing n>0, then (pred N) is the peano number representing n-1
(aka the "predecessor")
|#

(define (pzero? N) (equal? N 'pzero))
(define (pnum? N) (if (zero? N) #t (and (equal? (length N) 2) (equal? (first N) 'succ) (pnum? (second N)))))
(define (succ N) (list 'succ N))
(define (pred N) (if (pzero? N) 'pzero (second N)))

;also, here are some handy definitions we can use as shortcuts for typing
(define zero 'pzero)
(define one (succ zero))
(define two (succ one))
(define three (succ two))
(define four (succ three))
(define five (succ four))
(define six (succ five))
(define seven (succ six))
(define eight (succ seven))
(define nine (succ eight))
(define ten (succ nine))

; Please study the next three functions given below carefully and make sure you understand how they work.
; You may utilize these in your solutions if you wish.

; Input: M, N are pnums representing the integers m,n
; Output: (plus M N) is the pnum representing m+n
; Example: (plus two three) would be five, i.e. (succ (succ (succ (succ (succ pzero))))), since 2+3=5
(define (plus M N)
  (if (pzero? M) N (succ (plus (pred M) N))))

; Input: M, N are pnums representing the integers m,n
; Output: (mult M N) is the pnum representing m*n
; Example: (mult two three) would be six, i.e. (succ (succ (succ (succ (succ (succ pzero)))))), since 2*3=6
(define (mult M N)
  (if (pzero? M) zero (plus N (mult (pred M) N))))

; Input: M, N are pnums representing the integers m,n
; Output: (ltpnum? M N) is the predicate representation of m < n. In other words, the output is the boolean #t if m < n and #f otherwise.
; Examples: (ltpnum? two three) would be #t since it is true that 2 < 3.  however (ltpnum? five four) would be #f since it is false that 5 < 4
(define (ltpnum? M N)
  (cond
    [(pzero? N) #f]
    [(pzero? M) #t]
    [else (ltpnum? (pred M) (pred N))]))

; Question 6: subtraction of Peano numbers
; Input: M, N are pnums representing the integers m,n
; Output: (sub M N) is the pnum representing m-n if m >= n and zero otherwise
; Example: (sub five three) would be two, i.e. (succ (succ pzero)), since 5 -3 = 2
(define (sub M N)
  null); replace this null here with the lines of your code

; Question 7: Division of Peano numbers
; Input: ; Input: M, N are pnums representing the integers m,n where n > 0
; Output: the pnum representing the quotient of m divided by n (recall that quotient drops all fractions)
; Example: (div seven three) would be two, i.e. (succ (succ pzero)), since (quotient 7 3) is 2
(define (div M N)
  null); replace this null here with the lines of your code

;Question 8: Remainder of Peano numbers
; Input: M, N are pnums representing the integers m,n where n > 0
; Output: (rem M N) is the pnum representing the remainder of m divided by n
; Example: (rem seven three) would be one, i.e. (succ pzero), since (remainder 7 3) is 1.
; Requirement: your answer *must* be recursive to get credit since that is more efficient that calculating remainder = m - n*(quotient m n)
(define (rem M N)
  null); replace this null here with the lines of your code

(display "Question 6 - Subtraction\n")
(define-test-suite peano-subtract
  (test-equal? "" (sub ten ten) zero)
  (test-equal? "" (sub ten two) eight)
  (test-equal? "" (sub nine one) eight)
  (test-equal? "" (sub eight five) three)
  (test-equal? "" (sub seven one) six)
  (test-equal? "" (sub seven five) two)
  (test-equal? "" (sub six two) four)
  (test-equal? "" (sub five three) two)
  (test-equal? "" (sub three two) one)
  (test-equal? "" (sub two one) one))
(define q6_score (- 10 (run-tests peano-subtract 'verbose)))

(display "Question 7 - Division\n")
(define-test-suite peano-div
  (test-equal? "" (div ten ten) one)
  (test-equal? "" (div ten two) five)
  (test-equal? "" (div nine three) three)
  (test-equal? "" (div eight six) one)
  (test-equal? "" (div eight four) two)
  (test-equal? "" (div one seven) zero)
  (test-equal? "" (div seven five) one)
  (test-equal? "" (div six two) three)
  (test-equal? "" (div five three) one)
  (test-equal? "" (div three two) one))
(define q7_score  (- 10 (run-tests peano-div 'verbose)))

(display "Question 8 - Remainder\n")
(define-test-suite peano-rem
  (test-equal? "" (rem ten three) one)
  (test-equal? "" (rem ten two) zero)
  (test-equal? "" (rem nine one) zero)
  (test-equal? "" (rem eight five) three)
  (test-equal? "" (rem seven five) two)
  (test-equal? "" (rem six six) zero)
  (test-equal? "" (rem five three) two)
  (test-equal? "" (rem three two) one)
  (test-equal? "" (rem two one) zero)
  (test-equal? "" (rem one five) one))
(define q8_score  (- 10 (run-tests peano-rem 'verbose)))


#|

   PART THREE: DUBNUMS
   ===================

Similar to the set-up for pnums, included below are several definitions I've already built for you.
You should make sure you understand them and how they work; feel free to use any of them in your solutions.
|#

(define dubzero 'dzero)

;input=X is a dubnum representing x
;output=returns #t if and only if x is 0 (essentially the dubnum version of the zero? predicate)
(define (dubzero? X)
  (equal? X dubzero))

; note that the if condition below is to prevent outputing an illegimate DubNum such as (D dubzero)
;input = X is a dubnum representing x
;output = returns the dubnum representing 2x
(define (double X)
  (if (dubzero? X) dubzero (list 'D X)))

;input = X is a dubnum representing x
;output = returns the dubnum representing 2x+1
(define (double-plus1 X) (list 'DP1 X))

;input = X is a dubnum representing x
;output = returns #t/#f iff x is a positive even number
(define (double? X)
  (and (not (equal? X 'dzero)) (equal? (first X) 'D)))

;input = X is a dubnum representing x
;output = returns #t/#f iff x is an odd number
(define (double-plus1? X)
  (and (not (equal? X 'dzero)) (equal? (first X) 'DP1)))

; op is short for "operand", i.e. the dubnum which is being doubled/doubleplus1'd
(define op second)

; a quick predicate helper on the dubnum X that tells whether x=1
(define (dubone? X) (equal? X dubone))

; a few aliases for numbers for unit testing purposes
(define dubone (double-plus1 dubzero))
(define dubtwo (double dubone))
(define dubthree (double-plus1 dubone))
(define dubfour (double dubtwo))
(define dubfive (double-plus1 dubtwo))
(define dubsix (double dubthree))
(define dubseven (double-plus1 dubthree))
(define dubeight (double dubfour))
(define dubnine (double-plus1 dubfour))
(define dubten (double dubfive))

; increment a dubnum
; Input: X is a dubnum representing the integer x
; Output: the dubnum representing x + 1

(define(inc X)
  (cond
    [(dubzero? X) (double-plus1 X)]
    [(double? X) (double-plus1 (op X))]
    [else (double (inc (op X)))])) ; note the only case left is DP1 so no need to ask it

;Question 9.  Implement a recursive function to add two dubnums [20 points]
; Inputs: X and Y are dubnums representing the integers x,y
; Output: the dubnum representation of x + y
; Requirements: be sure to use the functions provided for you in this homework (double, double? etc).
; Done correctly, there should be five cases. to be efficient, every recursive call should be of the form (dubplus (op X) (op Y))
(define (dubplus X Y)
    null); replace this null here with the lines of your code

(display "Question 9 - DubNum Plus\n")
(define-test-suite bin-plus-test
  (test-equal? "" (dubplus dubzero dubone) dubone)
  (test-equal? "" (dubplus dubone dubtwo) dubthree)
  (test-equal? "" (dubplus dubtwo dubsix) dubeight)
  (test-equal? "" (dubplus dubthree dubtwo) dubfive)
  (test-equal? "" (dubplus dubfour dubfive) dubnine)
  (test-equal? "" (dubplus dubfive dubtwo) dubseven)
  (test-equal? "" (dubplus dubsix dubone) dubseven)
  (test-equal? "" (dubplus dubseven dubtwo) dubnine)
  (test-equal? "" (dubplus dubeight dubtwo) dubten)
  (test-equal? "" (dubplus dubnine dubzero) dubnine)
  (test-equal? "" (dubplus dubten dubzero) dubten)
  (test-equal? "" (dubplus dubnine dubone) dubten)
  (test-equal? "" (dubplus dubeight dubzero) dubeight)
  (test-equal? "" (dubplus dubseven dubone) dubeight)
  (test-equal? "" (dubplus dubsix dubthree) dubnine)
  (test-equal? "" (dubplus dubfive dubthree) dubeight)
  (test-equal? "" (dubplus dubfour dubtwo) dubsix)
  (test-equal? "" (dubplus dubthree dubseven) dubten)
  (test-equal? "" (dubplus dubtwo dubtwo) dubfour)
  (test-equal? "" (dubplus dubone dubfive) dubsix))
(define q9_score  (- 20 (run-tests bin-plus-test 'verbose)))

;Question 10.  Implement a recursive function to multiply two dubnums. [20 points]
; Inputs: X and Y are dubnums representing the integers x,y
; Output: the dubnum representing x * y
; Requirements: be sure to use the functions provided for you in this homework (double, double? etc).
;    Every recursive call should be of the form (dubmult X (op Y)). Note that it is possible to do this
;    without a cond or nested if, but it is also acceptable to break it up into 3 cases.

(define (dubmult X Y)
    null); replace this null here with the lines of your code

(display "Question 10 - DubNum Multiply\n")
(define-test-suite bin-mult-test
  (test-equal? "" (dubmult dubzero dubone) dubzero)
  (test-equal? "" (dubmult dubone dubzero) dubzero)
  (test-equal? "" (dubmult dubzero dubthree) dubzero)
  (test-equal? "" (dubmult dubnine dubzero) dubzero)
  (test-equal? "" (dubmult dubone dubthree) dubthree)
  (test-equal? "" (dubmult dubone dubseven) dubseven)
  (test-equal? "" (dubmult dubfive dubone) dubfive)
  (test-equal? "" (dubmult dubten dubone) dubten)
  (test-equal? "" (dubmult dubtwo dubone) dubtwo)
  (test-equal? "" (dubmult dubtwo dubtwo) dubfour)
  (test-equal? "" (dubmult dubtwo dubthree) dubsix)
  (test-equal? "" (dubmult dubtwo dubfour) dubeight)
  (test-equal? "" (dubmult dubtwo dubfive) dubten)
  (test-equal? "" (dubmult dubthree dubtwo) dubsix)
  (test-equal? "" (dubmult dubthree dubthree) dubnine)
  (test-equal? "" (dubmult dubfour dubtwo) dubeight)
  (test-equal? "" (dubmult dubfive dubtwo) dubten)
  (test-equal? "" (dubmult dubfive dubfour) (double dubten))
  (test-equal? "" (dubmult dubfour dubthree) (double dubsix))
  (test-equal? "" (dubmult dubfive dubthree) (double-plus1 dubseven)))
(define q10_score  (- 20 (run-tests bin-mult-test 'verbose)))

;---------------------------------------------------------------------
(display "------Test Summary------\n")
(display "Q1 passed ")
(display q1_score)
(display "/10\n")
(display "Q2 passed ")
(display q2_score)
(display "/10\n")
(display "Q3 passed ")
(display q3_score)
(display "/12\n")
(display "Q4 passed ")
(display q4_score)
(display "/10\n")
(display "Q5 passed ")
(display q5_score)
(display "/10\n")
(display "Q6 passed ")
(display q6_score)
(display "/10\n")
(display "Q7 passed ")
(display q7_score)
(display "/10\n")
(display "Q8 passed ")
(display q8_score)
(display "/10\n")
(display "Q9 passed ")
(display q9_score)
(display "/20\n")
(display "Q10 passed ")
(display q10_score)
(display "/20\n")