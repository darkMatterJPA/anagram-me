#lang racket

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CS 3800 Fall 2018 Project 00
;; Alton J. Panton
;;
;; Only the following references were used to inform
;; the development solutions in this file:
;; http://docs.racket-lang.org/guide/Lists__Iteration__and_Recursion.htmls
;; https://docs.racket-lang.org/reference/strings.html
;; https://cs.stackexchange.com/questions/16221/algorithm-to-write-a-dictionary-using-thousands-of-words-to-find-all-anagrams-fo ***(Inspiration for hash function)****
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;------------------------------------------------------------------------------------


; define some file
(define some-file "words.txt")

; puts file in the input-port
(define in (open-input-file some-file))

;A function that goes through the input-port and adds the appropriate word to a list
(define display-lst
  (for/list ([line (in-lines in)]
    #:unless (not (eq? (string-length line) 7))
)
   line))

; List of prime numbers used for hash function
(define prime '(
      2      3      5      7     11     13     17     19     23     29 
     31     37     41     43     47     53     59     61     67     71 
     73     79     83     89     97    101    103    107    109    113 
    127    131    137    139    149    151    157    163    167    173 
    179    181    191    193    197    199    211    223    227    229 
    233    239    241    251    257    263    269    271    277    281 
    283    293    307    311    313    317    331    337    347    349 
    353    359    367    373    379    383    389    397    401    409 
    419    421    431    433    439    443    449    457    461    463 
    467    479    487    491    499    503    509    521    523    541
                  ))
; CONTRACT: hash-function: str -> int
; PURPOSE: Function that takes a string and returns the hash value.
; CODE:
(define (hash-function str)
  (for/fold ([hash 31])
   ([i (in-range 0 (string-length str))])
            (* hash (list-ref prime  (abs (- (char->integer #\a) (char->integer(string-ref str i)) ))))
  ))

;test
; If you mode the hashed value of the list of input strings
; by each hashed word in the dictionary file and get a result
; of 0. then that word is a subset of the list of input words.
(eq? (modulo (hash-function "alton") (hash-function  "notla")) 0)
(eq? (modulo (hash-function  "nottopnla") (hash-function "ton")) 0)



; CONTRACT: find-words : letters -> String
; PURPOSE: Returns a string of comma delimited dictionary words 7
; letters long and in alphabetical order that can be composed of
; characters in letters. (anagrams of letters) There is no trailing
; comma after the last word in the returned string.
; Each letter in letters may only be used once per match, e.g.
; (find-words '("zymomin" "am")) could return "mammoni, zymomin"
; because "mammoni" is composed of letters in letters including the
; three 'm' characters in letters, and "zymomin" is similarly composed of
; letters in letters. However, "mammomi" could not be 
; returned because "mammomi" requires four 'm' characters and 
; only three are available in letters.
; CODE:
(define (find-words letters)
  (define list (string-join letters ""))
 (string-join (sort (for/list ([word (in-list display-lst)]
           #:unless (not (eq? (modulo (hash-function list) (hash-function (string-downcase word))) 0)))
  (string-downcase word)) string<?) ", ") 
)

;test
(time(displayln (find-words '("zymomin" "omixa"))))
(time(displayln (find-words '("worjlkhglhglock"))))
(time(displayln (find-words '("tropho-" "bon-ton" "by-cock"))))