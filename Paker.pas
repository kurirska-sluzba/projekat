unit Paker;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TPakerForm = class(TForm)
    Label3: TLabel;
    DBComboBox1: TDBComboBox;
    Button1: TButton;
    DBGrid1: TDBGrid;
    Button2: TButton;
    FetchNaloziQuery: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PakerForm: TPakerForm;

implementation

{$R *.dfm}

uses DB;

end.
