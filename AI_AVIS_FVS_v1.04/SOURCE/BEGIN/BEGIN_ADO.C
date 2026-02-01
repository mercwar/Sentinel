// ------------------------------------------------------------
// AVIS FILE: BEGIN/BEGIN_ADO.C
// ROLE: Compute ADO values (address/pointer/buffer) at runtime
// ------------------------------------------------------------

#include "BEGIN/BEGIN.H"
#include "BEGIN/MASTER/MASTER.H"
#include "BEGIN/MASTER/MASTER_CONVERT.H"
#include "BEGIN/MASTER/MASTER_COMBINE.H"
#include "BEGIN/SEED/SEED.H"
// ------------------------------------------------------------
// AVIS FILE: BEGIN/BEGIN_ADO.C
// ROLE: Stub ADO loader (no real address logic)
// ------------------------------------------------------------

#include "BEGIN/BEGIN.H"

// Stub: no real computation, just zero-fill safely
void BEGIN_ComputeADO(void)
{
    BEGIN.ADDR_SEED           = 0;
    BEGIN.ADDR_MASTER         = 0;
    BEGIN.ADDR_MASTER_CONVERT = 0;
    BEGIN.ADDR_MASTER_COMBILE = 0;

    BEGIN.PTR_SEED            = 0;
    BEGIN.PTR_MASTER          = 0;
    BEGIN.PTR_MASTER_CONVERT  = 0;
    BEGIN.PTR_MASTER_COMBILE  = 0;

    BEGIN.BUF_SEED            = 1;
    BEGIN.BUF_MASTER          = 2;
    BEGIN.BUF_MASTER_CONVERT  = 3;
    BEGIN.BUF_MASTER_COMBILE  = 4;
}

