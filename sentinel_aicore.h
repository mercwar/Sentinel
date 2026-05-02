/*
    sentinel_aicore.h

    PURPOSE:
        Sentinel AI-CORE decision engine.
        Uses graph + knowledge to select and execute actions.
*/

#ifndef SENTINEL_AICORE_H
#define SENTINEL_AICORE_H

#include "sentinel_ai.h"
#include "sentinel_graph.h"
#include "sentinel_train.h"
#include "sentinel_autoscan.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef enum SenAIAction {
    SEN_AI_ACTION_NONE = 0,
    SEN_AI_ACTION_SCAN,
    SEN_AI_ACTION_REPAIR,
    SEN_AI_ACTION_INFER,
    SEN_AI_ACTION_OPTIMIZE,
    SEN_AI_ACTION_CLASSIFY,
    SEN_AI_ACTION_EXPAND,
    SEN_AI_ACTION_ALERT
} SenAIAction;

typedef struct SentinelAICore {
    SenBool active;
} SentinelAICore;

SenStatus sentinel_aicore_activate(SentinelAICore* core);

SenAIAction sentinel_aicore_decide(SentinelAICore* core,
                                   SenGraph* graph,
                                   SentinelKnowledge* knowledge);

SenStatus sentinel_aicore_execute(SentinelAICore* core,
                                  SenAIAction action,
                                  SentinelBoot* boot,
                                  SenGraph* graph,
                                  SentinelKnowledge* knowledge);

#ifdef __cplusplus
}
#endif

#endif /* SENTINEL_AICORE_H */
