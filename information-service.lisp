(in-package :peer-cnnctd)
(declaim (optimize (debug 3) (safety 3) (speed 0)))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; published http calls

(hunchentoot:define-easy-handler (server :uri "/server") (port)
  (setf (hunchentoot:content-type*) "text/html")
  (unless port (setf port (req-port)))
  (<:html
   (<:head (<:title "peer_cnnctd server info"))
   (<:body (<:h1 "Server running at " port)
           (<:p "Server has " (length (peers-by-port port)) " peers")
           (<:ul (loop for peer in (peers-by-port port) collect (<:li peer))))))

(hunchentoot:define-easy-handler (peers :uri "/peers") ()
  (setf (hunchentoot:content-type*) "application/json")
  (jsown:to-json
   (jsown:new-js
     ("servers"
      (loop for port being the hash-keys of *known-clients-per-port*
         collect
           (jsown:new-js ("port" port)
                         ("peers" (gethash port *known-clients-per-port*))))))))
