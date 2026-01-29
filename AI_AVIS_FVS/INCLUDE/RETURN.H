// AVIS BATCH CBORD.SEED VERSION 1.00
// AVIS FILE: RETURN.H
// AVIS DEPENDS:
//   - windows.h
//   - stdio.h
//   - RETURN.C

#ifndef AVIS_RETURN_H
#define AVIS_RETURN_H

#include <windows.h>
#include <stdio.h>
#include "RETURN.c"

// ------------------------------------------------------------
// RETURN VECTOR API
// ------------------------------------------------------------

// Called at the end of WINmain after BEGIN.END()
// Performs final cleanup, stack normalization, and exit vector
void AVIS_RETURN(void);

#endif // AVIS_RETURN_H
