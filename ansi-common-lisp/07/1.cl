
(defun file-lines (file)
  (let ((ls nil))
    (with-open-file (in file :direction :input)
      (do ((line (read-line in nil 'eof)
                 (read-line in nil 'eof)))
        ((eql line 'eof))
        (setf ls (cons line ls))))
    (reverse ls)))

