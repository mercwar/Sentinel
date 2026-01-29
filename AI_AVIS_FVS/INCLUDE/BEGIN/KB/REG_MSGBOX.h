// AVIS BATCH CBORD.SEED VERSION 1.00
// AVIS FILE: BEGIN/KB/REG_MSGBOX.H
// AVIS DEPENDS:
//   - windows.h
//   - BEGIN.H
//   - BEGIN/KB/REG_MSGBOX.C

#ifndef KB_REG_MSGBOX_H
#define KB_REG_MSGBOX_H

#include <windows.h>
#include "BEGIN/BEGIN.H"

// ------------------------------------------------------------
// KB.REG_MSGBOX CLASS STRUCTURE
// ------------------------------------------------------------
typedef struct _KB_REG_MSGBOX_ {
    void (*SHOW)(const char *text);
    void (*SHOW2)(const char *title, const char *text);
    void (*LOG)(const char *text);
} KB_REG_MSGBOX_;

// ------------------------------------------------------------
// GLOBAL INSTANCE
// ------------------------------------------------------------
extern KB_REG_MSGBOX_ KB_REG_MSGBOX;

#endif // KB_REG_MSGBOX_H
