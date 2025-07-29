;;;; ./src/cfx/pre/method/add.lisp

(in-package :mnas-ansys/cfx/pre)




(defmethod add ((domain <domain>) (simulation <simulation>))
  "Добавляем домен в симуляцию"
  (setf (gethash (<domain>-name domain) 
                 (<simulation>-domains simulation))
        domain)
  simulation)

(defmethod add ((mesh <mesh>) (meshes <meshes>))
    "Добавляем сетку к коллекции сеток."
  (setf (gethash
         (<mesh>-name mesh)
         (<meshes>-meshes meshes))
        mesh)
  meshes)

(defmethod insert ((mesh-name string) (simulation <simulation>))
  "@b(Описание:) метод @b(insert) добавляет в симуляцию @(simulation)
домен по имени 3d-сетки ICEM."
  (let ((d-name (next-domain-name mesh-name simulation)))
    (when d-name
      (let ((domain (make-instance '<domain> :name d-name :parent simulation)))
        (loop :for sur :in (alexandria:hash-table-keys
                            (<mesh>-surfaces
                             (gethash mesh-name
                                      (<meshes>-meshes simulation))))
              :do
                 (let ((cfx-sur (next-surface-name sur simulation)))
                   (unless (gethash cfx-sur (<simulation>-surfaces simulation))
                     (setf (gethash sur (<domain>-surfaсes domain)) ;; добавляем поверхность в домен
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
      (let ((domain (make-instance '<domain> :name d-name-next)))
        (loop :for sur :in (simulation-doman-surfaces domain-name simulation)
              :do
                 (let ((cfx-sur (next-surface-name sur simulation)))
                   (unless (gethash cfx-sur (<simulation>-surfaces simulation))
                     (setf (gethash sur (<domain>-surfaсes domain)) ;; добавляем поверхность в домен
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
                                  (domain <domain>)
                                  (domain-copy <domain>))
  (let* ((simulation  (<domain>-parent domain))
        (surface-value (next-surface-by-suffix (name-icem->cfx surface-key)
                          (suffix surface-key domain)
                          (suffix surface-key simulation))))
    ;; добавляем поверхность в домен
    (setf (gethash surface-key (<domain>-surfaсes domain-copy)) surface-value)
    ;; добавляем поверхность в перечень поверхностей
    (setf (gethash surface-value (<simulation>-surfaces simulation)) surface-value)
    domain-copy))

(defmethod copy ((domain-name string) (simulation <simulation>))
  (let* ((domain ;; Копируемый домен
           (domain domain-name simulation))
         (domain-copy ;; Новый домен
           (make-instance '<domain>
                          :name (next-domain-name
                                 (domain-name->mesh-name domain-name)
                                 simulation)
                          :parent (<domain>-parent domain))))
    (loop :for sur-key :in (surface-keys domain)
          :do
             (insert-to-domain-copy sur-key domain domain-copy))
    (add domain-copy simulation)))
