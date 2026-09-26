/*******************************************************************************
 * [AVIS MODULE LOG]: stargate_routes.h
 *******************************************************************************/
#ifndef STARGATE_ROUTES_H
#define STARGATE_ROUTES_H

typedef struct {
    char route_path[256];
    int active_status;
    char target_gateway[128];
} StargateRoute;

void InitializeStargateGateway(void);
void DispatchRouteSync(const char *route_name);

#endif
