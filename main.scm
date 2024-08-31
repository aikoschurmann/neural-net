(#%require (only racket random error format current-milliseconds))
(load "macros.scm")
(load "matrix.scm")
(load "layer.scm")
(load "error.scm")
(load "math.scm")
(load "activations.scm")
(load "initializers.scm")
(load "neuralnet.scm")

;todo add optimisers now gradient descent 
;eg: ADA ADAM etc

(define layers (list (create-layer 2 10 (make-activation ReLU derReLU) XavierInitializer)
                     (create-layer 10 10 (make-activation ReLU derReLU) XavierInitializer)
                     (create-layer 10 1 (make-activation Sigmoid derSigmoid) XavierInitializer)))

(define network (create-FFNN layers (make-error mean-squared-error derivative-mean-squared-error)))

(define xor-dataset
  (list (cons #(0 0) #(0))
        (cons #(0 1) #(1))
        (cons #(1 0) #(1))
        (cons #(1 1) #(0))))
        
(define circle-dataset (generate-circle-dataset 100))
(define spiral-dataset (generate-spiral-dataset 100))

; Define the layers and network
(define layers (list (create-layer 2 10 (make-activation ReLU derReLU) XavierInitializer)
                     (create-layer 10 10 (make-activation ReLU derReLU) XavierInitializer)
                     (create-layer 10 1 (make-activation Sigmoid derSigmoid) XavierInitializer)))

(define network (create-FFNN layers (make-error mean-squared-error derivative-mean-squared-error)))

(network 'train circle-dataset 1000)

; Test the network with a few example inputs
(display (network 'forward #( #(0.1 0.1) )))
(newline)
(display (network 'forward #( #(0.5 0.5) )))
(newline)
(display (network 'forward #( #(0.9 0.9) )))
(newline)
(display (network 'forward #( #(0.1 0.9) )))