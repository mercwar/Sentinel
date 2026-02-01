// ------------------------------------------------------------
// AVIS BATCH CBORD.SEED VERSION 1.00
// AVIS FILE: WIN_MAIN.C
// ------------------------------------------------------------

#include "INT_ENUM.h"
#include "AVIS_LEGACY.H"
#include "WIN_MAIN.H"
#include "BEGIN/BEGIN.H"            // MUST come first
#include "BEGIN/SEED/SEED.H"        // SEED rooted to BEGIN.SEED
#include "BEGIN/SEED/SEED_EXEC.H"   // SEED activation declaration
#include "BEGIN/KB/REG_MSGBOX.H"    // struct visible before EXE include
#include "RETURN.H"

#include <stdlib.h>

// GLOBAL DISPATCH KEY
BEGIN_DISPATCH_KEY_TYPE BEGIN_DISPATCH_KEY = 0;

int WINAPI WinMain(HINSTANCE hInst, HINSTANCE hPrev, LPSTR lpCmd, int nShow)
{
    // BEGIN ROOT EXEC
    #include "BEGIN/BEGIN_EXE.C"

    // KB ROOT EXEC
    #include "BEGIN/KB/KB.c"

    // SEED EXECUTION CHAIN
    #include "BEGIN/SEED/SEED_EXE.C"  

    // DEVELOPMENT BLOCK
    #include "BEGIN/KB/REG_MSGBOX_EXE.C"

    // KB END / DISPATCH
    #include "BEGIN/KB/END.c"
    #include "BEGIN/KB/DISPATCH.c"

    KB_REG_MSGBOX.SHOW("DISPATCH COMPLETE — CLOSING PROGRAM");

    BEGIN.END(BEGIN_DISPATCH_KEY, TRUE, "LOG:ENDING PROGRAM DISPATCH");

    #include "RETURN_EXE.C"
    return AVIS_RETV;
}
