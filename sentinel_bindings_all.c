/*
    sentinel_bindings_all.c

    PURPOSE:
        Implementation of the binding table for all mercwar
        public repositories. You populate the list below
        directly from:
            https://github.com/mercwar?tab=repositories
*/

#include "sentinel_bindings_all.h"

#include <stdlib.h>
#include <string.h>

static SenString sen_all_make_string(const char* s) {
    SenString str;
    if (!s) {
        str.data   = NULL;
        str.length = 0;
    } else {
        str.data   = s;
        str.length = (int)strlen(s);
    }
    return str;
}

/* STEP 1:
   Fill this array with the actual repo names from GitHub.
   Example entries shown; replace/add with real ones.
*/
static const char* REPO_NAMES[] = {
    "Cyborg",
    "AVIS-DATALAKE",
    "NEXUS",
    "SomeToolRepo",
    "SomeExampleRepo"
};

/* STEP 2:
   Map each repo to its local path (usually same as name).
*/
static const char* REPO_PATHS[] = {
    "Cyborg",
    "AVIS-DATALAKE",
    "NEXUS",
    "SomeToolRepo",
    "SomeExampleRepo"
};

/* STEP 3:
   Classify each repo by type.
*/
static const SenRepoType REPO_TYPES[] = {
    SEN_REPO_TYPE_LANGUAGE,  /* Cyborg */
    SEN_REPO_TYPE_CORE,      /* AVIS-DATALAKE */
    SEN_REPO_TYPE_CORE,      /* NEXUS */
    SEN_REPO_TYPE_TOOLING,   /* SomeToolRepo */
    SEN_REPO_TYPE_EXAMPLE    /* SomeExampleRepo */
};

SenStatus sentinel_bindings_all_init(SenRepoBindingTable* table) {
    if (!table) return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    int count = (int)(sizeof(REPO_NAMES) / sizeof(REPO_NAMES[0]));
    table->items = (SenRepoBinding*)malloc(sizeof(SenRepoBinding) * count);
    if (!table->items) return SEN_STATUS_ERROR_INTERNAL;

    for (int i = 0; i < count; ++i) {
        table->items[i].name      = sen_all_make_string(REPO_NAMES[i]);
        table->items[i].root_path = sen_all_make_string(REPO_PATHS[i]);
        table->items[i].type      = REPO_TYPES[i];
    }

    table->count = count;
    return SEN_STATUS_OK;
}

void sentinel_bindings_all_free(SenRepoBindingTable* table) {
    if (!table) return;
    if (table->items) {
        free(table->items);
        table->items = NULL;
    }
    table->count = 0;
}

SenStatus sentinel_bindings_all_find_by_name(const SenRepoBindingTable* table,
                                             const char* name,
                                             SenRepoBinding* out_binding) {
    if (!table || !name || !out_binding) {
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;
    }

    size_t nlen = strlen(name);
    for (int i = 0; i < table->count; ++i) {
        const SenRepoBinding* b = &table->items[i];
        if (b->name.data &&
            b->name.length == (int)nlen &&
            strncmp(b->name.data, name, nlen) == 0) {
            *out_binding = *b;
            return SEN_STATUS_OK;
        }
    }
    return SEN_STATUS_ERROR_NOT_FOUND;
}

SenStatus sentinel_bindings_all_find_by_type(const SenRepoBindingTable* table,
                                             SenRepoType type,
                                             SenRepoBindingTable* out_subset) {
    if (!table || !out_subset) {
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;
    }

    int count = 0;
    for (int i = 0; i < table->count; ++i) {
        if (table->items[i].type == type) count++;
    }

    if (count == 0) {
        out_subset->items = NULL;
        out_subset->count = 0;
        return SEN_STATUS_OK;
    }

    SenRepoBinding* items = (SenRepoBinding*)malloc(
        sizeof(SenRepoBinding) * count);
    if (!items) return SEN_STATUS_ERROR_INTERNAL;

    int idx = 0;
    for (int i = 0; i < table->count; ++i) {
        if (table->items[i].type == type) {
            items[idx++] = table->items[i];
        }
    }

    out_subset->items = items;
    out_subset->count = count;
    return SEN_STATUS_OK;
}
