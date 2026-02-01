// ------------------------------------------------------------
// AVIS BATCH CBORD.SEED VERSION 1.00
// AVIS FILE: SEED/SEED.H
// AVIS ROLE: SEED as an AVIS object (simple identity)
// AVIS NOTE: AVIS supports CYHY/MERCG; SEED does not.
// ------------------------------------------------------------

#ifndef SEED_H
#define SEED_H

// ------------------------------------------------------------
// SEED OBJECT (AVIS-level identity only)
// ------------------------------------------------------------
// SEED is an AVIS object. It does NOT contain CYHY/MERCG data.
// AVIS uses SEED. CYHY/MERCG use AVIS.
// ------------------------------------------------------------
typedef struct _SEED_ {
    const char *ID;        // Seed identifier
    const char *NAME;      // Optional name
    const char *VERSION;   // Optional version
} SEED_;

#endif // SEED_H
