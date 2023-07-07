(defmodule yuri.path-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest split-path
  (is-equal '(#"" #"a" #"b" #"c")
            (yuri.path:split-path "/a/b/c"))
  (is-equal '(#"" #"a" #"b" #"c")
            (yuri.path:split-path #"/a/b/c"))
  (is-equal '(#"a" #"b" #"c")
            (yuri.path:split-path #"a/b/c"))
  (is-equal '(#" a" #"b" #"c ")
            (yuri.path:split-path #" a/b/c "))
  (is-equal '(#"" #"user" #"update" #":id")
            (yuri.path:split-path #"/user/update/:id")))

(deftest handle-path-segment
  (is-equal "a"
            (yuri.path:handle-path-segment "a"))
  (is-equal 'id
            (yuri.path:handle-path-segment ":id"))
  (is-equal 'id-with-dashes
            (yuri.path:handle-path-segment ":id-with-dashes"))
  (is-equal #"a"
            (yuri.path:handle-path-segment #"a"))
  (is-equal 'id
            (yuri.path:handle-path-segment #":id")))

(deftest handle-path-segments
  (is-equal '(#"a" #"b" #"c")
            (yuri.path:handle-path-segments '(#"a" #"b" #"c")))
  (is-equal '(#"user" #"update" id)
            (yuri.path:handle-path-segments '(#"user" #"update" #":id"))))

(deftest ->segments
  (is-equal '(#"a" #"b" #"c")
            (yuri.path:->segments "/a/b/c"))
  (is-equal '(#"a" #"b" #"c")
            (yuri.path:->segments #"/a/b/c"))
  (is-equal '(#"a" #"b" #"c")
            (yuri.path:->segments #"a/b/c"))
  (is-equal '(#"%20a" #"b" #"c%20")
            (yuri.path:->segments #" a/b/c "))
  (is-equal '(#"a" #"b" #"42")
            (yuri.path:->segments "/a/b/42"))
  (is-equal '(#"a" #"b" #"42")
            (yuri.path:->segments #"/a/b/42"))
  (is-equal '(#"a" #"b" #"42")
            (yuri.path:->segments #"a/b/42"))
  (is-equal '(#"%20a" #"b" #"42%20")
            (yuri.path:->segments #" a/b/42 "))
  (is-equal '(#"user" #"update" id)
            (yuri.path:->segments #"/user/update/:id")))
