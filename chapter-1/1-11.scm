;     0
; (0 1) (1 1)
; (0 2) (1 2) (2 2)
(define (pascal x y)
  (cond
    ; Leftmost row is always 1
    ((= x 0) 1)
    ; The rightmost element in a row is 1
    ((= x y) 1)
    (else (+
            (pascal (- x 1) (- y 1))
            (pascal x (- y 1))))))
