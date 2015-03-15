; Design a multiplication procedure analogous to fast-expt that uses a
; logarithmic number of steps.

(define (double a) (* a 2))
(define (halve a) (/ a 2))

; Logarithmic growth, O(log n)
; Number of steps for (fast-mult 2a b) is only one more than (fast-mult a b)
; since we `(halve a)` as the first operation. Therefore it's not linear, must be
; O(log n).
(define (fast-mult a b)
  (cond ((or (= 0 a) (= 0 b)) 0)
        ((= 1 a) b)
        ((= 1 b) a)
        ((even? a) (fast-mult (halve a) (double b)))
        ; With both of these even? checks, it just cycles between them:
        ; 6 20 -> 3 10 -> 6 20 etc
        ; ((even? b) (fast-mult (double a) (halve b)))
        ; a and b are odd
        (else (+ b (fast-mult (- a 1) b)))))
