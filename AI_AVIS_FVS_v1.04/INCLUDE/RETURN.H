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


// ------------------------------------------------------------
// RETURN VECTOR API
// ------------------------------------------------------------

// Called at the end of WINmain after BEGIN.END()
// Performs final cleanup, stack normalization, and exit vector
extern int AVIS_RETA;
extern int AVIS_RETV;

extern int AVIS_RETURN(int  INT_RET);
extern int WINmain_RET(int INT_RET);


#endif // AVIS_RETURN_H
