/*
    sentinel_prime.h

    PURPOSE:
        Sentinel Prime — unified intelligence engine.
        Combines:
            - Navigation
            - Training
            - Autoscan
            - Memory Graph
            - AI Reasoning
            - AI-CORE Decisions
*/

#ifndef SENTINEL_PRIME_H
#define SENTINEL_PRIME_H

#include "sentinel_boot.h"
#include "sentinel_train.h"
#include "sentinel_autoscan.h"
#include "sentinel_graph.h"
#include "sentinel_graph_builder.h"
#include "sentinel_ai.h"
#include "sentinel_aicore.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct SentinelPrime {
    SentinelBoot      boot;
    SentinelKnowledge knowledge;
    SenGraph          graph;
    SentinelAI        ai;
    SentinelAICore    core;
    SenBool           active;
} SentinelPrime;

SenStatus sentinel_prime_activate(SentinelPrime* prime,
                                  const char* repo_root);

SenStatus sentinel_prime_loop(SentinelPrime* prime);

#ifdef __cplusplus
}
#endif

#endif /* SENTINEL_PRIME_H */
