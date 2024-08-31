(#%require (only racket random error format current-milliseconds))
(load "macros.scm")
(load "matrix.scm")
(load "layer.scm")
(load "error.scm")
(load "math.scm")
(load "activations.scm")
(load "initializers.scm")
(load "neuralnet.scm")




(define layers (list (create-layer 2 10 (make-activation ReLU derReLU) XavierInitializer)
                     (create-layer 10 10 (make-activation ReLU derReLU) XavierInitializer)
                     (create-layer 10 1 (make-activation Sigmoid derSigmoid) XavierInitializer)))

(define network (create-FFNN layers (make-error mean-squared-error derivative-mean-squared-error)))
(define dataset (list (cons #(1 0) #(1))
                      (cons #(1 1) #(0))
                      (cons #(0 0) #(0))
                      (cons #(0 1) #(1))))

(network 'train dataset 1000)

(display (network 'forward #(#(1 0))))
(newline)
(display (network 'forward #(#(1 1))))
(newline)
(display (network 'forward #(#(0 0))))
(newline)
(display (network 'forward #(#(0 1))))