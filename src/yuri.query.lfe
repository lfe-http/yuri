(defmodule yuri.query
  (export
   (parse 1)))

(defun parse
 ((query) (when (is_list query))
  (maps:from_list (uri_string:dissect_query query)))
 ((yuri-data) (when (is_map yuri-data))
  (parse (maps:get 'query yuri-data ""))))
