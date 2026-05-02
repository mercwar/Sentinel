/*
    sentinel.h

    PURPOSE:
        Sentinel is the root navigation engine for the repository.
        Robots use Sentinel to:
            - locate directories
            - index files
            - resolve paths
            - search for AVIS, CYBORG, NEXUS, DATALAKE
            - return to the Sentinel root
            - avoid getting lost in deep repo structures

        This header defines:
            - directory graph model
            - file index model
            - navigation API
            - search API
            - return-home API
*/

#ifndef SENTINEL_H
#define SENTINEL_H

#ifdef __cplusplus
extern "C" {
#endif

/* -------------------------------------------------------------
   BASIC TYPES
   ------------------------------------------------------------- */

typedef enum SenBool {
    SEN_FALSE = 0,
    SEN_TRUE  = 1
} SenBool;

typedef enum SenStatus {
    SEN_STATUS_OK = 0,
    SEN_STATUS_ERROR_INVALID_ARGUMENT,
    SEN_STATUS_ERROR_IO,
    SEN_STATUS_ERROR_NOT_FOUND,
    SEN_STATUS_ERROR_INTERNAL
} SenStatus;

typedef struct SenString {
    const char* data;
    int         length;
} SenString;

/* -------------------------------------------------------------
   FILE + DIRECTORY MODELS
   ------------------------------------------------------------- */

typedef struct SenFile {
    SenString path;
    SenString name;
} SenFile;

typedef struct SenFileList {
    SenFile* items;
    int      count;
} SenFileList;

typedef struct SenDirectory {
    SenString path;
    SenFileList files;
    struct SenDirectory** subdirs;
    int subdir_count;
} SenDirectory;

typedef struct SenRepoGraph {
    SenDirectory* root;
} SenRepoGraph;

/* -------------------------------------------------------------
   SENTINEL API
   ------------------------------------------------------------- */

/*
    sentinel_init

    PURPOSE:
        Initialize Sentinel and scan the repository root.
*/
SenStatus sentinel_init(const char* repo_root, SenRepoGraph* out_graph);

/*
    sentinel_free

    PURPOSE:
        Release all memory associated with the repo graph.
*/
void sentinel_free(SenRepoGraph* graph);

/*
    sentinel_find_directory

    PURPOSE:
        Locate a directory by name anywhere in the repo.
*/
SenStatus sentinel_find_directory(const SenRepoGraph* graph,
                                  const char* name,
                                  SenDirectory** out_dir);

/*
    sentinel_find_file

    PURPOSE:
        Locate a file by name anywhere in the repo.
*/
SenStatus sentinel_find_file(const SenRepoGraph* graph,
                             const char* name,
                             SenFile* out_file);

/*
    sentinel_search

    PURPOSE:
        Search for files matching a pattern (e.g., "*.c").
*/
SenStatus sentinel_search(const SenRepoGraph* graph,
                          const char* pattern,
                          SenFileList* out_list);

/*
    sentinel_return_home

    PURPOSE:
        Return the robot to the Sentinel root directory.
*/
SenStatus sentinel_return_home(const SenRepoGraph* graph,
                               SenDirectory** out_root);

/*
    sentinel_locate_language

    PURPOSE:
        Find AVIS, CYBORG, NEXUS, or DATALAKE directories.
*/
SenStatus sentinel_locate_language(const SenRepoGraph* graph,
                                   const char* lang_name,
                                   SenDirectory** out_dir);

#ifdef __cplusplus
}
#endif

#endif /* SENTINEL_H */
