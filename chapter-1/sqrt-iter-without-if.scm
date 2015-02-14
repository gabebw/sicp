; This runs forever because it expands (sqrt-iter-with-new-if) to call itself
; (the else-clause) again, which calls itself again, and so on, forever. `if`
; works at the syntax level to force evaluation before moving on.
(define (sqrt-iter-with-new-if guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter-with-new-if (improve guess x) x)))

; This new-if uses `cond` instead of `if`
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.1))

(define (sqrt-with-new-if x)
  (sqrt-iter-with-new-if 1.0 x))

(println (sqrt-iter-with-new-if 1.0 25))
