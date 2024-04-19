object DataModule2: TDataModule2
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object Conn: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\ivkov\Documents\projekat\kurirska-sluzba.sqlit' +
        'e3'
      'DriverID=SQLite')
    Connected = True
    Left = 120
    Top = 96
  end
  object NaloziTable: TFDTable
    Active = True
    IndexFieldNames = 'id'
    Connection = Conn
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'nalozi'
    Left = 232
    Top = 104
  end
end
