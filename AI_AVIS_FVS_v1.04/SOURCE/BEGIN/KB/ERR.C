// AVIS BATCH CBORD.SEED VERSION 1.00
// AVIS FILE: BEGIN/KB/ERR.C
// AVIS DEPENDS:
//   - BEGIN/KB/ERR.H
//   - BEGIN/BEGIN.H
//   - windows.h

#include <windows.h>
#include "BEGIN/BEGIN.H"
#include "BEGIN/KB/ERR.H"

// ------------------------------------------------------------
// IMPLEMENTATIONS
// ------------------------------------------------------------

static void KB_ERR_PRINT_impl(const char *msg)
{
    BEGIN.KB.LOG.PRINT(msg);
}

static void KB_ERR_MSGBOX_impl(const char *msg)
{
    MessageBoxA(NULL, msg, "KB.ERR", MB_OK | MB_ICONERROR);
    BEGIN.KB.LOG.PRINT(msg);
}

static void KB_ERR_FATAL_impl(const char *msg)
{
    MessageBoxA(NULL, msg, "KB.ERR:FATAL", MB_OK | MB_ICONSTOP);
    BEGIN.KB.LOG.PRINT("KB.ERR:FATAL TRIGGERED");
    BEGIN.KB.LOG.PRINT(msg);

    // Fatal shutdown
    ExitProcess(1);
}

// ------------------------------------------------------------
// GLOBAL OBJECT
// ------------------------------------------------------------

KB_ERR_ KB_ERR = {
    KB_ERR_PRINT_impl,
    KB_ERR_MSGBOX_impl,
    KB_ERR_FATAL_impl
};
