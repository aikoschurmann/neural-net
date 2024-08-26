(define (train-network network dataset epochs)
  (define start-time (current-milliseconds))
  (define current-idx 0)
  (define elapsed-times (make-vector 20 #f))
  (define total-time 0)
  (define total-delta)
  
  (define (iter rest-dataset)
      (let* ((input (car (car dataset)))
             (target (cdr (car dataset)))
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
          (newline))


        (if (null? dataset)
          network
          (iter rest-dataset))))
          
  (iter dataset))