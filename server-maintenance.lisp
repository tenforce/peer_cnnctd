(in-package :peer-cnnctd)
(declaim (optimize (debug 3) (safety 3) (speed 0)))

;;;;;;;;;;;;;;;;;;;;;;;;
;;;; server maintainance

(defvar *servers* (make-hash-table :synchronized t)
  "contains all acceptors, by port")

(defun start-server (port)
  "hosts a new server at port PORT"
  (let ((acceptor (make-instance 'hunchentoot:easy-acceptor :port port)))
    (setf (gethash port *servers*) acceptor)
    (hunchentoot:start acceptor)
    (register-as-peer port)))

(defun stop-server (port)
  "stops the server running on PORT"
  (let ((acceptor (gethash port *servers*)))
    (setf (gethash port *servers*) nil)
    (unregister-as-peer port)
    (when acceptor
      (hunchentoot:stop acceptor))))
