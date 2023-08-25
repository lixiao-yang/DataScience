; Type your name after the colon: Lixiao Yang
; Note: please don't forget to put your full name in line1 after the colon -- it is necessary for the autograder (and worth 4pts)!

#lang racket

;The following two lines are required to test the code.
(require rackunit)
(require rackunit/text-ui)

#|
CS 270
Homework 1

Create By Professors Bruce Char, Mark Boady, Jeremy Johnson, and Steve Earth

Complete each of the below functions.

Tests given are not designed to be comprehensive.
They will give you an idea if your code is right, but they do not test all possible cases.
Think about your design. When grading, we will add additional tests for your functions.
The number of tests passed is NOT your score for the problem -- remember, even if just one test fails, that
means your code is buggy and likely may not receive much credit.

Important Rules:
0. Run your code before submitting it; if it crashes or goes into an infinite loop, A ZERO WILL BE GIVEN FOR THE ASSIGNMENT BY THE AUTOGRADER.
1. You may not use any loop constructs; if used, your answer will get a zero.
2. Unless stated otherwise, all these functions must be implemented recursively.
You will receive a zero if there is no recursion. Note that for some questions, recursive helper functions are allowed
(in which case, the grader will still give credit even with the main function not being recursive).
There is an acceptable implementation for Q7 (the prime tester) that can use a helper too (although it isn't strictly necessary).
3. You may not use any Racket commands not discussed in class. If used, your answer will get a zero.
As a general rule, you should only be using functions taught in class (otherwise you are likely missing
the point of the question and endangering your score).
4. Using If/Cond to pass the specific (non-base) tests provided instead of following the instructions will always
result in a zero for that question.  Do not assume that simply because your code passes all the example
unit tests here then that means you get 100%; we will be testing with input beyond the examples.
The graders will still obey the input contracts.
5. While you are encouraged to create your own comments, NEVER delete any provided comments
(they are used as touchstones by the autograder).

Each of the 8 problems is worth 12 pts for a total of 96 points, plus you get 4pts for writing your name at the end of line1.

; Question 1
input contract:  n is a non-negative integer
output contract: (sumsqs n) is the sum of the first n squares.
Example: when n=4, the output would be 30 because of 1 + 4 + 9 + 16
|#

(define (sumsqs n)
  (if (zero? n)
      0
      (+ (* n n) (sumsqs (- n 1))))); replace this null here with the lines of your code


;Test Bed
(display "Question 1 Tests\n")
(define-test-suite test_sum1
  (test-equal? "" (sumsqs 1) 1)
  (test-equal? "" (sumsqs 2) 5)
  (test-equal? "" (sumsqs 3) 14)
  (test-equal? "" (sumsqs 4) 30)
  (test-equal? "" (sumsqs 5) 55)
  (test-equal? "" (sumsqs 6) 91)
  (test-equal? "" (sumsqs 7) 140)
  (test-equal? "" (sumsqs 8) 204)
  (test-equal? "" (sumsqs 9) 285)
  (test-equal? "" (sumsqs 10) 385))
(define q1_score (- 10 (run-tests test_sum1)))



; Question 2
;input contract:  n is a non-negative integer
;output contract: (sumodds n) is the sum of the first n odd numbers.
;Example: when n=4, the output would be 16 because of 1 + 3 + 5 + 7

(define (sumodds n)
  (if (zero? n)
      0
      (+ (- (* n 2) 1) (sumodds (- n 1))))); replace this null here with the lines of your code.


;Test Bed
(display "Question 2 Tests\n")
(define-test-suite test_sum2
  (test-equal? "" (sumodds 1) 1)
  (test-equal? "" (sumodds 2) 4)
  (test-equal? "" (sumodds 3) 9)
  (test-equal? "" (sumodds 4) 16)
  (test-equal? "" (sumodds 5) 25)
  (test-equal? "" (sumodds 6) 36)
  (test-equal? "" (sumodds 7) 49)
  (test-equal? "" (sumodds 8) 64)
  (test-equal? "" (sumodds 9) 81)
  (test-equal? "" (sumodds 10) 100))
(define q2_score (- 10 (run-tests test_sum2 'verbose)))



#|
; Question 3
input contract:  n is a non-negative integer
output contract: (altcubes n) is an alternating adding/subtracting of the first n cubes
Requirement: the expt command is inefficient here and should not be used!
Example: when n=5, the output would be 81  because of 1 - 8 + 27 - 64 + 125

Hint: try to solve this "Racket style" in which the output of an if is either + or -
|#

(define (altcubes n)
  (define (sign k)
    (if (zero? (remainder k 2)) - +))
  (if (zero? n)
      0
      ((sign n) (altcubes (- n 1)) (* n n n)))); replace this null here with the lines of your code

;end

;Test Bed
(display "Question 3 Tests\n")
(define-test-suite test_sum3
  (test-equal? "" (altcubes 1) 1)
  (test-equal? "" (altcubes 2) -7)
  (test-equal? "" (altcubes 3) 20)
  (test-equal? "" (altcubes 4) -44)
  (test-equal? "" (altcubes 5) 81)
  (test-equal? "" (altcubes 6) -135)
  (test-equal? "" (altcubes 10) -575)
  (test-equal? "" (altcubes 100) -507500)
  (test-equal? "" (altcubes 347) 20981268)
  (test-equal? "" (altcubes 1001) 502253001))
(define q3_score (- 10 (run-tests test_sum3 'verbose)))


; Question 4
;input contract:  n is a non-negative integer
;output contract: (oddfact n) is the "factorial" of just the first n odds
;Example: when n=5, the output would be 945 because of 9*7*5*3*1
;Hint: be careful, the specs are NOT saying that n needs to be odd

(define (oddfact n)
  (if (zero? n)
      1
      (* (- (* 2 n) 1) (oddfact (- n 1))))); replace this null here with the lines of your code

;end

;Test Bed
(display "Question 4 Tests\n")
(define-test-suite test_sum4
  (test-equal? "" (oddfact 1) 1)
  (test-equal? "" (oddfact 2) 3)
  (test-equal? "" (oddfact 3) 15)
  (test-equal? "" (oddfact 4) 105)
  (test-equal? "" (oddfact 5) 945)
  (test-equal? "" (oddfact 6) 10395)
  (test-equal? "" (oddfact 7) 135135)
  (test-equal? "" (oddfact 8) 2027025)
  (test-equal? "" (oddfact 9) 34459425)
  (test-equal? "" (oddfact 10) 654729075))
(define q4_score (- 10 (run-tests test_sum4 'verbose)))

; Question 5
;input contract:  n is a positive integer
;output contract: (logfloor n) is the largest power of 2 which is less than or equal to n
;Example: when n=100, the output would be 6 because 2^6 <= 100 but 2^7 > 100
;Requirement: do NOT use any math operations beyond basic integer arithmetic (e.g. +, - , *, quotient, remainder)
;Hint: the ideal solution does not require a helper function.

(define (logfloor n)
  (if (= n 1)
      0
      (+ (logfloor (quotient n 2)) 1))); replace this null here with the lines of your code

;end

;Test Bed
(display "Question 5 Tests\n")
(define-test-suite test_sum5
  (test-equal? "" (logfloor 1) 0)
  (test-equal? "" (logfloor 2) 1)
  (test-equal? "" (logfloor 3) 1)
  (test-equal? "" (logfloor 4) 2)
  (test-equal? "" (logfloor 5) 2)
  (test-equal? "" (logfloor 6) 2)
  (test-equal? "" (logfloor 7) 2)
  (test-equal? "" (logfloor 8) 3)
  (test-equal? "" (logfloor 9) 3)
  (test-equal? "" (logfloor 10) 3))
(define q5_score (- 10 (run-tests test_sum5 'verbose)))

#|
Question 6: Staircase climbing

You are standing at the bottom of a staircase and heading to the top.
You can take big steps (3 stairs at a time), medium steps (2 stairs at a time) or small steps (1 stair at a time).

input contract:  n is a positive integer representing the number of stairs on the staircase
output contract: (stepways n) is the number of different ways you could get to the top from the bottom
Examples: when n=3, the output would be 4 because there are four different ways to climb the 3 stairs:
[1] three small steps  [2] a small step followed by a medium step  [3] a medium then a small  [4] one big step
As another example, (stepways 5) would be 13 because of: mb, ssb, bm, smm, msm, sssm, sbs, mms, ssms, bss, smss, mss, sssss
Hint: the program only needs to give the total ways. It should not generate those letters, s=small, m=medium, b=big 
|#

(define (stepways n)
  (cond
    [(< n 0) 0]
    [(= n 0) 1]
    [else (+ (stepways (- n 1)) (stepways (- n 2)) (stepways (- n 3)))])); replace this null here with the lines of your code

;end

;Test Bed
(display "Question 6 Tests\n")
(define-test-suite test_puzzle
  (test-equal? "" (stepways 1) 1)
  (test-equal? "" (stepways 2) 2)
  (test-equal? "" (stepways 4) 7)
  (test-equal? "" (stepways 5) 13)
  (test-equal? "" (stepways 7) 44)
  (test-equal? "" (stepways 10) 274)
  (test-equal? "" (stepways 15) 5768)
  (test-equal? "" (stepways 20) 121415)
  (test-equal? "" (stepways 25) 2555757)
  (test-equal? "" (stepways 30) 53798080))
(define q6_score (- 10 (run-tests test_puzzle 'verbose)))

#|
; Question 7: primality predicate
 
 input contract: n is any integer
 output contract: this is the predicate for primality.  In other words, (prime? n) returns #t if n is prime and #f if it isn't.

Here is a basic layout for your function.
1.) Negative Numbers, 0, and 1 are not primes.
2.) To determine if n is prime:
2a.) See if n is divisible by i=2
2b.) Set i=i+1
2c.) If i^2 <=n continue.
3.) If no values of i evenly divided n, then it must be prime.
Note: You can stop when i*i > n.
Why?
Take n=19 as an example.
i=2, 2 does not divide 19 evenly
i=3, 3 does not divide 19 evenly
i=4, 4 does not divide 19 evenly
i=5, we don't need to test this. 5*5=25.
If 5*x=19, the value of x would have to be smaller then 5.
We already tested those values!
No larger numbers can be factors unless one we already test is to.

Hint: You may have the recursion take place in a helper function!
In other words, define two functions, and have the "main" function
call the helper function which recursively performs the subcomputations.
Hint: a common coding error is for your program to incorrectly report 2 as not prime.
Rather than hard code in a special check for that (BAD programming habit!), instead
you should fix that error by adjusting the order of your cond cases.
|#

(define (prime? n)
  (cond
    [(<= n 1) #f]
    [else (helper n 2)]))
(define (helper n i)
  (cond
    [(> (* i i) n) #t]
    [(zero? (remainder n i)) #f]
    [else (helper n (+ i 1))])); replace this null here with the lines of your code

;end


;Here are some tests to see if your function works.
(display "Question 7 Tests\n")
(define-test-suite test_is_prime
  (test-equal? "" (prime? -1) #f)
  (test-equal? "" (prime? 0) #f)
  (test-equal? "" (prime? 1) #f)
  (test-equal? "" (prime? 2) #t)
  (test-equal? "" (prime? 3) #t)
  (test-equal? "" (prime? 4) #f)
  (test-equal? "" (prime? 5) #t)
  (test-equal? "" (prime? 6) #f)
  (test-equal? "" (prime? 7) #t)
  (test-equal? "" (prime? 8) #f)
  (test-equal? "" (prime? 9) #f)
  (test-equal? "" (prime? 10) #f)
  (test-equal? "" (prime? 11) #t)
  (test-equal? "" (prime? 12) #f)
  (test-equal? "" (prime? 13) #t)
  (test-equal? "" (prime? 14) #f)
  (test-equal? "" (prime? 16) #f)
  (test-equal? "" (prime? 18) #f)
  (test-equal? "" (prime? 20) #f)
  (test-equal? "" (prime? 35) #f))
(define q7_score (- 20 (run-tests test_is_prime 'verbose)))

#|
; Question 8
 input contract: n is a positive integer
 output contract: (sum_digits n) returns the sum of the digits of n.
 for example, when n=3123, the output would be 9 because of 3+1+2+3
 note: you should NOT be converting to strings to do this problem -- do all calculations with INTEGERS
|#

(define (sum_digits n)
  (if (zero? n)
      0
      (+ (remainder n 10) (sum_digits (quotient n 10))))); replace this null here with the lines of your code

;end

;Test Bed
(display "Question 8 Tests\n")
(define-test-suite test_sum_digits
  (test-equal? "" (sum_digits 395718860534) 59)
  (test-equal? "" (sum_digits 193139816415) 51)
  (test-equal? "" (sum_digits 22424170465) 37)
  (test-equal? "" (sum_digits 800187484459) 58)
  (test-equal? "" (sum_digits 427552056869) 59)
  (test-equal? "" (sum_digits 842622684442) 52)
  (test-equal? "" (sum_digits 412286285840) 50)
  (test-equal? "" (sum_digits 996417214180) 52)
  (test-equal? "" (sum_digits 386408307450) 48)
  (test-equal? "" (sum_digits 694607189265) 63))
(define q8_score (- 10 (run-tests test_sum_digits 'verbose)))

;;;;;;;;;;;;;;Test Summary;;;;;;;;;;;;;;;;;;;;;;;
(display "------Test Summary------\n")
(display "Q1 Passed ")(display q1_score)(display "/10\n")
(display "Q2 Passed ")(display q2_score)(display "/10\n")
(display "Q3 Passed ")(display q3_score)(display "/10\n")
(display "Q4 Passed ")(display q4_score)(display "/10\n")
(display "Q5 Passed ")(display q5_score)(display "/10\n")
(display "Q6 Passed ")(display q6_score)(display "/10\n")
(display "Q7 Passed ")(display q7_score)(display "/20\n")
(display "Q8 Passed ")(display q8_score)(display "/10\n")
