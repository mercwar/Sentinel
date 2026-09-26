/*******************************************************************************
 * [AVIS MODULE LOG]: engine_core.c
 *******************************************************************************/
#include "engine_core.h"
#include "config.h"

int InitializeGraphicalWindow(HINSTANCE hInstance, int nCmdShow) {
    WNDCLASS wc = {0};
    wc.lpfnWndProc = WindowProcedure;
    wc.hInstance = hInstance;
    wc.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);
    wc.lpszClassName = "SentinelEv4EngineClass";

    if (!RegisterClass(&wc)) return 0;

    HWND hwnd = CreateWindow(
        "SentinelEv4EngineClass", WINDOW_TITLE,
        WS_OVERLAPPEDWINDOW | WS_VISIBLE,
        CW_USEDEFAULT, CW_USEDEFAULT, DEF_WINDOW_WIDTH, DEF_WINDOW_HEIGHT,
        NULL, NULL, hInstance, NULL
    );

    if (!hwnd) return 0;

    ShowWindow(hwnd, nCmdShow);
    UpdateWindow(hwnd);

    MSG msg;
    while (GetMessage(&msg, NULL, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }
    return (int)msg.wParam;
}

LRESULT CALLBACK WindowProcedure(HWND hwnd, UINT msg, WPARAM wp, LPARAM lp) {
    switch (msg) {
        case WM_PAINT: {
            PAINTSTRUCT ps;
            HDC hdc = BeginPaint(hwnd, &ps);
            TextOut(hdc, 20, 20, "SENTINEL EV.4 ENGINE ACTIVE: Core Modules Ingested Instantly.", 61);
            EndPaint(hwnd, &ps);
            break;
        }
        case WM_DESTROY:
            PostQuitMessage(0);
            break;
        default:
            return DefWindowProc(hwnd, msg, wp, lp);
    }
    return 0;
}
