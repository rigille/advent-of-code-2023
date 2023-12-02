#!chezscheme
(library (day01 solution)
  (export sum-calibrations sum-written-out-calibrations)
  (import (chezscheme))
  (define (digit? c)
    (and (char<=? #\0 c) (char<=? c #\9)))

  (define (first-digit input)
    (do ((i 0 (+ i 1)))
        ((digit? (string-ref input i)) (char- (string-ref input i) #\0))))

  (define (last-digit input)
    (do ((i (- (string-length input) 1) (- i 1)))
        ((digit? (string-ref input i)) (char- (string-ref input i) #\0))))

  (define (sum-calibrations file-name)
    (let ((file (open-input-file file-name)))
      (do ((sum 0)
           (line (get-line file) (get-line file)))
          ((eq? line #!eof) (close-input-port file) sum)
        (set! sum (+ sum (* 10 (first-digit line)) (last-digit line))))))

  (define (substring? text text-index entry entry-index)
      (let ((text-end (>= text-index (string-length text)))
            (entry-end (>= entry-index (string-length entry))))
        (cond
          (entry-end
            #t)
          (text-end
            #f)
          ((eq? (string-ref text text-index) (string-ref entry entry-index))
           (substring? text (+ text-index 1) entry (+ entry-index 1)))
          (else
            #f))))

  (define digits
    '(("zero" 0)
      ("one" 1)
      ("two" 2)
      ("three" 3)
      ("four" 4)
      ("five" 5)
      ("six" 6)
      ("seven" 7)
      ("eight" 8)
      ("nine" 9)
      ("0" 0)
      ("1" 1)
      ("2" 2)
      ("3" 3)
      ("4" 4)
      ("5" 5)
      ("6" 6)
      ("7" 7)
      ("8" 8)
      ("9" 9)))

  (define (written-out line index)
      (let* ((written-out-test (lambda (entry) (substring? line index (car entry) 0)))
            (maybe-found (find written-out-test digits)))
        (if maybe-found (car (cdr maybe-found)) maybe-found)))

  (define (first-written-out line)
    (letrec ((loop (lambda (i)
                     (let ((maybe-found (written-out line i)))
                       (if maybe-found
                         maybe-found
                         (loop (+ i 1)))))))
      (loop 0)))

  (define (last-written-out line)
    (letrec ((loop (lambda (i)
                     (let ((maybe-found (written-out line i)))
                       (if maybe-found
                         maybe-found
                         (loop (- i 1)))))))
      (loop (- (string-length line) 1))))

  (define (sum-written-out-calibrations file-name)
    (let ((file (open-input-file file-name)))
      (do ((sum 0)
           (line (get-line file) (get-line file)))
          ((eq? line #!eof) (close-input-port file) sum)
        (set! sum (+ sum (* 10 (first-written-out line)) (last-written-out line)))))))
