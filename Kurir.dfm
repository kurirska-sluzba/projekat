object KurirForm: TKurirForm
  Left = 0
  Top = 0
  Caption = 'Kurir'
  ClientHeight = 434
  ClientWidth = 710
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label3: TLabel
    Left = 24
    Top = 18
    Width = 93
    Height = 54
    Caption = 'Kurir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 240
    Top = 120
    Width = 81
    Height = 15
    Caption = 'Stvari u paketu:'
  end
  object Label1: TLabel
    Left = 240
    Top = 88
    Width = 78
    Height = 15
    Caption = 'Status posiljke:'
  end
  object StringGrid1: TStringGrid
    Left = 240
    Top = 159
    Width = 449
    Height = 224
    TabOrder = 0
  end
  object ListBox1: TListBox
    Left = 24
    Top = 159
    Width = 202
    Height = 224
    ItemHeight = 15
    TabOrder = 1
  end
  object Zatvori: TButton
    Left = 614
    Top = 389
    Width = 75
    Height = 25
    Caption = 'Zatvori'
    TabOrder = 2
  end
  object ComboBox1: TComboBox
    Left = 336
    Top = 85
    Width = 145
    Height = 23
    TabOrder = 3
    Text = 'ComboBox1'
  end
  object CheckBox1: TCheckBox
    Left = 24
    Top = 88
    Width = 169
    Height = 17
    Caption = 'Prika'#382'i dostavljene posiljke'
    TabOrder = 4
  end
  object Edit1: TEdit
    Left = 24
    Top = 120
    Width = 122
    Height = 25
    TabOrder = 5
    TextHint = 'Unesite ID  posiljke'
  end
  object Button1: TButton
    Left = 584
    Top = 84
    Width = 97
    Height = 25
    Caption = 'Izmeni status'
    TabOrder = 6
  end
  object Button2: TButton
    Left = 152
    Top = 120
    Width = 74
    Height = 25
    Cancel = True
    Caption = 'Pretrazi'
    TabOrder = 7
  end
end
