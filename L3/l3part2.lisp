(defun f15 (l)
  (cond
    ((atom l) (list l))
    (t (mapcan #'f15 (reverse l)))))

(defun f16 (l)
  (cond
    ((atom l)(list l))
    (t(mapcan #'f16 l))))
