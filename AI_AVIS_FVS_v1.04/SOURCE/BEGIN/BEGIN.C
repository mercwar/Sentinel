// ------------------------------------------------------------
// AVIS BATCH CBORD.SEED VERSION 1.00
// AVIS FILE: BEGIN/BEGIN.C
// AVIS ROLE: BEGIN root implementation (SEED support shipped)
// AVIS NOTE: SEED pointer shipped but not expanded
// ------------------------------------------------------------

#include "BEGIN/BEGIN.H"

// ------------------------------------------------------------
// INTERNAL IMPLEMENTATIONS
// ------------------------------------------------------------

// LOG.PRINT
static void BEGIN_LOG_PRINT_impl(const char *msg)
{
    OutputDebugStringA(msg);
    OutputDebugStringA("\n");
}

// BEGIN.INI
static void BEGIN_INI_impl(void)
{
    BEGIN.LOG.PRINT("BEGIN.INI:READY");
}

// BEGIN.LOAD
static void BEGIN_LOAD_impl(void)
{
    BEGIN.LOG.PRINT("BEGIN.LOAD:READY");
}

// BEGIN.PROC
static void BEGIN_PROC_impl(void)
{
    BEGIN.LOG.PRINT("BEGIN.PROC:READY");
}

// BEGIN.DISPATCH
static void BEGIN_DISPATCH_impl(void)
{
    BEGIN.LOG.PRINT("BEGIN.DISPATCH:ENTER");

    // Legacy dispatch behavior
    BEGIN_DISPATCH_KEY = TRUE;

    BEGIN.LOG.PRINT("BEGIN.DISPATCH:EXIT");
}

// BEGIN.END
static void BEGIN_END_impl(BEGIN_DISPATCH_KEY_TYPE key, BOOL ok, const char *msg)
{
    BEGIN.LOG.PRINT("BEGIN.END:ENTER");
    BEGIN.LOG.PRINT(msg);

    if (key)
        BEGIN.LOG.PRINT("BEGIN.END:DISPATCH KEY VALID");
    else
        BEGIN.LOG.PRINT("BEGIN.END:DISPATCH KEY INVALID");

    BEGIN.LOG.PRINT("BEGIN.END:EXIT");
}

// KB.LOG.PRINT
static void BEGIN_KB_LOG_PRINT_impl(const char *msg)
{
    OutputDebugStringA("[KB] ");
    OutputDebugStringA(msg);
    OutputDebugStringA("\n");
}

// ------------------------------------------------------------
// GLOBAL BEGIN OBJECT INITIALIZATION
// ------------------------------------------------------------

BEGIN_ BEGIN = {

    // LOG subsystem
    .LOG = {
        .PRINT = BEGIN_LOG_PRINT_impl
    },

    // BEGIN lifecycle
    .INI      = BEGIN_INI_impl,
    .LOAD     = BEGIN_LOAD_impl,
    .PROC     = BEGIN_PROC_impl,
    .DISPATCH = BEGIN_DISPATCH_impl,
    .END      = BEGIN_END_impl,

    // KB subsystem
    .KB = {
        .LOG = {
            .PRINT = BEGIN_KB_LOG_PRINT_impl
        },
        .REG_MSGBOX = NULL
    },

    // --------------------------------------------------------
    // SEED subsystem (SHIPPED, NOT EXPANDED)
    // --------------------------------------------------------
    .SEED = NULL
};
