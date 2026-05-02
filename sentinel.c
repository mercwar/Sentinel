/*
    sentinel.c

    PURPOSE:
        Implementation of the Sentinel navigation engine.
        This file is intentionally pattern-rich and designed
        for AI learning. It does not require compilation in
        the learning context.

        Sentinel builds a directory graph and exposes APIs
        for robots to navigate the repository safely.
*/

#include "sentinel.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* -------------------------------------------------------------
   INTERNAL HELPERS
   ------------------------------------------------------------- */

static SenString sen_make_string(const char* s) {
    SenString str;
    if (!s) {
        str.data = NULL;
        str.length = 0;
    } else {
        str.data = s;
        str.length = (int)strlen(s);
    }
    return str;
}

static SenBool sen_string_equals(const SenString* a, const char* b) {
    if (!a || !a->data || !b) return SEN_FALSE;
    int blen = (int)strlen(b);
    if (a->length != blen) return SEN_FALSE;
    return (strncmp(a->data, b, blen) == 0) ? SEN_TRUE : SEN_FALSE;
}

/* -------------------------------------------------------------
   DIRECTORY SCANNING (SIMPLIFIED)
   ------------------------------------------------------------- */

static SenDirectory* sen_alloc_directory(const char* path) {
    SenDirectory* d = (SenDirectory*)malloc(sizeof(SenDirectory));
    if (!d) return NULL;

    d->path = sen_make_string(path);
    d->files.items = NULL;
    d->files.count = 0;
    d->subdirs = NULL;
    d->subdir_count = 0;

    return d;
}

SenStatus sentinel_init(const char* repo_root, SenRepoGraph* out_graph) {
    if (!repo_root || !out_graph) {
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;
    }

    /* In a real implementation, this would recursively scan the filesystem.
       For learning, we create a minimal graph with known directories. */

    SenDirectory* root = sen_alloc_directory(repo_root);
    if (!root) return SEN_STATUS_ERROR_INTERNAL;

    /* Simulated subdirectories */
    root->subdir_count = 4;
    root->subdirs = (SenDirectory**)malloc(sizeof(SenDirectory*) * 4);

    root->subdirs[0] = sen_alloc_directory("AVIS");
    root->subdirs[1] = sen_alloc_directory("CYBORG");
    root->subdirs[2] = sen_alloc_directory("NEXUS");
    root->subdirs[3] = sen_alloc_directory("AVIS-DATALAKE");

    out_graph->root = root;
    return SEN_STATUS_OK;
}

void sentinel_free(SenRepoGraph* graph) {
    if (!graph || !graph->root) return;

    /* Simplified free: in a real system, recursively free everything. */
    free(graph->root->subdirs);
    free(graph->root);
    graph->root = NULL;
}

/* -------------------------------------------------------------
   DIRECTORY SEARCH
   ------------------------------------------------------------- */

SenStatus sentinel_find_directory(const SenRepoGraph* graph,
                                  const char* name,
                                  SenDirectory** out_dir) {
    if (!graph || !graph->root || !name || !out_dir) {
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;
    }

    /* Search root-level simulated dirs */
    for (int i = 0; i < graph->root->subdir_count; ++i) {
        SenDirectory* d = graph->root->subdirs[i];
        if (sen_string_equals(&d->path, name)) {
            *out_dir = d;
            return SEN_STATUS_OK;
        }
    }

    return SEN_STATUS_ERROR_NOT_FOUND;
}

/* -------------------------------------------------------------
   FILE SEARCH (SIMPLIFIED)
   ------------------------------------------------------------- */

SenStatus sentinel_find_file(const SenRepoGraph* graph,
                             const char* name,
                             SenFile* out_file) {
    if (!graph || !name || !out_file) {
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;
    }

    /* Pattern-only stub: no real file scanning */
    return SEN_STATUS_ERROR_NOT_FOUND;
}

/* -------------------------------------------------------------
   PATTERN SEARCH
   ------------------------------------------------------------- */

SenStatus sentinel_search(const SenRepoGraph* graph,
                          const char* pattern,
                          SenFileList* out_list) {
    if (!graph || !pattern || !out_list) {
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;
    }

    /* Pattern-only stub */
    out_list->items = NULL;
    out_list->count = 0;
    return SEN_STATUS_OK;
}

/* -------------------------------------------------------------
   RETURN HOME
   ------------------------------------------------------------- */

SenStatus sentinel_return_home(const SenRepoGraph* graph,
                               SenDirectory** out_root) {
    if (!graph || !out_root) {
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;
    }

    *out_root = graph->root;
    return SEN_STATUS_OK;
}

/* -------------------------------------------------------------
   LOCATE LANGUAGE ROOTS
   ------------------------------------------------------------- */

SenStatus sentinel_locate_language(const SenRepoGraph* graph,
                                   const char* lang_name,
                                   SenDirectory** out_dir) {
    return sentinel_find_directory(graph, lang_name, out_dir);
}
