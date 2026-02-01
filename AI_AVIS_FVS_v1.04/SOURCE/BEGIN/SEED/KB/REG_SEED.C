// ------------------------------------------------------------
// AVIS FILE: BEGIN/SEED/KB/REG_SEED.C
// ------------------------------------------------------------

#include "BEGIN/SEED/KB/REG_SEED.H"

// KB_REG_SEED is the low-level assignment
void KB_REG_SEED(SEED_ *seed)
{
    BEGIN.SEED = seed;
}

// REG_SEED_EXE is the CALL CHAIN ENTRY POINT
// KB.c will call THIS, not SEED_EXEC directly.
void REG_SEED_EXE(void)
{
    SEED_EXEC();   // <-- CALL CHAIN: SEED_EXEC → KB_REG_SEED → BEGIN.SEED
}
