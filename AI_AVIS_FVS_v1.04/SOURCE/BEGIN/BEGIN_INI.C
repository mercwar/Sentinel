// ------------------------------------------------------------
// AVIS FILE: BEGIN/BEGIN_INI.C
// ROLE: INI loader for ADO (address/pointer/buffer)
// ------------------------------------------------------------

#include <windows.h>
#include <stdlib.h>
#include "BEGIN/BEGIN.H"

static const char *g_iniPath = "H:\\htdocs\\robo-knight\\AI_AVIS_FVS\\AVIS_PRJ_SCAN\\AVIS_PRJ_SCAN.INI";

static unsigned long GetIniULong(const char *section, const char *key, unsigned long defVal)
{
    char buf[64] = {0};
    GetPrivateProfileStringA(section, key, "", buf, sizeof(buf), g_iniPath);
    if (buf[0] == '\0')
        return defVal;
    return strtoul(buf, NULL, 10);
}

static int GetIniInt(const char *section, const char *key, int defVal)
{
    return (int)GetPrivateProfileIntA(section, key, defVal, g_iniPath);
}

void BEGIN_LoadADOFromINI(void)
{
    // Address numbers
    BEGIN.ADDR_SEED           = GetIniULong("ADO", "ADO_ADDR_SEED", 0);
    BEGIN.ADDR_MASTER         = GetIniULong("ADO", "ADO_ADDR_MASTER", 0);
    BEGIN.ADDR_MASTER_CONVERT = GetIniULong("ADO", "ADO_ADDR_MASTER_CONVERT", 0);
    BEGIN.ADDR_MASTER_COMBILE = GetIniULong("ADO", "ADO_ADDR_MASTER_COMBILE", 0);

    // Pointer numbers
    BEGIN.PTR_SEED            = GetIniULong("ADO", "ADO_PTR_SEED", 0);
    BEGIN.PTR_MASTER          = GetIniULong("ADO", "ADO_PTR_MASTER", 0);
    BEGIN.PTR_MASTER_CONVERT  = GetIniULong("ADO", "ADO_PTR_MASTER_CONVERT", 0);
    BEGIN.PTR_MASTER_COMBILE  = GetIniULong("ADO", "ADO_PTR_MASTER_COMBILE", 0);

    // Buffer enums
    BEGIN.BUF_SEED            = GetIniInt("ADO", "ADO_BUF_SEED", 1);
    BEGIN.BUF_MASTER          = GetIniInt("ADO", "ADO_BUF_MASTER", 2);
    BEGIN.BUF_MASTER_CONVERT  = GetIniInt("ADO", "ADO_BUF_MASTER_CONVERT", 3);
    BEGIN.BUF_MASTER_COMBILE  = GetIniInt("ADO", "ADO_BUF_MASTER_COMBILE", 4);
}
