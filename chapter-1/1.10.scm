(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

; What is (A 1 10)?
(A 1 10)
; x = 1, y = 10
(A (- 1 1) (A 1 (- 10 1)))
; Substitute what we can
(A 0 (A 1 9))
; Expand (A 1 9)
(A 0 (A (- 1 1) (A 1 (- 9 1))))
; Subtract
(A 0 (A 0 (A 1 8)))
; Expand (A 1 8)
(A 0 (A 0 (A (- 1 1) (A 1 (- 8 1)))))
; Subtract
(A 0 (A 0 (A 0 (A 1 7))))
; Expand (A 1 7)
(A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 7 1))))))
; Subtract
(A 0 (A 0 (A 0 (A 0 (A 1 6)))))
; Expand (A 1 6)
(A 0 (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 6 1)))))))
; Subtract
(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))
; Expand (A 1 5)
(A 0 (A 0 (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 5 1))))))))
; Subtract
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))
; Expand (A 1 4)
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 4 1)))))))))
; Subtract
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))
; Expand (A 1 3)
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 3 1))))))))))
; Subtract
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))
; Expand (A 1 2)
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 2 1)))))))))))
; Subtract
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))
; Expand (A 1 1). y = 1, so the result is 2
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))
; Evaluate (A 0 2). x = y, so result is (* 2 y) == (* 2 2) == 4
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))
; per rules above, (A 0 4) is (* 2 4) == 8
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))
; (A 0 8) == 16
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))
; (A 0 16) == 32
(A 0 (A 0 (A 0 (A 0 (A 0 32)))))
; (A 0 32) == 64
(A 0 (A 0 (A 0 (A 0 64))))
; (A 0 64) == 128
(A 0 (A 0 (A 0 128)))
; (A 0 128) == 256
(A 0 (A 0 256))
; (A 0 265) == 512
(A 0 512)
; (A 0 512) == 1024
1024

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; What is (A 2 4)?
(A 2 4)
; Expand A, since it doesn't hit any of the base cases
(A (- 2 1) (A 2 (- 4 1)))
; Subtract
(A 1 (A 2 3))
; Expand (A 2 3)
(A 1 (A (- 2 1) (A 2 (- 3 1))))
; Subtract
(A 1 (A 1 (A 2 2)))
; Expand (A 2 2)
(A 1 (A 1 (A (- 2 1) (A 2 (- 2 1)))))
; Subtract
(A 1 (A 1 (A 1 (A 2 1))))
; Expand (A 2 1). y == 1, so result is 2
(A 1 (A 1 (A 1 2)))
; Expand (A 1 2)
(A 1 (A 1 (A (- 1 1) (A 1 (- 2 1)))))
; Subtract
(A 1 (A 1 (A 0 (A 1 1))))
; (A 1 1) is 2 since y == 1
(A 1 (A 1 (A 0 2)))
; (A 0 2) is (* 2 2) since x == 0
(A 1 (A 1 4))
; Expand (A 1 4)
(A 1 (A (- 1 1) (A 1 (- 4 1))))
; Subtract
(A 1 (A 0 (A 1 3)))
; Expand (A 1 3)
(A 1 (A 0 (A (- 1 1) (A 1 (- 3 1)))))
; Subtract
(A 1 (A 0 (A 0 (A 1 2))))
; Expand (A 1 2)
(A 1 (A 0 (A 0 (A (- 1 1) (A 1 (- 2 1))))))
; Subtract
(A 1 (A 0 (A 0 (A 0 (A 1 1)))))
; (A 1 1) is 2 since y == 1
(A 1 (A 0 (A 0 (A 0 2))))
; (A 0 2) is (* 2 2) since x == 0
(A 1 (A 0 (A 0 (* 2 2))))
; (* 2 2) is 4
(A 1 (A 0 (A 0 4)))
; (A 0 4) is (* 2 4) since x == 0
(A 1 (A 0 (* 2 4)))
; (* 2 4) is 8
(A 1 (A 0 8))
; (A 0 8) is (* 2 8) since x == 0
(A 1 (* 2 8))
; (* 2 8) is 16
(A 1 16)
; Expand (A 1 16)
(A (- 1 1) (A 1 (- 16 1)))
; Subtract
(A 0 (A 1 15))
; Expand (A 1 15)
(A 0 (A (- 1 1) (A 1 (- 15 1))))
; Subtract
(A 0 (A 0 (A 1 14)))
; Expand (A 1 14)
(A 0 (A 0 (A (- 1 1) (A 1 (- 14 1)))))
; Subtract
(A 0 (A 0 (A 0 (A 1 13))))
; Expand (A 1 13)
(A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 13 1))))))
; Subtract
(A 0 (A 0 (A 0 (A 0 (A 1 12)))))
; Expand (A 1 12)
(A 0 (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 12 1)))))))
; Subtract
(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 11))))))
; Expand (A 1 11)
(A 0 (A 0 (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 11 1))))))))
; Subtract
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 10)))))))
; (A 1 10) == 1024, as shown in the previous problem above
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 1024))))))
; (A 0 1024) == (* 2 1024)
(A 0 (A 0 (A 0 (A 0 (A 0 (* 2 1024))))))
(A 0 (A 0 (A 0 (A 0 (A 0 2048)))))
; (A 0) is (* 2), so we'll skip a few steps and expand that through:
(* 2 (* 2 (* 2 (* 2 (* 2 2048)))))
65536

; (skipping (A 3 3))
