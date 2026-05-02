/*
    sentinel_autoscan.h

    PURPOSE:
        High-level autoscan engine.
        Walks all repos in traversal order and performs
        self-search on each one.
*/

#ifndef SENTINEL_AUTOSCAN_H
#define SENTINEL_AUTOSCAN_H

#include "sentinel_selfsearch.h"
#include "sentinel_train.h"

#ifdef __cplusplus
extern "C" {
#endif

SenStatus sentinel_autoscan_all(SentinelBoot* boot,
                                SentinelKnowledge* knowledge);

#ifdef __cplusplus
}
#endif

#endif /* SENTINEL_AUTOSCAN_H */
