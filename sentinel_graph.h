/*
    sentinel_graph.h

    PURPOSE:
        Graph engine for robot memory.
        Stores nodes, edges, and relationships between repos.
*/

#ifndef SENTINEL_GRAPH_H
#define SENTINEL_GRAPH_H

#include "sentinel_boot.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct SenGraphNode {
    SenString name;
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

#ifdef __cplusplus
}
#endif

#endif /* SENTINEL_GRAPH_H */
