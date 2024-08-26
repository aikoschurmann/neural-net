

(provide & ! ^ ~ << >>)

(define & bitwise-and)
(define ! bitwise-ior)
(define ^ bitwise-xor)
(define ~ bitwise-not)
(define (<< byte offset) (arithmetic-shift byte offset))
(define (>> byte offset) (arithmetic-shift byte (- offset)))







(define (f n)
  (let ((x (>> n 1)))
    (if (= (& n 1) 1)
        (+ (>> x 2) (>> n 1) 1)
        (<< (f x) 2))))