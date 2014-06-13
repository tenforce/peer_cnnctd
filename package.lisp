(defpackage :peer-cnnctd
  (:use :cl)
  (:export #:start-server #:stop-server #:*peer-cnnctr-path* #:*peer-cnnctd-hostname*)
  (:import-from :hunchentoot :define-easy-handler :content-type*))

#+sbcl (declaim (sb-ext:muffle-conditions style-warning))
(eval-when (:compile-toplevel :load-toplevel :execute)
  (sexml:with-compiletime-active-layers (sexml:standard-sexml sexml:xml-doctype)
    (sexml:support-dtd (asdf:system-relative-pathname :sexml "html5.dtd") :<)))
#+sbcl (declaim (sb-ext:unmuffle-conditions style-warning))
