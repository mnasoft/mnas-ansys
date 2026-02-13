;;;; ./src/mesh/msh/parse.lisp

(in-package :mnas-ansys/mesh-msh)

(defclass <msh-group> ()
  ((name
    :accessor msh-group-name
    :initarg :name
    :initform ""
    :documentation "Group name as stored in the .msh file")
   (count
    :accessor msh-group-count
    :initarg :count
    :initform 0
    :documentation "Number of items in the group")
   (kind
    :accessor msh-group-kind
    :initarg :kind
    :initform :faces
    :documentation "Group kind: :elements or :faces")
   (items
    :accessor msh-group-items
    :initarg :items
    :initform nil
    :documentation "Group items: element ids or (element face) pairs"))
  (:documentation "Group definition inside an ICEM .msh file"))

(defclass <msh-mesh> ()
  ((magic
    :accessor msh-mesh-magic
    :initarg :magic
    :initform 0
    :documentation "Magic number from the first line")
   (version
    :accessor msh-mesh-version
    :initarg :version
    :initform ""
    :documentation "Version line")
   (header
    :accessor msh-mesh-header
    :initarg :header
    :initform nil
    :documentation "Numeric header line (list of integers)")
   (node-count
    :accessor msh-mesh-node-count
    :initarg :node-count
    :initform 0
    :documentation "Number of nodes")
   (element-count
    :accessor msh-mesh-element-count
    :initarg :element-count
    :initform 0
    :documentation "Number of tetra elements")
   (nodes
    :accessor msh-mesh-nodes
    :initarg :nodes
    :initform nil
    :documentation "Vector of node coordinates, each is a list (x y z)")
   (elements
    :accessor msh-mesh-elements
    :initarg :elements
    :initform nil
    :documentation "Vector of tetra connectivity, each is a list of 4 node ids")
   (groups
    :accessor msh-mesh-groups
    :initarg :groups
    :initform nil
    :documentation "List of group objects"))
  (:documentation "Parsed ICEM CFD .msh mesh"))

(defun parse-number-list (line)
  "Parse all numbers from LINE and return a list."
  (with-input-from-string (stream line)
    (loop for obj = (read stream nil :eof)
          until (eq obj :eof)
          when (numberp obj)
          collect obj)))

(defun parse-group-header (line)
  "Parse group header line into COUNT and NAME, or return NIL." 
  (let* ((trim (string-trim '(#\Space #\Tab) line)))
    (when (> (length trim) 0)
      (multiple-value-bind (count pos)
          (parse-integer trim :junk-allowed t)
        (when count
          (let ((rest (string-trim '(#\Space #\Tab) (subseq trim pos))))
            (when (> (length rest) 0)
              (values count rest))))))))

(defun header-line-p (line)
  "Return T when LINE looks like a group header." 
  (some #'alpha-char-p line))

(defun read-numbers (stream count)
  "Read COUNT numbers from STREAM, spanning multiple lines if needed." 
  (let ((numbers (make-array count))
        (idx 0))
    (loop while (< idx count)
          for line = (read-line stream nil nil)
          while line
          do (dolist (num (parse-number-list line))
               (when (< idx count)
                 (setf (aref numbers idx) num)
                 (incf idx))))
    (when (< idx count)
      (error "Unexpected end of file while reading ~a numbers" count))
    numbers))

(defun read-pairs (stream count)
  "Read COUNT pairs from STREAM, spanning multiple lines if needed." 
  (let ((pairs (make-array count))
        (idx 0)
        (pending nil)
        (has-pending nil))
    (loop while (< idx count)
          for line = (read-line stream nil nil)
          while line
          do (dolist (num (parse-number-list line))
               (if has-pending
                   (progn
                     (setf (aref pairs idx) (list pending num))
                     (incf idx)
                     (setf has-pending nil
                           pending nil))
                   (progn
                     (setf pending num)
                     (setf has-pending t)))))
    (when has-pending
      (error "Odd number of integers while reading pairs"))
    (when (< idx count)
      (error "Unexpected end of file while reading ~a pairs" count))
    pairs))

(defun read-group-items (stream count)
  "Read group items and infer kind by layout.

Returns three values: KIND, ITEMS, PENDING-LINE.
KIND is :elements or :faces. PENDING-LINE is a header line that was read
ahead and should be processed by the caller.
"
  (let ((numbers nil)
        (pending-line nil))
    (loop for line = (read-line stream nil nil)
          while line
          do (if (header-line-p line)
                 (progn
                   (setf pending-line line)
                   (return))
                 (setf numbers (nconc numbers (parse-number-list line))))
          when (>= (length numbers) (* 2 count)) do (return))
    (when (< (length numbers) count)
      (error "Unexpected end of file while reading ~a group items" count))
    (let* ((numvec (coerce numbers 'vector))
           (len (length numvec)))
      (cond
        ((>= len (* 2 count))
         (when (> len (* 2 count))
           (error "Too many numbers for faces group: ~a > ~a" len (* 2 count)))
         (let ((pairs (make-array count)))
           (dotimes (i count)
             (let ((a (aref numvec (* 2 i)))
                   (b (aref numvec (1+ (* 2 i)))))
               (setf (aref pairs i) (list a b))))
           (values :faces pairs pending-line)))
        ((= len count)
         (values :elements numvec pending-line))
        (t
         (error "Ambiguous group data length: ~a numbers for count ~a"
                len count))))))

(defun parse-msh-file (pathname)
  "Parse an ICEM CFD .msh file and return a <msh-mesh> object.

Supported layout for this dataset:
- Line 1: magic integer
- Line 2: version line
- Line 3: numeric header, first two numbers are node and element counts
- Node coordinates: node-count lines with 3 floats
- Tetra elements: element-count lines with 4 node ids
- Groups: repeating blocks of 'count name' followed by element ids or
  (element face) pairs.
"
  (when (probe-file pathname)
    (with-open-file (stream pathname :direction :input)
      (let* ((magic (parse-integer (read-line stream)))
             (version (read-line stream))
             (header (parse-number-list (read-line stream)))
             (node-count (if header (first header) 0))
             (element-count (if (and header (second header)) (second header) 0))
             (nodes (make-array node-count))
             (elements (make-array element-count))
             (groups nil))
        ;; Nodes
        (dotimes (i node-count)
          (let ((nums (parse-number-list (read-line stream))))
            (when (/= (length nums) 3)
              (error "Node ~a does not have 3 coordinates" (1+ i)))
            (setf (aref nodes i) nums)))
        ;; Elements
        (dotimes (i element-count)
          (let ((nums (parse-number-list (read-line stream))))
            (when (/= (length nums) 4)
              (error "Element ~a does not have 4 node ids" (1+ i)))
            (setf (aref elements i) nums)))
        ;; Groups until EOF
        (let ((pending-line nil))
          (labels ((next-line ()
                     (if pending-line
                         (prog1 pending-line (setf pending-line nil))
                         (read-line stream nil nil)))
                   (push-line (line)
                     (setf pending-line line)))
            (loop for line = (next-line)
                  while line
                  do (multiple-value-bind (count name)
                         (parse-group-header line)
                       (when name
                         (multiple-value-bind (kind items pending)
                             (read-group-items stream count)
                           (when pending
                             (push-line pending))
                           (push (make-instance '<msh-group>
                                                :name name
                                                :count count
                                                :kind kind
                                                :items items)
                                 groups)))))))
        (make-instance '<msh-mesh>
                       :magic magic
                       :version version
                       :header header
                       :node-count node-count
                       :element-count element-count
                       :nodes nodes
                       :elements elements
                       :groups (nreverse groups))))))

(defun vec-sub (a b)
  (list (- (first a) (first b))
        (- (second a) (second b))
        (- (third a) (third b))))

(defun vec-cross (a b)
  (list (- (* (second a) (third b)) (* (third a) (second b)))
        (- (* (third a) (first b)) (* (first a) (third b)))
        (- (* (first a) (second b)) (* (second a) (first b)))))

(defun vec-dot (a b)
  (+ (* (first a) (first b))
     (* (second a) (second b))
     (* (third a) (third b))))

(defun vec-norm (a)
  (sqrt (vec-dot a a)))

(defun triangle-area (p1 p2 p3)
  (* 0.5d0 (vec-norm (vec-cross (vec-sub p2 p1) (vec-sub p3 p1)))))

(defun tetra-volume (p1 p2 p3 p4)
  (abs (/ (vec-dot (vec-sub p1 p4)
                   (vec-cross (vec-sub p2 p4) (vec-sub p3 p4)))
          6.0d0)))

(defun mesh-node (mesh node-id)
  (aref (msh-mesh-nodes mesh) (1- node-id)))

(defun mesh-element (mesh element-id)
  (aref (msh-mesh-elements mesh) (1- element-id)))

(defun tetra-face-node-ids (element face-id)
  (destructuring-bind (n1 n2 n3 n4) element
    (case face-id
      (1 (list n2 n3 n4))
      (2 (list n1 n4 n3))
      (3 (list n1 n2 n4))
      (4 (list n1 n3 n2))
      (t (error "Unknown face id: ~a" face-id)))))

(defun msh-element-volume (mesh element-id)
  (destructuring-bind (n1 n2 n3 n4) (mesh-element mesh element-id)
    (tetra-volume (mesh-node mesh n1)
                  (mesh-node mesh n2)
                  (mesh-node mesh n3)
                  (mesh-node mesh n4))))

(defun msh-element-face-area (mesh element-id face-id)
  (let* ((element (mesh-element mesh element-id))
         (face-nodes (tetra-face-node-ids element face-id))
         (p1 (mesh-node mesh (first face-nodes)))
         (p2 (mesh-node mesh (second face-nodes)))
         (p3 (mesh-node mesh (third face-nodes))))
    (triangle-area p1 p2 p3)))

(defun msh-group-volume (mesh group)
  (unless (eq (msh-group-kind group) :elements)
    (error "Group ~a is not an elements group" (msh-group-name group)))
  (let ((sum 0.0d0))
    (dotimes (i (msh-group-count group) sum)
      (incf sum (msh-element-volume mesh (aref (msh-group-items group) i))))))

(defun msh-group-area (mesh group)
  (unless (eq (msh-group-kind group) :faces)
    (error "Group ~a is not a faces group" (msh-group-name group)))
  (let ((sum 0.0d0))
    (dotimes (i (msh-group-count group) sum)
      (destructuring-bind (element-id face-id)
          (aref (msh-group-items group) i)
        (incf sum (msh-element-face-area mesh element-id face-id))))))

(defun msh-mesh-total-volume (mesh)
  (let ((sum 0.0d0)
        (count (msh-mesh-element-count mesh)))
    (dotimes (i count sum)
      (incf sum (msh-element-volume mesh (1+ i))))))

(defun msh-mesh-surface-areas (mesh)
  (loop for group in (msh-mesh-groups mesh)
        when (eq (msh-group-kind group) :faces)
        collect (cons (msh-group-name group)
                      (msh-group-area mesh group))))

(defun msh-mesh-total-surface-area (mesh)
  (let ((sum 0.0d0))
    (dolist (pair (msh-mesh-surface-areas mesh) sum)
      (incf sum (cdr pair)))))
