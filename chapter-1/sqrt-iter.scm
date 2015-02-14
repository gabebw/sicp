(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.1))

(define (small-fraction-of? improved old)
  (let ((change (abs (- improved old))))
    (< (/ change old) 0.1)))

; Instead of using 0.1, check how `guess` changes from one iteration to the next
; and stop when the change is a small fraction of the guess
(define (sqrt-iter-new guess x)
  (if (small-fraction-of? (improve guess x) guess)
      guess
      (sqrt-iter-new (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define large-number 5e200)
(define small-number 5e-200)

; (println (sqrt 25))
(println (sqrt-iter-new 1.0 large-number))
(println (sqrt large-number))
