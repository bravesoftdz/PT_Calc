object Form_Concrete_Strength: TForm_Concrete_Strength
  Left = 647
  Top = 389
  Width = 801
  Height = 364
  Caption = 'Concrete Strength'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo9: TMemo
    Left = 330
    Top = 24
    Width = 441
    Height = 273
    Lines.Strings = (
      
        'fck : Characteristic(5%) compressive cylinder strength of concre' +
        'te at 28 days.'
      
        'fck,cube : Characteristic(5%) compressive cube strength of concr' +
        'ete at 28 days.'
      'fcm : Mean value of concrete cylinder compressive strength.')
    ParentColor = True
    TabOrder = 0
  end
  object GroupBox10: TGroupBox
    Left = 8
    Top = 24
    Width = 297
    Height = 273
    Hint = 'Basic parameters input area.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
    object Label3: TLabel
      Left = 14
      Top = 59
      Width = 35
      Height = 22
      AutoSize = False
      Caption = 'fck:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label32: TLabel
      Left = 14
      Top = 21
      Width = 123
      Height = 22
      AutoSize = False
      Caption = 'Concrete Strength:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label35: TLabel
      Left = 126
      Top = 58
      Width = 67
      Height = 22
      AutoSize = False
      Caption = 'fck,cube:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object ComboBox12: TComboBox
      Left = 160
      Top = 21
      Width = 97
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      ItemIndex = 0
      ParentColor = True
      TabOrder = 0
      Text = 'C20/25MPa'
      OnChange = ComboBox12Change
      Items.Strings = (
        'C20/25MPa'
        'C24/30MPa'
        'C28/35MPa'
        'C32/40MPa'
        'C36/45MPa'
        'C40/50MPa'
        'C44/55MPa'
        'C48/60MPa'
        'C52/65MPa'
        'C56/70MPa'
        'C60/75MPa'
        'C64/80MPa'
        'C68/85MPa'
        'C72/90MPa'
        'C76/95MPa'
        'C80/100MPa'
        'C84/105MPa')
    end
    object Edit29: TEdit
      Left = 48
      Top = 59
      Width = 65
      Height = 22
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 1
      Text = '20'
    end
    object Edit30: TEdit
      Left = 192
      Top = 58
      Width = 65
      Height = 22
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 2
      Text = '25'
    end
  end
end
