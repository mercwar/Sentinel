#include "RETURN.H"

int AVIS_RETA = 0;
int AVIS_RETV = 0;

int WINmain_RET(int INT_RET)
{
    return INT_RET;
}

int AVIS_RETURN(int INT_RET)
{
    OutputDebugStringA("AVIS_RETURN:EXIT\n");
    return WINmain_RET(INT_RET);
}
