// AVIS BATCH CBORD.SEED VERSION 1.00
// AVIS FILE: BEGIN/KB/ERR.H
// AVIS DEPENDS:
//   - windows.h
//   - BEGIN/BEGIN.H
//   - BEGIN/KB/ERR.C

#ifndef KB_ERR_H
#define KB_ERR_H

#include <windows.h>
#include "BEGIN/BEGIN.H"

// ------------------------------------------------------------
// KB.ERR CLASS STRUCTURE
// ------------------------------------------------------------
typedef struct _KB_ERR_ {
    void (*PRINT)(const char *msg);
    void (*MSGBOX)(const char *msg);
    void (*FATAL)(const char *msg);
} KB_ERR_;

// Global instance
extern KB_ERR_ KB_ERR;

#endif
