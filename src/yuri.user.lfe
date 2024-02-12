(defmodule yuri.user
  (export
   (->parts 1)
   (parsed->parts 1)
   (parse 1)
   (parse-to-list 1)))

(defun userinfo-sep () #":")

(defun ->parts (userinfo)
  (binary:split userinfo (userinfo-sep)))

(defun parsed->parts (parsed)
  (->parts (mref parsed 'userinfo)))

(defun parse (parsed)
 (_parse (parsed->parts parsed)))

(defun _parse
 ((`())
  `#m(user #""
      password #""))
 ((`(#""))
  `#m(user #""
      password #""))
 ((`(,user))
  `#m(user ,user
      password #""))
 ((`(#"" #""))
  `#m(user #""
      password #""))
 ((`(,user #""))
  `#m(user ,user
      password #""))
 ((`(#"" ,password))
  `#m(user #""
      password ,password))
 ((`(,user ,password))
  `#m(user ,user
      password ,password)))

(defun parse-to-list (parsed)
  (maps:to_list (parse parsed)))
