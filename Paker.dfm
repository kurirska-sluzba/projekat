object PakerForm: TPakerForm
  Left = 0
  Top = 0
  Caption = 'Paker'
  ClientHeight = 442
  ClientWidth = 628
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
    Width = 105
    Height = 54
    Caption = 'Paker'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBComboBox1: TDBComboBox
    Left = 24
    Top = 96
    Width = 233
    Height = 23
    DataField = 'ime'
    DataSource = DataModule2.NaloziDataSource
    TabOrder = 0
  end
  object Button1: TButton
    Left = 487
    Top = 94
    Width = 122
    Height = 25
    Caption = 'Dodaj podrud'#382'binu'
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 24
    Top = 144
    Width = 585
    Height = 282
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object Button2: TButton
    Left = 271
    Top = 94
    Width = 122
    Height = 25
    Cancel = True
    Caption = 'Dodaj proizvod'
    TabOrder = 3
  end
  object FetchNaloziQuery: TFDQuery
    Left = 576
    Top = 24
  end
end
