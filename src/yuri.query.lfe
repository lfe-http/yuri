(defmodule yuri.query
  (export
   (parse 1)))

(defun parse
  ((query) (when (is_binary query))
   (parse (binary_to_list query)))
  ((query) (when (is_list query))
   (maps:from_list
    (lists:map
     #'kv->bins/1
     (uri_string:dissect_query query))))
  ((yuri-data) (when (is_map yuri-data))
   (parse (maps:get 'query yuri-data ""))))

(defun kv->bins
  ((`#(,k ,v)) (when (andalso (is_binary k) (is_binary v)))
   `#(,k ,v))
  ((`#(,k ,v)) (when (is_list k))
   (kv->bins `#(,(list_to_binary k) ,v)))
  ((`#(,k ,v)) (when (is_list v))
   (kv->bins `#(,k ,(list_to_binary v))))
  ((`#(,k ,v)) (when (is_atom k))
   (kv->bins `#(,(atom_to_list k) ,v)))
  ((`#(,k ,v)) (when (is_atom v))
   (kv->bins `#(,k ,(atom_to_list v))))
  ((`#(,k ,v)) (when (is_integer v))
   (kv->bins `#(,k ,(integer_to_list v 10)))))
