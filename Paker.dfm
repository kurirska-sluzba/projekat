object PakerForm: TPakerForm
  Left = 0
  Top = 0
  Caption = 'Paker'
  ClientHeight = 582
  ClientWidth = 693
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Label3: TLabel
    Left = 8
    Top = 8
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
  object ukupnaCenaLabel: TLabel
    Left = 16
    Top = 478
    Width = 85
    Height = 15
    Caption = 'Cena proizvoda:'
  end
  object Label1: TLabel
    Left = 16
    Top = 507
    Width = 82
    Height = 15
    Caption = 'Cena po'#353'tarine:'
  end
  object Label2: TLabel
    Left = 16
    Top = 536
    Width = 72
    Height = 15
    Caption = 'Ukupna cena:'
  end
  object Button2: TButton
    Left = 400
    Top = 262
    Width = 273
    Height = 25
    Cancel = True
    Caption = 'Dodaj proizvod'
    TabOrder = 0
    OnClick = Button2Click
  end
  object nazivEdit: TEdit
    Left = 400
    Top = 142
    Width = 273
    Height = 23
    TabOrder = 1
    TextHint = 'Naziv predmeta'
  end
  object cenaEdit: TEdit
    Left = 400
    Top = 182
    Width = 273
    Height = 23
    TabOrder = 2
    TextHint = 'Cena predmeta'
  end
  object kolicinaEdit: TEdit
    Left = 400
    Top = 222
    Width = 273
    Height = 23
    ImeName = 'US'
    TabOrder = 3
    TextHint = 'Kolicina'
  end
  object adresaEdit: TEdit
    Left = 8
    Top = 182
    Width = 273
    Height = 23
    TabOrder = 4
    TextHint = 'Adresa isporuke'
  end
  object Button1: TButton
    Left = 598
    Top = 484
    Width = 75
    Height = 25
    Caption = 'Sa'#269'uvaj'
    TabOrder = 5
    OnClick = Button1Click
  end
  object cenaProizvodaEdit: TEdit
    Left = 120
    Top = 475
    Width = 137
    Height = 23
    Enabled = False
    TabOrder = 6
    Text = '0'
  end
  object cenaPostarineEdit: TEdit
    Left = 120
    Top = 504
    Width = 137
    Height = 23
    Enabled = False
    TabOrder = 7
  end
  object ukupnaCenaEdit: TEdit
    Left = 120
    Top = 533
    Width = 137
    Height = 23
    Enabled = False
    TabOrder = 8
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 222
    Width = 273
    Height = 23
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    Text = 'Odaberite grad'
    TextHint = 'Izaberite grad'
  end
  object korisniciComboBox: TComboBox
    Left = 8
    Top = 142
    Width = 273
    Height = 23
    TabOrder = 10
    Text = 'Odaberite korisnika'
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 325
    Width = 657
    Height = 120
    TabOrder = 11
  end
  object FetchNaloziQuery: TFDQuery
    Connection = DataModule2.Conn
    SQL.Strings = (
      
        'SELECT pr.naziv, pr.cena, pp.kolicina, pp.ukupna_cena FROM posil' +
        'jka_predmeti pp '
      'INNER JOIN predmeti pr ON pp.predmet_id = pr.id;')
    Left = 448
    Top = 24
  end
  object AddPredmetQuery: TFDQuery
    Connection = DataModule2.Conn
    SQL.Strings = (
      
        'SELECT pr.naziv, pr.cena, pp.kolicina, pp.ukupna_cena FROM posil' +
        'jka_predmeti pp '
      'INNER JOIN predmeti pr ON pp.predmet_id = pr.id;')
    Left = 536
    Top = 24
  end
  object FDQuery1: TFDQuery
    Connection = DataModule2.Conn
    SQL.Strings = (
      'SELECT pr.naziv, pr.cena, pp.kolicina FROM posiljka_predmeti pp '
      'INNER JOIN predmeti pr ON pp.predmet_id = pr.id;')
    Left = 616
    Top = 24
  end
  object FetchGradoviQuery: TFDQuery
    MasterSource = DataModule2.NaloziDataSource
    Connection = DataModule2.Conn
    SQL.Strings = (
      'SELECT id, naziv, pos_broj FROM gradovi;')
    Left = 600
    Top = 88
  end
  object FDQuery2: TFDQuery
    Connection = DataModule2.Conn
    SQL.Strings = (
      'SELECT pr.naziv, pr.cena, pp.kolicina FROM posiljka_predmeti pp '
      'INNER JOIN predmeti pr ON pp.predmet_id = pr.id;')
    Left = 520
    Top = 88
  end
end
