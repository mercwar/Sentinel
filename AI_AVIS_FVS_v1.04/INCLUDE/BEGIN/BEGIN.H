// ------------------------------------------------------------
// AVIS BATCH CBORD.SEED VERSION 1.00
// AVIS FILE: BEGIN/BEGIN.H
// AVIS ROLE: BEGIN root object with SEED support shipped
// AVIS NOTE: SEED subsystem included but not expanded
// ------------------------------------------------------------

#ifndef BEGIN_H
#define BEGIN_H

#include <windows.h>
#include <stdio.h>
#include "WIN_MAIN.H"
#include "BEGIN/MASTER/MASTER.H"

// ------------------------------------------------------------
// FORWARD DECLARATION: SEED OBJECT (identity defined elsewhere)
// ------------------------------------------------------------
typedef struct _SEED_ SEED_;

// ------------------------------------------------------------
// BEGIN ROOT OBJECT STRUCTURE (SHIPPED WITH SEED SUPPORT)
// ------------------------------------------------------------

typedef struct _BEGIN_ BEGIN_;

struct _BEGIN_ {
    // --------------------------------------------------------
    // ADO: Address / Pointer / Buffer payload registry
    // --------------------------------------------------------
    unsigned long ADDR_SEED;
    unsigned long ADDR_MASTER;
    unsigned long ADDR_MASTER_CONVERT;
    unsigned long ADDR_MASTER_COMBILE;

    unsigned long PTR_SEED;
    unsigned long PTR_MASTER;
    unsigned long PTR_MASTER_CONVERT;
    unsigned long PTR_MASTER_COMBILE;

    int BUF_SEED;
    int BUF_MASTER;
    int BUF_MASTER_CONVERT;
    int BUF_MASTER_COMBILE;

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

        void *REG_MSGBOX;
    } KB;

    // --------------------------------------------------------
    // SEED subsystem (SHIPPED, NOT EXPANDED)
    // --------------------------------------------------------
    // BEGIN ships with SEED pointer only.
    // SEED identity (.ID, .NAME, etc.) lives in SEED_ object.
    // FVS sees SEED support but no SEED metadata.
    // --------------------------------------------------------
    SEED_ *SEED;
// --------------------------------------------------------
// MASTER subsystem (SHIPPED, NOT EXPANDED)
// --------------------------------------------------------
// BEGIN ships with MASTER pointer only.
// MASTER identity and logic live in MASTER_ object.
// FVS sees MASTER support but no MASTER metadata.
// --------------------------------------------------------
MASTER_ *MASTER;

};

// ------------------------------------------------------------
// GLOBAL BEGIN INSTANCE
// ------------------------------------------------------------
extern BEGIN_ BEGIN;

#endif // BEGIN_H
