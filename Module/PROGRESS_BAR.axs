MODULE_NAME='PROGRESS_BAR'(DEV vdv_DEVICE, DEV TP_DEVICE)

DEFINE_VARIABLE

CHAR PROGRESS_BAR_DEBUG = 0

DEFINE_CALL 'PROGRESS_BAR_TP_5'(){

    SEND_LEVEL TP_DEVICE, 1, 0
    
    WAIT 2 SEND_LEVEL TP_DEVICE, 1, 1
    WAIT 4 SEND_LEVEL TP_DEVICE, 1, 2
    WAIT 6 SEND_LEVEL TP_DEVICE, 1, 3
    WAIT 8 SEND_LEVEL TP_DEVICE, 1, 4
    WAIT 10 SEND_LEVEL TP_DEVICE, 1, 5
    WAIT 12 SEND_LEVEL TP_DEVICE, 1, 6
    WAIT 14 SEND_LEVEL TP_DEVICE, 1, 7
    WAIT 16 SEND_LEVEL TP_DEVICE, 1, 8
    WAIT 18 SEND_LEVEL TP_DEVICE, 1, 9
    WAIT 20 SEND_LEVEL TP_DEVICE, 1, 10
    
    WAIT 22 SEND_LEVEL TP_DEVICE, 1, 11
    WAIT 24 SEND_LEVEL TP_DEVICE, 1, 12
    WAIT 26 SEND_LEVEL TP_DEVICE, 1, 13
    WAIT 28 SEND_LEVEL TP_DEVICE, 1, 14
    WAIT 30 SEND_LEVEL TP_DEVICE, 1, 15
    WAIT 32 SEND_LEVEL TP_DEVICE, 1, 16
    WAIT 34 SEND_LEVEL TP_DEVICE, 1, 17
    WAIT 36 SEND_LEVEL TP_DEVICE, 1, 18
    WAIT 38 SEND_LEVEL TP_DEVICE, 1, 19
    WAIT 40 SEND_LEVEL TP_DEVICE, 1, 20
    
    WAIT 42 SEND_LEVEL TP_DEVICE, 1, 21
    WAIT 44 SEND_LEVEL TP_DEVICE, 1, 22
    WAIT 46 SEND_LEVEL TP_DEVICE, 1, 23
    WAIT 48 SEND_LEVEL TP_DEVICE, 1, 24
    WAIT 50 SEND_LEVEL TP_DEVICE, 1, 25
}

DEFINE_CALL 'PROGRESS_BAR_TP_10'(){

    SEND_LEVEL TP_DEVICE, 1, 0
    
    WAIT 4 SEND_LEVEL TP_DEVICE, 1, 1
    WAIT 8 SEND_LEVEL TP_DEVICE, 1, 2
    WAIT 12 SEND_LEVEL TP_DEVICE, 1, 3
    WAIT 16 SEND_LEVEL TP_DEVICE, 1, 4
    WAIT 20 SEND_LEVEL TP_DEVICE, 1, 5
    WAIT 24 SEND_LEVEL TP_DEVICE, 1, 6
    WAIT 28 SEND_LEVEL TP_DEVICE, 1, 7
    WAIT 32 SEND_LEVEL TP_DEVICE, 1, 8
    WAIT 36 SEND_LEVEL TP_DEVICE, 1, 9
    WAIT 40 SEND_LEVEL TP_DEVICE, 1, 10
    
    WAIT 44 SEND_LEVEL TP_DEVICE, 1, 11
    WAIT 48 SEND_LEVEL TP_DEVICE, 1, 12
    WAIT 52 SEND_LEVEL TP_DEVICE, 1, 13
    WAIT 56 SEND_LEVEL TP_DEVICE, 1, 14
    WAIT 60 SEND_LEVEL TP_DEVICE, 1, 15
    WAIT 64 SEND_LEVEL TP_DEVICE, 1, 16
    WAIT 68 SEND_LEVEL TP_DEVICE, 1, 17
    WAIT 72 SEND_LEVEL TP_DEVICE, 1, 18
    WAIT 76 SEND_LEVEL TP_DEVICE, 1, 19
    WAIT 80 SEND_LEVEL TP_DEVICE, 1, 20
    
    WAIT 84 SEND_LEVEL TP_DEVICE, 1, 21
    WAIT 88 SEND_LEVEL TP_DEVICE, 1, 22
    WAIT 92 SEND_LEVEL TP_DEVICE, 1, 23
    WAIT 96 SEND_LEVEL TP_DEVICE, 1, 24
    WAIT 100 SEND_LEVEL TP_DEVICE, 1, 25
}

DEFINE_CALL 'PROGRESS_BAR_TP_20'(){

    SEND_LEVEL TP_DEVICE, 1, 0
    
    WAIT 8 SEND_LEVEL TP_DEVICE, 1, 1
    WAIT 16 SEND_LEVEL TP_DEVICE, 1, 2
    WAIT 24 SEND_LEVEL TP_DEVICE, 1, 3
    WAIT 32 SEND_LEVEL TP_DEVICE, 1, 4
    WAIT 40 SEND_LEVEL TP_DEVICE, 1, 5
    WAIT 48 SEND_LEVEL TP_DEVICE, 1, 6
    WAIT 56 SEND_LEVEL TP_DEVICE, 1, 7
    WAIT 64 SEND_LEVEL TP_DEVICE, 1, 8
    WAIT 72 SEND_LEVEL TP_DEVICE, 1, 9
    WAIT 80 SEND_LEVEL TP_DEVICE, 1, 10
    
    WAIT 88 SEND_LEVEL TP_DEVICE, 1, 11
    WAIT 96 SEND_LEVEL TP_DEVICE, 1, 12
    WAIT 104 SEND_LEVEL TP_DEVICE, 1, 13
    WAIT 112 SEND_LEVEL TP_DEVICE, 1, 14
    WAIT 120 SEND_LEVEL TP_DEVICE, 1, 15
    WAIT 128 SEND_LEVEL TP_DEVICE, 1, 16
    WAIT 136 SEND_LEVEL TP_DEVICE, 1, 17
    WAIT 144 SEND_LEVEL TP_DEVICE, 1, 18
    WAIT 152 SEND_LEVEL TP_DEVICE, 1, 19
    WAIT 160 SEND_LEVEL TP_DEVICE, 1, 20
    
    WAIT 168 SEND_LEVEL TP_DEVICE, 1, 21
    WAIT 176 SEND_LEVEL TP_DEVICE, 1, 22
    WAIT 184 SEND_LEVEL TP_DEVICE, 1, 23
    WAIT 192 SEND_LEVEL TP_DEVICE, 1, 24
    WAIT 200 SEND_LEVEL TP_DEVICE, 1, 25
}

DEFINE_CALL 'PROGRESS_BAR_TP_30'(){

    SEND_LEVEL TP_DEVICE, 1, 0
    
    WAIT 12 SEND_LEVEL TP_DEVICE, 1, 1
    WAIT 24 SEND_LEVEL TP_DEVICE, 1, 2
    WAIT 36 SEND_LEVEL TP_DEVICE, 1, 3
    WAIT 48 SEND_LEVEL TP_DEVICE, 1, 4
    WAIT 60 SEND_LEVEL TP_DEVICE, 1, 5
    WAIT 72 SEND_LEVEL TP_DEVICE, 1, 6
    WAIT 84 SEND_LEVEL TP_DEVICE, 1, 7
    WAIT 96 SEND_LEVEL TP_DEVICE, 1, 8
    WAIT 108 SEND_LEVEL TP_DEVICE, 1, 9
    WAIT 120 SEND_LEVEL TP_DEVICE, 1, 10
    
    WAIT 132 SEND_LEVEL TP_DEVICE, 1, 11
    WAIT 144 SEND_LEVEL TP_DEVICE, 1, 12
    WAIT 156 SEND_LEVEL TP_DEVICE, 1, 13
    WAIT 168 SEND_LEVEL TP_DEVICE, 1, 14
    WAIT 180 SEND_LEVEL TP_DEVICE, 1, 15
    WAIT 192 SEND_LEVEL TP_DEVICE, 1, 16
    WAIT 204 SEND_LEVEL TP_DEVICE, 1, 17
    WAIT 216 SEND_LEVEL TP_DEVICE, 1, 18
    WAIT 228 SEND_LEVEL TP_DEVICE, 1, 19
    WAIT 240 SEND_LEVEL TP_DEVICE, 1, 20
    
    WAIT 252 SEND_LEVEL TP_DEVICE, 1, 21
    WAIT 264 SEND_LEVEL TP_DEVICE, 1, 22
    WAIT 276 SEND_LEVEL TP_DEVICE, 1, 23
    WAIT 288 SEND_LEVEL TP_DEVICE, 1, 24
    WAIT 300 SEND_LEVEL TP_DEVICE, 1, 25
}

DEFINE_CALL 'PROGRESS_BAR_TP_40'(){

    SEND_LEVEL TP_DEVICE, 1, 0
    
    WAIT 16 SEND_LEVEL TP_DEVICE, 1, 1
    WAIT 32 SEND_LEVEL TP_DEVICE, 1, 2
    WAIT 48 SEND_LEVEL TP_DEVICE, 1, 3
    WAIT 64 SEND_LEVEL TP_DEVICE, 1, 4
    WAIT 80 SEND_LEVEL TP_DEVICE, 1, 5
    WAIT 96 SEND_LEVEL TP_DEVICE, 1, 6
    WAIT 112 SEND_LEVEL TP_DEVICE, 1, 7
    WAIT 128 SEND_LEVEL TP_DEVICE, 1, 8
    WAIT 144 SEND_LEVEL TP_DEVICE, 1, 9
    WAIT 160 SEND_LEVEL TP_DEVICE, 1, 10
    
    WAIT 176 SEND_LEVEL TP_DEVICE, 1, 11
    WAIT 192 SEND_LEVEL TP_DEVICE, 1, 12
    WAIT 208 SEND_LEVEL TP_DEVICE, 1, 13
    WAIT 224 SEND_LEVEL TP_DEVICE, 1, 14
    WAIT 240 SEND_LEVEL TP_DEVICE, 1, 15
    WAIT 256 SEND_LEVEL TP_DEVICE, 1, 16
    WAIT 272 SEND_LEVEL TP_DEVICE, 1, 17
    WAIT 288 SEND_LEVEL TP_DEVICE, 1, 18
    WAIT 304 SEND_LEVEL TP_DEVICE, 1, 19
    WAIT 320 SEND_LEVEL TP_DEVICE, 1, 20
    
    WAIT 336 SEND_LEVEL TP_DEVICE, 1, 21
    WAIT 352 SEND_LEVEL TP_DEVICE, 1, 22
    WAIT 368 SEND_LEVEL TP_DEVICE, 1, 23
    WAIT 384 SEND_LEVEL TP_DEVICE, 1, 24
    WAIT 400 SEND_LEVEL TP_DEVICE, 1, 25
}

DEFINE_EVENT

DATA_EVENT[vdv_DEVICE]
{
    ONLINE:
    {
	IF (PROGRESS_BAR_DEBUG) SEND_STRING 0, "'PROGRESS_BAR - vdv_DEVICE ONLINE'"
    }
    OFFLINE:
    {
	IF (PROGRESS_BAR_DEBUG) SEND_STRING 0, "'PROGRESS_BAR - vdv_DEVICE OFFLINE'"
    }
    COMMAND:
    {
	IF (PROGRESS_BAR_DEBUG) SEND_STRING 0, "'PROGRESS_BAR - vdv_DEVICE RECEIVED COMMAND: ', DATA.TEXT"
	SELECT
	{
	    ACTIVE (FIND_STRING(DATA.TEXT,"'START_PROGRESS=40'",1)) :
	    {
		CALL 'PROGRESS_BAR_TP_40'()
	    }
	    ACTIVE (FIND_STRING(DATA.TEXT,"'START_PROGRESS=30'",1)) :
	    {
		CALL 'PROGRESS_BAR_TP_30'()
	    }
	    ACTIVE (FIND_STRING(DATA.TEXT,"'START_PROGRESS=20'",1)) :
	    {
		CALL 'PROGRESS_BAR_TP_20'()
	    }
	    ACTIVE (FIND_STRING(DATA.TEXT,"'START_PROGRESS=10'",1)) :
	    {
		CALL 'PROGRESS_BAR_TP_10'()
	    }
	    ACTIVE (FIND_STRING(DATA.TEXT,"'START_PROGRESS=5'",1)) :
	    {
		CALL 'PROGRESS_BAR_TP_5'()
	    }
	    ACTIVE (FIND_STRING(DATA.TEXT,"'PASSTHRUGH='",1)) :
	    {
		REMOVE_STRING(DATA.TEXT,"'PASSTHRUGH='",1)
		IF (PROGRESS_BAR_DEBUG) SEND_STRING 0, "'PROGRESS_BAR PASSTHRUGH: ', DATA.TEXT"
	    }
	    ACTIVE (1) :
	    {
	    SWITCH (DATA.TEXT)
		{
		CASE 'REINIT':
		{
		    REBUILD_EVENT()
		}
		CASE 'DEBUG=ENABLE' : ON[PROGRESS_BAR_DEBUG]
		CASE 'DEBUG=DISABLE' : OFF[PROGRESS_BAR_DEBUG]
		}
	    }
	}
    }
}