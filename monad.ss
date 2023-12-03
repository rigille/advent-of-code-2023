(import (day01 solution))

(define-record-type monad (fields bind pure))

(define-record-type parser-success (fields value cursor))

(define (bind parser next)
  (lambda (text cursor)
    (let ((reply (parser text cursor)))
      (if (parser-success? reply)
          ((next (parser-success-value reply)) text (parser-success-cursor reply))
          #f))))

(define (pure value)
  (lambda (text cursor)
    (make-parser-success value cursor)))

(define parser (make-monad bind pure))

(define (literal entry)
    (lambda (text cursor)
      (if (substring? text cursor entry 0)
          (make-parser-success #t (+ cursor (string-length entry)))
          #f)))

(define digit
    (lambda (text cursor)
      (if (and (< cursor (string-length text)) (digit? (string-ref text cursor)))
          (make-parser-success
            (char- (string-ref text cursor) #\0)
            (+ cursor 1))
          #f)))

(define (run parser text)
  (let ((reply (parser text 0)))
    (if (parser-success? reply)
      (parser-success-value (parser text 0))
      #f)))

(define (many parser)
  (lambda (text cursor)
    (let ((reply (parser text cursor)))
      (if (parser-success? reply)
          (let ((tail ((many parser) text (parser-success-cursor reply))))
            (make-parser-success
              (cons (parser-success-value reply) (parser-success-value tail))
              (parser-success-cursor tail)))
          (make-parser-success (list) cursor)))))

(define-syntax let-bind*
  (syntax-rules ()
    ((_ m () b1 b2 ...)
     ((monad-pure m) (begin b1 b2 ...)))
    ((_ m ((i1 e1) (i2 e2) ...) b1 b2 ...)
     ((monad-bind m) e1 (lambda (i1)
       (let-bind* m ([i2 e2] ...) b1 b2 ...))))))
