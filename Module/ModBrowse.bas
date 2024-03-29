Attribute VB_Name = "ModBrowse"
    
Public Type BrowseInfo
    lnghWnd As Long
    pIDLRoot As Long
    pszDisplayName As Long
    lpszTitle As Long
    ulFlags As Long
    lpfnCallback As Long
    lParam As Long
    iImage As Long
End Type

Public Const BIF_NEWDIALOGSTYLE As Long = &H40
Public Const BIF_EDITBOX As Long = &H10
Public Const MAX_PATH As Integer = 260


Public Function BrowseForFolder(ByVal hWndOwner As Long, _
    ByVal strPrompt As String) As String

    On Error GoTo ErrHandle
    
    Dim intNull As Integer
    Dim lngIDList As Long, lngResult As Long
    Dim strPath As String
    Dim udtBI As BrowseInfo
    
    With udtBI
        .lnghWnd = hWndOwner
        .lpszTitle = lstrcat(strPrompt, "")
        .ulFlags = BIF_NEWDIALOGSTYLE + BIF_EDITBOX
    End With
    
    lngIDList = SHBrowseForFolder(udtBI)
    
    If lngIDList <> 0 Then
        strPath = String(MAX_PATH, 0)
        lngResult = SHGetPathFromIDList(lngIDList, _
            strPath)
        Call CoTaskMemFree(lngIDList)
        intNull = InStr(strPath, vbNullChar)
            If intNull > 0 Then
                strPath = Left(strPath, intNull - 1)
            End If
    End If

    BrowseForFolder = strPath
    Exit Function
    
ErrHandle:
    BrowseForFolder = Empty
    
End Function






