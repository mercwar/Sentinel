/*
    sentinel_graph_builder.c

    PURPOSE:
        Hard-coded graph builder for learning.
        In a full system, this would parse AVIS files.
*/

#include "sentinel_graph_builder.h"

SenStatus sentinel_graph_build(SenGraph* graph) {
    if (!graph) return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    sentinel_graph_init(graph);

    /* Nodes */
    sentinel_graph_add_node(graph, "AVIS-DATALAKE", SEN_REPO_TYPE_CORE);
    sentinel_graph_add_node(graph, "AVIS", SEN_REPO_TYPE_CORE);
    sentinel_graph_add_node(graph, "AVIS-ALERT-FVS", SEN_REPO_TYPE_CORE);
    sentinel_graph_add_node(graph, "AVIS-AI-INI-DIR-MK-SCAN", SEN_REPO_TYPE_TOOLING);
    sentinel_graph_add_node(graph, "CYHY-CMT", SEN_REPO_TYPE_CORE);

    sentinel_graph_add_node(graph, "Fire-Gem", SEN_REPO_TYPE_CORE);
    sentinel_graph_add_node(graph, "Dark-Com", SEN_REPO_TYPE_CORE);
    sentinel_graph_add_node(graph, "Sentinel", SEN_REPO_TYPE_CORE);
    sentinel_graph_add_node(graph, "NEXUS", SEN_REPO_TYPE_CORE);

    sentinel_graph_add_node(graph, "Robo-Knight-Gallery", SEN_REPO_TYPE_LANGUAGE);
    sentinel_graph_add_node(graph, "Robo-Knight-Player", SEN_REPO_TYPE_LANGUAGE);
    sentinel_graph_add_node(graph, "Robo-Knight-Demos", SEN_REPO_TYPE_LANGUAGE);
    sentinel_graph_add_node(graph, "robo-knight-inventory", SEN_REPO_TYPE_LANGUAGE);

    sentinel_graph_add_node(graph, "CVBGODLY-CONSOLE", SEN_REPO_TYPE_TOOLING);
    sentinel_graph_add_node(graph, "CYBORG-PROJECT-EXPLORER", SEN_REPO_TYPE_TOOLING);
    sentinel_graph_add_node(graph, "Cyborg", SEN_REPO_TYPE_LANGUAGE);
    sentinel_graph_add_node(graph, "JMC-ANDROID-APP-DEMO", SEN_REPO_TYPE_EXAMPLE);
    sentinel_graph_add_node(graph, "mercwar", SEN_REPO_TYPE_CORE);

    /* Edges */
    sentinel_graph_add_edge(graph, "AVIS", "AVIS-DATALAKE", "feeds");
    sentinel_graph_add_edge(graph, "AVIS-ALERT-FVS", "AVIS", "extends");
    sentinel_graph_add_edge(graph, "AVIS-AI-INI-DIR-MK-SCAN", "AVIS-DATALAKE", "scans");
    sentinel_graph_add_edge(graph, "CYHY-CMT", "AVIS", "computes");

    sentinel_graph_add_edge(graph, "Fire-Gem", "NEXUS", "powers");
    sentinel_graph_add_edge(graph, "Dark-Com", "NEXUS", "communicates");
    sentinel_graph_add_edge(graph, "Sentinel", "NEXUS", "controls");

    sentinel_graph_add_edge(graph, "Robo-Knight-Player", "Robo-Knight-Gallery", "uses");
    sentinel_graph_add_edge(graph, "Robo-Knight-Demos", "Robo-Knight-Player", "demonstrates");
    sentinel_graph_add_edge(graph, "robo-knight-inventory", "Robo-Knight-Player", "supplies");

    sentinel_graph_add_edge(graph, "Cyborg", "CYBORG-PROJECT-EXPLORER", "explores");
    sentinel_graph_add_edge(graph, "CVBGODLY-CONSOLE", "Cyborg", "executes");

    sentinel_graph_add_edge(graph, "mercwar", "Sentinel", "hosts");

    return SEN_STATUS_OK;
}
