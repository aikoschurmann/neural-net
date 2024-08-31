(#%require (only racket random))

(define (tanh x)
  (/ (- (exp x) (exp (- x)))
     (+ (exp x) (exp (- x)))))

(define (sqr x)
  (expt x 2))

(define pi 3.1415926535)

(define (random-normal mean stddev)
  (let* ((u1 (random)) 
         (u2 (random))
         (theta (* 2.0 pi (random)))
         (r (sqrt (* -2.0 (log u1))))
         (z (* r (cos theta))))
    (+ mean (* z stddev))))


(define (decimal-round number decimals)
  (let ((decimal (expt 10 decimals)))
    (/ (round (* number decimal)) decimal)))

(define (milliseconds->minutes-seconds ms)
  (let* ((total-seconds (/ ms 1000))
         (minutes (quotient (round total-seconds) 60))
         (seconds (remainder (round total-seconds) 60)))
    (string-append (number->string minutes) "m:" (number->string seconds) "s")))