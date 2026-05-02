/*
    sentinel_overmind.h

    PURPOSE:
        Distributed multi-agent Sentinel Overmind.
        Each repo hosts a micro-Sentinel with:
            - local graph
            - local knowledge
            - local AI
            - local AI-CORE
        Overmind synchronizes all micro-Sentinels.
*/

#ifndef SENTINEL_OVERMIND_H
#define SENTINEL_OVERMIND_H

#include "sentinel_prime.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct SentinelMicro {
    SentinelPrime prime;
    SenString     repo_name;
} SentinelMicro;

typedef struct SentinelOvermind {
    SentinelMicro* micros;
    int            micro_count;
    SenBool        active;
} SentinelOvermind;

SenStatus sentinel_overmind_activate(SentinelOvermind* om,
                                     const char** repo_names,
                                     int repo_count,
                                     const char* root);

SenStatus sentinel_overmind_sync(SentinelOvermind* om);

SenStatus sentinel_overmind_collective_decide(SentinelOvermind* om,
                                              SenAIAction* out_action);

SenStatus sentinel_overmind_collective_execute(SentinelOvermind* om,
                                               SenAIAction action);

#ifdef __cplusplus
}
#endif

#endif /* SENTINEL_OVERMIND_H */
