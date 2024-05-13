object DataModule2: TDataModule2
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object Conn: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\ivkov\Documents\projekat-main\kurirska-sluzba.' +
        'sqlite3'
      'DriverID=SQLite')
    Left = 120
    Top = 96
  end
  object NaloziTable: TFDTable
    IndexFieldNames = 'id'
    Connection = Conn
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'nalozi'
    Left = 233
    Top = 104
  end
  object NaloziDataSource: TDataSource
    DataSet = SviNaloziTable
    Left = 440
    Top = 96
  end
  object SviNaloziTable: TFDTable
    IndexFieldNames = 'id'
    Connection = Conn
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'nalozi'
    Left = 233
    Top = 208
    object SviNaloziTableid: TIntegerField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object SviNaloziTableime: TWideStringField
      FieldName = 'ime'
      Origin = 'ime'
      Required = True
      Size = 32767
    end
    object SviNaloziTablekorisnicko_ime: TWideStringField
      FieldName = 'korisnicko_ime'
      Origin = 'korisnicko_ime'
      Size = 32767
    end
    object SviNaloziTablesifra: TWideStringField
      FieldName = 'sifra'
      Origin = 'sifra'
      Size = 32767
    end
    object SviNaloziTabletip: TWideStringField
      FieldName = 'tip'
      Origin = 'tip'
      Size = 32767
    end
  end
end
