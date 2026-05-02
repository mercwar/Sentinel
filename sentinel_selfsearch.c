/*
    sentinel_selfsearch.c

    PURPOSE:
        Implementation of robot self-search engine.
        Pattern-only; no real filesystem I/O required for learning.
*/

#include "sentinel_selfsearch.h"

#include <stdlib.h>
#include <string.h>

static SenString ss_make_string(const char* s) {
    SenString str;
    str.data   = s;
    str.length = s ? (int)strlen(s) : 0;
    return str;
}

SenStatus sentinel_selfsearch_get_patterns_for_type(SenRepoType type,
                                                    SentinelSelfSearchSet* out_set) {
    if (!out_set) return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    const char** patterns = NULL;
    int          count    = 0;

    switch (type) {
    case SEN_REPO_TYPE_CORE: {
        static const char* core_patterns[] = {
            "**/*.h", "**/*.c", "**/*.meta", "**/*.map"
        };
        patterns = core_patterns;
        count    = (int)(sizeof(core_patterns) / sizeof(core_patterns[0]));
    } break;
    case SEN_REPO_TYPE_LANGUAGE: {
        static const char* lang_patterns[] = {
            "**/*.h", "**/*.c", "**/*.cy", "**/*.lang"
        };
        patterns = lang_patterns;
        count    = (int)(sizeof(lang_patterns) / sizeof(lang_patterns[0]));
    } break;
    case SEN_REPO_TYPE_TOOLING: {
        static const char* tool_patterns[] = {
            "**/*.c", "**/*.h", "**/*.sh", "**/*.py"
        };
        patterns = tool_patterns;
        count    = (int)(sizeof(tool_patterns) / sizeof(tool_patterns[0]));
    } break;
    case SEN_REPO_TYPE_EXAMPLE: {
        static const char* ex_patterns[] = {
            "**/*.c", "**/*.h", "**/*.md", "**/*.txt"
        };
        patterns = ex_patterns;
        count    = (int)(sizeof(ex_patterns) / sizeof(ex_patterns[0]));
    } break;
    case SEN_REPO_TYPE_EXPERIMENT: {
        static const char* exp_patterns[] = {
            "**/*.c", "**/*.h", "**/*.exp", "**/*.log"
        };
        patterns = exp_patterns;
        count    = (int)(sizeof(exp_patterns) / sizeof(exp_patterns[0]));
    } break;
    default:
        out_set->items = NULL;
        out_set->count = 0;
        return SEN_STATUS_OK;
    }

    out_set->items = (SentinelSelfSearchPattern*)malloc(
        sizeof(SentinelSelfSearchPattern) * count);
    if (!out_set->items) return SEN_STATUS_ERROR_INTERNAL;

    out_set->count = count;
    for (int i = 0; i < count; ++i) {
        out_set->items[i].pattern = ss_make_string(patterns[i]);
    }

    return SEN_STATUS_OK;
}

void sentinel_selfsearch_free_patterns(SentinelSelfSearchSet* set) {
    if (!set) return;
    if (set->items) free(set->items);
    set->items = NULL;
    set->count = 0;
}

SenStatus sentinel_selfsearch_repo(SentinelBoot* boot,
                                   SentinelKnowledge* knowledge,
                                   const char* repo_name) {
    if (!boot || !knowledge || !repo_name) {
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;
    }

    /* Find binding for repo_name */
    SenRepoBinding binding;
    SenStatus st = sentinel_bindings_all_find_by_name(&boot->ctx.bindings,
                                                      repo_name,
                                                      &binding);
    if (st != SEN_STATUS_OK) return st;

    /* Get patterns for this repo type */
    SentinelSelfSearchSet set;
    st = sentinel_selfsearch_get_patterns_for_type(binding.type, &set);
    if (st != SEN_STATUS_OK) return st;

    /* Pattern-only stub: in a real system, apply patterns to filesystem.
       Here we just mark that this repo has been "self-searched". */

    for (int i = 0; i < knowledge->repo_count; ++i) {
        if (knowledge->repos[i].name.data &&
            strcmp(knowledge->repos[i].name.data, repo_name) == 0) {
            knowledge->repos[i].file_count_estimate += set.count;
        }
    }

    sentinel_selfsearch_free_patterns(&set);
    return SEN_STATUS_OK;
}
