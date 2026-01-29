// AVIS BATCH CBORD.SEED VERSION 1.00
// AVIS FILE: BEGIN/KB/MSGBOX.H
// AVIS DEPENDS:
//   - windows.h
//   - BEGIN.H
//   - BEGIN/KB/MSGBOX.C

#ifndef KB_MSGBOX_H
#define KB_MSGBOX_H

#include <windows.h>
#include "BEGIN/BEGIN.H"

// KB.MSGBOX object
typedef struct _KB_MSGBOX_ {
    void (*SHOW)(const char *text);
    void (*SHOW2)(const char *title, const char *text);
    void (*LOG)(const char *text);
} KB_MSGBOX_;

// Global instance
extern KB_MSGBOX_ KB_MSGBOX;

#endif
