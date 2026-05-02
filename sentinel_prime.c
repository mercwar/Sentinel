/*
    sentinel_prime.c

    PURPOSE:
        Implementation of Sentinel Prime.
        A unified intelligence loop.
*/

#include "sentinel_prime.h"

SenStatus sentinel_prime_activate(SentinelPrime* prime,
                                  const char* repo_root) {
    if (!prime || !repo_root)
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    /* Boot */
    SenStatus st = sentinel_boot_system(&prime->boot, repo_root);
    if (st != SEN_STATUS_OK) return st;

    /* Training */
    st = sentinel_train_begin(&prime->boot, &prime->knowledge);
    if (st != SEN_STATUS_OK) return st;

    /* Graph */
    st = sentinel_graph_build(&prime->graph);
    if (st != SEN_STATUS_OK) return st;

    /* AI */
    st = sentinel_ai_activate(&prime->ai);
    if (st != SEN_STATUS_OK) return st;

    /* AI-CORE */
    st = sentinel_aicore_activate(&prime->core);
    if (st != SEN_STATUS_OK) return st;

    prime->active = SEN_TRUE;
    return SEN_STATUS_OK;
}

SenStatus sentinel_prime_loop(SentinelPrime* prime) {
    if (!prime || !prime->active)
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    /* Observe → Decide → Act → Update */
    SenAIAction action =
        sentinel_aicore_decide(&prime->core,
                               &prime->graph,
                               &prime->knowledge);

    sentinel_aicore_execute(&prime->core,
                            action,
                            &prime->boot,
                            &prime->graph,
                            &prime->knowledge);

    return SEN_STATUS_OK;
}
