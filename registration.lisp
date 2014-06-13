(in-package :peer-cnnctd)
(declaim (optimize (debug 3) (safety 3) (speed 0)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; peer_cnnctr registration

(defparameter *peer-cnnctr-path* "http://localhost:3001"
  "place where the peer_cnnctr service is running")

(defparameter *peer-cnnctd-hostname* "localhost"
  "hostname of this service")

(defun register-as-peer (port)
  "registers the current server as the peer"
  (let ((response
         (flexi-streams:octets-to-string
          (drakma:http-request (format nil "~A/peer_groups/didicat/peers.json" *peer-cnnctr-path*)
                               :method :post
                               :parameters `(("peer[contact_point]" 
                                              . ,(format nil "http://~A:~A/contact_point"
                                                         *peer-cnnctd-hostname* port))
                                             ("peer[shared_contact_url]" 
                                              . ,(format nil "http://~A:~A"
                                                         *peer-cnnctd-hostname* port))
                                             ("peer_group_key" 
                                              . "didicat")))
          :external-format :utf8)))
    (loop for peer in (jsown:val (jsown:parse response) "peers")
       do (add-peer peer port))))

(defun unregister-as-peer (port)
  "disconnects the server at port PORT from the peer pool"
  (declare (ignore port))
  (error "unregistration is not support yet"))

