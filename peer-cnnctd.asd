(asdf:defsystem :peer-cnnctd
  :name "peer-cnnctd"
  :author "Aad Versteden <madnificent@gmail.com>"
  :version "0.0.1"
  :maintainer "Aad Versteden <madnificent@gmail.com>"
  :license "Apache 2.0"
  :description "Empty connector to a peer group, making testing easier."
  :serial t
  :depends-on (:hunchentoot :jsown :drakma :sexml)
  :components ((:file "package")
               (:file "support")
               (:file "peers")
               (:file "registration")
               (:file "server-maintenance")
               (:file "information-service")))
