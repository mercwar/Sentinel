// ------------------------------------------------------------
// AVIS BATCH CBORD.SEED VERSION 1.00
// AVIS FILE: BEGIN/SEED/SEED_EXEC.C
// AVIS ROLE: SEED activation stub (instantiate + attach)
// ------------------------------------------------------------

#include "BEGIN/SEED/SEED.H"
#include "BEGIN/SEED/KB/REG_SEED.H"

// STATIC SEED INSTANCE
static SEED_ BEGIN_SEED = {
    "AVIS-SEED-0001",
    "BEGIN-SEED",
    "1.00"
};

void SEED_EXEC(void)
{
    KB_REG_SEED(&BEGIN_SEED);
}
