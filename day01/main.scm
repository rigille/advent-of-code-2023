#!/usr/bin/scheme-script
(import (day01 solution)
        (chezscheme))
(define program-directory (include "day01/prefix.ss"))
(display-string "first star: ")
(display (sum-calibrations (string-append program-directory "input.txt")))
(display-string "\nsecond star: ")
(display (sum-written-out-calibrations (string-append program-directory "input.txt")))
(display-string "\n")
