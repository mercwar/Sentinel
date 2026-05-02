/*
    sentinel_graph.c

    PURPOSE:
        Implementation of robot memory graph engine.
*/

#include "sentinel_graph.h"

#include <stdlib.h>
#include <string.h>

static SenString sg_make_string(const char* s) {
    SenString str;
    str.data   = s;
    str.length = s ? (int)strlen(s) : 0;
    return str;
}

SenStatus sentinel_graph_init(SenGraph* graph) {
    if (!graph) return SEN_STATUS_ERROR_INVALID_ARGUMENT;
    graph->nodes      = NULL;
    graph->node_count = 0;
    graph->edges      = NULL;
    graph->edge_count = 0;
    return SEN_STATUS_OK;
}

SenStatus sentinel_graph_add_node(SenGraph* graph,
                                  const char* name,
                                  SenRepoType type) {
    if (!graph || !name) return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    int new_count = graph->node_count + 1;
    SenGraphNode* new_nodes = realloc(graph->nodes,
                                      sizeof(SenGraphNode) * new_count);
    if (!new_nodes) return SEN_STATUS_ERROR_INTERNAL;

    graph->nodes = new_nodes;
    graph->nodes[graph->node_count].name = sg_make_string(name);
    graph->nodes[graph->node_count].type = type;
    graph->node_count = new_count;

    return SEN_STATUS_OK;
}

SenStatus sentinel_graph_add_edge(SenGraph* graph,
                                  const char* from,
                                  const char* to,
                                  const char* relation) {
    if (!graph || !from || !to || !relation)
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    int new_count = graph->edge_count + 1;
    SenGraphEdge* new_edges = realloc(graph->edges,
                                      sizeof(SenGraphEdge) * new_count);
    if (!new_edges) return SEN_STATUS_ERROR_INTERNAL;

    graph->edges = new_edges;
    graph->edges[graph->edge_count].from     = sg_make_string(from);
    graph->edges[graph->edge_count].to       = sg_make_string(to);
    graph->edges[graph->edge_count].relation = sg_make_string(relation);
    graph->edge_count = new_count;

    return SEN_STATUS_OK;
}

void sentinel_graph_free(SenGraph* graph) {
    if (!graph) return;
    if (graph->nodes) free(graph->nodes);
    if (graph->edges) free(graph->edges);
    graph->nodes = NULL;
    graph->edges = NULL;
    graph->node_count = 0;
    graph->edge_count = 0;
}
