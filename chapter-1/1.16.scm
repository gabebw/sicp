; Compute b^n
(define (expt b n)
  (expt-iter b n 1))

(define (expt-iter b n a)
  (cond ((= n 0) (* a b))
        ((= n 1) (* a b))
        (else
         ; set a = a*b
         ; set o = n-1
         ; old: a * b^n
         ; new: a*b * b^(n-1) = a * b * b^(n-1)
         ; b * b^(n-1) = b^n
         ; so it's still a * b^n
         ; a started at 1, so it's b^n
         (expt-iter b (- n 1) (* b a)))))
