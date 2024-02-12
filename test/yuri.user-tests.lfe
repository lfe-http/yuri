(defmodule yuri.user-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest ->parts
  (is-equal '(#"alice.roberts" #"sekr1t")
            (yuri.user:->parts #"alice.roberts:sekr1t")))

(deftest parsed->parts
  (let ((parsed (yuri:parse
                  "http://alice.roberts:sekr1t@example.com:8080/a/b/c?a=1&b=2#start")))
    (is-equal '(#"alice.roberts" #"sekr1t")
              (yuri.user:parsed->parts parsed))))
