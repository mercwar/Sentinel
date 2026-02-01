#ifndef MASTER_CONVERT_H
#define MASTER_CONVERT_H

#define __STDC_WANT_LIB_EXT1__ 1

#include <windows.h>
#include <wchar.h>
#include <stdlib.h>
#include <string.h>
#include <locale.h>
#include <errno.h>
#include <ctype.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct _MASTER_CONVERT {

    void *GF;

    void *(*Call)(struct _MASTER_CONVERT *self,
                  const char *toType,
                  const char *fromType,
                  void *data,
                  int length);

    void (*Log)(const char *msg);

    int   (*CountDigits)(int value);
    char *(*IntToString)(int value);
    int   (*StringToInt)(const char *STR);

    wchar_t *(*WCT)(HWND hwnd, char *STR, int LSTR);
    wchar_t *(*pbuff)(HWND hwnd, char *STR);
    void     (*FREEWT)(wchar_t *wcP);

    char    *(*CCP)(char c);
    wchar_t *(*WCP)(wchar_t wc);
    char    *(*ACP)(const char *STR);
    wchar_t *(*WCPTR)(const wchar_t *WSTR);

    wchar_t *(*STRtoW)(HWND hwnd, const char *STR);
    char    *(*STRtoA)(HWND hwnd, const wchar_t *WSTR);
    wchar_t *(*AtoSTR)(HWND hwnd, const char *STR);
    char    *(*WtoSTR)(HWND hwnd, const wchar_t *WSTR);

    char    *(*ACT)(HWND hwnd, wchar_t *WSTR, int LSTR);
    char    *(*ATW)(HWND hwnd, char *STR, int LSTR);
    wchar_t *(*WTA)(HWND hwnd, wchar_t *WSTR, int LSTR);
    wchar_t *(*WTW)(HWND hwnd, wchar_t *WSTR, int LSTR);

    char    *(*CharToAnsi)(char c);
    wchar_t *(*CharToWide)(char c);
    char    *(*WCharToAnsi)(wchar_t wc);
    wchar_t *(*WCharToWide)(wchar_t wc);

    char    *(*AnsiToAnsi)(const char *STR);
    wchar_t *(*WideToWide)(const wchar_t *WSTR);
    wchar_t *(*AnsiToWideA)(const char *STR);
    char    *(*WideToAnsiW)(const wchar_t *WSTR);

} MASTER_CONVERT;

MASTER_CONVERT *MC_Create(void *GF);
void MC_Destroy(MASTER_CONVERT *mc);
void MASTER_CONVERT_RegisterWithAVIS(void);

#ifdef __cplusplus
}
#endif

#endif /* MASTER_CONVERT_H */
