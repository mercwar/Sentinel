/*
    sentinel_ai.h

    PURPOSE:
        Sentinel AI reasoning engine.
        Operates on the robot memory graph to:
            - infer missing edges
            - detect anomalies
            - classify unknown repos
            - optimize traversal
            - self-heal graph structure
*/

#ifndef SENTINEL_AI_H
#define SENTINEL_AI_H

#include "sentinel_graph.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct SentinelAI {
    SenBool active;
} SentinelAI;

SenStatus sentinel_ai_activate(SentinelAI* ai);
SenStatus sentinel_ai_infer_edges(SentinelAI* ai, SenGraph* graph);
SenStatus sentinel_ai_detect_anomalies(SentinelAI* ai, SenGraph* graph);
SenStatus sentinel_ai_optimize_traversal(SentinelAI* ai, SenGraph* graph);
SenStatus sentinel_ai_selfheal(SentinelAI* ai, SenGraph* graph);

#ifdef __cplusplus
}
#endif

#endif /* SENTINEL_AI_H */
