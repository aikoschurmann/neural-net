(#%require (only racket random error format current-milliseconds))
(load "macros.scm")
(load "matrix.scm")
(load "layer.scm")
(load "math.scm")
(load "activations.scm")
(load "initializers.scm")
(load "neuralnet.scm")
(load "mnist.scm")



(define layers (list (create-layer (* 28 28) 30 (make-activation ReLU derReLU) XavierInitializer)
                     (create-layer 30 50 (make-activation ReLU derReLU) XavierInitializer)
                     (create-layer 50 10 (make-activation Sigmoid derSigmoid) XavierInitializer)))

(define network (create-FFNN layers))
;
;(define images (read-mnist-image-file "dataset/train-images.idx3-ubyte"))
;(set! images (map (lambda (image) (list->vector image)) images))
;
;(define labels (read-mnist-label-file "dataset/train-labels.idx1-ubyte")) 
;(set! labels (map (lambda (label) (one-hot-encode label 10)) labels))
;
;(define data-set (map cons images labels))

;(save-dataset data-set "dataset.ser")

(define data-set (load-data "dataset.ser"))

(display "loaded dataset")
(newline)




(define (milliseconds->minutes-seconds ms)
  (let* ((total-seconds (/ ms 1000))
         (minutes (quotient (round total-seconds) 60))
         (seconds (remainder (round total-seconds) 60)))
    (string-append (number->string minutes) "m:" (number->string seconds) "s")))

(define (clear-terminal)
  (let loop ((n 50)) ; Adjust the number of newlines as needed
    (if (zero? n)
        (newline)
        (begin
          (newline)
          (loop (- n 1))))))


(define (train-network network dataset epochs)
  (define start-time (current-milliseconds))
  (define current-idx 0)
  (define elapsed-times (make-vector 20 #f))
  (define total-time 0)

  
  (define (iter rest-dataset)
      (let* ((input (car (car rest-dataset)))
             (target (cdr (car rest-dataset)))
             (predicted (network 'forward (vector input)))
             (error (mean-squared-error predicted (vector target)))
             (delta (derivative-mean-squared-error predicted (vector target)))
             (current-time (current-milliseconds)))
             
        (network 'backward delta)
        
        (set! total-time (+ total-time (- current-time start-time)))
        (set! start-time current-time)
        (set! current-idx (+ current-idx 1))


        (when (= (modulo current-idx 10) 0)
          (clear-terminal)
          (display current-idx)
          (display "  ")
          (display (milliseconds->minutes-seconds (round (* (/ total-time current-idx) (- 60000 current-idx)))))
          (newline)
          (display "error :")
          (display error)
          (newline))


        (if (null? (cdr rest-dataset))
          network
          (iter (cdr rest-dataset)))))
          
  (iter dataset))