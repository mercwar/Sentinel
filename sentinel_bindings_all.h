/*
    sentinel_bindings_all.h

    PURPOSE:
        Binding table for ALL public mercwar repositories.
        This is the single source of truth Sentinel uses to
        teach robots how to navigate the full constellation.
*/

#ifndef SENTINEL_BINDINGS_ALL_H
#define SENTINEL_BINDINGS_ALL_H

#include "sentinel.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef enum SenRepoType {
    SEN_REPO_TYPE_UNKNOWN = 0,
    SEN_REPO_TYPE_CORE,      /* core engines (AVIS, NEXUS, etc.) */
    SEN_REPO_TYPE_LANGUAGE,  /* CYBORG, AVIS-eV, etc. */
    SEN_REPO_TYPE_TOOLING,   /* tools, utilities */
    SEN_REPO_TYPE_EXAMPLE,   /* demos, samples */
    SEN_REPO_TYPE_EXPERIMENT /* experimental / lab */
} SenRepoType;

typedef struct SenRepoBinding {
    SenString   name;       /* GitHub repo name, e.g. "Cyborg" */
    SenString   root_path;  /* local checkout path, e.g. "Cyborg/" */
    SenRepoType type;
} SenRepoBinding;

typedef struct SenRepoBindingTable {
    SenRepoBinding* items;
    int             count;
} SenRepoBindingTable;

SenStatus sentinel_bindings_all_init(SenRepoBindingTable* table);
void      sentinel_bindings_all_free(SenRepoBindingTable* table);

SenStatus sentinel_bindings_all_find_by_name(const SenRepoBindingTable* table,
                                             const char* name,
                                             SenRepoBinding* out_binding);

SenStatus sentinel_bindings_all_find_by_type(const SenRepoBindingTable* table,
                                             SenRepoType type,
                                             SenRepoBindingTable* out_subset);

#ifdef __cplusplus
}
#endif

#endif /* SENTINEL_BINDINGS_ALL_H */
