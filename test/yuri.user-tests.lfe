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

(deftest parse-to-list-none
  (let ((parsed (yuri:parse
                  "http://example.com:8080/a/b/c?a=1&b=2#start")))
    (is-equal '(#(user #"")
                #(password #""))
              (yuri.user:parse-to-list parsed))))

(deftest parse-to-list-user-only
  (let ((parsed (yuri:parse
                  "http://alice.roberts@example.com:8080/a/b/c?a=1&b=2#start")))
    (is-equal '(#(user #"alice.roberts")
                #(password #""))
              (yuri.user:parse-to-list parsed))))

(deftest parse-to-list-password-only
  (let ((parsed (yuri:parse
                  "http://:sekr1t@example.com:8080/a/b/c?a=1&b=2#start")))
    (is-equal '(#(user #"")
                #(password #"sekr1t"))
              (yuri.user:parse-to-list parsed))))

(deftest parse-to-list-all
  (let ((parsed (yuri:parse
                  "http://alice.roberts:sekr1t@example.com:8080/a/b/c?a=1&b=2#start")))
    (is-equal '(#(user #"alice.roberts")
                #(password #"sekr1t"))
              (yuri.user:parse-to-list parsed))))
