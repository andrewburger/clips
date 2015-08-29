;;;======================================================
;;;   Who Drinks Water? And Who owns the Zebra?
;;;
;;;         
;;;
;;;     Similar Puzzle with Different Inputs
;;;
;;;     October 2002
;;;
;;;     CLIPS Version 6.0 Example
;;;
;;;     To execute, merely load, reset and run.
;;;======================================================
(deftemplate avh (field a) (field v) (field h))

(defrule find-solution

; Carl hosted the group on Wednesday.
  (avh (a host) (v Carl) (h ?h1&3))

; The fellows ate at a Thai restaurant on Friday.
  (avh (a food) (v Thai) (h ?f1&5)

; Bill, who detests fish, volunteered to be the first host.
  (avh (a host) (v Bill) (h ?h2&~?h1&1)
  (avh (a food) (v fish) (h ?f2&?h2&1)

; Dave selected a steak house for the night before one of the fellows hosted everyone at a raucous pizza parlor
  (avh (a host) (v Dave) (h ?h3&~?h2&~?h1)
  (avh (a food) (v steak) (h ?f3&?h3)
  (avh (a food) (v pizza) (h ?f4&~?f3&?~h3)

; Eric miss Friday
  (avh (a host) (v Eric) (h ?h4&~?h3&~?h2&~?h1&~5)

; Andy and Tacos will match remaining slots.
  (avh (a host) (v Andy) (h ?h5&~?h4&~?h3&~?h2&~?h1)
  (avh (a food) (v Tacos) (h ?f5&~?f4&~?f3&~?f2&~?f1)
  =>
   (assert (solution food Thai  ?f1)
  	   (solution food Fish  ?f2)
           (solution food Pizza ?f3)
           (solution food Steak ?f4)
           (solution food Tacos ?f5)
           (solution host Carl  ?h1)
	   (solution host Bill  ?h2)
           (solution host Dave  ?h3)
	   (solution host Eric  ?h4)
	   (solution host Andy  ?h5)
 	)
)

(defrule print-solution
  (declare (salience 800))
  ?f01  <- (solution host ?h1 1)
  ?f02  <- (solution food ?f1 1)
  ?f03  <- (solution host ?h2 2)
  ?f04  <- (solution food ?f2 2)
  ?f05  <- (solution host ?h3 3)
  ?f06  <- (solution food ?f3 3)
  ?f07  <- (solution host ?h4 4)
  ?f08  <- (solution food ?f4 4)
  ?f09  <- (solution host ?h5 5)
  ?f10  <- (solution food ?f5 5)
    =>
  (retract ?f01 ?f02 ?f03 ?f04 ?f05 ?f06 ?f07 ?f08 ?f09 ?f10)

  (format t "  Day   | %-11s | %-6s %n"  Host  Food)
  (format t "--------------------------------------------------------------------%n")
  (format t "  Mon   | %-11s | %-6s%n" ?h1 ?f1)
  (format t "  Tue   | %-11s | %-6s%n" ?h2 ?f2)
  (format t "  Wed   | %-11s | %-6s%n" ?h3 ?f3)
  (format t "  Thu   | %-11s | %-6s%n" ?h4 ?f4)
  (format t "  Fri   | %-11s | %-6s%n" ?h5 ?f5)

  (printout t crlf crlf))

(defrule startup
   =>
   (printout t
    "One week five bachelors agreed to go out together to eat the"     crlf
    "5 evening meals on Monday through Friday. It was understood "     crlf
    "that Eric would miss Friday's meal because of an out-of-town "    crlf
    "wedding at which he fervently hoped to catch the bride's garter."     crlf
    "Each bachelor served as the host at a restaurant of his choice on"     crlf
    "a different night. Use the clues below to determine which bachelor "    crlf
    "hosted the group each night and what food he selected. Carl hosted "    crlf
    "the group on Wednesday. The fellows ate at a Thai restaurant on Friday."    crlf
    "Bill, who detests fish, volunteered to be the first host."    crlf
    "Dave selected a steak house for the night before one of the fellows hosted everyone at a raucous pizza parlor." t    crlf
    "Now, who select which food on what day?" crlf crlf)
   (assert (value host Andy)
 	   (value host Bill)
 	   (value host Carl)                (value host Dave)
 	   (value host Eric)
 	   (value food Tacos)
 	   (value food Steak) 	            (value food Pizza)
 	   (value food Thai)
 	   (value food Fish)

    )
)
(defrule generate-combinations
   ?f <- (value ?s ?e)
   =>
   (retract ?f)
   (assert (avh (a ?s) (v ?e) (h 1))
           (avh (a ?s) (v ?e) (h 2))
           (avh (a ?s) (v ?e) (h 3))
           (avh (a ?s) (v ?e) (h 4))
           (avh (a ?s) (v ?e) (h 5))))
