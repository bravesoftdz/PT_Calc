object fmRAPTConvert: TfmRAPTConvert
  Left = 891
  Top = 451
  Caption = 'RAPT Converter'
  ClientHeight = 223
  ClientWidth = 625
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 92
    Top = 82
    Width = 4
    Height = 18
    Caption = '.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial Rounded MT Bold'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 150
    Top = 82
    Width = 4
    Height = 18
    Caption = '.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial Rounded MT Bold'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 205
    Top = 82
    Width = 4
    Height = 18
    Caption = '.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial Rounded MT Bold'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 112
    Top = 24
    Width = 75
    Height = 25
    Caption = 'OPEN'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 112
    Top = 160
    Width = 75
    Height = 25
    Caption = 'SAVE'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 112
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Convert'
    TabOrder = 2
    OnClick = Button3Click
  end
  object MPHexEditorEx1: TMPHexEditorEx
    Left = 312
    Top = 72
    Width = 297
    Height = 129
    Cursor = crIBeam
    BackupExtension = '.bak'
    PrintOptions.MarginLeft = 20
    PrintOptions.MarginTop = 15
    PrintOptions.MarginRight = 25
    PrintOptions.MarginBottom = 25
    PrintOptions.Flags = [pfSelectionBold, pfMonochrome]
    PrintFont.Charset = DEFAULT_CHARSET
    PrintFont.Color = clWindowText
    PrintFont.Height = -15
    PrintFont.Name = 'Courier New'
    PrintFont.Style = []
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    BytesPerRow = 16
    Translation = tkAsIs
    OffsetFormat = '-!10:0x|'
    Colors.Background = clWindow
    Colors.ChangedBackground = 11075583
    Colors.ChangedText = clMaroon
    Colors.CursorFrame = clNavy
    Colors.Offset = clBlack
    Colors.OddColumn = clBlue
    Colors.EvenColumn = clNavy
    Colors.CurrentOffsetBackground = clBtnShadow
    Colors.OffsetBackground = clBtnFace
    Colors.CurrentOffset = clBtnHighlight
    Colors.Grid = clBtnFace
    Colors.NonFocusCursorFrame = clAqua
    Colors.ActiveFieldBackground = clWindow
    FocusFrame = True
    DrawGridLines = False
    Version = 'september 30, 2007; ?markus stephany, vcl[at]mirkes[dot]de'
    DrawGutter3D = False
  end
  object Edit2: TEdit
    Left = 453
    Top = 48
    Width = 41
    Height = 19
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 4
    Text = '0000'
  end
  object Edit3: TEdit
    Left = 499
    Top = 48
    Width = 41
    Height = 19
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 5
    Text = '0000'
  end
  object ComboBox1: TComboBox
    Left = 48
    Top = 80
    Width = 41
    Height = 21
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Style = csDropDownList
    Ctl3D = False
    ItemHeight = 13
    ItemIndex = 6
    ParentCtl3D = False
    TabOrder = 6
    Text = '60'
    Items.Strings = (
      '00'
      '10'
      '20'
      '30'
      '40'
      '50'
      '60'
      '70'
      '80'
      '90')
  end
  object ComboBox2: TComboBox
    Left = 104
    Top = 80
    Width = 41
    Height = 21
    Style = csDropDownList
    Ctl3D = False
    ItemHeight = 13
    ItemIndex = 5
    ParentCtl3D = False
    TabOrder = 7
    Text = '50'
    Items.Strings = (
      '00'
      '10'
      '20'
      '30'
      '40'
      '50'
      '60'
      '70'
      '80'
      '90')
  end
  object ComboBox3: TComboBox
    Left = 160
    Top = 80
    Width = 41
    Height = 21
    Style = csDropDownList
    Ctl3D = False
    ItemHeight = 13
    ItemIndex = 6
    ParentCtl3D = False
    TabOrder = 8
    Text = '60'
    Items.Strings = (
      '00'
      '10'
      '20'
      '30'
      '40'
      '50'
      '60'
      '70'
      '80'
      '90')
  end
  object ComboBox4: TComboBox
    Left = 216
    Top = 80
    Width = 41
    Height = 21
    Style = csDropDownList
    Ctl3D = False
    ItemHeight = 13
    ItemIndex = 0
    ParentCtl3D = False
    TabOrder = 9
    Text = '00'
    Items.Strings = (
      '00'
      '10'
      '20'
      '30'
      '40'
      '50'
      '60'
      '70'
      '80'
      '90')
  end
end
