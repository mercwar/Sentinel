// AVIS BATCH CBORD.SEED VERSION 1.00
// AVIS FILE: BEGIN/BEGIN.H
// AVIS DEPENDS:
//   - windows.h
//   - stdio.h
//   - WIN_MAIN.H (for BEGIN_DISPATCH_KEY_TYPE)

#ifndef BEGIN_H
#define BEGIN_H

#include <windows.h>
#include <stdio.h>
#include "WIN_MAIN.H"

// ------------------------------------------------------------
// BEGIN ROOT OBJECT STRUCTURE
// ------------------------------------------------------------

typedef struct _BEGIN_ BEGIN_;

struct _BEGIN_ {

    // LOG subsystem
    struct {
        void (*PRINT)(const char *msg);
    } LOG;

    // BEGIN lifecycle
    void (*INI)(void);
    void (*LOAD)(void);
    void (*PROC)(void);
    void (*DISPATCH)(void);
    void (*END)(BEGIN_DISPATCH_KEY_TYPE key, BOOL ok, const char *msg);

    // KB subsystem
    struct {
        struct {
            void (*PRINT)(const char *msg);
        } LOG;

        // KB classes register here
        // (REG_MSGBOX will attach here)
        void *REG_MSGBOX;
    } KB;
};

// ------------------------------------------------------------
// GLOBAL BEGIN INSTANCE
// ------------------------------------------------------------
extern BEGIN_ BEGIN;

#endif // BEGIN_H
