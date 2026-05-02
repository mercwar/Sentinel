/*
    sentinel_bindings_all.c

    PURPOSE:
        Implementation of the universal binding table for all
        mercwar public repositories.

        YOU populate the arrays below with the repo names from:
            https://github.com/mercwar?tab=repositories

        Sentinel will then:
            - classify them
            - index them
            - navigate them
            - teach robots how to find them
*/

#include "sentinel_bindings_all.h"

#include <stdlib.h>
#include <string.h>

static SenString sen_all_make_string(const char* s) {
    SenString str;
    str.data   = s;
    str.length = s ? (int)strlen(s) : 0;
    return str;
}

/* -------------------------------------------------------------
   STEP 1 — LIST ALL MERCWAR PUBLIC REPOS HERE
   ------------------------------------------------------------- */

static const char* REPO_NAMES[] = {
    /* Fill these with your actual repo names */
    "Cyborg",
    "AVIS-DATALAKE",
    "NEXUS",
    "TOOLS",
    "EXPERIMENTS"
};

/* -------------------------------------------------------------
   STEP 2 — MAP EACH REPO TO ITS LOCAL PATH
   ------------------------------------------------------------- */

static const char* REPO_PATHS[] = {
    "Cyborg",
    "AVIS-DATALAKE",
    "NEXUS",
    "TOOLS",
    "EXPERIMENTS"
};

/* -------------------------------------------------------------
   STEP 3 — CLASSIFY EACH REPO
   ------------------------------------------------------------- */

static const SenRepoType REPO_TYPES[] = {
    SEN_REPO_TYPE_LANGUAGE,   /* Cyborg */
    SEN_REPO_TYPE_CORE,       /* AVIS-DATALAKE */
    SEN_REPO_TYPE_CORE,       /* NEXUS */
    SEN_REPO_TYPE_TOOLING,    /* TOOLS */
    SEN_REPO_TYPE_EXPERIMENT  /* EXPERIMENTS */
};

/* -------------------------------------------------------------
   INITIALIZATION
   ------------------------------------------------------------- */

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
    if (table->items) free(table->items);
    table->items = NULL;
    table->count = 0;
}

/* -------------------------------------------------------------
   LOOKUP BY NAME
   ------------------------------------------------------------- */

SenStatus sentinel_bindings_all_find_by_name(const SenRepoBindingTable* table,
                                             const char* name,
                                             SenRepoBinding* out_binding) {
    if (!table || !name || !out_binding) return SEN_STATUS_ERROR_INVALID_ARGUMENT;

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

/* -------------------------------------------------------------
   LOOKUP BY TYPE
   ------------------------------------------------------------- */

SenStatus sentinel_bindings_all_find_by_type(const SenRepoBindingTable* table,
                                             SenRepoType type,
                                             SenRepoBindingTable* out_subset) {
    if (!table || !out_subset) return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    int count = 0;
    for (int i = 0; i < table->count; ++i) {
        if (table->items[i].type == type) count++;
    }

    if (count == 0) {
        out_subset->items = NULL;
        out_subset->count = 0;
        return SEN_STATUS_OK;
    }

    SenRepoBinding* items = (SenRepoBinding*)malloc(sizeof(SenRepoBinding) * count);
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
