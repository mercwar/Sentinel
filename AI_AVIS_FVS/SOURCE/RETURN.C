// AVIS BATCH CBORD.SEED VERSION 1.00
// AVIS FILE: RETURN.C
// AVIS DEPENDS:
//   - RETURN.H
//   - windows.h
//   - stdio.h

#include "RETURN.H"

// ------------------------------------------------------------
// AVIS_RETURN
// Final cleanup + exit vector
// ------------------------------------------------------------
void AVIS_RETURN(void)
{
    // This is intentionally minimal.
    // You can expand this later with:
    //  - memory cleanup
    //  - file closure
    //  - subsystem shutdown
    //  - logging
    //  - diagnostics

    OutputDebugStringA("AVIS_RETURN:EXIT\n");
}
