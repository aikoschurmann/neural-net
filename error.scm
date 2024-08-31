(define (mean-squared-error)
  (lambda (predicted actual)
    (let ((diff (matrix-subtract predicted actual)))
      (matrix-scalar-multiply (matrix-sum (matrix-map diff sqr) 'cols) 
                              (/ 1 (* 2 (vector-length actual)))))))

(define (derivative-mean-squared-error)
  (lambda (predicted actual)
    (matrix-scalar-multiply (matrix-subtract predicted actual) 
                            (/ 1 (vector-length actual)))))


(define-class (Error error-function error-function-derivative)
  (error-function! (lambda (new-val) (set! error-function new-val)))
  (error-function-derivative! (lambda (new-val) (set! error-function-derivative new-val))))

(define (make-error error-function error-function-derivative)
  (let ((error (Error)))
    (error 'error-function! (error-function))
    (error 'error-function-derivative! (error-function-derivative))
    error))

