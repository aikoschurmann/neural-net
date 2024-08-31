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

(define (generate-circle-dataset n)
  (define (point-in-circle? x y)
    (< (+ (* (- x 0.5) (- x 0.5)) (* (- y 0.5) (- y 0.5))) (* 0.5 0.5)))
  (define (helper i dataset)
    (if (= i 0)
        dataset
        (let* ((x (random))
               (y (random))
               (label (if (point-in-circle? x y) #(1) #(0))))
          (helper (- i 1) (cons (cons (vector x y) label) dataset)))))
  (helper n '()))
      
(define (generate-spiral-dataset n)
  (define (generate-spiral-class t sign)
    (let* ((r (* 0.5 t))
           (x (+ 0.5 (* r (cos (* sign t 4 pi)))))
           (y (+ 0.5 (* r (sin (* sign t 4 pi))))))
      (cons (vector x y) (vector (if (= sign 1) 1 0)))))
  (define (helper i dataset)
    (if (= i 0)
        dataset
        (let* ((t (/ i n))
               (sign (if (even? i) 1 -1))
               (point (generate-spiral-class t sign)))
          (helper (- i 1) (cons point dataset)))))
  (helper n '()))
      
