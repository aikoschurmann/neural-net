(define-syntax when
  (syntax-rules ()
    ((_ pred b1 ...)
     (if pred (begin b1 ...)))))

(define-syntax define-class
  (syntax-rules ()
    ((_ (class-name var ...)
        (proc-name proc-lambda)... )
     
     (define (class-name)
       
         (define var 0)...
         (define proc-name proc-lambda)...

         (lambda (message . args)
          (apply (case message
                  
                  ((proc-name) proc-lambda)
                  ...
                  ((var) (lambda () var))
                  ...
                  (else (lambda () (error "Unknown message")))) args))))))

