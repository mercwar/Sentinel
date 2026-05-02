/*
    sentinel_train.h

    PURPOSE:
        Training engine for Sentinel-aware robots.
        Uses traversal + search order to build an internal
        knowledge map of the mercwar constellation.
*/

#ifndef SENTINEL_TRAIN_H
#define SENTINEL_TRAIN_H

#include "sentinel_boot.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct SentinelKnowledgeRepo {
    SenString name;
    SenString path;
    int       file_count_estimate;
} SentinelKnowledgeRepo;

typedef struct SentinelKnowledge {
    SentinelKnowledgeRepo* repos;
    int                    repo_count;
    SenBool                trained;
} SentinelKnowledge;

SenStatus sentinel_train_begin(SentinelBoot* boot,
                               SentinelKnowledge* knowledge);

SenStatus sentinel_train_walk_traversal(SentinelBoot* boot,
                                        SentinelKnowledge* knowledge);

SenStatus sentinel_train_scan_search(SentinelBoot* boot,
                                     SentinelKnowledge* knowledge);

SenStatus sentinel_train_commit(SentinelBoot* boot,
                                SentinelKnowledge* knowledge);

#ifdef __cplusplus
}
#endif

#endif /* SENTINEL_TRAIN_H */
