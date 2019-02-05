; queue

(define (head-ptr q) (car q))
(define (tail-ptr q) (cdr q))

(define (head-queue q) (car (car q)))

(define (set-head-ptr! q x) (set-car! q x))
(define (set-tail-ptr! q x) (set-cdr! q x))

(define (empty-queue? q) (null? (head-ptr q)))

(define (delete-queue! q) 
  (begin (set-head-ptr! q (cdr (head-ptr q)))
         (if (null? (head-ptr q))
           (set-tail-ptr! q '()))))

(define (make-queue) (cons '() '()))

(define (insert-queue! q x)
    (let ((new-pair (cons x '())))
        (cond ((empty-queue? q)
                (set-head-ptr! q new-pair)
                (set-tail-ptr! q new-pair)
                q)
              (else (set-cdr! (tail-ptr q) new-pair)
                    (set-tail-ptr! q new-pair)))))



; wire foundations

(define (call-each procs)
  (if (null? procs)
    'done
    (begin
      ((car procs))
      (call-each (cdr procs)))))

(define (make-wire)
  (let ((signal-value 0) (actions '()))
    (define (set-this-signal! new-value)
      (if (not (= signal-value new-value))
        (begin (set! signal-value new-value)
               (call-each actions))
        'done))
    (define (accept-action! proc)
      (set! actions (cons proc actions))
      (proc))
    (lambda (m)
      (cond ((eq? m 'get-signal) signal-value)
            ((eq? m 'set-signal!) set-this-signal!)
            ((eq? m 'add-action!) accept-action!)
            (else (error "unknown operation" m))))))

(define (get-signal wire)
    (wire 'get-signal))

(define (set-signal! wire new-value)
    ((wire 'set-signal!) new-value))

(define (add-action! wire action)
    ((wire 'add-action!) action))


; agenda
(define (after-delay del action)
  (add-to-agenda! (+ del (current-time the-agenda))
                  action
                  the-agenda))

(define (propogate)
  (if (empty-agenda? the-agenda)
    'done
    (let ((first-item (first-agenda-item the-agenda)))
      (first-item)
      (remove-first-agenda-item! the-agenda)
      (propogate))))

(define (probe name wire)
  (add-action! wire
               (lambda ()
                 (display name)
                 (display " ")
                 (display (current-time the-agenda))
                 (display " New-value = ")
                 (display (get-signal wire))
                 (newline))))


(define (make-time-segment time queue)
  (cons time queue)) 

(define (segment-time s) (car s)) 
(define (segment-queue s) (cdr s))

(define (make-agenda) (list 0))
(define (current-time agenda) (car agenda)) 
(define (set-current-time! agenda time)  (set-car! agenda time)) 
(define (segments agenda) (cdr agenda))
 (define (set-segments! agenda segments)  
(set-cdr! agenda segments))

 (define (first-segment agenda) (car (segments agenda))) 
(define (rest-segments agenda) (cdr (segments agenda)))

(define (empty-agenda? agenda)  (null? (segments agenda)))


(define (add-to-agenda! time action agenda)
 (define (belongs-before? segments)
    (or (null? segments)
        (< time (segment-time (car segments)))))

  (define (make-new-time-segment time action)
    (let ((q (make-queue)))
      (insert-queue! q action)
      (make-time-segment time q)))

  (define (add-to-segments! segments)
    (if (= (segment-time (car segments)) time)
      (insert-queue! (segment-queue (car segments))
                     action)
      (let ((rest (cdr segments)))
        (if (belongs-before? rest)
          (set-cdr!
            segments
            (cons (make-new-time-segment time action)
                  (cdr segments)))
          (add-to-segments! rest)))))

 (let ((segments (segments agenda)))
    (if (belongs-before? segments)
      (set-segments!
        agenda
        (cons (make-new-time-segment time action)
              segments))
      (add-to-segments! segments))))

(define (remove-first-agenda-item! agenda)
  (let ((q (segment-queue (first-segment agenda))))
    (delete-queue! q)
    (if (empty-queue? q)
        (set-segments! agenda (rest-segments agenda)))))

(define (first-agenda-item agenda)
  (if (empty-agenda? agenda)
      (error "Agenda is empty -- FIRST-AGENDA-ITEM")
      (let ((first-seg (first-segment agenda)))
        (set-current-time! agenda (segment-time first-seg))
        (head-queue (segment-queue first-seg)))))

