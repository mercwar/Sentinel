/*
    sentinel_robot_protocol.h

    PURPOSE:
        Robot navigation protocol.
        Teaches robots how to:
            - follow traversal order
            - follow search order
            - locate repos
            - return home
            - avoid getting lost
*/

#ifndef SENTINEL_ROBOT_PROTOCOL_H
#define SENTINEL_ROBOT_PROTOCOL_H

#include "sentinel_nav.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct SentinelRobotProtocol {
    const char** traversal;
    int          traversal_count;

    const char** search;
    int          search_count;

    SenBool      active;
} SentinelRobotProtocol;

SenStatus sentinel_robot_protocol_activate(SentinelContext* ctx);
void      sentinel_robot_protocol_shutdown(SentinelContext* ctx);

/* Robot helper APIs */
SenStatus sentinel_robot_locate(SentinelContext* ctx,
                                const char* repo_name,
                                SenDirectory** out_dir);

SenStatus sentinel_robot_return_home(SentinelContext* ctx,
                                     SenDirectory** out_dir);

#ifdef __cplusplus
}
#endif

#endif /* SENTINEL_ROBOT_PROTOCOL_H */
