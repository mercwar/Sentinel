// AVIS BATCH CBORD.SEED VERSION 1.00
// AVIS FILE: WIN_MAIN.C
// AVIS DEPENDS:
//   - WIN_MAIN.H
//   - BEGIN/BEGIN.H
//   - RETURN.H
//   - BEGIN/BEGIN.C
//   - BEGIN/KB/KB.c
//   - BEGIN/KB/REG_MSGBOX.C
//   - BEGIN/KB/END.c
//   - BEGIN/KB/DISPATCH.c
//   - RETURN.c

#include "WIN_MAIN.H"
#include "BEGIN/BEGIN.H"          // MUST come first
#include "BEGIN/KB/REG_MSGBOX.H"  // struct visible before EXE include
#include "RETURN.H"

// GLOBAL DISPATCH KEY
BEGIN_DISPATCH_KEY_TYPE BEGIN_DISPATCH_KEY = 0;

int WINmain(void)
{
    #include "BEGIN/BEGIN_EXE.C"

    // KB ROOT EXEC
    #include "BEGIN/KB/KB.c"

    // DEVELOPMENT BLOCK
    #include "BEGIN/KB/REG_MSGBOX_EXE.C"

    // KB END / DISPATCH
    #include "BEGIN/KB/END.c"
    #include "BEGIN/KB/DISPATCH.c"

    KB_REG_MSGBOX.SHOW("DISPATCH COMPLETE — CLOSING PROGRAM");

    BEGIN.END(BEGIN_DISPATCH_KEY, TRUE, "LOG:ENDING PROGRAM DISPATCH");

    #include "RETURN_EXE.C"
}
