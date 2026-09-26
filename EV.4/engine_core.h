/*******************************************************************************
 * [AVIS MODULE LOG]: engine_core.h
 *******************************************************************************/
#ifndef ENGINE_CORE_H
#define ENGINE_CORE_H

#include <windows.h>

// Graphical Window Entrypoints for MSVC/Win32
int InitializeGraphicalWindow(HINSTANCE hInstance, int nCmdShow);
LRESULT CALLBACK WindowProcedure(HWND hwnd, UINT msg, WPARAM wp, LPARAM lp);
void RenderStatusText(HWND hwnd, const char *text);

#endif
