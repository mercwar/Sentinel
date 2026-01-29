// AVIS BATCH CBORD.SEED VERSION 1.00
// AVIS FILE: WIN_MAIN.H
// AVIS DEPENDS:
//   - BEGIN/BEGIN.H
//   - RETURN.H
//   - WIN_MAIN.C

#ifndef WIN_MAIN_H
#define WIN_MAIN_H

typedef int BOOL;

// Dispatch key type
typedef BOOL BEGIN_DISPATCH_KEY_TYPE;

// Global dispatch key (defined in WIN_MAIN.C)
extern BEGIN_DISPATCH_KEY_TYPE BEGIN_DISPATCH_KEY;

// Entry point
int WINmain(void);

#endif // WIN_MAIN_H
