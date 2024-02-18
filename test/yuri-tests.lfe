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

(deftest parse-host
  (is-equal '(#(fragment #"")
              #(host #"example.com")
              #(path #"")
              #(port #"")
              #(query #"")
              #(scheme #"http")
              #(userinfo #""))
            (lists:sort (yuri:parse-to-list "http://example.com"))))

(deftest parse-host-with-user
  (is-equal '(#(fragment #"")
              #(host #"example.com")
              #(path #"")
              #(port #"")
              #(query #"")
              #(scheme #"http")
              #(userinfo #"alice.roberts:sekr1t"))
            (lists:sort (yuri:parse-to-list "http://alice.roberts:sekr1t@example.com"))))

(deftest parse-host-with-fragment
  (is-equal '(#(fragment #"start")
              #(host #"example.com")
              #(path #"/")
              #(port #"")
              #(query #"")
              #(scheme #"http")
              #(userinfo #""))
            (lists:sort (yuri:parse-to-list "http://example.com/#start"))))

(deftest parse-host-with-port
  (is-equal '(#(fragment #"")
              #(host #"example.com")
              #(path #"")
              #(port #"8080")
              #(query #"")
              #(scheme #"http")
              #(userinfo #""))
            (lists:sort (yuri:parse-to-list "http://example.com:8080"))))

(deftest parse-host-with-query
  (is-equal '(#(fragment #"")
              #(host #"example.com")
              #(path #"")
              #(port #"")
              #(query #"a=1&b=2")
              #(scheme #"http")
              #(userinfo #""))
            (lists:sort (yuri:parse-to-list "http://example.com?a=1&b=2"))))

(deftest parse-host-with-all
  (is-equal '(#(fragment #"start")
              #(host #"example.com")
              #(path #"/a/b/c")
              #(port #"8080")
              #(query #"a=1&b=2")
              #(scheme #"http")
              #(userinfo #"alice.roberts:sekr1t"))
            (lists:sort (yuri:parse-to-list "http://alice.roberts:sekr1t@example.com:8080/a/b/c?a=1&b=2#start"))))

(deftest format-empty
  (is-equal ":"
           (lists:flatten (yuri:format (yuri:new)))))

(deftest format-with-host
  (let ((parsed #m(fragment #""
                 host #"example.com"
                 path #""
                 port #""
                 query #""
                 scheme #"http"
                 userinfo #"")))
    (is-equal "http://example.com"
             (lists:flatten (yuri:format parsed)))))

(deftest format-with-user
  (let ((parsed #m(fragment #""
                 host #"example.com"
                 path #""
                 port #""
                 query #""
                 scheme #"http"
                 userinfo #"alice.roberts:sekr1t")))
    (is-equal "http://alice.roberts:sekr1t@example.com"
             (lists:flatten (yuri:format parsed)))))

(deftest format-with-fragment
  (let ((parsed #m(fragment #"start"
                 host #"example.com"
                 path #""
                 port #""
                 query #""
                 scheme #"http"
                 userinfo #"")))
    (is-equal "http://example.com#start"
             (lists:flatten (yuri:format parsed)))))

(deftest format-with-port
  (let ((parsed #m(fragment #""
                 host #"example.com"
                 path #""
                 port #"5099"
                 query #""
                 scheme #"http"
                 userinfo #"")))
    (is-equal "http://example.com:5099"
             (lists:flatten (yuri:format parsed)))))

(deftest format-with-query
  (let ((parsed #m(fragment #""
                 host #"example.com"
                 path #""
                 port #""
                 query #"a=1&b=2"
                 scheme #"http"
                 userinfo #"")))
    (is-equal "http://example.com?a=1&b=2"
             (lists:flatten (yuri:format parsed)))))

(deftest format-with-all
  (let ((parsed #m(fragment #"start"
                 host #"example.com"
                 path #"/a/b/c"
                 port #"5099"
                 query #"a=1&b=2"
                 scheme #"http"
                 userinfo #"alice.roberts:sekr1t")))
    (is-equal "http://alice.roberts:sekr1t@example.com:5099/a/b/c?a=1&b=2#start"
             (lists:flatten (yuri:format parsed)))))

(deftest clean
  (let ((parsed #m(fragment #"start"
                 host #"example.com"
                 path #"/a/b/c"
                 port #"5099"
                 query #"a=1&b=2"
                 scheme #"http"
                 userinfo #"alice.roberts:sekr1t")))
    (is-equal "http://example.com:5099/a/b/c?a=1&b=2#start"
             (lists:flatten (yuri:format (yuri:clean parsed))))))
