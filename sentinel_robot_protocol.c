/*
    sentinel_robot_protocol.c

    PURPOSE:
        Implementation of the robot navigation protocol.
*/

#include "sentinel_robot_protocol.h"

#include <stdlib.h>

static SentinelRobotProtocol PROTOCOL;

SenStatus sentinel_robot_protocol_activate(SentinelContext* ctx) {
    if (!ctx) return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    sentinel_get_traversal_order(ctx,
                                 &PROTOCOL.traversal,
                                 &PROTOCOL.traversal_count);

    sentinel_get_search_order(ctx,
                              &PROTOCOL.search,
                              &PROTOCOL.search_count);

    PROTOCOL.active = SEN_TRUE;
    return SEN_STATUS_OK;
}

void sentinel_robot_protocol_shutdown(SentinelContext* ctx) {
    (void)ctx;
    PROTOCOL.active = SEN_FALSE;
}

SenStatus sentinel_robot_locate(SentinelContext* ctx,
                                const char* repo_name,
                                SenDirectory** out_dir) {
    if (!ctx || !repo_name || !out_dir) {
        return SEN_STATUS_ERROR_INVALID_ARGUMENT;
    }
    return sentinel_resolve_repo(ctx, repo_name, out_dir);
}

SenStatus sentinel_robot_return_home(SentinelContext* ctx,
                                     SenDirectory** out_dir) {
    return sentinel_return_home(&ctx->graph, out_dir);
}
