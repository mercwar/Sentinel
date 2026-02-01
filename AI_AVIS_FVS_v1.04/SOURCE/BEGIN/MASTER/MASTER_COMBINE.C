// ------------------------------------------------------------
// AVIS BATCH CBORD.SEED VERSION 1.00
// AVIS FILE: BEGIN/MASTER/MASTER_COMBINE.C
// AVIS ROLE: AMSTER (MASTER) SEED combiner
// ------------------------------------------------------------

#include "BEGIN/MASTER/MASTER_COMBINE.H"
#include "BEGIN/SEED/SEED.H"
#include "BEGIN/BEGIN.H"
#include <windows.h>
#include "BEGIN/MASTER/MASTER_COMBINE.H"

// ------------------------------------------------------------
// AVIS FILE: BEGIN/MASTER/MASTER_COMBINE.C
// ROLE: Stub MASTER_COMBINE implementation
// ------------------------------------------------------------



char *MASTER_COMBINE(INT_ENUM INT_SWITCH)
{
    switch (INT_SWITCH)
    {
        case 0: //&BEGIN.ADDRESS.SEED.:
        {
            static char seed_info_buf[128];

            if (BEGIN.SEED)
                wsprintf(seed_info_buf, "%s %s",
                         BEGIN.SEED->NAME,
                         BEGIN.SEED->VERSION);
            else
                wsprintf(seed_info_buf, "NO-SEED");

            return seed_info_buf;
        }

        break;
    }

    return NULL;
}

