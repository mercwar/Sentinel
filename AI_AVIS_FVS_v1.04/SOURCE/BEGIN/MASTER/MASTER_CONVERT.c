// FILE: MASTER_CONVERT.c

#define __STDC_WANT_LIB_EXT1__ 1
#if !defined(_TRUNCATE)
#define _TRUNCATE ((size_t)-1)
#endif

#include "BEGIN\MASTER\MASTER_CONVERT.H"
#include "AVIS_LEGACY.H"

#include <wchar.h>
#include <stdio.h>
#include <locale.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

/* ---------------------------------------------------------
   REQUIRED FORWARD DECLARATIONS
   (Fixes ACT/ATW/WTA/WTW undeclared errors)
--------------------------------------------------------- */
char *ACT(HWND hwnd, wchar_t *WSTR, int LSTR);
char *ATW(HWND hwnd, char *STR, int LSTR);
wchar_t *WTA(HWND hwnd, wchar_t *WSTR, int LSTR);
wchar_t *WTW(HWND hwnd, wchar_t *WSTR, int LSTR);

/* ---------------------------------------------------------
   GLOBAL BUFFER (legacy)
--------------------------------------------------------- */
static wchar_t *gwcP = NULL;

/* ---------------------------------------------------------
   CORE CONVERSION FUNCTIONS (MATCH HEADER)
--------------------------------------------------------- */

wchar_t *pbuff(HWND hwnd, char *STR)
{
    setlocale(LC_ALL, "en_US.UTF-8");

    const char *multiByteString = STR;
    wchar_t *wideStringBuffer = NULL;
    size_t requiredSizeInWords = 0;
    int sz_str = (int)strlen(multiByteString);

    mbstowcs_s(&requiredSizeInWords, NULL, 0, multiByteString, (size_t)sz_str);

    wideStringBuffer = (wchar_t *)malloc((requiredSizeInWords + 1) * sizeof(wchar_t));
    if (!wideStringBuffer) return L"EXIT_FAILURE 2";

    size_t convertedCharsCount = 0;
    mbstowcs_s(&convertedCharsCount, wideStringBuffer, requiredSizeInWords, multiByteString, (size_t)sz_str);

    gwcP = (wchar_t *)malloc((requiredSizeInWords + 1) * sizeof(wchar_t));
    if (!gwcP) return L"EXIT_FAILURE 4";

    wcsncpy(gwcP, wideStringBuffer, requiredSizeInWords);
    gwcP[requiredSizeInWords] = L'\0';

    free(wideStringBuffer);
    return gwcP;
}

void FREEWT(wchar_t *wcP)
{
    wcP = NULL;
    free(wcP);
    wcP = NULL;
}

wchar_t *WCT(HWND hwnd, char *STR, int LSTR)
{
    setlocale(LC_ALL, "en_US.UTF-8");

    wchar_t *wcP;
    wchar_t wcB[(size_t)LSTR];
    wcP = wcB;

    size_t convertedChars = 0;
    mbstowcs_s(&convertedChars, wcP, (size_t)LSTR, STR, (size_t)LSTR);

    FREEWT(wcP);
    wcP = NULL;

    return pbuff(hwnd, STR);
}

/* ---------------------------------------------------------
   POINTER-BASED CONVERTERS (MATCH HEADER)
--------------------------------------------------------- */

char *CCP(char c)
{
    char *buf = (char *)malloc(2);
    buf[0] = c;
    buf[1] = '\0';
    return buf;
}

wchar_t *WCP(wchar_t wc)
{
    wchar_t *buf = (wchar_t *)malloc(2 * sizeof(wchar_t));
    buf[0] = wc;
    buf[1] = L'\0';
    return buf;
}

char *ACP(const char *STR)
{
    return STR ? _strdup(STR) : NULL;
}

wchar_t *WCPTR(const wchar_t *WSTR)
{
    if (!WSTR) return NULL;

    size_t len = wcslen(WSTR);
    wchar_t *buf = (wchar_t *)malloc((len + 1) * sizeof(wchar_t));
    wcscpy(buf, WSTR);
    return buf;
}

/* ---------------------------------------------------------
   STRING-TO-STRING CONVERTERS (MATCH HEADER)
--------------------------------------------------------- */

wchar_t *STRtoW(HWND hwnd, const char *STR)
{
    (void)hwnd;
    if (!STR) return NULL;

    int len = (int)strlen(STR);
    wchar_t *buf = (wchar_t *)malloc((len + 1) * sizeof(wchar_t));
    MultiByteToWideChar(CP_ACP, 0, STR, len, buf, len);
    buf[len] = L'\0';
    return buf;
}

char *STRtoA(HWND hwnd, const wchar_t *WSTR)
{
    return ACT(hwnd, (wchar_t *)WSTR, -1);
}

wchar_t *AtoSTR(HWND hwnd, const char *STR)
{
    return STRtoW(hwnd, STR);
}

char *WtoSTR(HWND hwnd, const wchar_t *WSTR)
{
    return ACT(hwnd, (wchar_t *)WSTR, -1);
}

/* ---------------------------------------------------------
   DUPLICATE-NAMED CONVERTERS (MATCH HEADER)
--------------------------------------------------------- */

char *ACT(HWND hwnd, wchar_t *WSTR, int LSTR)
{
    (void)hwnd;
    if (!WSTR) return NULL;

    int len = (LSTR >= 0) ? LSTR : (int)wcslen(WSTR);
    int alen = WideCharToMultiByte(CP_ACP, 0, WSTR, len, NULL, 0, NULL, NULL);

    char *buf = (char *)malloc(alen + 1);
    if (!buf) return NULL;

    WideCharToMultiByte(CP_ACP, 0, WSTR, len, buf, alen, NULL, NULL);
    buf[alen] = '\0';
    return buf;
}

char *ATW(HWND hwnd, char *STR, int LSTR)
{
    (void)hwnd;
    (void)LSTR;
    return STR ? _strdup(STR) : NULL;
}

wchar_t *WTA(HWND hwnd, wchar_t *WSTR, int LSTR)
{
    (void)hwnd;
    if (!WSTR) return NULL;

    int len = (LSTR >= 0) ? LSTR : (int)wcslen(WSTR);
    wchar_t *buf = (wchar_t *)malloc((len + 1) * sizeof(wchar_t));
    if (!buf) return NULL;

    wcsncpy(buf, WSTR, len);
    buf[len] = L'\0';
    return buf;
}

wchar_t *WTW(HWND hwnd, wchar_t *WSTR, int LSTR)
{
    return WTA(hwnd, WSTR, LSTR);
}

/* ---------------------------------------------------------
   AVIS REGISTRATION
--------------------------------------------------------- */



void MASTER_CONVERT_RegisterWithAVIS(void)
{
    AVIS_RegisterLegacy("WCT",        (void *)WCT);
    AVIS_RegisterLegacy("pbuff",      (void *)pbuff);
    AVIS_RegisterLegacy("FREEWT",     (void *)FREEWT);

    AVIS_RegisterLegacy("CCP",        (void *)CCP);
    AVIS_RegisterLegacy("WCP",        (void *)WCP);
    AVIS_RegisterLegacy("ACP",        (void *)ACP);
    AVIS_RegisterLegacy("WCPTR",      (void *)WCPTR);

    AVIS_RegisterLegacy("STRtoW",     (void *)STRtoW);
    AVIS_RegisterLegacy("STRtoA",     (void *)STRtoA);
    AVIS_RegisterLegacy("AtoSTR",     (void *)AtoSTR);
    AVIS_RegisterLegacy("WtoSTR",     (void *)WtoSTR);

    AVIS_RegisterLegacy("ACT",        (void *)ACT);
    AVIS_RegisterLegacy("ATW",        (void *)ATW);
    AVIS_RegisterLegacy("WTA",        (void *)WTA);
    AVIS_RegisterLegacy("WTW",        (void *)WTW);
}
