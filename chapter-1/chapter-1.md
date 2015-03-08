# Chapter 1

## Basic Syntax

```scheme
; primitive value
5

; set a value in the local environment
(define pi 3.14159)

; function
(define (square x) (* x x)

; conditional
(define (compare-to-three x)
  ; cond has a bunch of clauses
  ; else evaluates to `true`
  (cond ((> x 3) x)
        ((= x 3) 0)
        (else (- x))))

; if statement
(if (< x 0)
  (- x)
  x)

(and #t #f) ; => #f
(or #t #f) ; => #t
(not #f) ; => #t
```

## Evaluation

* Applicative-order evaluation evaluates operands, then applies the functions
  - this is what Scheme actually does
* Normal-order evaluation fully expands the operands until we have only
  primitives and primitive operators, then reduces them

Take

```scheme
(+ 5 (square (+ 5 1)))
```

Applicative-order evaluation:

```scheme
(+ 5 (square (+ 5 1)))
(+ 5 (square 6))
(+ 5 (* 6 6))
(+ 5 36)
41
```

Normal-order evaluation:

```scheme
(+ 5 (square (+ 5 1)))
(+ 5 (* (+ 5 1) (+ 5 1)))
(+ 5 (* 6 6))
(+ 5 36)
41
```

Note that in applicative-order, we only evaluate `(+ 5 1)` once, instead of
twice.

## Exercises

#### 1.1

```scheme
10
12
8
3
6
a
b
19
#f
4
16
6
16
```

#### 1.2

Translate this into prefix form:


```scheme
; (5 + 4 + (2 - (3 - (6 + 4/5)))) / (3 (6 - 2) (2 - 7))

(/
  (+ 5 4 (- 2 3 (+ 6 (/ 4 5))))
  (* 3 (- 6 2) (- 2 7)))
```

#### 1.3

Define a procedure that takes three numbers as arguments and returns the sum of
the squares of the two larger numbers.

```scheme
(define (square-larger-two x y z)
  (cond ((> x y) (if (> z y)
                   ; > x y, > z y
                   (+ (* x x) (* z z))
                   ; > x y, but z <= y
                   (+ (* x x) (* y y))))
        ((> x z) (if (> y z)
                   ; > x z, > y z
                   (+ (* x x) (* y y))
                   ; > x z, but z >= y
                   (+ (* x x) (* z z))))
        ; at this point, x <= z, because otherwise it would match
        ; (> x z) above. We can also assume that x <= y because otherwise it
        ; would match (> x y).
        ; So x <= z and x <= y. So y and z are the two larger numbers.
        (else (+ (* y y) (* z z)))))
```

#### 1.4

Describe the behavior of:

```scheme
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
```

If b is greater than 0, then the operator is `+`, otherwise `-`. So if b is
greater than 0, it evaluates to `(+ a b)`. If b is less than zero, it evaluates
to `(- a b)`.

#### 1.5

Given:

```scheme
(define (p) (p))
(define (test x y)
  (if
    (= x 0) 0
    y))

(test 0 (p))
```

With applicative-order evaluation, `(test 0 (p))` would attempt to evaluate the
operands first. `0` is `0`, but `(p)` becomes `(p)` and recurses forever.

With normal-order evaluation, the expression is fully-expanded, so `(test 0 (p)`
becomes `(if (= 0 0) 0 (p))`, which evaluates to `0`, and `(p)` is never
evaluated.

#### 1.6

This function is not a substitute for `if` at the syntax-level:

```scheme
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))
```

`cond` can replace `if` at the syntax level, but putting a function around the
syntax means that the interpreter's applicative-order evaluation attempts to
evaluate ALL of `new-if`'s arguments before moving on, while `if`/`cond` only
evaluates the second clause if the conditional evaluates to false

#### 1.7

> The good-enough? test used in computing square roots will not be very
> effective for finding the square roots of very small numbers

`good-enough?` won't work for square roots of small numbers because e.g.
`sqrt(0.0005)` is `0.0225`, but the difference between the square of the guess
and the actual number becomes smaller than 0.1 (our threshold) quite quickly.
0.1 is larger than the number we want to find the square root of, so the first
time we get within 0.1 of the root, it stops. If the threshold were lower than
0.1, we could keep going until we find a closer approximation. If the threshold
is lowered to `0.0001`, for example, we get a very good approximation.

> In real computers, arithmetic operations are almost always performed with
> limited precision. This makes our test inadequate for very large numbers.

The test fails with `(sqrt 5e1000)` because that number overflows and is
represented as infinity in scheme which means the square is also infinity, the
guess is infinity, and `infinity - infinity` in `good-enough?` is `+nan.0` (not
a number), meaning the comparisons between numbers are totally wacky and we
can't tell whether our guess is good enough because we're comparing "not a
number" to `0.1`.

> An alternative strategy for implementing good-enough? is to watch how guess
> changes from one iteration to the next and to stop when the change is a very
> small fraction of the guess.

Assuming this is the test we use for determining if a guess is good:

```scheme
(define (small-fraction-of? improved old)
  (let ((change (abs (- improved old))))
    (< (/ change old) 0.1)))

(define (sqrt-iter-new guess x)
  (if (small-fraction-of? (improve guess x) guess)
      guess
      (sqrt-iter-new (improve guess x) x)))
```

...then yes, it does help. The square root of 5e-200 is correctly calculated,
while `sqrt-iter` gives `0.25`, which is very incorrect. It does not work
significantly better for large numbers, but it's not incredibly far off, either.

#### 1.8

Cube root:

```scheme
; Exercise 1.8

(define (cube-root-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-root-iter (improve guess x) x)))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) 0.1))

(define (small-fraction-of? improved old)
  (let ((change (abs (- improved old))))
    (< (/ change old) 0.1)))

(define (cube-root x)
  (cube-root-iter 1.0 x))

(define (cube x)
  (* x x x))

(println "Should be 3: " (cube-root (cube 3)))
(println "Should be 27: " (cube-root (cube 27)))
(println "Should be 200000: " (cube-root (cube 2e5)))
```

### 1.9

```scheme
(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))
```

Using the substitution model, illustrate the process generated by each procedure
in evaluating `(+ 4 5)`. Are these processes iterative or recursive?

Using the first procedure:

```scheme
; a = 4, b = 5
(inc (+ (dec 4) 5))
; (dec 4) is 3. can't evaluate expand inc yet because we don't know its operands
(inc (+ 3 5))
; a = 3, b = 5
(inc (inc (+ (dec 3) 5)))
; (dec 3) == 2
(inc (inc (+ 2 5)))
; expand +: a = 2, b = 5
(inc (inc (inc (+ (dec 2) 5))))
; (dec 2) == 1
(inc (inc (inc (+ 1 5))))
; expand +: a = 1, b = 5
(inc (inc (inc (inc (+ (dec 1) 5)))))
; (dec 1) == 0
(inc (inc (inc (inc (+ 0 5)))))
; expand +: a == 0, so we've hit the base case
(inc (inc (inc (inc 5))))
; inc 5 == 6
(inc (inc (inc 6)))
; inc 6 == 7
(inc (inc 7))
; inc 7 == 8
(inc 8)
; inc 8 == 9
9
```

This follows the sideways-bell-curve shape of a recursive function. `+`
continually expands its arguments, and we store many deferred `inc` calls until
we finally reach the base case of `(= a 0)` and can return a number instead of a
function call. Until we reach that base case, we store `a` function calls (if a
is 4, we store 4 function calls, etc).

Using the second procedure:

```scheme
(+ 4 5)
; ...expands to:
(+ (dec 4) (inc 5))
; dec 4 = 3, inc 5 = 6
(+ 3 6)
(+ (dec 3) (inc 6))
(+ 2 7)
(+ (dec 2) (inc 7))
(+ 1 8)
(+ (dec 1) (inc 8))
(+ 0 9)
; a is 0, so return b
9
```

This is iterative: it does not defer all evaluation until the end. Instead, it
stores its state at each step. There are no deferred evaluations, like the
stacked `inc` above. At each stage, `inc` and `dec` operate on atoms, not
deferred procedures.

1.10: Ackermann's function

See file 1-10.scm

* `(define (f n) (A 0 n))`; `(f n)` is 2n
* `(define (g n) (A 1 n))`; `(g n)` is 2^n
* `(define (h n) (A 2 n))`; `(h n)` is 2 raised to itself n times, e.g. `(h 4)`
  is `2^2^2^2`. This is also called [double-up-arrow][arrow] or [tetration].

[arrow]: http://en.wikipedia.org/wiki/Knuth%27s_up-arrow_notation
[tetration]: http://en.wikipedia.org/wiki/Tetration

1.11

```scheme
; This is recursive - see (f-rec 4)'s shape below
(define (f-rec n)
  (if (< n 3)
    n
    (+
      (f-rec (- n 1))
      (* 2 (f-rec (- n 2)))
      (* 3 (f-rec (- n 3))))))
```

```scheme
(f-rec 4)
; n = 4
(+ (f-rec (- 4 1)) (* 2 (f-rec (- 4 2))) (* 3 (f-rec (- 4 3))))
; Subtract
(+ (f-rec 3) (* 2 (f-rec 2)) (* 3 (f-rec 1)))
; (f-rec 3) gets expanded, (f-rec 2) is 2, (f-rec 1) is 1
(+ (+ (f-rec (- 3 1)) (* 2 (f-rec (- 3 2))) (* 3 (f-rec (- 3 3)))) (* 2 2) (* 3 1))
; Subtract
(+ (+ (f-rec 2) (* 2 (f-rec 1)) (* 3 (f-rec 0))) (* 2 2) (* 3 1))
; (f-rec 2) is 2, (f-rec 1) is 1, (f-rec 0) is 0
(+ (+ 2 (* 2 1) (* 3 0)) (* 2 2) (* 3 1))
; Multiply
(+ (+ 2 2 0) 4 3)
; Add
(+ 4 4 3)
; Add
11
```

```scheme
(define (f-iter n)
  (???)
```

1.11

See `1-11.scm`
