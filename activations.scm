(define (ReLU)
  (lambda (zi) (max 0 zi)))

(define (derReLU)
  (lambda (zi) (if (< zi 0) 0 1)))

(define (LeakyRelu)
  (let ((a 0.01))
    (lambda (zi) (if (< zi 0) (* a zi) zi))))

(define (derLeakyRelu)
  (let ((a 0.01))
    (lambda (zi) (if (< zi 0) a 1))))

(define (Elu)
  (let ((alpha 1))
    (lambda (zi) (if (> zi 0) zi (* alpha (- (exp zi) 1))))))

(define (derElu)
  (let ((alpha 1))
    (lambda (zi) (if (> zi 0) 1 (* alpha (exp zi))))))

(define (Sigmoid)
  (lambda (zi) (/ 1 (+ 1 (exp (- zi))))))

(define (derSigmoid)
  (lambda (zi) (* ((sigmoid) zi) (- 1 ((sigmoid) zi)))))


(define-class (Activation activation-function activation-function-derivative)
  (activation-function! (lambda (new-val) (set! activation-function new-val)))
  (activation-function-derivative! (lambda (new-val) (set! activation-function-derivative new-val))))

(define (make-activation activation-function activation-function-derivative)
  (let ((activation (Activation)))
    (activation 'activation-function! (activation-function))
    (activation 'activation-function-derivative! (activation-function-derivative))
    activation))

;# Softplus
;def SoftPlus(z):
;    return np.log(1 + np.exp(z))
;
;def derSoftplus(z):
;    return 1 / (1 + np.exp(-z))
;
;# TanH
;def TanH(z):
;    return np.tanh(z)
;
;def derTanH(z):
;    return 1 - np.tanh(z)**2
;
;# Arctan
;def Arctan(x):
;    return np.arctan(x)
;
;def derArctan(x):
;    return 1 / (1 + x**2)


    



