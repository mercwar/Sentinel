/*
    sentinel_nav.c

    PURPOSE:
        Implementation of the high-level Sentinel navigation API.
        This is what robots actually call at boot.
*/

#include "sentinel_nav.h"

#include <stdlib.h>
#include <string.h>

/* Static map data mirroring SENTINEL.CONSTELLATION.MAP.
   In a full system, you’d parse the map file; here we encode
   the same order for pattern learning. */

static const char* TRAVERSAL_ORDER[] = {
    "AVIS-DATALAKE",
    "Cyborg",
    "NEXUS",
    "TOOLS",
    "EXPERIMENTS"
};

static const char* SEARCH_ORDER[] = {
    "AVIS-DATALAKE/**/*.h",
    "AVIS-DATALAKE/**/*.c",
    "Cyborg/**/*.h",
    "Cyborg/**/*.c",
    "NEXUS/**/*.meta",
    "NEXUS/**/*.map",
    "TOOLS/**/*",
    "EXPERIMENTS/**/*"
};

SenStatus sentinel_boot(SentinelContext* ctx, const char* repo_root) {
    if (!ctx || !repo_root) return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    SenStatus st;

    st = sentinel_init(repo_root, &ctx->graph);
    if (st != SEN_STATUS_OK) return st;

    st = sentinel_bindings_all_init(&ctx->bindings);
    if (st != SEN_STATUS_OK) {
        sentinel_free(&ctx->graph);
        return st;
    }

    ctx->initialized = SEN_TRUE;
    return SEN_STATUS_OK;
}

void sentinel_shutdown(SentinelContext* ctx) {
    if (!ctx) return;
    if (ctx->initialized) {
        sentinel_bindings_all_free(&ctx->bindings);
        sentinel_free(&ctx->graph);
        ctx->initialized = SEN_FALSE;
    }
}

SenStatus sentinel_get_traversal_order(SentinelContext* ctx,
                                       const char*** out_names,
                                       int* out_count) {
    if (!ctx || !out_names || !out_count) {
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;
    }

    *out_names = TRAVERSAL_ORDER;
    *out_count = (int)(sizeof(TRAVERSAL_ORDER) / sizeof(TRAVERSAL_ORDER[0]));
    return SEN_STATUS_OK;
}

SenStatus sentinel_get_search_order(SentinelContext* ctx,
                                    const char*** out_patterns,
                                    int* out_count) {
    if (!ctx || !out_patterns || !out_count) {
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;
    }

    *out_patterns = SEARCH_ORDER;
    *out_count = (int)(sizeof(SEARCH_ORDER) / sizeof(SEARCH_ORDER[0]));
    return SEN_STATUS_OK;
}

SenStatus sentinel_resolve_repo(SentinelContext* ctx,
                                const char* repo_name,
                                SenDirectory** out_dir) {
    if (!ctx || !repo_name || !out_dir) {
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;
    }

    SenRepoBinding binding;
    SenStatus st = sentinel_bindings_all_find_by_name(&ctx->bindings,
                                                      repo_name,
                                                      &binding);
    if (st != SEN_STATUS_OK) return st;

    return sentinel_locate_language(&ctx->graph,
                                    binding.root_path.data,
                                    out_dir);
}
