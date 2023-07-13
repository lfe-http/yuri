(defmodule yuri.path
  (export
   (->segments 1)
   (path-sep 0)
   (split-path 1))
  ;; These should be treated as private; exported for testing
  ;; purposes only.
  (export
   (handle-path-segment 1)
   (handle-path-segments 1)))

(defun path-sep () #"/")

(defun split-path
  ((path) (when (is_list path))
   (split-path (list_to_binary path)))
  ((path) (when (is_binary path))
   (binary:split path (path-sep) '(global))))

(defun ->segments
 ((path) (when (is_list path))
  (->segments (list_to_binary path)))
 ((path) (when (is_binary path))
  (lists:filter
    (lambda (x) (=/= #"" x))
    (lists:map
     (lambda (x)
       (let ((r (handle-path-segment x)))
         (if (is_atom r)
           r
           (yuri:encode r `#m(as-bytes true)))))
     (split-path path))))
 ((yuri-data) (when (is_map yuri-data))
  (->segments (maps:get 'path yuri-data #""))))


;;; Private functions

(defun handle-path-segment
  (((= (cons #\: var-name) seg)) (when (is_list seg))
   (list_to_atom var-name))
  (((= (binary ":" (var-name bitstring)) seg)) (when (is_binary seg))
    (binary_to_atom var-name 'utf8))
  ((seg)
   seg))

(defun handle-path-segments (path-segments)
  (lists:map
   #'yuri.path:handle-path-segment/1
   path-segments))
