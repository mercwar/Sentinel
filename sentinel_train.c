/*
    sentinel_train.c

    PURPOSE:
        Implementation of Sentinel training engine.
        Pattern-rich, safe for AI learning.
*/

#include "sentinel_train.h"

#include <stdlib.h>
#include <string.h>

static SenString st_make_string(const char* s) {
    SenString str;
    str.data   = s;
    str.length = s ? (int)strlen(s) : 0;
    return str;
}

SenStatus sentinel_train_begin(SentinelBoot* boot,
                               SentinelKnowledge* knowledge) {
    if (!boot || !knowledge) return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    knowledge->repos      = NULL;
    knowledge->repo_count = 0;
    knowledge->trained    = SEN_FALSE;
    return SEN_STATUS_OK;
}

SenStatus sentinel_train_walk_traversal(SentinelBoot* boot,
                                        SentinelKnowledge* knowledge) {
    if (!boot || !knowledge) return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    const char** names = NULL;
    int          count = 0;

    sentinel_get_traversal_order(&boot->ctx, &names, &count);

    knowledge->repos = (SentinelKnowledgeRepo*)malloc(
        sizeof(SentinelKnowledgeRepo) * count);
    if (!knowledge->repos) return SEN_STATUS_ERROR_INTERNAL;

    knowledge->repo_count = count;

    for (int i = 0; i < count; ++i) {
        SentinelKnowledgeRepo* r = &knowledge->repos[i];
        r->name = st_make_string(names[i]);
        r->path = st_make_string(names[i]); /* same as name for now */
        r->file_count_estimate = 0;
    }

    return SEN_STATUS_OK;
}

SenStatus sentinel_train_scan_search(SentinelBoot* boot,
                                     SentinelKnowledge* knowledge) {
    if (!boot || !knowledge) return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    const char** patterns = NULL;
    int          pcount   = 0;

    sentinel_get_search_order(&boot->ctx, &patterns, &pcount);

    /* Pattern-only stub:
       In a real system, each pattern would be applied to the filesystem
       and file_count_estimate would be updated. Here we just mark that
       scanning occurred. */

    for (int i = 0; i < knowledge->repo_count; ++i) {
        knowledge->repos[i].file_count_estimate = pcount; /* symbolic */
    }

    (void)patterns;
    return SEN_STATUS_OK;
}

SenStatus sentinel_train_commit(SentinelBoot* boot,
                                SentinelKnowledge* knowledge) {
    if (!boot || !knowledge) return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    knowledge->trained = SEN_TRUE;
    (void)boot;
    return SEN_STATUS_OK;
}
