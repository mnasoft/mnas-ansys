;;;; ./src/cfx/pre/web/methods/render.lisp

(in-package #:mnas-ansys/cfx/pre/web)

(defmethod reblocks/widget:render ((widget hw-page))
  (reblocks/html:with-html ()
    (:div ;; :style "display: flex; flex-direction: column;"  gap: 0.25rem
     (:h1 "Hello World!")
     (:p "Приветствую Вас друзья на mnas-ansys/cfx/pre/web")
     (:p (:a :href "/apps/gosts/" "gosts")))))

(defmethod reblocks/widget:render ((widget simulation-page))
  (reblocks/html:with-html ()
    (:div ;; :style "display: flex; flex-direction: column;"  gap: 0.25rem
     (:h1 "Simulation")
     (:p "Приветствую Вас друзья на simulation")
     (:p (:a :href "/apps1/simulation/meshes/" "Meshes"))
     (:p (:a :href "/apps1/simulation/3d-regions/" "3D-Regions"))
     (:p (:a :href "/apps1/simulation/commands/" "Commands"))     
     #+nil (:p (:pre (format nil "~A" mnas-ansys/cfx/pre::*simulation*))))))

(defmethod reblocks/widget:render ((widget simulation-meshes-page))
  (let ((simulation mnas-ansys/cfx/pre::*simulation*))
    (reblocks/html:with-html ()
      (:div ;; :style "display: flex; flex-direction: column;"  gap: 0.25rem
       (:h1 "Meshes")
       (:p "Приветствую Вас друзья на meshes")
       (:table
        (:tr
         (:th "Name")
         (:th "tin-file")
         (:th "msh-file"))
        (loop :for msh :in (mnas-ansys/cfx/pre:ht-keys-sort
                            (mnas-ansys/cfx/pre:<simulation>-meshes
                             simulation))
              :do
                 (:tr
                  (:td msh)
                  (:td (namestring
                        (mnas-ansys/cfx/pre:<mesh>-tin-pathname
                         (mnas-ansys/cfx/pre:mesh msh simulation))))
                  (:td (namestring
                        (mnas-ansys/cfx/pre:<mesh>-msh-pathname
                         (mnas-ansys/cfx/pre:mesh msh simulation)))))))
       
       (:p
        (:pre (format nil "~A" simulation)))
       ))))

(defmethod reblocks/widget:render ((widget <mesh-item>))
  (let ((mesh (<mesh-id>-mesh
               (<mesh-item>-mesh widget))))
    (reblocks/html:with-html ()
      (:tr (:td (mnas-ansys/cfx/pre:<mesh>-name mesh))
           (:td (namestring (mnas-ansys/cfx/pre:<mesh>-tin-pathname mesh)))
           (:td (namestring (mnas-ansys/cfx/pre:<mesh>-msh-pathname mesh)))))))

(defmethod reblocks/widget:render ((widget <mesh-page>))
  (let ((mesh (<mesh-id>-mesh
               (<mesh-page>-mesh widget))))
    (reblocks/html:with-html ()
      (:h2 "MESH:")
      (:table
       (:tr (:td "Name:") (:td (mnas-ansys/cfx/pre:<mesh>-name mesh)))
       (:tr (:td "Instances:") (:td (mnas-ansys/cfx/pre:<mesh>-3d-region-instance-number mesh)))
       (:tr (:td "Tin-Pathname:") (:td (namestring (mnas-ansys/cfx/pre:<mesh>-tin-pathname mesh))))
       (:tr (:td "Msh-Pathname:") (:td (namestring (mnas-ansys/cfx/pre:<mesh>-msh-pathname mesh)))))
      (:h2 "2D-Regions:")
      (:table
       (:tr (:th "Keys") (:th "Values"))
       (loop :for 2d-region :in
                            (mnas-ansys/cfx/pre:ht-keys-sort
                             (mnas-ansys/cfx/pre:<mesh>-2d-regions mesh))
             :do
                (:tr
                 (:td 2d-region)
                 (:td (mnas-ansys/cfx/pre:2d-region 2d-region mesh))))))))

(:p "Mesh:" (mnas-ansys/cfx/pre:<mesh>-2d-regions mesh))

(loop :for 2d-region :in
                     (mnas-ansys/cfx/pre:<mesh>
                      (mnas-ansys/cfx/pre:<mesh>-2d-regions *mesh-g1*))
:collect (mnas-ansys/cfx/pre:2d-region
          2d-region
          *mesh-g1*
          ))

          (mnas-ansys/cfx/pre:<mesh>-2d-regions *mesh-g1*)

