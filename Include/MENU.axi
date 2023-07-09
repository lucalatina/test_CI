PROGRAM_NAME='MENU'

DEFINE_MODULE 'PROGRESS_BAR' BAR1(vdv_PROGRESS_BAR_1, TP1_MENU)
DEFINE_MODULE 'PROGRESS_BAR' BAR2(vdv_PROGRESS_BAR_2, TP2_MENU)

DEFINE_CONSTANT

INTEGER TL_MENU_FB_ID = 24
LONG TL_MENU_FB_ARRAY[] = {300}

INTEGER BT_POWER = 100

INTEGER BT_TLC1 = 21
INTEGER BT_TLC2 = 22

INTEGER BT_ACCENSIONE = 101
INTEGER BT_SPEGNIMENTO = 102

INTEGER BT_MENU[] = {1,2,3,4,5,6}

DEFINE_VARIABLE

PERSISTENT INTEGER SISTEMA_ACCESO


DEFINE_START

TIMELINE_CREATE(TL_MENU_FB_ID,TL_MENU_FB_ARRAY,LENGTH_ARRAY(TL_MENU_FB_ARRAY),TIMELINE_RELATIVE,TIMELINE_REPEAT)

DEFINE_CALL 'MENU_FB'()
{
    //CALL 'MACRO_FB'()
    //CALL 'PA_FEEDBACK'()

    [TP1_MENU,BT_POWER] = (SISTEMA_ACCESO)
    [TP2_MENU,BT_POWER] = (SISTEMA_ACCESO)
}


DEFINE_CALL 'SALA_ON'()
{
    IF (!SISTEMA_ACCESO) {
	CALL 'PULSE_RELE_01'()
	CALL 'GLOBAL_WAITING'()
    }
}

DEFINE_CALL 'SALA_OFF'()
{
    IF (SISTEMA_ACCESO) {
	CALL 'PULSE_RELE_01'()
	CALL 'GLOBAL_WAITING'()
    }
}

DEFINE_CALL 'GLOBAL_WAITING'()
{
    CLOSE_ALL_PAGE (TP1_MENU)
    CLOSE_ALL_PAGE (TP2_MENU)
    OPEN_PAGE (TP1_MENU,'WAITING')
    OPEN_PAGE (TP2_MENU,'WAITING')
    SEND_COMMAND vdv_PROGRESS_BAR_1, 'START_PROGRESS=10'
    SEND_COMMAND vdv_PROGRESS_BAR_2, 'START_PROGRESS=10'
    WAIT 100
    {
	CLOSE_PAGE (TP1_MENU,'WAITING')
	CLOSE_PAGE (TP2_MENU,'WAITING')
    }
}

DEFINE_EVENT

CHANNEL_EVENT[DV_IO,1]
{
    ON:
    {
	SISTEMA_ACCESO = 1
    }
    OFF:
    {
	SISTEMA_ACCESO = 0
    }
}

TIMELINE_EVENT[TL_MENU_FB_ID]
{
    CALL 'MENU_FB'()
}

DATA_EVENT[TP1_MENU]
{
    ONLINE:
    {
	STACK_VAR INTEGER J
	GOTO_PAGE (TP1_MENU,'LOGO')
	//SEND_LEVEL
	CALL 'MIMO_PANEL_FB'()
	//CALL 'LINDY_PANEL_FB'()
	
	FOR(J=1;J<=12;J++)
	{
	    SEND_LEVEL vTP_MIMO1212, BT_MIMO_LEVEL_IN[J], MIMO_INPUT_LEVEL[J]
	    SEND_LEVEL vTP_MIMO1212, BT_MIMO_LEVEL_OUT[J], MIMO_OUTPUT_LEVEL[J]
	}
    }
}

BUTTON_EVENT[TP1_MENU,BT_POWER]
{
    PUSH:
    {
	IF (SISTEMA_ACCESO)
	{
	    OPEN_PAGE (TP1_MENU,'SPEGNIMENTO')
	}
	ELSE
	{
	    OPEN_PAGE (TP1_MENU,'ACCENSIONE')
	}
    }
}

BUTTON_EVENT[TP1_MENU,BT_ACCENSIONE]
{
    PUSH:
    {
	CALL 'SALA_ON'()
    }
}

BUTTON_EVENT[TP1_MENU,BT_SPEGNIMENTO]
{
    PUSH:
    {
	CALL 'SALA_OFF'()
    }
}


/// TP 2


DATA_EVENT[TP2_MENU]
{
    ONLINE:
    {
	STACK_VAR INTEGER J
	GOTO_PAGE (TP2_MENU,'LOGO')
	//SEND_LEVEL
	CALL 'MIMO_PANEL_FB'()
	//CALL 'LINDY_PANEL_FB'()
	
	FOR(J=1;J<=12;J++)
	{
	    SEND_LEVEL vTP_MIMO1212, BT_MIMO_LEVEL_IN[J], MIMO_INPUT_LEVEL[J]
	    SEND_LEVEL vTP_MIMO1212, BT_MIMO_LEVEL_OUT[J], MIMO_OUTPUT_LEVEL[J]
	}
    }
}

BUTTON_EVENT[TP2_MENU,BT_POWER]
{
    PUSH:
    {
	IF (SISTEMA_ACCESO)
	{
	    OPEN_PAGE (TP2_MENU,'SPEGNIMENTO')
	}
	ELSE
	{
	    OPEN_PAGE (TP2_MENU,'ACCENSIONE')
	}
    }
}

BUTTON_EVENT[TP2_MENU,BT_ACCENSIONE]
{
    PUSH:
    {
	CALL 'SALA_ON'()
    }
}

BUTTON_EVENT[TP2_MENU,BT_SPEGNIMENTO]
{
    PUSH:
    {
	CALL 'SALA_OFF'()
    }
}


