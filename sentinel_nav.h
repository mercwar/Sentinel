/*
    sentinel_nav.h

    PURPOSE:
        High-level navigation API that:
            - loads the constellation map
            - loads repo bindings
            - applies traversal + search order
            - exposes a single boot call for robots
*/

#ifndef SENTINEL_NAV_H
#define SENTINEL_NAV_H

#include "sentinel.h"
#include "sentinel_bindings_all.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct SentinelContext {
    SenRepoGraph        graph;
    SenRepoBindingTable bindings;
    SenBool             initialized;
} SentinelContext;

/* Boot Sentinel: init graph + bindings. */
SenStatus sentinel_boot(SentinelContext* ctx, const char* repo_root);

/* Shutdown Sentinel: free graph + bindings. */
void      sentinel_shutdown(SentinelContext* ctx);

/* Get ordered list of repos for traversal (from map). */
SenStatus sentinel_get_traversal_order(SentinelContext* ctx,
                                       const char*** out_names,
                                       int* out_count);

/* Get ordered search patterns (from map). */
SenStatus sentinel_get_search_order(SentinelContext* ctx,
                                    const char*** out_patterns,
                                    int* out_count);

/* Resolve a repo name to a directory via bindings + graph. */
SenStatus sentinel_resolve_repo(SentinelContext* ctx,
                                const char* repo_name,
                                SenDirectory** out_dir);

#ifdef __cplusplus
}
#endif

#endif /* SENTINEL_NAV_H */
