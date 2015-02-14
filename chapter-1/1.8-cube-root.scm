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

(define large-number 5e200)
(define small-number 5e-200)

(println "Should be 3: " (cube-root (cube 3)))
(println "Should be 27: " (cube-root (cube 27)))
(println "Should be 200000: " (cube-root (cube 2e5)))
