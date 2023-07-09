PROGRAM_NAME='KRAMER'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 23/06/2015  AT: 09:00:25        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:    1.0                                     *)
(***********************************************************)
(*
    $History: $ First Commit
    KRAMER PROTOCOL AND GUI'S STUFF
    
    Author: Luca PERER
    
    CAVO DELLA MATRICE DRITTO!
*)
(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

INTEGER KRAMER_MAX_BUFFER_SIZE = 1024
INTEGER KRAMER_MAX_OUTPUTS = 4
INTEGER KRAMER_MAX_INPUTS = 8


//+1 perch� la 17 � il test pattern (T1)
char MATRIX_LABEL[KRAMER_MAX_INPUTS + 1][15] = {'TLC 1','TLC 2','TLC 3','IN 4','IN 5','IN 6','IN 7','IN 8','TEST'}


INTEGER BT_KRAMER_CHANNEL_INPUTS[KRAMER_MAX_INPUTS] = {1,2,3,4,5,6,7,8}

INTEGER BT_KRAMER_CHANNEL_OUTPUTS[KRAMER_MAX_OUTPUTS] = {33,34,35,36}

INTEGER BUTTON_RELOAD_KRAMER = 21

DEFINE_VARIABLE

//VARIABILE CONTATORE INTERNO AL CODICE
INTEGER COUNT = 1

//VARIABILE DI DEBUG PER VISUALIZZARE I LOG IN TEMPO REALE
INTEGER DEBUG_KRAMER = 1

//VARIABILE CONTATORE INTERNO AL CODICE, PER LETTURA STATO COMPLETO
ReadOutTies = 0

//BUFFER SERIALE PER IL DEVICE KRAMER
VOLATILE KRAMER_sBuffer[KRAMER_MAX_BUFFER_SIZE]       // Data Buffer for the actual device



//VARIABILE PER INGRESSO SCELTO
INTEGER MAT_VIDEO_IN_SCELTO_1

//VARIABILE PER USCITA SCELTA
INTEGER MAT_VIDEO_OUT_SCELTO_1

//VARIABILE PER TESTO LABEL USCITA
CHAR MAT_VIDEO_DESCRIZIONE_1[15]



//VARIABILE PER MEMORIZZAZIONE STATO MATRICE
INTEGER MAT_VIDEO_IN_OUT[KRAMER_MAX_OUTPUTS] = {0,0,0,0}


DEFINE_MUTUALLY_EXCLUSIVE

DEFINE_FUNCTION AGG_KRAMER(DEV PORTA)
{
    local_var integer i
    LOCAL_VAR CHAR DESC[10]
    local_var dev VTP
    
    for (i=1;i<=KRAMER_MAX_OUTPUTS;i++)
    {
	IF (MAT_VIDEO_IN_OUT[i]>0)
	   DESC = MATRIX_LABEL[MAT_VIDEO_IN_OUT[i]] 
	ELSE
	    DESC = "'OUT ',ITOA(i)"
	    
	SEND_VTEXT(PORTA,BT_KRAMER_CHANNEL_OUTPUTS[i],DESC)
    }
}

DEFINE_CALL 'CLEAR_KRAMER' (DEV PORTA, integer OUT)
{
    SEND_STRING PORTA,"$01,$80,$80 + OUT,$81"
    IF (PORTA == KRAMER) MAT_VIDEO_IN_OUT[OUT] = 0
}

DEFINE_CALL 'KRAMER_CONTROL' (DEV PORTA, INTEGER IN, INTEGER OUT)
{
    IF (IN > 0){
	SEND_STRING PORTA,"$01,$80 + IN,$80 + OUT,$81"
	SEND_KRAMER_VTEXT(BT_KRAMER_CHANNEL_OUTPUTS[OUT],MATRIX_LABEL[IN])
    }
    ELSE {
	SEND_STRING PORTA,"$01,$80,$80 + OUT,$81"
	SEND_KRAMER_VTEXT(BT_KRAMER_CHANNEL_OUTPUTS[OUT],ITOA(IN))
    }
    IF (PORTA == KRAMER) MAT_VIDEO_IN_OUT[OUT] = IN
}

DEFINE_CALL 'KRAMER_STORE_PRESET' (DEV PORTA, INTEGER INDEX)
{
    SEND_STRING PORTA,"$03,$80 + INDEX,$80,$81"
}

DEFINE_CALL 'KRAMER_RECALL_PRESET' (DEV PORTA, INTEGER INDEX)
{
    SEND_STRING PORTA,"$04,$80 + INDEX,$80,$81"
}

DEFINE_CALL 'GET OUT KRAMER' (INTEGER OUTPUT)
{
    SEND_STRING KRAMER,"$05,$80,$80 + OUTPUT,$81"
}

DEFINE_FUNCTION SEND_KRAMER_VTEXT(INTEGER CHAN, CHAR LABEL[]){
    STACK_VAR INTEGER P
    FOR(P=1;P<=LENGTH_ARRAY(vTP_KRAMER);P++)
    {
	SEND_VTEXT(vTP_KRAMER[P],CHAN,LABEL)
    }
}

// AGGIORNARE!!!!
define_call 'loop kramer' (integer out)
{
    STACK_VAR INTEGER P
    ReadOutTies = out
    IF (out<KRAMER_MAX_OUTPUTS) 
    {
	ReadOutTies++;
	CALL 'GET OUT KRAMER' (ReadOutTies)
    }
    else
    {
	ReadOutTies=0;
	FOR(P=1;P<=LENGTH_ARRAY(vTP_KRAMER);P++)
	{
	    AGG_KRAMER(vTP_KRAMER[P])
	}
    }
}

DEFINE_CALL 'PARSE BUFFER KRAMER' ( sBuff[] )
STACK_VAR CHAR sTemp[4]
LOCAL_VAR INTEGER nTemp_out
LOCAL_VAR INTEGER nTemp_in
{
    sTemp = LEFT_STRING(sBuff,4)
    SELECT
    {
	ACTIVE (sTemp[1] == "$45"):
	{
	    nTemp_in = sTemp[3] - 128 
	    nTemp_out = ReadOutTies
	    MAT_VIDEO_IN_OUT[nTemp_out] = nTemp_in
	    IF (nTemp_in > 0)
		SEND_KRAMER_VTEXT(BT_KRAMER_CHANNEL_OUTPUTS[nTemp_out],MATRIX_LABEL[nTemp_in])
	    ELSE
		SEND_KRAMER_VTEXT(BT_KRAMER_CHANNEL_OUTPUTS[nTemp_out],"'OUT ', ITOA(nTemp_out)")
		
	    call 'loop kramer'(ReadOutTies)
	}
	ACTIVE (sTemp[1] == "$41"):
	{
	    nTemp_in = sTemp[2] - 128
	    nTemp_out = sTemp[3] - 128
	    
	    MAT_VIDEO_IN_OUT[nTemp_out] = nTemp_in
	}
    }
    CLEAR_BUFFER sBuff
}

DEFINE_EVENT

DATA_EVENT[KRAMER]
{
  ONLINE :                          // Communication Parameters
  {
    SEND_COMMAND KRAMER,"'SET BAUD 9600,N,8,1 485 DISABLED'"
    SEND_COMMAND KRAMER,"'HSOFF'"
    SEND_COMMAND KRAMER,"'XOFF'"
  }
  STRING  :
  {
    IF( DEBUG_KRAMER )
    {
      SEND_STRING 0,"'KRAMER - FROM DEVICE: ',EXPLODE_HEX_STRING(DATA.TEXT)"
    }  
     WHILE( LENGTH_STRING( KRAMER_sBuffer ) )
    {
	CALL 'PARSE BUFFER KRAMER' ( KRAMER_sBuffer)
    }  
    CLEAR_BUFFER DATA.TEXT
  }
}


(***********************************************************)
(*                      GUI EVENTS                         *)
(***********************************************************)

// TOUCH PANEL 
BUTTON_EVENT[vTP_KRAMER, BT_KRAMER_CHANNEL_OUTPUTS]
{
    PUSH:
    {
	IF (MAT_VIDEO_IN_SCELTO_1 > 0){
	    MAT_VIDEO_OUT_SCELTO_1 = GET_LAST(BT_KRAMER_CHANNEL_OUTPUTS)
	    SEND_KRAMER_VTEXT(BT_KRAMER_CHANNEL_OUTPUTS[MAT_VIDEO_OUT_SCELTO_1],MAT_VIDEO_DESCRIZIONE_1)
	    CALL 'KRAMER_CONTROL' (KRAMER,MAT_VIDEO_IN_SCELTO_1,MAT_VIDEO_OUT_SCELTO_1)
	} ELSE {
	    MAT_VIDEO_OUT_SCELTO_1 = GET_LAST(BT_KRAMER_CHANNEL_OUTPUTS)
	    SEND_KRAMER_VTEXT(BT_KRAMER_CHANNEL_OUTPUTS[MAT_VIDEO_OUT_SCELTO_1],'')
	    CALL 'CLEAR_KRAMER' (KRAMER,MAT_VIDEO_OUT_SCELTO_1)
	    //CALL 'KRAMER_CONTROL' (KRAMER,MAT_VIDEO_IN_SCELTO_1,MAT_VIDEO_OUT_SCELTO_1)
	}
    }
}

BUTTON_EVENT[vTP_KRAMER, BT_KRAMER_CHANNEL_INPUTS]
{
    PUSH:
    {
	LOCAL_VAR INTEGER BT_LAST
	
	OFF[vTP_KRAMER,BT_KRAMER_CHANNEL_INPUTS]
	ON[vTP_KRAMER,PUSH_CHANNEL]
	BT_LAST = GET_LAST(BT_KRAMER_CHANNEL_INPUTS)
	IF (MAT_VIDEO_IN_SCELTO_1 == BT_LAST)
	{
	    MAT_VIDEO_IN_SCELTO_1 = 0
	    OFF[vTP_KRAMER,BT_KRAMER_CHANNEL_INPUTS]
	}
	ELSE
	{
	    MAT_VIDEO_IN_SCELTO_1 = GET_LAST(BT_KRAMER_CHANNEL_INPUTS)
	    MAT_VIDEO_DESCRIZIONE_1 = MATRIX_LABEL[MAT_VIDEO_IN_SCELTO_1]
	}
    }
}


BUTTON_EVENT[TP1_MENU, BUTTON_RELOAD_KRAMER]
{
    PUSH:
    {
	AGG_KRAMER(vTP_KRAMER[1])
    }
}

BUTTON_EVENT[TP1_MENU, BUTTON_RELOAD_KRAMER]
{
    PUSH:
    {
	AGG_KRAMER(vTP_KRAMER[2])
    }
}


define_start
CREATE_BUFFER KRAMER,KRAMER_sBuffer

call 'loop kramer'(0)