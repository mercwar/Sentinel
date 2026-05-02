/*
    sentinel_boot.c

    PURPOSE:
        Implementation of the Sentinel boot engine.
*/

#include "sentinel_boot.h"

SenStatus sentinel_boot_system(SentinelBoot* boot, const char* repo_root) {
    if (!boot || !repo_root) return SEN_STATUS_ERROR_INVALID_ARGUMENT;

    SenStatus st;

    /* Initialize navigation engine */
    st = sentinel_boot(&boot->ctx, repo_root);
    if (st != SEN_STATUS_OK) return st;

    /* Activate robot navigation protocol */
    st = sentinel_robot_protocol_activate(&boot->ctx);
    if (st != SEN_STATUS_OK) {
        sentinel_shutdown(&boot->ctx);
        return st;
    }

    boot->ready = SEN_TRUE;
    return SEN_STATUS_OK;
}

void sentinel_shutdown_system(SentinelBoot* boot) {
    if (!boot) return;
    if (boot->ready) {
        sentinel_robot_protocol_shutdown(&boot->ctx);
        sentinel_shutdown(&boot->ctx);
        boot->ready = SEN_FALSE;
    }
}
