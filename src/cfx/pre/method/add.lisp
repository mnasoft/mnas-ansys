;;;; ./src/cfx/pre/method/add.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod add ((3d-region <3d-region>) (simulation <simulation>))
  "Добавляем домен в симуляцию"
  (setf (<3d-region>-3d-suffix 3d-region)
        (incf (<mesh>-3d-region-instance-number (<3d-region>-mesh 3d-region))))
  (setf (gethash (name 3d-region)
                 (<simulation>-3d-regions simulation))
        3d-region)
  (setf (<3d-region>-2d-suffix 3d-region)
        (hash-table-count (<simulation>-3d-regions simulation)))
  simulation)

(defmethod name ((3d-region <3d-region>))
  (let ((mesh-name (<mesh>-name (<3d-region>-mesh 3d-region))))
    (format nil "D~A ~A ~A" mesh-name mesh-name (<3d-region>-3d-suffix 3d-region))
    #+nil
    (concatenate 'string "D" mesh-name " " mesh-name)
    ))

(defmethod add ((mesh <mesh>) (simulation <simulation>))
  "Добавляем сетку к сиуляции."
  (setf (gethash (<mesh>-name mesh)
                 (<simulation>-meshes simulation))
        mesh)
  simulation)

(defmethod insert ((mesh-name string) (simulation <simulation>))
  "@b(Описание:) метод @b(insert) добавляет в симуляцию @(simulation)
домен по имени 3d-сетки ICEM."
  (let ((d-name (next-domain-name mesh-name simulation)))
    (when d-name
      (let ((domain (make-instance '<3d-region> :name d-name :parent simulation)))
        (loop :for sur :in (alexandria:hash-table-keys
                            (<mesh>-2d-regions
                             (gethash mesh-name
                                      (<meshes>-meshes simulation))))
              :do
                 (let ((cfx-sur (next-surface-name sur simulation)))
                   (unless (gethash cfx-sur (<simulation>-surfaces simulation))
                     (setf (gethash sur (<3d-region>-surfaсes domain)) ;; добавляем поверхность в домен
                           cfx-sur) 
                     (setf (gethash cfx-sur (<simulation>-surfaces simulation)) ;; добавляем поверхность в перечень поверхностей
                           cfx-sur)))) ;; loop
        (add domain simulation)
        simulation ;; возвращаем симуляцию
        ))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod copy ((domain-name string) (simulation <simulation>))
  (let ((d-name-next (next-domain-name
                      (domain-name->mesh-name domain-name)
                      simulation)))
    (when d-name-next
      (let ((domain (make-instance '<3d-region> :name d-name-next)))
        (loop :for sur :in (simulation-doman-surfaces domain-name simulation)
              :do
                 (let ((cfx-sur (next-surface-name sur simulation)))
                   (unless (gethash cfx-sur (<simulation>-surfaces simulation))
                     (setf (gethash sur (<3d-region>-surfaсes domain)) ;; добавляем поверхность в домен
                           cfx-sur)
                     (setf ;; добавляем поверхность в перечень поверхностей
                      (gethash cfx-sur (<simulation>-surfaces simulation)) 
                           cfx-sur))))
        (add domain simulation)))
    simulation))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun next-suffix (domain-suffix simulation-suffixes)
  (cond
    ((and (string= domain-suffix "")
          (equalp '("") simulation-suffixes))
     "2")
    ((and (string= domain-suffix "")
          (equalp '("" "2") simulation-suffixes))
     "3")
    ((and (string= domain-suffix "2")
          (equalp '("" "3" "2") simulation-suffixes))
     "3")
    ((and (string= domain-suffix "2")
          (equalp '("" "2") simulation-suffixes))
     "3")
    (t
     (break "~S ~S" domain-suffix simulation-suffixes
            ))))

(defun next-surface-by-suffix (name domain-suffix simulation-suffixes)
  (concatenate 'string name " " (next-suffix domain-suffix simulation-suffixes)))

(defmethod insert-to-domain-copy ((surface-key string)
                                  (domain <3d-region>)
                                  (domain-copy <3d-region>))
  (let* ((simulation  (<3d-region>-parent domain))
        (surface-value (next-surface-by-suffix (name-icem->cfx surface-key)
                          (suffix surface-key domain)
                          (suffix surface-key simulation))))
    ;; добавляем поверхность в домен
    (setf (gethash surface-key (<3d-region>-surfaсes domain-copy)) surface-value)
    ;; добавляем поверхность в перечень поверхностей
    (setf (gethash surface-value (<simulation>-surfaces simulation)) surface-value)
    domain-copy))

(defmethod copy ((domain-name string) (simulation <simulation>))
  (let* ((domain ;; Копируемый домен
           (domain domain-name simulation))
         (domain-copy ;; Новый домен
           (make-instance '<3d-region>
                          :name (next-domain-name
                                 (domain-name->mesh-name domain-name)
                                 simulation)
                          :parent (<3d-region>-parent domain))))
    (loop :for sur-key :in (surface-keys domain)
          :do
             (insert-to-domain-copy sur-key domain domain-copy))
    (add domain-copy simulation)))
