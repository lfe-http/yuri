(defmodule yuri.user
  (export
   (->parts 1)
   (parsed->parts 1)))

(defun userinfo-sep () #":")

(defun ->parts (userinfo)
  (binary:split userinfo (userinfo-sep)))

(defun parsed->parts (parsed)
  (->parts (mref parsed 'userinfo)))
