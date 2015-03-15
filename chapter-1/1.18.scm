(define (double a) (* a 2))
(define (halve a) (/ a 2))

(define (mult a b)
  (mult-iter a b 0))

; O(log n) steps because you have to increase the input by quite a bit to  add 1
; more step: (mult 3 6) takes only 1 more step than (mult 3 12)

; (mult 3 6) - 5 steps
;  a b result
;  3 6 0
;  6 3 0
;  6 2 6
; 12 1 6
; 18 (5 steps)
;
; (mult 3 12) - 6 steps
;  a  b result
;  3 12 0
;  6  6 0
; 12  3 0
; 12  2 12
; 24  1 12
; 36
(define (mult-iter a b result)
  (cond
    ((= 0 b) 0)
    ((= 1 b) (+ a result))
    ((even? b) (mult-iter (double a) (halve b) result))
    (else (mult-iter a (- b 1) (+ a result)))))
