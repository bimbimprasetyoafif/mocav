VERSION 5.00
Begin VB.Form pengaturan 
   Caption         =   "Form1"
   ClientHeight    =   8640
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   16215
   LinkTopic       =   "Form1"
   ScaleHeight     =   8640
   ScaleWidth      =   16215
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox tabpengaturan 
      BackColor       =   &H00C0FFFF&
      BorderStyle     =   0  'None
      Height          =   7575
      Left            =   0
      ScaleHeight     =   7575
      ScaleWidth      =   15495
      TabIndex        =   0
      Top             =   0
      Visible         =   0   'False
      Width           =   15495
      Begin VB.CheckBox startup 
         Appearance      =   0  'Flat
         BackColor       =   &H00FFFFFF&
         Caption         =   "Run On Startup"
         BeginProperty Font 
            Name            =   "Kozuka Gothic Pro B"
            Size            =   17.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   615
         Left            =   6120
         TabIndex        =   2
         Top             =   600
         Width           =   4215
      End
      Begin VB.CheckBox scanwith 
         Appearance      =   0  'Flat
         BackColor       =   &H00FFFFFF&
         Caption         =   "Aktifkan Open With"
         BeginProperty Font 
            Name            =   "@Kozuka Gothic Pro B"
            Size            =   17.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   735
         Left            =   600
         TabIndex        =   1
         Top             =   600
         Width           =   3975
      End
      Begin TugasAkhir.ShapeButton restart 
         Height          =   1335
         Left            =   6120
         TabIndex        =   3
         Top             =   6000
         Width           =   3255
         _ExtentX        =   5741
         _ExtentY        =   2355
         ButtonShape     =   1
         ButtonStyle     =   3
         BackColor       =   8454143
         BorderColor     =   8454143
         BorderColorPressed=   -2147483628
         BorderColorHover=   -2147483627
         Caption         =   "Simpan dan Restart"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Reference Sans Serif"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label atur 
         BackStyle       =   0  'Transparent
         Caption         =   "Pengaturan"
         BeginProperty Font 
            Name            =   "Minion Pro Med"
            Size            =   14.25
            Charset         =   0
            Weight          =   500
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   960
         TabIndex        =   6
         Top             =   0
         Width           =   3255
      End
      Begin VB.Label deskripsinya 
         BackColor       =   &H00C0FFFF&
         BackStyle       =   0  'Transparent
         Caption         =   "Metode untuk scan pada sebuah file dalam explorer."
         BeginProperty Font 
            Name            =   "NewsGoth Lt BT"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1095
         Left            =   840
         TabIndex        =   5
         Top             =   1200
         Width           =   3135
      End
      Begin VB.Label deskripsinya2 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Memulai Program Antivirus Saat Komputer Pertama Kali Dinyalakan"
         BeginProperty Font 
            Name            =   "NewsGoth Lt BT"
            Size            =   14.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   975
         Left            =   6360
         TabIndex        =   4
         Top             =   1200
         Width           =   3975
      End
      Begin VB.Image bgpengaturan 
         Height          =   7575
         Left            =   -120
         Picture         =   "pengaturan.frx":0000
         Stretch         =   -1  'True
         Top             =   0
         Width           =   15495
      End
   End
End
Attribute VB_Name = "pengaturan"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
