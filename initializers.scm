(define (XavierInitializer input-units output-units)
  (let ((stddev (sqrt (/ 2 (+ input-units output-units)))))
    (lambda () (random-normal 0 stddev))))