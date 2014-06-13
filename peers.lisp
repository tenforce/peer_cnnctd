(in-package :peer-cnnctd)
(declaim (optimize (debug 3) (safety 3) (speed 0)))

;;;;;;;;;;
;;;; peers

(defvar *known-clients-per-port* (make-hash-table :synchronized t)
  "contains all the peer which are known, for each server")

(defun has-peer-p (client-url &optional (server-port (req-port)))
  "returns truehy iff the server running on SERVER-PORT has a client with url CLIENT-URL"
  (find client-url (gethash server-port *known-clients-per-port*) :test #'string=))

(defun add-peer (client-url &optional (server-port (req-port)))
  "adds the client to the server unless it is aleardy there"
  (unless (has-peer-p client-url server-port)
    (push client-url (gethash server-port *known-clients-per-port*))))

(defun peers-by-port (&optional (server-port (req-port)))
  (gethash server-port *known-clients-per-port*))

(defun remove-peer (client-url &optional (server-port (req-port)))
  "removes the client from the server if it was there"
  (remove-from-list client-url (gethash server-port *known-clients-per-port*) :test #'string=))

(define-easy-handler (contact-point :uri "/contact_point")
    (joined left)
  (setf (content-type*) "application/json")
  (when joined (add-peer joined))
  (when left (remove-peer left))
  (jsown:to-json
   (jsown:new-js
     ("state-change" 
      (jsown:new-js ("joined" joined)
                    ("left" left))))))

