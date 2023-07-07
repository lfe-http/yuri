(defmodule yuri-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest encode
  (is-equal ""
            (yuri:encode ""))
  (is-equal "a"
            (yuri:encode "a"))
  (is-equal "42"
            (yuri:encode "42"))
  (is-equal "%20"
            (yuri:encode " "))
  (is-equal "a42"
            (yuri:encode "a42"))
  (is-equal "42a"
            (yuri:encode "42a"))
  (is-equal "42%20a"
            (yuri:encode "42 a"))
  (is-equal "42%20a%40stuff"
            (yuri:encode "42 a@stuff"))
  (is-equal "alice%3aroberts%40host"
            (yuri:encode "alice:roberts@host"))
  (is-equal "-_.!~*'()"
            (yuri:encode "-_.!~*'()")))

(deftest encode-string
  (is-equal ""
            (yuri:encode "" #m(as-string true)))`
  (is-equal "a"
            (yuri:encode "a" #m(as-string true)))`
  (is-equal "42"
            (yuri:encode "42" #m(as-string true)))
  (is-equal "%20"
            (yuri:encode " " #m(as-string true)))
  (is-equal "a42"
            (yuri:encode "a42" #m(as-string true)))
  (is-equal "42a"
            (yuri:encode "42a" #m(as-string true)))
  (is-equal "42%20a"
            (yuri:encode "42 a" #m(as-string true)))
  (is-equal "42%20a%40stuff"
            (yuri:encode "42 a@stuff" #m(as-string true)))
  (is-equal "alice%3aroberts%40host"
            (yuri:encode "alice:roberts@host" #m(as-string true))))

(deftest encode-bytes
  (is-equal #""
            (yuri:encode #"" #m(as-bytes true)))
  (is-equal #"a"
            (yuri:encode #"a" #m(as-bytes true)))
  (is-equal #"42"
            (yuri:encode #"42" #m(as-bytes true)))
  (is-equal #"%20"
            (yuri:encode #" " #m(as-bytes true)))
  (is-equal #"a42"
            (yuri:encode #"a42" #m(as-bytes true)))
  (is-equal #"42a"
            (yuri:encode #"42a" #m(as-bytes true)))
  (is-equal #"42%20a"
            (yuri:encode #"42 a" #m(as-bytes true)))
  (is-equal #"42%20a%40stuff"
            (yuri:encode #"42 a@stuff" #m(as-bytes true)))
  (is-equal #"alice%3aroberts%40host"
            (yuri:encode #"alice:roberts@host" #m(as-bytes true))))
