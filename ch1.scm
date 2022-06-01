;; I came across the site www.teachyourselfcs.com which gives a structured path to a self-taught computer science education
;;; They recommnd as a first step, working through the first three chapters of Structure and Interpretations of Computer Programs
;;; This is a documentation of my journey through the text.

;; Chapter 1.1

;; Exercise 1.1.1
;; Below is a sequence of expressions. What is the result printed by the interpreter in response to each expression? Assume that the sequence is to be evaluated in the order in which it is presented
;; The answers are on the same line as the expression after the semicolon i.e. as comments

10 ;; 10

(+ 5 4 3) ;; 12

(- 9 1) ;; 8

(/ 6 2) ;; 3

(+ (* 2 4) (- 4 6)) ;; 6

(define a 3) ;; a = 3

(define b (+ a 1)) ;; b = 3+1 (4)

(+ a b (* a b)) ;; (3 + 4 + (3*4)) -> 7 + 12 -> 19

(= a b) ;; this expression evaluates as false

(if (and  (> b a) (< b (* a b))) b a) ;; if b is greater than a and b is less than the product of a and b, return b else return a... the predicate evaluates to true hence it returns b which is 4

(cond ((= a 4) 6) ((= b 4) (+ 6 7 a)) (else 25)) ;; second predicate is true hence returns its consequent (6 + 7 + 3) -> 16

(+ 2 (if (> b a) b a)) ;; the predicate is true hence b i.e. (4) is returned whose sum with 2 is 6

(* (cond ((> a b) a) ((< a b) b) (else -1)) (+ a 1)) ;; In the first operand the second predicate evaluates to true hence 4 is returned from this expression which is multiplied by the result of the second expression (3+1) -> 4, hence the result is 4*4 -> 16

;;Exercise 1.1.2
;; Translate the following expression into prefix form

(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7))) ;; evaluates to -37/150 or -0.246666666

;; Exercise 1.1.3
;; Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers


;; Step 1 define the square procedure as below
(define (square x) (* x x))

;; Step 2 is to define the sum of squares procedure as below
(define (sum-squares x y) (+ (square x) (square y)))


;; Step 3 is to define the procedure to determine the larger of two numbers as follows: using the if conditional check whether the first number is larger than the second, if yes, return the first if not return the second, then check whether the second number is larger than the third, if yes, return the second number if not return the third. This will give you the larger two numbers.

(define (sum-larger-squares a b c) (sum-squares (if (> a b) a b) (if (> b c) b c)))


;; Exercise 1.1.4
;; Observe that our model of evaluation allows for combinations whose operators are compound expressions. Use this observation to describe the behavior of the following procedure

(define (a-plus-abs-b a b) ((if (> b 0) + -) a b))

;; Here, the if expression checks whether b is positive or negativeand returns the operator '+' if positive and the operator '-' if negative, this is then applied to the operands a and b



;; Exercise 1.1.5
;; Ben Bitdiddle has invented a test to determine whether the interpreter he is faced with  is using applicative-order or normal-order evaluation. He defines the following two procedures:

(define (p) (p))

(define (test x y) (if (= x 0) 0 y))

;; Then he evaluates the expression 

(test 0 (p))

;; What behavior will Ben observe with an interpreter that uses applicative-order evaluation? What behavior will he observe with an interpreter that use normal-order evaluation? Explain your answer. (Assume that the evaluation rule for the special form 'if' is the same whether the interpreter is using normal or applicative order: Thepredicate expression is evaluated first, and the result determines whether to evaluate te consequent or the alternative expression)

;; Answer: If the interpreter uses normal-order evaluation, it will return 0 as the answer since it will evaluate the operands of (test x y) i.e. (test 0 (p)) it will first check whether x i.e. 0 is equal to 0 if true it will return 0 if false it will return y i.e. (p) which will call itself recursively. In this case x == 0 hence there will be no need to evaluate y i.e. (p). If it was applicative-order evaluation, the expression (test 0 (p)) will enter an infinite loop since both x==0 and y==(p) will have to be evaluated.



;; Exercise 1.1.6

;; sqrt procedure
(define (square x) (* x x))
(define (good-enough? guess x)  (< (abs (- (square guess) x)) 0.001))
(define (average x y) (/ (+ x y) 2))
(define (improve guess x)  (average guess (/ x guess))) 
(define (sqrt-iter guess x) (if (good-enough? guess x) guess (sqrt-iter (improve guess x) x)))
(define (sqrt x)   (sqrt-iter 1.0 x))


;; Alyssa P. Hacker doesn’t see why if needs to be provided as a special form. “Why can’t I just define it as an ordinary procedure in terms of cond?” she asks. Alyssa’s friend Eva Lu Ator claims this can indeed be done, and she defines a new version of if:

(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

;; Delighted, Alyssa uses new-if to rewrite the square-root program:

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))
          
;; What happens when Alyssa attempts to use this to compute square roots? Explain.

;; The program enters an infinite loop since new-if is not a special form like the original if hence when evaluating the alternative it calls itself ad infinitum 




;; Exercise 1.1.7

;; The good-enough? test used in computing square roots will not be very effective for finding the square roots of very small numbers. Also, in real computers, arithmetic operations are almost always performed with limited precision. This makes our test inadequate for very large numbers. Explain these statements, with examples showing how the test fails for small and large numbers. An alternative strategy for implementing good-enough? is to watch how guess changes from one iteration to the next and to stop when the change is a very small fraction of the guess. Design a square-root procedure that uses this kind of end test. Does this work better for small and large numbers?




;; Exercise 1.1.8

;; Newton’s method for cube roots is based on the fact that if y is an approximation to the cube root of x, then a better approximation is given by the value ((x/y^2) + 2y / 3). Use this formula to implement a cube-root procedure analogous to the square-root procedure. (In 1.3.4 we will see how to implement Newton’s method in general as an abstraction of these square-root and cube-root procedures.)

(define (square x) (* x x)) ;; procedure definition for squaring numbers

(define (cube x) (* x x x)) ;; procedure definition for cubing numbers

(define (goodenough? guess x) (< (abs (- (cube guess) x)) 0.001)) ;; procedure definition for checking whether the guess is accurate enough

(define (himprove guess x) (/ (+ (/ x (square guess)) (* 2 guess)) 3)) ;; procedure definition for improving the guess if not accurate enough

(define (crt-iter guess x) (if (goodenough? guess x) guess (crt-iter (himprove guess x) x))) ;; procedure definition for computing the cube root

(define (crt x) (crt-iter 1.0 x)) ;; procedure definition for computing the cube root






;;Chapter 1.2

;; Example 1.2.1
;; Linear recursion and iteration
;; Consider the factorial function n! which could be rewritten as n.(n-1)!
;; This can be written in scheme as:

(define (factorial n) (if (= n 1) 1 (* n (factorial (- n 1)))))

;; The above is a recursive process which has deferred operations, the visualization is as below, it fans out then back in
;; Recursive processes are characterized by a chain of deferred operations. The interpreter keeps track of the operations to be performed later on. In the computation of n!, the length of hte chain of deferred multiplications and hence the amount of information needed to keep track of it grows linearly with n just like the number of steps. Such a process is called a linear recursive process.

(factorial 6)
(* 6 (factorial 5))
(* 6 (* 5 (factorial 4)))
(* 6 (* 5 (* 4 (factorial 3))))
(* 6 (* 5 (* 4 (* 3 (factorial 2)))))
(* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))
(* 6 (* 5 (* 4 (* 3 (* 2 1)))))
(* 6 (* 5 (* 4 (* 3 2))))
(* 6 (* 5 (* 4 6)))
(* 6 (* 5 24))
(* 6 120)
720


;; The iterative model

;; A different perspective is the iterative model where we maintain a running product and a counter i.e.
;; product <- product * counter
;; counter <- counter + 1

;; Hence we can recast our factorial function iteratively as below

(define (factorial n) (fact-iter 1 1 n))
(define (fact-iter product counter max-count) (if (> counter max-count) product (fact-iter (* counter product) (+ counter 1) max-count)))

;; In the above case, the visualization is as below with constant space, no fanning out. This process does not grow and shink, at each step all we need to keep track of, for any n, are the current values of the variables product, counter and max-count. This is an iterative processs, i.e. one whose state can be summarized by a fixed number of state variables together with a fixed rule that describes how the state varables should be updated as the proces moves from state to state and an (optional) end test that specifies conditions under which the process should terminate. 

(factorial 6)
(fact-iter 1 1 6)
(fact-iter 1 2 6)
(fact-iter 2 3 6)
(fact-iter 6 4 6)
(fact-iter 24 5 6)
(fact-iter 120 6 6)
(fact-iter 720 7 6)
720

;; Exercise 1.9
;; Each of the follwoing two procedures defines a method for adding two positive integers in terms of the procedures inc, which increments its argument by 1, and dec, which decrements its argument by 1

(define (+ a b)
  (if (= a 0) 
      b 
      (inc (+ (dec a) b))))

(define (+ a b)
  (if (= a 0) 
      b 
      (+ (dec a) (inc b))))
      
;; Using the substitution model, illustrate the process generated by each procedure in evaluating (+ 4 5). Are these processes iterative or recursive?

;; The first process is recursive while the second is iterative

;; Exercise 1.10
;; The following procedure computes a mathematical function called Ackermann’s function.

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))
                 
;; What are the values of the following expressions?

;; (A 1 10) -> 1024
;; (A 2 4) -> 65536
;; (A 3 3) -> 65536


;; Consider the following procedures, where A is the procedure defined above:

;; (define (f n) (A 0 n)) -> 2n
;; (define (g n) (A 1 n)) -> 2^n
;; (define (h n) (A 2 n)) -> 
;; (define (k n) (* 5 n n))
;; Give concise mathematical definitions for the functions computed by the procedures f, g, and h for positive integer values of n. For example, (k n) computes 5n2.      


