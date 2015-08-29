(deffacts initial_facts
   (factor_check 1)
   (phase chosenum))

; Ask the player to select an interger number

(defrule number-select
    (phase chosenum)
   =>
   (printout t "Which number you want? ")
   (assert (num-select (read)))
)

(defrule bad-number-choice
   ?phase <- (phase chosenum)
   ?choice <- (num-select ?size&~:(integerp ?size) 
                                |:(<= ?size 0))
   =>
   (retract ?phase ?choice)
   (assert (phase chosenum))
   (printout t "Choose an integer greater than one."
               crlf)
)

(defrule good-number-choice
   ?phase <- (phase chosenum)
   ?choice <- (num-select ?size&:(integerp ?size)
                                &:(> ?size 0))
   =>
   (retract ?phase ?choice)
   (assert (goal ?size))
   (assert (state 2))
)


; Calculate and output the sequence of the prime factorization

(defrule calculate_factors
  (state 2)
  (goal ?g)
  (printout t "Prime factorization: 0 1 ")
  (factor_check ?fc)

  if (= mod(?g/?fc) 0)
   =>
  (printout t ?fc " ")
  (assert (factor_check (+ ?fc 1)

  if (=! mod(?g/?fc) 0)
   =>
  (assert (factor_check (+ ?fc 1)
  if (> ?g ?fc)
   =>
  (assert (state 2))
)
