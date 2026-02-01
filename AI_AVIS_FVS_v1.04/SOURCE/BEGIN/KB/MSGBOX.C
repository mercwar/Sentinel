// AVIS BATCH CBORD.SEED VERSION 1.00
// AVIS FILE: BEGIN/KB/MSGBOX.C
// AVIS DEPENDS:
//   - BEGIN/KB/MSGBOX.H
//   - BEGIN.H
//   - windows.h

#include "BEGIN/BEGIN.H"
#include "BEGIN/KB/MSGBOX.H"

// ------------------------------------------------------------
// INTERNAL IMPLEMENTATIONS
// ------------------------------------------------------------

static void KB_MSGBOX_SHOW_impl(const char *text)
{
    MessageBoxA(NULL, text, "KB.MSGBOX", MB_OK | MB_ICONINFORMATION);
}

static void KB_MSGBOX_SHOW2_impl(const char *title, const char *text)
{
    MessageBoxA(NULL, text, title, MB_OK | MB_ICONINFORMATION);
}

static void KB_MSGBOX_LOG_impl(const char *text)
{
    BEGIN.KB.LOG.PRINT(text);
    MessageBoxA(NULL, text, "KB.MSGBOX.LOG", MB_OK | MB_ICONINFORMATION);
}

// ------------------------------------------------------------
// GLOBAL OBJECT
// ------------------------------------------------------------

KB_MSGBOX_ KB_MSGBOX = {
    KB_MSGBOX_SHOW_impl,
    KB_MSGBOX_SHOW2_impl,
    KB_MSGBOX_LOG_impl
};
