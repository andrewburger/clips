;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
; Car Monitoring Program.                               ;
;			    				;
;       Monitoring oil pressure, water temperature      ;
;       and voltage.                                    ;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
; The system will determine the action to be taken      ;
; given the cars oil pressure, water temperature        ;
; and voltage. If the oil pressure is below 40 pound 	;
; or the temperature is above 135 degrees celsius 	;
; or the voltage is below 12v, the system will advise 	;
; the driver to stop the car.        			;
;                                                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
; To run the system:                                    ;
; (reset)                                               ;
; (run)                                                 ;
;                                                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

( defrule monitoring_system
=>
( printout t " " crlf)

( printout t "This system monitors your cars oil pressure," crlf )
( printout t "water temperature and voltage. The system will" crlf )
( printout t "determine if there is a problem with your car," crlf )
( printout t "advise you of the best possible action." crlf )
( printout t " " crlf)

; Prompt user for input on the oil pressure, water temperature
; and voltage.

( printout t "What is the oil pressure?")
( printout t " ")
( bind ?oil_pressure (read t))

( if ( <= ?oil_pressure 20 ) then ( assert ( oil_pressure low )))
( if ( and ( > ?oil_pressure 20 ) ( < ?oil_pressure 40 ))
	then ( assert (oil_pressure medium )))
( if ( >= ?oil_pressure 40 ) then ( assert ( oil_pressure correct )))

( printout t " " crlf)
( printout t "What is the water temperature?")
( printout t " ")
( bind ?water_temperature (read t))

( if ( <= ?water_temperature 110 ) then ( assert ( water_temperature normal )))
( if ( and ( > ?water_temperature 110 ) ( < ?water_temperature 135))
	then ( assert ( water_temperature medium )))
( if ( >= ?water_temperature 135 ) then ( assert ( water_temperature high )))

( printout t " " crlf)
( printout t "What is the voltage?")
( printout t " ")
( bind ?voltage (read t))

( if ( < ?voltage 8 ) then ( assert ( voltage low )))
( if ( and ( >= ?voltage 8) ( =< ?voltage 10)
        then ( assert ( voltage medium))
( if ( > ?voltage 10 ) then ( assert ( voltage normal))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Rules to stop the car                                 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
( defrule normal
	( oil_pressure correct)
	( water_temperature normal)
	( voltage normal)
=>
	( printout t " " crlf)
	( printout t "All systems functioning correctly. Drive at peace ....." crlf)
	( printout t "That is until something does go wrong." crlf))

( defrule slow_med-oil
	( oil_pressure medium )
	( water_temperature normal )
	( voltage normal )
=>
	( printout t " " crlf )
	( printout t "Slow down, there may be a problem developing with the oil pressure." crlf))

( defrule slow_med-oil_med-temp
	( oil_pressure medium )
	( water_temperature medium )
	( voltage normal )
=>
	( printout t " " crlf )
	( printout t "Slow down, there may be a problem developing with the" crlf)
	( printout t "oil pressure and the water temperature. Driving slower may" crlf)
	( printout t "decrease the load on the cooling system." crlf))

( defrule slow_med-temp
	( oil_pressure correct )
	( water_temperature medium )
	( voltage normal )
=>
	( printout t " " crlf )
	( printout t "Slow down, there may be a problem developing with the cooling system." crlf))

( defrule slow_med-oil_low-volt
	( oil_pressure medium )
	( water_temperature normal )
	( voltage low )
=>
	( printout t " " crlf )
	( printout t "Slow down, there may be a problem developing with the oil pressure" crlf)
	( printout t "and the charging system." crlf))

( defrule slow_low-volt	( oil_pressure correct )
	( water_temperature normal )
	( voltage low )
=>
	( printout t " " crlf )
	( printout t "Slow down, there may be a problem developing with the charging system," crlf)
	( printout t "When possible have the system checked. As the wipers and fan will" crlf)
	( printout t "will drain the system if used heavily." crlf))

( defrule slow_med-temp_low-volt
	( oil_pressure correct )
	( water_temperature medium )
	( voltage low )
=>	( printout t " " crlf )
	( printout t "Slow down, there may be a problem developing" crlf)
	( printout t "with the cooling system and charging system." crlf))

( defrule slow_med-oil_med-temp_low-volt
	( oil_pressure medium )
	( water_temperature medium )
	( voltage low )
=>
	( printout t " " crlf )
	( printout t "Slow down, there may be a problem developing" crlf)
	( printout t "with the oil pressure, cooling system and charging system." crlf))
( defrule stop_oil-low_temp-med
	( oil_pressure low)
	( water_temperature medium )
	( voltage normal )
=>
	( printout t " " crlf )
	( printout t "Stop the car immediately, there is a problem with the oil pressure." crlf) )

( defrule stop_oil-med_temp-high
	( oil_pressure medium)
	( water_temperature high)
=>
	( printout t " " crlf )
	( printout t "Stop the car immediately, there is a problem with the cooling system." crlf))

( defrule stop_oil-low
	( oil_pressure low)
 	( water_temperature normal)
	( voltage normal )
=>
	( printout t " " crlf )
	( printout t "Stop the car immediately, there is a problem with the oil pressure." crlf))

( defrule stop_oil-low_high-temp
	( oil_pressure low)
 	( water_temperature high)
	( voltage normal )
=>
	( printout t " " crlf )
	( printout t "Stop the car immediately, there is a problem with the oil pressure" crlf)
	( printout t " and the cooling system." crlf))

( defrule stop_high-temp
	( oil_pressure correct )
	( water_temperature high)
	( voltage normal )
=>
	( printout t " " crlf )
	( printout t "Stop the car immediately, there is a problem with the cooling system." crlf))

( defrule stop_low-oil_low-volt
	( oil_pressure low )
	( water_temperature normal )
	( voltage low)
=>
	( printout t " " crlf )
	( printout t "Stop the car immediately, there is a problem with the oil pressure." crlf)
	( printout t "and the charging system." crlf))

( defrule stop_oil-med_temp-high_volt-low
	( oil_pressure medium )
	( water_temperature high)
	( voltage low)
=>
	( printout t " " crlf )
	( printout t "Stop the car immediately, there is a problem with the cooling system" crlf)
	( printout t "and the charging system." crlf ))

( defrule stop_oil-low_temp-high_volt-low
	( oil_pressure low)
	( water_temperature high)
	( voltage low)
=>
	( printout t " " crlf )
	( printout t "Stop the car immediately, there is a problem with the oil pressure," crlf)
	( printout t "cooling system and charging system." crlf ))
( defrule stop_temp-high_volt-low
	( oil_pressure correct )
	( water_temperature high)
	( voltage low)
=>
	( printout t " " crlf )
	( printout t "Stop the car immediately, there is a problem with the cooling system," crlf)
	( printout t "and the charging system." crlf))

( defrule stop_oil-low_temp-med_volt-low
	( oil_pressure low)
	( water_temperature medium )
	( voltage low)
=>
	( printout t " " crlf )
	( printout t "Stop the car immediately, there is a problem with the oil pressure," crlf)
	( printout t "and the charging system." crlf))
( defrule slow_med-temp_med-volt
	( oil_pressure correct)
	( water_temperature medium )
	( voltage medium)
=>
	( printout t " " crlf )
	( printout t "Slow down, the car really needs to recharge and cool off." crlf)

( defrule slow_med-oil_med-temp_low-volt
	( oil_pressure medium)
	( water_temperature medium )
	( voltage low)
=>
	( printout t " " crlf )
	( printout t "Slow down, the car really needs to recharge and cool off. Your oil" crlf)
	( printout t "pressure is also less than optimal." crlf))

( defrule slow med-volt
	( oil_pressure correct)
	( water_temperature normal )
	( voltage medium)
=>
	( printout t " " crlf )
	( printout t "Slow down, your voltage has just started to get low.  Give it a" crlf)
	( printout t "chance to recharge." crlf))
