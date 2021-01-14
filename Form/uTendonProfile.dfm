object fmTendonProfile: TfmTendonProfile
  Left = 690
  Top = 340
  Caption = 'Tendoon Profile'
  ClientHeight = 333
  ClientWidth = 773
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  object Label7: TLabel
    Left = 7
    Top = 19
    Width = 123
    Height = 16
    AutoSize = False
    Caption = 'Tendon Profile Type:'
  end
  object Label11: TLabel
    Left = 407
    Top = 19
    Width = 83
    Height = 16
    AutoSize = False
    Caption = 'Tendon Type:'
  end
  object ComboBox2: TComboBox
    Left = 129
    Top = 16
    Width = 273
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    ItemIndex = 0
    TabOrder = 0
    Text = '1. Building - Double Parabolic Profile'
    OnChange = ComboBox2Change
    Items.Strings = (
      '1. Building - Double Parabolic Profile'
      '2. Building - Parabolic-Straight-Parabolic Profile'
      '3. Building - Parabolic-Straight Profile'
      '4. Building - Straight-Parabolic Profile'
      '5. Civil - Parabolic Profile'
      '6. Civil - Cubic Profile')
  end
  object ComboBox6: TComboBox
    Left = 489
    Top = 16
    Width = 66
    Height = 23
    Style = csOwnerDrawFixed
    ItemHeight = 17
    ItemIndex = 1
    TabOrder = 1
    Text = '1s-3s'
    OnChange = ComboBox6Change
    Items.Strings = (
      'Slab'
      '1s-3s'
      '4s'
      '5s-7s'
      '8s-9s'
      '10s-13s'
      '14s-19s'
      '20s-22s'
      '23s-25s'
      '26s-27s'
      '28s-31s'
      '32s-37s'
      '38s-55s'
      '')
  end
  object GroupBox2: TGroupBox
    Left = 2
    Top = 56
    Width = 553
    Height = 57
    Caption = 'Profile Control:'
    TabOrder = 2
    object Label10: TLabel
      Left = 14
      Top = 22
      Width = 99
      Height = 16
      AutoSize = False
      Caption = 'Start Point Level:'
    end
    object Label13: TLabel
      Left = 374
      Top = 23
      Width = 91
      Height = 16
      AutoSize = False
      Caption = 'Horizontal Dist. :'
    end
    object Label14: TLabel
      Left = 206
      Top = 22
      Width = 91
      Height = 16
      AutoSize = False
      Caption = 'End Point Level:'
    end
    object Edit_X: TEdit
      Left = 472
      Top = 21
      Width = 65
      Height = 20
      AutoSize = False
      TabOrder = 2
      Text = '12850'
    end
    object Edit_Y2: TEdit
      Left = 296
      Top = 20
      Width = 57
      Height = 20
      AutoSize = False
      TabOrder = 1
      Text = '50'
    end
    object Edit_Y1: TEdit
      Left = 112
      Top = 20
      Width = 57
      Height = 20
      AutoSize = False
      TabOrder = 0
      Text = '850'
    end
    object Button2: TButton
      Left = 175
      Top = 20
      Width = 25
      Height = 20
      Hint = 'Exchange Starting Point and Ending Point'
      Caption = '<->'
      TabOrder = 3
      OnClick = Button2Click
    end
  end
  object GroupBox9: TGroupBox
    Left = 2
    Top = 128
    Width = 553
    Height = 57
    Caption = 'Profile Adjustment:'
    TabOrder = 3
    object Label15: TLabel
      Left = 14
      Top = 25
      Width = 107
      Height = 16
      AutoSize = False
      Caption = 'Start Point (mm):'
    end
    object Label8: TLabel
      Left = 206
      Top = 25
      Width = 83
      Height = 16
      AutoSize = False
      Caption = 'Interval (mm):'
    end
    object Label9: TLabel
      Left = 374
      Top = 25
      Width = 99
      Height = 16
      AutoSize = False
      Caption = 'Rounding (mm):'
    end
    object Edit5: TEdit
      Left = 112
      Top = 23
      Width = 57
      Height = 20
      AutoSize = False
      TabOrder = 0
      Text = '850'
    end
    object ComboBox4: TComboBox
      Left = 296
      Top = 22
      Width = 57
      Height = 23
      ItemHeight = 15
      ItemIndex = 1
      TabOrder = 1
      Text = '1000'
      Items.Strings = (
        '500'
        '1000')
    end
    object ComboBox5: TComboBox
      Left = 472
      Top = 22
      Width = 65
      Height = 23
      Hint = 'Round profile result, normally 5mm for Beam and 10mm for Slab.'
      Style = csOwnerDrawFixed
      ItemHeight = 17
      ItemIndex = 0
      TabOrder = 2
      Text = '1'
      Items.Strings = (
        '1'
        '5'
        '10')
    end
  end
  object Panel1: TPanel
    Left = 2
    Top = 200
    Width = 553
    Height = 153
    BevelOuter = bvNone
    DockSite = True
    ParentColor = True
    TabOrder = 4
    object Chart1: TChart
      Left = 0
      Top = 0
      Width = 553
      Height = 153
      BackWall.Brush.Color = clWhite
      BackWall.Color = clWindow
      BackWall.Pen.Color = clGray
      Border.Visible = True
      BottomWall.Brush.Color = clWhite
      BottomWall.Brush.Style = bsClear
      Foot.Brush.Color = clWhite
      Foot.Text.Strings = (
        'Tendon Profile')
      Foot.Visible = False
      LeftWall.Brush.Color = clWhite
      LeftWall.Brush.Style = bsClear
      Legend.Alignment = laLeft
      Legend.ColorWidth = 0
      Legend.Font.Color = clGray
      Legend.Frame.Color = clSilver
      Legend.Frame.Style = psDash
      Legend.Frame.SmallDots = True
      Legend.Shadow.HorizSize = 0
      Legend.Shadow.VertSize = 0
      Legend.Symbol.Width = 0
      Legend.TopPos = 2
      Legend.Visible = False
      PrintProportional = False
      Title.Text.Strings = (
        'TChart')
      Title.Visible = False
      BottomAxis.Axis.Color = clGray
      BottomAxis.Axis.Width = 1
      Frame.Color = clGray
      LeftAxis.Axis.Color = clGray
      LeftAxis.Axis.Width = 1
      LeftAxis.TickLength = 1
      RightAxis.Axis.Color = clGray
      RightAxis.Axis.Width = 1
      RightAxis.ExactDateTime = False
      TopAxis.Axis.Color = clGray
      TopAxis.Axis.Width = 1
      View3D = False
      Align = alClient
      BevelOuter = bvNone
      DockSite = True
      DragMode = dmAutomatic
      ParentColor = True
      PopupMenu = PopupMenu2
      TabOrder = 0
      DragKind = dkDock
    end
  end
  object Memo1: TMemo
    Left = 576
    Top = 8
    Width = 201
    Height = 273
    Hint = 'Tendon Profile result area.'
    Lines.Strings = (
      'Tendon Profile Result:')
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object Memo2: TMemo
    Left = 488
    Top = 88
    Width = 289
    Height = 25
    TabOrder = 6
    Visible = False
  end
  object Memo3: TMemo
    Left = 488
    Top = 119
    Width = 289
    Height = 43
    Lines.Strings = (
      ' 0'
      'SECTION'
      ' 2'
      'HEADER'
      ' 9'
      '$EXTMIN'
      ' 10'
      ' 0.000000000000000'
      ' 20'
      ' 0.000000000000000'
      ' 30'
      ' 0.000000000000000'
      ' 9'
      '$EXTMAX'
      ' 10'
      ' 15080.911132812500000'
      ' 20'
      ' 1745.465332031250000'
      ' 30'
      ' 0.000000000000000'
      ' 9'
      '$LIMMIN'
      ' 10'
      ' 0.000000000000000'
      ' 20'
      ' 0.000000000000000'
      ' 9'
      '$LIMMAX'
      ' 10'
      ' 15080.911132812500000'
      ' 20'
      ' 1745.465332031250000'
      ' 0'
      'ENDSEC'
      ' 0'
      'SECTION'
      ' 2'
      'TABLES'
      ' 0'
      'TABLE'
      ' 2'
      'VPORT'
      ' 0'
      'VPORT'
      ' 2'
      '*ACTIVE'
      ' 70'
      ' 0'
      ' 10'
      ' 0.000000000000000'
      ' 20'
      ' 0.000000000000000'
      ' 11'
      ' 15080.911132812500000'
      ' 21'
      ' 1745.465332031250000'
      ' 12'
      ' 3770.227783203125000'
      ' 22'
      ' 436.366333007812500'
      ' 13'
      ' 0.000000000000000'
      ' 23'
      ' 0.000000000000000'
      ' 14'
      ' 1.000000000000000'
      ' 24'
      ' 1.000000000000000'
      ' 15'
      ' 0.000000000000000'
      ' 25'
      ' 0.000000000000000'
      ' 16'
      ' 0.000000000000000'
      ' 26'
      ' 0.000000000000000'
      ' 36'
      ' 1.000000000000000'
      ' 17'
      ' 0.000000000000000'
      ' 27'
      ' 0.000000000000000'
      ' 37'
      ' 0.000000000000000'
      ' 40'
      ' 1745.465332031250000'
      ' 41'
      ' 8.640051841735840'
      ' 42'
      ' 50.000000000000000'
      ' 43'
      ' 0.000000000000000'
      ' 44'
      ' 0.000000000000000'
      ' 50'
      ' 0.000000000000000'
      ' 51'
      ' 0.000000000000000'
      ' 71'
      ' 0'
      ' 72'
      ' 100'
      ' 73'
      ' 1'
      ' 74'
      ' 1'
      ' 75'
      ' 0'
      ' 76'
      ' 0'
      ' 77'
      ' 0'
      ' 78'
      ' 0'
      ' 0'
      'ENDTAB'
      ' 0'
      'TABLE'
      ' 2'
      'LTYPE'
      ' 0'
      'LTYPE'
      ' 2'
      'ACAD_ISO02W100'
      ' 70'
      ' 0'
      ' 3'
      'ISO dash __ __ __ __ __ __ __ __ __ __ __ __ __'
      ' 72'
      ' 65'
      ' 73'
      ' 2'
      ' 40'
      ' 15.000000000000000'
      ' 49'
      ' 12.000000000000000'
      ' 49'
      ' -3.000000000000000'
      ' 0'
      'LTYPE'
      ' 2'
      'Continuous'
      ' 70'
      ' 0'
      ' 3'
      'Solid Line ____________________________________'
      ' 72'
      ' 65'
      ' 73'
      ' 0'
      ' 40'
      ' 0.000000000000000'
      ' 0'
      'LTYPE'
      ' 2'
      'DASHDOT'
      ' 70'
      ' 0'
      ' 3'
      'Dash dot __ . __ . __ . __ . __ . __ . __ . __'
      ' 72'
      ' 65'
      ' 73'
      ' 4'
      ' 40'
      ' 1.000000000000000'
      ' 49'
      ' 0.500000000000000'
      ' 49'
      ' -0.250000000000000'
      ' 49'
      ' 0.000000000000000'
      ' 49'
      ' -0.250000000000000'
      ' 0'
      'LTYPE'
      ' 2'
      'DASHDOT2'
      ' 70'
      ' 0'
      ' 3'
      'Dash dot (.5x) _._._._._._._._._._._._._._._.'
      ' 72'
      ' 65'
      ' 73'
      ' 4'
      ' 40'
      ' 0.500000000000000'
      ' 49'
      ' 0.250000000000000'
      ' 49'
      ' -0.125000000000000'
      ' 49'
      ' 0.000000000000000'
      ' 49'
      ' -0.125000000000000'
      ' 0'
      'LTYPE'
      ' 2'
      'DASHED'
      ' 70'
      ' 0'
      ' 3'
      'Dashed __ __ __ __ __ __ __ __ __ __ __ __ __ _'
      ' 72'
      ' 65'
      ' 73'
      ' 2'
      ' 40'
      ' 0.750000000000000'
      ' 49'
      ' 0.500000000000000'
      ' 49'
      ' -0.250000000000000'
      ' 0'
      'LTYPE'
      ' 2'
      'DOT'
      ' 70'
      ' 0'
      ' 3'
      'Dot . . . . . . . . . . . . . . . . . . . . . . . .'
      ' 72'
      ' 65'
      ' 73'
      ' 2'
      ' 40'
      ' 0.250000000000000'
      ' 49'
      ' 0.000000000000000'
      ' 49'
      ' -0.250000000000000'
      ' 0'
      'ENDTAB'
      ' 0'
      'TABLE'
      ' 2'
      'LAYER'
      ' 0'
      'LAYER'
      ' 2'
      'Links'
      ' 70'
      ' 0'
      ' 62'
      ' 3'
      ' 6'
      'Continuous'
      ' 0'
      'LAYER'
      ' 2'
      'Outline'
      ' 70'
      ' 0'
      ' 62'
      ' 1'
      ' 6'
      'Continuous'
      ' 0'
      'LAYER'
      ' 2'
      'Prestress'
      ' 70'
      ' 0'
      ' 62'
      ' 7'
      ' 6'
      'Continuous'
      ' 0'
      'LAYER'
      ' 2'
      'TENDON'
      ' 70'
      ' 0'
      ' 62'
      ' 232'
      ' 6'
      'Continuous'
      ' 0'
      'LAYER'
      ' 2'
      'TABLE'
      ' 70'
      ' 0'
      ' 62'
      ' 8'
      ' 6'
      'Continuous'
      ' 0'
      'LAYER'
      ' 2'
      'COLUMN'
      ' 70'
      ' 0'
      ' 62'
      ' 8'
      ' 6'
      'Continuous'
      ' 0'
      'LAYER'
      ' 2'
      'PROFILE-TXT-DIST'
      ' 70'
      ' 0'
      ' 62'
      ' 241'
      ' 6'
      'Continuous'
      ' 0'
      'LAYER'
      ' 2'
      'PROFILE-TXT-HEIGHT'
      ' 70'
      ' 0'
      ' 62'
      ' 7'
      ' 6'
      'Continuous'
      ' 0'
      'LAYER'
      ' 2'
      'PROFILE-HEADER'
      ' 70'
      ' 0'
      ' 62'
      ' 3'
      ' 6'
      'Continuous'
      ' 0'
      'LAYER'
      ' 2'
      'Beam-Line'
      ' 70'
      ' 0'
      ' 62'
      ' 1'
      ' 6'
      'Continuous'
      ' 0'
      'LAYER'
      ' 2'
      'Beam-TXT'
      ' 70'
      ' 0'
      ' 62'
      ' 140'
      ' 6'
      'Continuous'
      ' 0'
      'LAYER'
      ' 2'
      'Scale-TXT'
      ' 70'
      ' 0'
      ' 62'
      ' 220'
      ' 6'
      'Continuous'
      ' 0'
      'LAYER'
      ' 2'
      'Reinforcement'
      ' 70'
      ' 0'
      ' 62'
      ' 2'
      ' 6'
      'Continuous'
      ' 0'
      'LAYER'
      ' 2'
      'Text'
      ' 70'
      ' 0'
      ' 62'
      ' 4'
      ' 6'
      'Continuous'
      ' 0'
      'ENDTAB'
      ' 0'
      'TABLE'
      ' 2'
      'STYLE'
      ' 0'
      'STYLE'
      ' 2'
      'TextStyle'
      ' 3'
      'simplex'
      ' 70'
      ' 0'
      ' 71'
      ' 0'
      ' 40'
      ' 0.000000000000000'
      ' 41'
      ' 1.000000000000000'
      ' 42'
      ' 1.000000000000000'
      ' 50'
      ' 0.000000000000000'
      ' 0'
      'ENDTAB'
      ' 0'
      'TABLE'
      ' 2'
      'DIMSTYLE'
      ' 0'
      'ENDTAB'
      ' 0'
      'ENDSEC'
      ' 0'
      'SECTION'
      ' 2'
      'BLOCKS'
      ' 0'
      'ENDSEC'
      ' 0'
      'SECTION'
      ' 2'
      'ENTITIES')
    TabOrder = 7
    Visible = False
  end
  object Memo4: TMemo
    Left = 489
    Top = 168
    Width = 292
    Height = 17
    TabOrder = 8
    Visible = False
  end
  object Button3: TButton
    Left = 592
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Generate'
    TabOrder = 9
    OnClick = Button3Click
  end
  object ProgressBar1: TProgressBar
    Left = 36
    Top = 359
    Width = 337
    Height = 17
    Max = 2147483647
    Smooth = True
    Step = 1
    TabOrder = 10
    Visible = False
  end
  object Button4: TButton
    Left = 702
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Export'
    TabOrder = 11
    OnClick = Button4Click
  end
  object PopupMenu2: TPopupMenu
    Left = 388
    Top = 65504
    object PopupMenu_DXF: TMenuItem
      Caption = 'Export DXF Drawing'
      ImageIndex = 4
      OnClick = PopupMenu_DXFClick
    end
  end
end
