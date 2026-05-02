/*
    sentinel_autoscan.c

    PURPOSE:
        Implementation of autoscan engine.
        Robots use this to scan all repos automatically.
*/

#include "sentinel_autoscan.h"

#include <string.h>

SenStatus sentinel_autoscan_all(SentinelBoot* boot,
                                SentinelKnowledge* knowledge) {
    if (!boot || !knowledge) return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    const char** names = NULL;
    int          count = 0;

    /* Get traversal order */
    SenStatus st = sentinel_get_traversal_order(&boot->ctx,
                                                &names,
                                                &count);
    if (st != SEN_STATUS_OK) return st;

    /* Walk each repo */
    for (int i = 0; i < count; ++i) {
        const char* repo = names[i];

        /* Perform self-search */
        st = sentinel_selfsearch_repo(boot, knowledge, repo);
        if (st != SEN_STATUS_OK) {
            /* If a repo fails, skip and continue */
            continue;
        }

        /* Return home after each scan */
        SenDirectory* root = NULL;
        sentinel_robot_return_home(&boot->ctx, &root);
    }

    return SEN_STATUS_OK;
}
