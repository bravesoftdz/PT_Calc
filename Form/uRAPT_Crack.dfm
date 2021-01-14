object fmRAPT_Crack: TfmRAPT_Crack
  Left = 0
  Top = 0
  Caption = 'RAPT Crack'
  ClientHeight = 286
  ClientWidth = 540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 3
    Width = 514
    Height = 270
    Caption = 'RAPT Crack'
    TabOrder = 0
    object GroupBox7: TGroupBox
      Left = 331
      Top = 38
      Width = 162
      Height = 213
      Caption = 'Windows (64 bit) Opt1'
      TabOrder = 0
      object btn64bit_Opt1_Crack: TButton
        Left = 39
        Top = 40
        Width = 94
        Height = 33
        Action = fmMain.act64bit_Opt1_Crack
        TabOrder = 0
      end
      object btn64bit_Opt1_Recrack: TButton
        Left = 39
        Top = 94
        Width = 94
        Height = 33
        Action = fmMain.act64bit_Opt1_Recrack
        TabOrder = 1
      end
      object btn64bit_Opt1_Uncrack: TButton
        Left = 39
        Top = 147
        Width = 94
        Height = 33
        Action = fmMain.act64bit_Opt1_Uncrack
        TabOrder = 2
      end
    end
    object GroupBox2: TGroupBox
      Left = 171
      Top = 37
      Width = 154
      Height = 213
      Caption = 'Windows (32 bit) Opt2'
      TabOrder = 1
      object btn32bit_Opt2_Crack: TButton
        Left = 39
        Top = 39
        Width = 94
        Height = 33
        Action = fmMain.act32bit_Opt2_Crack
        TabOrder = 0
      end
      object btn32bit_Opt2_Uncrack: TButton
        Left = 39
        Top = 152
        Width = 94
        Height = 33
        Action = fmMain.act32bit_Opt2_Uncrack
        TabOrder = 1
      end
      object btn32bit_Opt2_Recrack: TButton
        Left = 39
        Top = 96
        Width = 94
        Height = 33
        Action = fmMain.act32bit_Opt2_Recrack
        TabOrder = 2
      end
    end
    object GroupBox8: TGroupBox
      Left = 14
      Top = 38
      Width = 151
      Height = 213
      Caption = 'Windows (32 bit) Opt1'
      TabOrder = 2
      object btn32bit_Opt1_Crack: TButton
        Left = 39
        Top = 40
        Width = 94
        Height = 33
        Action = fmMain.act32bit_Opt1_Crack
        TabOrder = 0
      end
      object btn32bit_Opt1_Uncrack: TButton
        Left = 39
        Top = 152
        Width = 94
        Height = 33
        Action = fmMain.act32bit_Opt1_Uncrack
        TabOrder = 1
      end
      object btn32bit_Opt1_Recrack: TButton
        Left = 39
        Top = 94
        Width = 94
        Height = 33
        Action = fmMain.act32bit_Opt1_Recrack
        TabOrder = 2
      end
    end
  end
end
