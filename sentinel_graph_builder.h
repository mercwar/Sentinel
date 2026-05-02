/*
    sentinel_graph_builder.h

    PURPOSE:
        Builds the robot memory graph from:
            - MERCWAR.CONSTELLATION.AVIS
            - SENTINEL.MEMORYGRAPH.AVIS
*/

#ifndef SENTINEL_GRAPH_BUILDER_H
#define SENTINEL_GRAPH_BUILDER_H

#include "sentinel_graph.h"

#ifdef __cplusplus
extern "C" {
#endif

SenStatus sentinel_graph_build(SenGraph* graph);

#ifdef __cplusplus
}
#endif

#endif /* SENTINEL_GRAPH_BUILDER_H */
