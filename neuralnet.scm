
;layers is a list
(define-class (FFNN layers)
  (layers! (lambda (new-val) (set! layers new-val)))

  (forward (lambda (X)
             (let ((output X))
               (for-each (lambda (layer)
                           (set! output (layer 'activation-forward output)))
                         layers)
               output)))
               
  (backward (lambda (loss-gradient) 
              (let ((loss-gradient loss-gradient))
                (for-each (lambda (layer)
                            (let ((DA ((layer 'activation) 'activation-function-derivative))
                                  (Z (layer 'Z))
                                  (A-prev (layer 'A-prev))
                                  (weights (layer 'weights))
                                  (biases (layer 'biases)))

                              (set! loss-gradient (matrix-multiply (matrix-map Z DA) loss-gradient))
                              (layer 'dW! (matrix-dot (matrix-transpose A-prev) loss-gradient))
                              (layer 'weights! (matrix-subtract weights (matrix-scalar-multiply (layer 'dW) 0.01)))
                              (layer 'db! (matrix-sum loss-gradient 'rows))
                              (layer 'biases! (matrix-subtract biases (matrix-scalar-multiply (layer 'db) 0.01)))

                              (set! loss-gradient (matrix-dot loss-gradient (matrix-transpose weights)))))
                          (reverse layers))))))


(define (create-FFNN layers)
  (let* ((network (FFNN)))
    (network 'layers! layers)
    network))
