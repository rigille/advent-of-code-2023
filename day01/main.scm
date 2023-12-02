#!/nix/store/v4f7hy4hh7wqcb26n4i6kly1fv76fyl3-chez-scheme-racket-unstable-2021-12-11/bin/scheme --script
(import (day01 solution)
        (chezscheme))
(define program-directory (include "day01/prefix.ss"))
(display-string "first star: ")
(display (sum-calibrations (string-append program-directory "input.txt")))
(display-string "\nsecond star: ")
(display (sum-written-out-calibrations (string-append program-directory "input.txt")))
(display-string "\n")
