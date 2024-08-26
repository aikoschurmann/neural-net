(define-class (Layer weights biases activation A-prev Z dW db)
  (weights! (lambda (new-val) (set! weights new-val)))
  (biases! (lambda (new-val) (set! biases new-val)))
  (activation! (lambda (new-val) (set! activation new-val)))
  (dW! (lambda (new-val) (set! dW new-val)))
  (db! (lambda (new-val) (set! db new-val)))

  (linear-forward (lambda (inputs)
                    (let ((z-local (matrix-add (matrix-dot inputs weights) biases)))
                      (set! A-prev inputs)
                      (set! Z z-local)
                      z-local)))

  (activation-forward (lambda (inputs) 
                        (matrix-map 
                          (linear-forward inputs) (activation 'activation-function)))))


(define (create-layer inputs outputs activation initializer)
  (let* ((layer (Layer))
         (initializer (initializer inputs outputs))
         (weights (make-matrix inputs outputs initializer))
         (biases (make-matrix 1 outputs (lambda () 0))))

    (layer 'weights! weights)
    (layer 'biases! biases)
    (layer 'activation! activation)
    layer))