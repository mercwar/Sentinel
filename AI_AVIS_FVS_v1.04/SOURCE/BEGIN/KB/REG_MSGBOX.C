// AVIS BATCH CBORD.SEED VERSION 1.00
// AVIS FILE: BEGIN/KB/REG_MSGBOX.C

#include <windows.h>
#include "BEGIN/BEGIN.H"
#include "BEGIN/KB/REG_MSGBOX.H"

static void KB_REG_MSGBOX_SHOW_impl(const char *text)
{
    MessageBoxA(NULL, text, "KB.REG_MSGBOX", MB_OK | MB_ICONINFORMATION);
}

static void KB_REG_MSGBOX_SHOW2_impl(const char *title, const char *text)
{
    MessageBoxA(NULL, text, title, MB_OK | MB_ICONINFORMATION);
}

static void KB_REG_MSGBOX_LOG_impl(const char *text)
{
    BEGIN.KB.LOG.PRINT(text);
    MessageBoxA(NULL, text, "KB.REG_MSGBOX.LOG", MB_OK | MB_ICONINFORMATION);
}

KB_REG_MSGBOX_ KB_REG_MSGBOX = {
    KB_REG_MSGBOX_SHOW_impl,
    KB_REG_MSGBOX_SHOW2_impl,
    KB_REG_MSGBOX_LOG_impl
};
