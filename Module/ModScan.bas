Attribute VB_Name = "ModScan"
Option Explicit
Public jumlah_file, JumDir As Single
Public Hasil, alamat As String
Public FileName As String
Public FileName2 As String


Const MAX_PATH = 260
Const INVALID_HANDLE_VALUE = -1
Const FILE_ATTRIBUTE_DIRECTORY = &H10

Public Type FILETIME
    dwLowDateTime As Long
    dwHighDateTime As Long
End Type

Public Type WIN32_FIND_DATA
    dwFileAttributes As Long
    ftCreationTime As FILETIME
    ftLastAccessTime As FILETIME
    ftLastWriteTime As FILETIME
    nFileSizeHigh As Long
    nFileSizeLow As Long
    dwReserved0 As Long
    dwReserved1 As Long
    cFileName As String * MAX_PATH
    cAlternate As String * 14
End Type

Dim NamaVirusNya As String
'-----------------------------------

Function StripNulls(OriginalStr As String) As String
    If (InStr(OriginalStr, Chr(0)) > 0) Then
        OriginalStr = Left(OriginalStr, InStr(OriginalStr, Chr(0)) - 1)
    End If
    StripNulls = OriginalStr
End Function

'///////////////////////////////////////////////////////////SCAN CEPAT///////////////////////////////////////////////////////////////

Public Function MulaiScan(path As String)

    Dim DirName As String
    Dim dirNames() As String
    Dim nDir As Integer
    Dim I As Integer
    Dim hSearch As Long
    Dim WFD As WIN32_FIND_DATA
    Dim Cont As Integer
    On Error Resume Next
    If UI.cmdScan.Caption = "Scan" Then Exit Function
    If Right(path, 1) <> "\" Then path = path & "\"
    nDir = 0
    ReDim dirNames(nDir)
    Cont = True
    hSearch = FindFirstFile(path & "*", WFD)
    If hSearch <> INVALID_HANDLE_VALUE Then
        Do While Cont
        DirName = StripNulls(WFD.cFileName)
        If (DirName <> ".") And (DirName <> "..") Then
            If GetFileAttributes(path & DirName) And _
            FILE_ATTRIBUTE_DIRECTORY Then
                dirNames(nDir) = DirName
                nDir = nDir + 1
                JumDir = JumDir + 1
                ReDim Preserve dirNames(nDir)
            End If
        End If
        Cont = FindNextFile(hSearch, WFD)
        DoEvents
        Loop
        Cont = FindClose(hSearch)
    End If
    hSearch = FindFirstFile(path & "*.*", WFD)
    Cont = True
    If hSearch <> INVALID_HANDLE_VALUE Then
        While Cont And UI.cmdScan.Caption = "Stop"
            FileName = StripNulls(WFD.cFileName)
            If (FileName <> ".") And (FileName <> "..") Then
                 jumlah_file = jumlah_file + 1
                 UI.Label2.Caption = path & FileName
                 alamat = path & FileName
                 UI.Label8.Caption = jumlah_file & " File Dan " & " [" & JumDir & "]" & " Folder "
                 If FileLen(alamat) >= 3000000 Then GoTo langsung
                 If Right(alamat, 6) = "_virus" Then GoTo langsung
                 CEK_DENGAN_CRC32 (alamat)
                 If UI.lstVirus.ListItems.Count > 0 Then
                    UI.bgscancepat.Picture = LoadPicture("")
                            UI.Label2.Top = 2765
                            UI.Label8.Top = 3360
                            UI.Label7.Top = 3720
                            UI.cmdScan.Top = 400
                            UI.cmdScan.Left = 6480
                            UI.tabscancepat.BackColor = &H8080FF
                            UI.Label7.Visible = True
                            UI.Label7.Caption = "Ancaman Ditemukan"
                            UI.lstVirus.Visible = True
                            UI.cmdKarantina.Visible = True
                            UI.cmdClean.Visible = True
                            Else
                            UI.Label7.Caption = "Belum ada Ancaman"
                End If
                         
langsung:
            End If
            Cont = FindNextFile(hSearch, WFD)
            DoEvents
        Wend
        Cont = FindClose(hSearch)
    End If
    If nDir > 0 Then
        For I = 0 To nDir - 1
            MulaiScan = MulaiScan + MulaiScan(path & dirNames(I) & "\")
            DoEvents
        Next I
    End If
End Function
Function CEK_DENGAN_CRC32(Lokasi As String)
Dim ceksum As String
Dim NamaVirus As String
Dim LV As ListItem
Dim crc As New ClsCrc
Dim materi() As Byte
Dim lcrc As Long
On Error Resume Next
  Open Lokasi For Binary As #1
  ReDim materi(LOF(1) - 1)
  Get #1, , materi
  Close #1
  lcrc = UBound(materi())
  lcrc = crc.CRC32(materi, lcrc)
  ceksum = UCase(Hex(lcrc))
NamaVirus = Cocokan_Ceksum1(ceksum)
If NamaVirus <> "" Then
    Set LV = UI.lstVirus.ListItems.Add(1, , FileName)
    LV.SubItems(1) = Lokasi
    LV.SubItems(2) = "Virus CRC32"
    LV.SubItems(3) = FileLen(Lokasi) & " B"
    Set LV = Nothing
End If
End Function


'///////////////////////////////////////////////////////////SCAN CERMAT//////////////////////////////////////////////////////////////


Function MulaiScan2(path As String)
    Dim a As String
    Dim b As String
    Dim DirName As String
    Dim dirNames() As String
    Dim nDir As Integer
    Dim I As Integer
    Dim hSearch As Long
    Dim WFD As WIN32_FIND_DATA
    Dim Cont As Integer
    On Error Resume Next
    If UI.cmdScan2.Caption = "Scan" Then Exit Function
    If Right(path, 1) <> "\" Then path = path & "\"
    nDir = 0
    ReDim dirNames(nDir)
    Cont = True
    hSearch = FindFirstFile(path & "*", WFD)
    If hSearch <> INVALID_HANDLE_VALUE Then
        Do While Cont
        DirName = StripNulls(WFD.cFileName)
        If (DirName <> ".") And (DirName <> "..") Then
            If GetFileAttributes(path & DirName) And _
            FILE_ATTRIBUTE_DIRECTORY Then
                dirNames(nDir) = DirName
                nDir = nDir + 1
                JumDir = JumDir + 1
                ReDim Preserve dirNames(nDir)
            End If
        End If
        Cont = FindNextFile(hSearch, WFD)
        DoEvents
        Loop
        Cont = FindClose(hSearch)
    End If
    hSearch = FindFirstFile(path & "*.*", WFD)
    Cont = True
    If hSearch <> INVALID_HANDLE_VALUE Then
        While Cont And UI.cmdScan2.Caption = "Stop"
            FileName2 = StripNulls(WFD.cFileName)
            If (FileName2 <> ".") And (FileName2 <> "..") Then
                 jumlah_file = jumlah_file + 1
                 UI.Label22.Caption = path & FileName2
                 alamat = path & FileName2
                 UI.Label82.Caption = jumlah_file & " File Dan " & " [" & JumDir & "]" & " Folder "
                 If FileLen(alamat) >= 2024288 Then GoTo langsung
                 If Right(alamat, 6) = "_virus" Then GoTo langsung
                 If InStr("JPG BMP PNG ICO XLS XLSX CAB MSI INI LOG TTF TMP XML CSV BIN DAT RAR ZIP DOC DOCX PPT PPTX TXT PDF DLL PEG REG OCX CTL CTX FILE MP4 MP3 WAV MKV APK", UCase(Right(path, 3))) > 0 Then GoTo langsung
                    a = EkstensiGanda(alamat)
                    If a <> "" Then GoTo ada
                    b = CEK_DENGAN_CRC322(alamat)
                    If b <> "" Then GoTo ada
                    CEK_DENGAN_MD5 (alamat)
                    
ada:
                 If UI.lstVirus2.ListItems.Count > 0 Then
                        UI.bgscancermat.Picture = LoadPicture("")
                            UI.Label22.Top = 2765
                            UI.Label82.Top = 3360
                            UI.Label72.Top = 3720
                            UI.cmdScan2.Top = 400
                            UI.cmdScan2.Left = 6480
                            UI.tabscancermat.BackColor = &H8080FF
                            UI.Label72.Visible = True
                            UI.Label72.Caption = "Ancaman Ditemukan"
                            UI.lstVirus2.Visible = True
                            UI.cmdKarantina2.Visible = True
                            UI.cmdClean2.Visible = True
                            Else
                            UI.Label72.Caption = "Belum ada Ancaman"
                End If
                         
langsung:
            End If
            Cont = FindNextFile(hSearch, WFD)
            DoEvents
        Wend
        Cont = FindClose(hSearch)
    End If
    If nDir > 0 Then
        For I = 0 To nDir - 1
            MulaiScan2 = MulaiScan2 + MulaiScan2(path & dirNames(I) & "\")
            DoEvents
        Next I
    End If
End Function
Function CEK_DENGAN_MD5(Lokasi As String)
Dim Ceksum2 As String
Dim NamaVirus2 As String
Dim LV2 As ListItem
DoEvents
Ceksum2 = LCase(GetMD5(Lokasi))
NamaVirus2 = Cocokan_Ceksum_MD5(Ceksum2)
If NamaVirus2 <> "" Then
    Set LV2 = UI.lstVirus2.ListItems.Add(1, , FileName2)
    LV2.SubItems(1) = Lokasi
    LV2.SubItems(2) = "Virus MD5"
    LV2.SubItems(3) = FileLen(Lokasi) & " B"
    Set LV2 = Nothing
End If
End Function
Function CEK_DENGAN_CRC322(Lokasi As String) As String
Dim ceksum As String
Dim NamaVirus As String
Dim LV As ListItem
Dim crc As New ClsCrc
Dim materi() As Byte
Dim lcrc As Long
On Error Resume Next
CEK_DENGAN_CRC322 = ""
DoEvents
  Open Lokasi For Binary As #1
  ReDim materi(LOF(1) - 1)
  Get #1, , materi
  Close #1
  lcrc = UBound(materi())
  lcrc = crc.CRC32(materi, lcrc)
  ceksum = UCase(Hex(lcrc))
NamaVirus = Cocokan_Ceksum1(ceksum)
If NamaVirus <> "" Then
    Set LV = UI.lstVirus2.ListItems.Add(1, , FileName2)
    LV.SubItems(1) = Lokasi
    LV.SubItems(2) = "Virus CRC32"
    LV.SubItems(3) = FileLen(Lokasi) & " B"
    Set LV = Nothing
    CEK_DENGAN_CRC322 = "Ada"
End If

End Function

Private Function EkstensiGanda(Lokasi As String) As String
On Error Resume Next
Dim LV As ListItem
EkstensiGanda = ""
NamaVirusNya = "Virus ekstensi ganda"
If IsDoubleExt(Lokasi) = True Then
    Set LV = UI.lstVirus2.ListItems.Add(1, , FileName2)
        LV.SubItems(1) = Lokasi
        LV.SubItems(2) = "Virus Ekstensi Ganda"
        LV.SubItems(3) = FileLen(Lokasi) & " B"
    Set LV = Nothing
    EkstensiGanda = "Ada"
End If
End Function

Function IsDoubleExt(path As String) As Boolean
Dim sTrX As String
If InStr("EXE COM SCR PIF MSD VBS BAT", UCase(Right(path, 3))) > 0 And InStr("JPG BMP DOC TXT DLL VBS PEG REG OCX FILE MP4 MKV APK", UCase(Mid(Right(Replace(path, " ", ""), 7), 1, 3))) > 0 Then
    sTrX = Replace(path, " ", "")
    sTrX = Right(sTrX, 8)
    If Left(sTrX, 1) = "." And Mid(sTrX, 5, 1) = "." Then
        IsDoubleExt = True
            Else
        IsDoubleExt = False
    End If
Else
    Exit Function
End If
End Function
