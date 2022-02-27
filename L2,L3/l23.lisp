(defun postorder (l)
  (cond
    ((null l)nil)
    (t(append (postorder (cadr l)) (postorder (caddr l)) (list (car l))))))


(defun frequency (e l)
  (cond
    ((eql l e)1)
    ((atom L)0)
    (t (apply #'+ (mapcar #'(lambda (l)(frequency e l)) l)))))

(defun l3 (e l)
  (> (frequency e l) 0))
