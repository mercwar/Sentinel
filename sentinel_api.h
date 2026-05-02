/*
    sentinel_api.h

    Unified public API for all Sentinel systems.
    Matches sentinel_api.c exactly.
*/

#ifndef SENTINEL_API_H
#define SENTINEL_API_H

/* -------------------------------------------------------------
   Core Types
   ------------------------------------------------------------- */

typedef int SenBool;
typedef int SenStatus;

#define SEN_TRUE   1
#define SEN_FALSE  0

#define SEN_STATUS_OK                        0
#define SEN_STATUS_ERROR_INVALID_ARGUMENT   -1
#define SEN_STATUS_ERROR_INTERNAL           -2

typedef struct SenString {
    const char* data;
    int         length;
} SenString;

typedef struct SenDirectory SenDirectory;
typedef struct SentinelContext SentinelContext;

/* Repo types */
typedef enum SenRepoType {
    SEN_REPO_TYPE_UNKNOWN = 0,
    SEN_REPO_TYPE_CORE,
    SEN_REPO_TYPE_LANGUAGE,
    SEN_REPO_TYPE_TOOLING,
    SEN_REPO_TYPE_EXAMPLE,
    SEN_REPO_TYPE_EXPERIMENT
} SenRepoType;

/* -------------------------------------------------------------
   Boot
   ------------------------------------------------------------- */

typedef struct SentinelBoot {
    SentinelContext ctx;
    SenBool         ready;
} SentinelBoot;

SenStatus sentinel_boot_system(SentinelBoot* boot, const char* repo_root);
void      sentinel_shutdown_system(SentinelBoot* boot);

/* -------------------------------------------------------------
   Robot Protocol
   ------------------------------------------------------------- */

typedef struct SentinelRobotProtocol {
    const char** traversal;
    int          traversal_count;

    const char** search;
    int          search_count;

    SenBool      active;
} SentinelRobotProtocol;

SenStatus sentinel_robot_protocol_activate(SentinelContext* ctx);
void      sentinel_robot_protocol_shutdown(SentinelContext* ctx);

SenStatus sentinel_robot_locate(SentinelContext* ctx,
                                const char* repo_name,
                                SenDirectory** out_dir);

SenStatus sentinel_robot_return_home(SentinelContext* ctx,
                                     SenDirectory** out_dir);

SenStatus sentinel_get_traversal_order(SentinelContext* ctx,
                                       const char*** out_names,
                                       int* out_count);

SenStatus sentinel_get_search_order(SentinelContext* ctx,
                                    const char*** out_patterns,
                                    int* out_count);

SenStatus sentinel_resolve_repo(SentinelContext* ctx,
                                const char* repo_name,
                                SenDirectory** out_dir);

/* -------------------------------------------------------------
   Training
   ------------------------------------------------------------- */

typedef struct SentinelKnowledgeRepo {
    SenString name;
    SenString path;
    int       file_count_estimate;
} SentinelKnowledgeRepo;

typedef struct SentinelKnowledge {
    SentinelKnowledgeRepo* repos;
    int                    repo_count;
    SenBool                trained;
} SentinelKnowledge;

SenStatus sentinel_train_begin(SentinelBoot* boot,
                               SentinelKnowledge* knowledge);

SenStatus sentinel_train_walk_traversal(SentinelBoot* boot,
                                        SentinelKnowledge* knowledge);

SenStatus sentinel_train_scan_search(SentinelBoot* boot,
                                     SentinelKnowledge* knowledge);

SenStatus sentinel_train_commit(SentinelBoot* boot,
                                SentinelKnowledge* knowledge);

/* -------------------------------------------------------------
   Self-Search
   ------------------------------------------------------------- */

typedef struct SentinelSelfSearchPattern {
    SenString pattern;
} SentinelSelfSearchPattern;

typedef struct SentinelSelfSearchSet {
    SentinelSelfSearchPattern* items;
    int                        count;
} SentinelSelfSearchSet;

SenStatus sentinel_selfsearch_get_patterns_for_type(SenRepoType type,
                                                    SentinelSelfSearchSet* out_set);

void      sentinel_selfsearch_free_patterns(SentinelSelfSearchSet* set);

SenStatus sentinel_selfsearch_repo(SentinelBoot* boot,
                                   SentinelKnowledge* knowledge,
                                   const char* repo_name);

/* -------------------------------------------------------------
   Autoscan
   ------------------------------------------------------------- */

SenStatus sentinel_autoscan_all(SentinelBoot* boot,
                                SentinelKnowledge* knowledge);

/* -------------------------------------------------------------
   Memory Graph
   ------------------------------------------------------------- */

typedef struct SenGraphNode {
    SenString   name;
    SenRepoType type;
} SenGraphNode;

typedef struct SenGraphEdge {
    SenString from;
    SenString to;
    SenString relation;
} SenGraphEdge;

typedef struct SenGraph {
    SenGraphNode* nodes;
    int           node_count;

    SenGraphEdge* edges;
    int           edge_count;
} SenGraph;

SenStatus sentinel_graph_init(SenGraph* graph);

SenStatus sentinel_graph_add_node(SenGraph* graph,
                                  const char* name,
                                  SenRepoType type);

SenStatus sentinel_graph_add_edge(SenGraph* graph,
                                  const char* from,
                                  const char* to,
                                  const char* relation);

void      sentinel_graph_free(SenGraph* graph);

SenStatus sentinel_graph_build(SenGraph* graph);

/* -------------------------------------------------------------
   AI Reasoning
   ------------------------------------------------------------- */

typedef struct SentinelAI {
    SenBool active;
} SentinelAI;

SenStatus sentinel_ai_activate(SentinelAI* ai);

SenStatus sentinel_ai_infer_edges(SentinelAI* ai, SenGraph* graph);
SenStatus sentinel_ai_detect_anomalies(SentinelAI* ai, SenGraph* graph);
SenStatus sentinel_ai_optimize_traversal(SentinelAI* ai, SenGraph* graph);
SenStatus sentinel_ai_selfheal(SentinelAI* ai, SenGraph* graph);

/* -------------------------------------------------------------
   AI-CORE
   ------------------------------------------------------------- */

typedef enum SenAIAction {
    SEN_AI_ACTION_NONE = 0,
    SEN_AI_ACTION_SCAN,
    SEN_AI_ACTION_REPAIR,
    SEN_AI_ACTION_INFER,
    SEN_AI_ACTION_OPTIMIZE,
    SEN_AI_ACTION_CLASSIFY,
    SEN_AI_ACTION_EXPAND,
    SEN_AI_ACTION_ALERT
} SenAIAction;

typedef struct SentinelAICore {
    SenBool active;
} SentinelAICore;

SenStatus  sentinel_aicore_activate(SentinelAICore* core);

SenAIAction sentinel_aicore_decide(SentinelAICore* core,
                                   SenGraph* graph,
                                   SentinelKnowledge* knowledge);

SenStatus  sentinel_aicore_execute(SentinelAICore* core,
                                   SenAIAction action,
                                   SentinelBoot* boot,
                                   SenGraph* graph,
                                   SentinelKnowledge* knowledge);

/* -------------------------------------------------------------
   Sentinel Prime
   ------------------------------------------------------------- */

typedef struct SentinelPrime {
    SentinelBoot      boot;
    SentinelKnowledge knowledge;
    SenGraph          graph;
    SentinelAI        ai;
    SentinelAICore    core;
    SenBool           active;
} SentinelPrime;

SenStatus sentinel_prime_activate(SentinelPrime* prime,
                                  const char* repo_root);

SenStatus sentinel_prime_loop(SentinelPrime* prime);

/* -------------------------------------------------------------
   Sentinel Overmind
   ------------------------------------------------------------- */

typedef struct SentinelMicro {
    SentinelPrime prime;
    SenString     repo_name;
} SentinelMicro;

typedef struct SentinelOvermind {
    SentinelMicro* micros;
    int            micro_count;
    SenBool        active;
} SentinelOvermind;

SenStatus sentinel_overmind_activate(SentinelOvermind* om,
                                     const char** repo_names,
                                     int repo_count,
                                     const char* root);

SenStatus sentinel_overmind_sync(SentinelOvermind* om);

SenStatus sentinel_overmind_collective_decide(SentinelOvermind* om,
                                              SenAIAction* out_action);

SenStatus sentinel_overmind_collective_execute(SentinelOvermind* om,
                                               SenAIAction action);

#endif /* SENTINEL_API_H */
