/*
    sentinel_boot.h

    PURPOSE:
        High-level Sentinel boot engine.
        This is the single entry point robots call at startup.
*/

#ifndef SENTINEL_BOOT_H
#define SENTINEL_BOOT_H

#include "sentinel_nav.h"
#include "sentinel_robot_protocol.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct SentinelBoot {
    SentinelContext ctx;
    SenBool         ready;
} SentinelBoot;

SenStatus sentinel_boot_system(SentinelBoot* boot, const char* repo_root);
void      sentinel_shutdown_system(SentinelBoot* boot);

#ifdef __cplusplus
}
#endif

#endif /* SENTINEL_BOOT_H */
