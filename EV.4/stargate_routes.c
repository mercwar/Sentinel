/*******************************************************************************
 * [AVIS MODULE LOG]: stargate_routes.c
 *******************************************************************************/
#include <stdio.h>
#include <string.h>
#include "stargate_routes.h"

static StargateRoute runtime_routes[4];

void InitializeStargateGateway(void) {
    strcpy_s(runtime_routes[0].route_path, 256, "/Station");
    strcpy_s(runtime_routes[1].route_path, 256, "/Stargate");
    strcpy_s(runtime_routes[2].route_path, 256, "/NEXUS");
    strcpy_s(runtime_routes[3].route_path, 256, "/AVIS-DATALAKE");

    for (int i = 0; i < 4; i++) {
        runtime_routes[i].active_status = 1;
        sprintf_s(runtime_routes[i].target_gateway, 128, "EV4_Gateway_Alpha_%d", i);
    }
}

void DispatchRouteSync(const char *route_name) {
    for (int i = 0; i < 4; i++) {
        if (strcmp(runtime_routes[i].route_path, route_name) == 0) {
            runtime_routes[i].active_status = 2; 
            break;
        }
    }
}
