(defmodule yuri
  (export
   (encode 1) (encode 2))
  (export
   (parse 1)
   (quote 1) (quote 2)))

;;; uri_string library wrappers

(defun parse (uri)
  (uri_string:parse uri))

(defun quote (uri)
  (uri_string:quote uri))

(defun quote (uri safe)
  (uri_string:quote uri safe))

;; Code for this was converted from Erlang written by Renato Albano, CapnKernul
;; (Github user), erlangexamples.com, and the erlang docs for the edoc lib.
;; These functions were originally part of the lanes library at the following
;; locations:
;;  * `src/encode_uri_rfc3986.erl`
;;  * `src/lanes/uri.lfe

(defun encode (chars)
  (encode chars #m(as-string true)))

(defun encode
  ((chars `#m(as-bytes true))
    (encode-binary chars))
  ((chars _)
    (encode-string chars)))

;;; Private functions

(defun encode-binary (data)
  (unicode:characters_to_binary
    (encode-string
      (unicode:characters_to_list data))))

(defun encode-string
 ;; alpha-numerics
 (((cons char rest)) (when (andalso (>= char #\a) (=< char #\z)))
  (cons char (encode-string rest)))
 (((cons char rest)) (when (andalso (>= char #\A) (=< char #\Z)))
  (cons char (encode-string rest)))
 (((cons char rest)) (when (andalso (>= char #\0) (=< char #\9)))
 ;; non-alpha, non-special chars
  (cons char (encode-string rest)))
 (((cons (= 33 char) rest)) ; !
  (cons char (encode-string rest)))
 (((cons (= 39 char) rest)) ; '
  (cons char (encode-string rest)))
 (((cons (= 40 char) rest)) ; (
  (cons char (encode-string rest)))
 (((cons (= 41 char) rest)) ; )
  (cons char (encode-string rest)))
 (((cons (= 42 char) rest)) ; *
  (cons char (encode-string rest)))
 (((cons (= 45 char) rest)) ; -
  (cons char (encode-string rest)))
 (((cons (= 46 char) rest)) ; .
  (cons char (encode-string rest)))
 (((cons (= 95 char) rest)) ; _
  (cons char (encode-string rest)))
 (((cons (= 126 char) rest)) ; ~
  (cons char (encode-string rest)))
 ;; special chars
 (((cons char rest)) (when (=< char #x7f))
  (++ (escape-byte char) (encode-string rest)))
 (((cons char rest)) (when (and (>= char #x7f) (=< char #x07ff)))
  (++ (escape-byte (+ (bsr char 6) #xc0))
      (escape-byte (+ (band char #x3f) #x80))
      (encode-string rest)))
 (((cons char rest)) (when (> char #x07ff))
  (++ (escape-byte (+ (bsr char 12) #xe0))
      (escape-byte (+ (band #x3f (bsr char 6)) #x80))
      (escape-byte (+ (band char #x3f) #x80))
      (encode-string rest)))
 ;; other
 (((cons char rest))
  (++ (escape-byte char) (encode-string rest)))
 (('())
  '()))

(defun hex-octet
 ((char) (when (=< char 9))
  (list (+ #\0 char)))
 ((char) (when (> char 15))
  (++ (hex-octet (bsr char 4))
      (hex-octet (band char 15))))
 ((char)
  (list (+ (- char 10) #\a))))

(defun normalise-hex
 ((hex) (when (== (length hex) 1))
  (++ "%0" hex))
 ((hex)
  (++ "%" hex)))

(defun escape-byte (char)
  (normalise-hex (hex-octet char)))
