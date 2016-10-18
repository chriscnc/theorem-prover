#lang racket
(require rackunit)

; returns nil for non-empty lists
(define (atom x)
  (not (cons? x)))

; (dethm atom/cons (x y))
; (equal (atom (cons x y)) 'nil)
; perform bi-directional substitution
(define (atom/cons focus x y)
  (if (equal? 'nil focus)
    `(atom (cons ,x ,y))
    (if (and (equal? (car focus) 'atom)
	     (equal? (caadr focus) 'cons)
	     (equal? (second (cadr focus)) x)
	     (equal? (third (cadr focus)) y))
      'nil
      (error 'atom/cons "no match for x y in focus"))))


; atom/cons tests
(check-equal? 'nil (atom/cons '(atom (cons 1 (2 3))) 1 '(2 3)))
(check-equal? '(atom (cons 1 (2 3))) (atom/cons 'nil 1 '(2 3)))
(check-exn exn:fail? (lambda () (atom/cons '(atom (cons 1 (2 3))) 0 '(1 2))))
(check-exn exn:fail? (lambda () (atom/cons 'invalid-focus 0 '(1 2))))

