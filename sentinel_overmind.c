/*
    sentinel_overmind.c

    PURPOSE:
        Implementation of Sentinel Overmind.
        Multi-agent distributed intelligence.
*/

#include "sentinel_overmind.h"

#include <stdlib.h>
#include <string.h>

static SenString om_make_string(const char* s) {
    SenString str;
    str.data   = s;
    str.length = s ? (int)strlen(s) : 0;
    return str;
}

SenStatus sentinel_overmind_activate(SentinelOvermind* om,
                                     const char** repo_names,
                                     int repo_count,
                                     const char* root) {
    if (!om || !repo_names || !root)
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    om->micros = malloc(sizeof(SentinelMicro) * repo_count);
    if (!om->micros) return SEN_STATUS_ERROR_INTERNAL;

    om->micro_count = repo_count;

    for (int i = 0; i < repo_count; ++i) {
        SentinelMicro* m = &om->micros[i];
        m->repo_name = om_make_string(repo_names[i]);

        /* Activate micro-Sentinel */
        sentinel_prime_activate(&m->prime, root);
    }

    om->active = SEN_TRUE;
    return SEN_STATUS_OK;
}

SenStatus sentinel_overmind_sync(SentinelOvermind* om) {
    if (!om || !om->active)
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    /* Pattern-only stub:
       Each micro-Sentinel would broadcast its state,
       and Overmind would aggregate them.
    */

    return SEN_STATUS_OK;
}

SenStatus sentinel_overmind_collective_decide(SentinelOvermind* om,
                                              SenAIAction* out_action) {
    if (!om || !out_action)
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    /* Collective decision:
       Overmind picks the highest-priority action
       suggested by any micro-Sentinel.
    */

    *out_action = SEN_AI_ACTION_NONE;

    for (int i = 0; i < om->micro_count; ++i) {
        SentinelMicro* m = &om->micros[i];

        SenAIAction a =
            sentinel_aicore_decide(&m->prime.core,
                                   &m->prime.graph,
                                   &m->prime.knowledge);

        if (a > *out_action)
            *out_action = a;
    }

    return SEN_STATUS_OK;
}

SenStatus sentinel_overmind_collective_execute(SentinelOvermind* om,
                                               SenAIAction action) {
    if (!om)
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    for (int i = 0; i < om->micro_count; ++i) {
        SentinelMicro* m = &om->micros[i];

        sentinel_aicore_execute(&m->prime.core,
                                action,
                                &m->prime.boot,
                                &m->prime.graph,
                                &m->prime.knowledge);
    }

    return SEN_STATUS_OK;
}
