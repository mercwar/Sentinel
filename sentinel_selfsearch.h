/*
    sentinel_selfsearch.h

    PURPOSE:
        Robot self-search engine.
        Derives search patterns from repo type and applies them
        per-repo.
*/

#ifndef SENTINEL_SELFSEARCH_H
#define SENTINEL_SELFSEARCH_H

#include "sentinel_boot.h"
#include "sentinel_train.h"
#include "sentinel_bindings_all.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct SentinelSelfSearchPattern {
    SenString pattern;
} SentinelSelfSearchPattern;

typedef struct SentinelSelfSearchSet {
    SentinelSelfSearchPattern* items;
    int                        count;
} SentinelSelfSearchSet;

SenStatus sentinel_selfsearch_get_patterns_for_type(SenRepoType type,
                                                    SentinelSelfSearchSet* out_set);

void      sentinel_selfsearch_free_patterns(SentinelSelfSearchSet* set);

/* High-level: robot self-search for a single repo by name. */
SenStatus sentinel_selfsearch_repo(SentinelBoot* boot,
                                   SentinelKnowledge* knowledge,
                                   const char* repo_name);

#ifdef __cplusplus
}
#endif

#endif /* SENTINEL_SELFSEARCH_H */
