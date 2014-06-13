(in-package :peer-cnnctd)
(declaim (optimize (debug 3) (safety 3) (speed 0)))

;;;;;;;;;;;;
;;;; support

(defmacro remove-from-list (item location &key (test 'eql))
  "removes item item from location"
  `(setf ,location (remove ,item ,location :test ,test)))

(defun req-port ()
  "returns the port of the current request"
  (hunchentoot:local-port hunchentoot:*request*))

;; we're devving here
(setf hunchentoot:*catch-errors-p* nil)


