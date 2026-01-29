// AVIS BATCH CBORD.SEED VERSION 1.00
// AVIS FILE: BEGIN/KB/DISPATCH.c
// AVIS DEPENDS:
//   - BEGIN/BEGIN.H
//   - WIN_MAIN.H

// ------------------------------------------------------------
// KB DISPATCH LOGIC
// ------------------------------------------------------------

BEGIN.KB.LOG.PRINT("KB:DISPATCH:ENTER");

// In a future version, this becomes your KB event router.
// For now, it simply marks the dispatch phase as complete.

BEGIN_DISPATCH_KEY = TRUE;

BEGIN.KB.LOG.PRINT("KB:DISPATCH:EXIT");
