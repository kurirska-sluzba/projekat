object KorisnikForm: TKorisnikForm
  Left = 0
  Top = 0
  Caption = 'Korisnik'
  ClientHeight = 463
  ClientWidth = 704
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Label3: TLabel
    Left = 24
    Top = 18
    Width = 231
    Height = 54
    Caption = 'Lista po'#353'iljki'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 224
    Top = 128
    Width = 35
    Height = 15
    Caption = 'Status:'
  end
  object Label2: TLabel
    Left = 224
    Top = 160
    Width = 81
    Height = 15
    Caption = 'Stvari u paketu:'
  end
  object StringGrid1: TStringGrid
    Left = 224
    Top = 187
    Width = 449
    Height = 217
    TabOrder = 0
  end
  object Zatvori: TButton
    Left = 598
    Top = 418
    Width = 75
    Height = 25
    Caption = 'Zatvori'
    TabOrder = 1
    OnClick = ZatvoriClick
  end
  object ListBox1: TListBox
    Left = 24
    Top = 187
    Width = 185
    Height = 217
    ItemHeight = 15
    TabOrder = 2
    OnClick = ListBox1Click
  end
  object statusEdit: TEdit
    Left = 280
    Top = 125
    Width = 169
    Height = 23
    Color = cl3DLight
    ReadOnly = True
    TabOrder = 3
  end
  object FDQuery1: TFDQuery
    Connection = DataModule2.Conn
    Left = 600
    Top = 32
  end
  object FDQuery2: TFDQuery
    Connection = DataModule2.Conn
    Left = 648
    Top = 32
  end
end
