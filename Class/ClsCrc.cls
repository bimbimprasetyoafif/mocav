VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ClsCrc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Private crcTable(0 To 255) As Long
Public Function CRC32(ByRef bArrayIn() As Byte, ByVal lLen As Long, Optional ByVal lcrc As Long = 0) As Long
  Dim lCurPos As Long
  Dim lTemp As Long
  If lLen = 0 Then Exit Function
  'Untuk menghitung CRC32 suatu file kita perlu ukuran dari file tersebut dan mengeset standar perbandingan untuk CRC32 ke heksa FFFFFFFF. Kemudian untuk mengecek nilai yang ada tiap byte nya
  lTemp = lcrc Xor &HFFFFFFFF
  For lCurPos = 0 To lLen
    lTemp = (((lTemp And &HFFFFFF00) \ &H100) And &HFFFFFF) Xor (crcTable((lTemp And 255) Xor bArrayIn(lCurPos)))
  Next lCurPos
  CRC32 = lTemp Xor &HFFFFFFFF
End Function

Private Function BuildTable() As Boolean
  Dim i As Long, x As Long, crc As Long
  Const Limit = &HEDB88320
  For i = 0 To 255
    crc = i
    For x = 0 To 7
      If crc And 1 Then
        crc = (((crc And &HFFFFFFFE) \ 2) And &H7FFFFFFF) Xor Limit
      Else
        crc = ((crc And &HFFFFFFFE) \ 2) And &H7FFFFFFF
      End If
    Next x
    crcTable(i) = crc
  Next i
End Function
Private Sub Class_Initialize()
  BuildTable
End Sub

