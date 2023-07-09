MODULE_NAME='CLEANING' (DEV TP_CLEANING)
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/04/2006  AT: 11:33:16        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
*)    

DEFINE_CONSTANT

INTEGER CLEANING_TL_ID = 4
INTEGER CLEANING_TIME = 30 // LENGHT ARRAY

LONG TL_CLEANING[CLEANING_TIME] = {1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,
			1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,
			1000,1000,1000,1000,1000,1000,1000,1000,1000,1000}

INTEGER BT_CLEANING_START = 50
INTEGER ADDRESS_CLEANING_TIME = 1

CHAR CLEANING_PAGE_NAME[] = '_CLEANING'


DEFINE_VARIABLE

INCLUDE 'Funzioni'

DEFINE_EVENT

BUTTON_EVENT[TP_CLEANING, BT_CLEANING_START]
{
    PUSH:
    {
	SEND_VTEXT (TP_CLEANING, ADDRESS_CLEANING_TIME, ITOA(30))
	OPEN_PAGE (TP_CLEANING,CLEANING_PAGE_NAME)
	TIMELINE_CREATE(CLEANING_TL_ID, TL_CLEANING, LENGTH_ARRAY(TL_CLEANING), TIMELINE_RELATIVE, TIMELINE_ONCE)
    }
}

TIMELINE_EVENT[CLEANING_TL_ID]
{
    SEND_VTEXT (TP_CLEANING, ADDRESS_CLEANING_TIME, ITOA(30 - TIMELINE.SEQUENCE))
    IF (TIMELINE.SEQUENCE == 30)
    {
	CLOSE_PAGE (TP_CLEANING,CLEANING_PAGE_NAME)
    }
}


DEFINE_PROGRAM

(*****************************************************************)
(*                       END OF PROGRAM                          *)
(*                                                               *)
(*         !!!  DO NOT PUT ANY CODE BELOW THIS COMMENT  !!!      *)
(*                                                               *)
(*****************************************************************)
