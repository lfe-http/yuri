(defmodule yuri.query-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest parse-binary
  (let ((query #"a=b&c=2&flags=1,3,5,6,9"))
    (is-equal #M(#"a" #"b"
                 #"c" #"2"
                 #"flags" #"1,3,5,6,9")
              (yuri.query:parse query))))

(deftest parse-list
  (let ((query "a=b&c=2&flags=1,3,5,6,9"))
    (is-equal #M(#"a" #"b"
                 #"c" #"2"
                 #"flags" #"1,3,5,6,9")
              (yuri.query:parse query))))

(deftest parse-map
  (let ((url-map (yuri:parse "https://example.com?a=b&c=2&flags=1,3,5,6,9")))
    (is-equal #M(#"a" #"b"
                 #"c" #"2"
                 #"flags" #"1,3,5,6,9")
              (yuri.query:parse url-map))))
