(#%require (only racket arithmetic-shift read-bytes read-byte error))

(define (ash x n)
  (arithmetic-shift x n))

(define (read-mnist-image-file filename)
  (with-input-from-file filename
    (lambda ()
      (let ((magic-number (read-big-endian-integer))
            (num-images (read-big-endian-integer))
            (num-rows (read-big-endian-integer))
            (num-cols (read-big-endian-integer)))
        (let loop ((images '()) (count 0))
          (if (= count num-images)
              (reverse images)
              (loop (cons (normalize-image (read-image (* num-rows num-cols))) images) (+ count 1))))))))

(define (normalize-image image)
  (map (lambda (x) (/ x 255.0)) image))

(define (read-image total-pixels)
  (define pixels '())  ; Initialize an empty list to store pixels
  (let loop ((index 0))
    (if (= index total-pixels)
        (reverse pixels)  ; Reverse the list to maintain the correct order
        (begin
          (set! pixels (cons (read-pixel) pixels))  ; Add the read pixel to the list
          (loop (+ index 1))))))


(define (read-pixel)
  (let ((pixel (read-byte)))
    (if (not (eof-object? pixel))
        pixel
        (error "Unexpected end of file"))))

(define (read-mnist-label-file filename)
  (with-input-from-file filename
    (lambda ()
      (let ((magic-number (read-big-endian-integer))
            (num-labels (read-big-endian-integer)))
        (let loop ((labels '()) (count 0))
          (if (= count num-labels)
              (reverse labels)
              (loop (cons (read-byte) labels) (+ count 1))))))))


(define (read-big-endian-integer)
  (let ((b1 (read-byte))
        (b2 (read-byte))
        (b3 (read-byte))
        (b4 (read-byte)))
    (+ (ash b1 24) (ash b2 16) (ash b3 8) b4)))

(define (one-hot-encode num total-nums)
  (define vec (make-vector total-nums 0))
  (vector-set! vec num 1)
  vec)

(define (save-data dataset filename)
  (with-output-to-file filename
    #:exists 'truncate  ; Overwrite the file if it already exists
    (lambda ()
      (write dataset))))


;; Loading dataset from a file
(define (load-data filename)
  (with-input-from-file filename
    (lambda ()
      (read))))






