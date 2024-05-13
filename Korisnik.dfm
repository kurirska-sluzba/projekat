object KorisnikForm: TKorisnikForm
  Left = 0
  Top = 0
  Caption = 'Korisnik'
  ClientHeight = 550
  ClientWidth = 704
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
  object Edit1: TEdit
    Left = 24
    Top = 95
    Width = 265
    Height = 23
    TabOrder = 0
    TextHint = 'Pretrazi po broju posiljke'
  end
  object Button1: TButton
    Left = 304
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Pretra'#382'i'
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 24
    Top = 144
    Width = 657
    Height = 385
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
end
