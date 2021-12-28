 ; 1. Write a function to check if an atom is a member of a nonlinear list

; mathematical model
; f1(l e) =
; { 1, if l = e
; { 0, if l is an atom
; { f1(l1 e)+f1(l2 e)+...+f1(ln e), if l = (l1...ln)

(defun f1 (l e)
  (cond
    ((eql l e) 1)
    ((atom l) 0)
    (t (apply #'+ (mapcar #'(lambda (L) (f1 L e)) l)))))

(defun f1main (l e)
  (> (f1 l e) 0))

;2. Write a function that returns the sum of numeric atoms in a list, at any level.
; mathematical model
; f2(l) =
; { l, if l is a numeric atom
; { 0, if l is a non numeric atom
                                        ; { f2(l1)+f2(l2)+...+f2(ln), if l = (l1...ln) is a list

(defun f2 (l)
  (cond
    ((numberp l) l)
    ((atom l) 0)
    (t(apply #'+ (mapcar #'f2 l)))))

; without map functions
; mathematical model
; sum(l1l2...ln) = 
; { 0, if n = 0
; { l1 + sum(l2...ln), if l1 is a numeric atom
; { sum(l2...ln), if l1 is a non numeric atom
; { sum(l1) + sum(l2...ln), if l1 is a list (otherwise)

(defun sum (l)
  (cond
    ((null l) 0)
    ((numberp (car l)) (+ (car l) (sum (cdr l))))
    ((atom (car l)) (sum (cdr l)))
    (t(+(sum (car l)) (sum (cdr l))))))

;3. Define a function to tests the membership of a node in a n-tree represented as (root list_of_nodes_subtree1 ... list_of_nodes_subtreen)
;Eg. tree is (a (b (c)) (d) (E (f))) and the node is "b" => true
; mathematical model
; frequency(e, l) =
; { 1, if e = l
; { 0, if l is an atom
; { frequency(e, l1) + ... + frequency(e, ln), otherwise, l = (l1...ln)

(defun frequency (e l)
  (cond
    ((eql l e)1)
    ((atom L)0)
    (t (apply #'+ (mapcar #'(lambda (l)(frequency e l)) l)))))

(defun f3 (e l)
  (> (frequency e l) 0))

;4. Write a function that returns the product of numeric atoms in a list, at any level.
; mathematical model
; f4(l) = 
; { l, if l is a numeric atom
; { 1, if l is a non numeric atom
; { f4(l1) * f4(l2) * ... * f4(ln), if l = (l1...ln)

(defun f4 (l)
  (cond
    ((numberp l) l)
    ((atom l) 1)
    (t(apply #'* (mapcar #'f4 l)))))

; without map functions
; product(l1l2...ln) = 
; { 1, if n = 0
; { l1 * product(l2...ln), if l1 is a number
; { product(l2...ln), if l1 is a non numeric atom
; { product(l1) * product(l2...ln), otherwise

(defun product (l)
  (cond
    ((null l)1)
    ((numberp (car l)) (* (car l) (product (cdr l))))
    ((atom (car l))(product (cdr l)))
    (t(* (product (car l)) (product (cdr l))))))

;5.  Write a function that computes the sum of even numbers and the decrease the sum of odd numbers, at any level of a list.
; mathematical model
; f5(l) =
; { l, if l is a numeric atom and even
; { -l, if l is a numeric atom and odd
; { 0, if l is a non numeric atom
; { f5(l1)+f5(l2)+...+f5(ln), otherwise, l = (l1l2...ln)

(defun f5 (l)
  (cond
    ((and (numberp l) (= 0 (mod l 2)))l)
    ((and (numberp l) (= 1 (mod l 2)))(* -1 l))
    ((atom l)0)
    (t(apply #'+(mapcar #'f5 l)))))

;6. Write a function that returns the maximum of numeric atoms in a list, at any level.
; mathematical model
; f6(l) = 
; { l, if l is a numeric atom
; { null, if l is a non numeric atom
; { max(f6(l1), ..., f6(ln)), otherwise, l = (l1...ln)

(defun f6 (l)
  (cond
    ((numberp l)l)
    ((atom l) most-negative-fixnum)
    (t(apply #'max (mapcar #'f6 l)))))

;without map functions
;f6max(l1l2...ln) =
; { most-negative-fixnum, if l = 0
; { max(l1, f6max(l2...ln)), if l is a numeric atom
; { f6max(l2...ln), if l is a non numeric atom
; { max(f6max(l1), f6max(l2...ln)), otherwise

(defun f6max (l)
  (cond
    ((null l)most-negative-fixnum)
    ((numberp (car l))(max (car l) (f6max (cdr l))))
    ((atom (car l))(f6max (cdr l)))
    (t(max (f6max (car l)) (f6max (cdr l))))))

;7.Write a function that substitutes an element E with all elements of a list L1 at all levels of a given list L.
; mathematical model
; f7(l e l1) =
; { l1, if e = l
; { l, if l is an atom and e!=l
; { f7(L1 e l1) U f7(L2 e l1) U ... U f7(Ln e l1), otherwise, l = (L1...Ln)

(defun f7 (l e l1)
  (cond
    ((eql e l) l1)
    ((atom l) l)
    (t(mapcar #'(lambda (L)(f7 L e l1)) l) )))

;8.Write a function to determine the number of nodes on the level k from a n-tree represented as follows: (root list_nodes_subtree1 ... list_nodes_subtreen)
;Eg: tree is (a (b (c)) (d) (e (f))) and k=2 => 3 nodes - 1st level is 1
; mathematical model
; f8(l, level) = 
; { 1, if l is an atom, level = 0
; { 0, if l is an atom
; { 0, if level = 0
                                        ; { f8(l1, level) + ... + f8(ln, level), otherwise
(defun f8 (l n)
  (cond
    ((and (eql n 1) (atom l)) 1)
    ((listp l)(apply #'+ (mapcar #'(lambda (l) (f8 l (- n 1))) l)))
    (t 0)))


(defun f82 (l n)
  (cond
    ((and (eql n 0)(atom l))(list l))
    ((listp l)(mapcan #'(lambda (l)(f82 l (- n 1))) l))
    (t nil)
    ))

;9.Write a function that removes all occurrences of an atom from any
; level of a list.
; mathematical model
; f9(l, e) =
; { null, if e = l
; { {l}, if l is an atom, e != l
                                        ; { f9(l1, e) U ... U f9(ln, e), otherwise, l = (l1...ln)

(defun f9 (l e)
  (cond
    ((eql l e) nil)
    ((atom l) (list l))
    (t(list (mapcan #'(lambda (l)(f9 l e))

;10. Define a function that replaces one node with another one in a n-tree represented as: root list_of_nodes_subtree1... list_of_nodes_subtreen)
;Eg: tree is (a (b (c)) (d) (e (f))) and node 'b' will be replace with node 'g' => tree (a (g (c)) (d) (e (f)))}
; mathematical model
; f10(l, node, newnode) =
; { newnode, if l = node
; { l, if l is an atom, l!=node
; { f10(l1, node, newnode) U ... U f10(ln, node, newnode), otherwise, l = (l1...ln)

(defun f10 (l node newnode)
  (cond
    ((eql node l) (list newnode))
    ((atom l) (list l))
    (t(list (mapcan #'(lambda (l)(f10 l node newnode))l) ))
    ))

; 11. Write a function to determine the depth of a list
(defun f11 (l)
  (cond
    ((null (cdr l))1)
    (t(+ 1 (apply #'max (mapcar #'f11 (cdr l)))))))

;14. Write a function that returns the number of atoms in a list, at any level.
; mathematical model
; f14(l) =
; { 1, if l is an atom
                                        ; { f14(l1) + f14(l2) + ... + f14(ln), otherwise, l = (l1...ln)

(defun f14 (l)
  (cond
    ((atom l)1)
    (t(apply #'+(mapcar #'f14 l))))))

           
