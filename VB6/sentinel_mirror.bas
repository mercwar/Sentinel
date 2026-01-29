' BGIN
' /* AVIS_COORD: AVIS://VB6/MIRROR/TERMINAL_V1.0/CVBGOD */
' /* ROLE: Mirrors SIL (console_copy.txt) to MS Command.com UI */

Option Explicit

Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Private Const WM_SETTEXT As Long = &HC

' /* sci_note: Polls the SIL surface and injects into the Terminal */
Public Sub SyncTerminal(ByVal targetHwnd As Long)
    Dim strBuffer As String
    Dim intFile As Integer
    
    ' 1. BEGIN: Handshake with the SIL surface
    intFile = FreeFile
    Open App.Path & "\console_copy.txt" For Input As #intFile
        
    ' 2. SYNC: Read the latest Pulse from the Heavy Dependency
    Line Input #intFile, strBuffer
    Close #intFile
    
    ' 3. WM_SETTEXT: Force the SIL state into the Win32 Command UI
    ' This is the official MS Command.com handshake
    If Len(strBuffer) > 0 Then
        SendMessage targetHwnd, WM_SETTEXT, 0, ByVal strBuffer
    End If
End Sub

' /* AVIS-DATALAKE-VERSION 1.0.CVBGOD .return(1) */
``` [INDEX]