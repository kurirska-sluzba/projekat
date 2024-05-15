unit Korisnik;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ComCtrls;

type
  TKorisnikForm = class(TForm)
    Label3: TLabel;
    FDQuery1: TFDQuery;
    StringGrid1: TStringGrid;
    Zatvori: TButton;
    ListBox1: TListBox;
    FDQuery2: TFDQuery;
    Label1: TLabel;
    Label2: TLabel;
    statusEdit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ClearStringGrid(StringGrid: TStringGrid);
    procedure RefreshGrid();
    procedure Refresh();
    procedure ZatvoriClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  KorisnikForm: TKorisnikForm;

implementation

{$R *.dfm}

uses DB;

procedure TKorisnikForm.FormCreate(Sender: TObject);
var SQL: String;
begin
  // Prikazi status posiljke
  SQL := 'SELECT id FROM posiljka WHERE korisnik_id = :korisnik_id';

  FDQuery1.SQL.Text := SQL;
  FDQuery1.ParamByName('korisnik_id').Value := 1;
  FDQuery1.Active := True;

  Refresh();
end;

procedure TKorisnikForm.ListBox1Click(Sender: TObject);
var SQL: String;
var Selected: Integer;
begin
  if ListBox1.ItemIndex <> -1 then
  begin
    // Dodaj za status posiljke
    SQL := 'SELECT pr.naziv, pr.cena, pp.kolicina, ps.status, pp.ukupna_cena ' +
      'FROM posiljka_predmeti pp ' +
      'INNER JOIN predmeti pr ON pp.predmet_id = pr.id ' +
      'INNER JOIN posiljka ps ON pp.posiljka_id = ps.id ' +
      'WHERE pp.posiljka_id = :id';
    Selected := strToInt(ListBox1.Items[ListBox1.ItemIndex]);

    FDQuery2.SQL.Text := SQL;
    FDQuery2.ParamByName('id').Value := Selected;
    FDQuery2.Active := True;

    statusEdit.Text := FDQuery2.FieldByName('status').AsString;

    RefreshGrid();
  end;
end;

procedure TKorisnikForm.ClearStringGrid(StringGrid: TStringGrid);
var
  Col, Row: Integer;
begin
  for Col := 0 to StringGrid.ColCount - 1 do
    for Row := 0 to StringGrid.RowCount - 1 do
      StringGrid.Cells[Col, Row] := '';
end;

procedure TKorisnikForm.RefreshGrid();
var
  Col, Row: Integer;
begin
  FDQuery2.Open;

  ClearStringGrid(StringGrid1);

  StringGrid1.ColCount := FDQuery2.Fields.Count;


  for Col := 0 to FDQuery1.Fields.Count - 1 do
      StringGrid1.Cells[Col, 0] := FDQuery2.Fields[Col].FieldName;

    FDQuery2.First;

    Row := 1;
    while not FDQuery2.Eof do
    begin
      for Col := 0 to FDQuery2.Fields.Count - 1 do
        StringGrid1.Cells[Col, Row] := FDQuery2.Fields[Col].AsString;
      Inc(Row);
      FDQuery2.Next;
    end;

    FDQuery2.Close;
end;

procedure TKorisnikForm.Refresh();
var Row: Integer;
begin
   FDQuery1.Open;

  ListBox1.Clear;

  FDQuery1.First;

  while not FDQuery1.Eof do
  begin
    ListBox1.Items.Add(FDQuery1.Fields[0].AsString);
    FDQuery1.Next;
  end;

  FDQuery1.Close;
end;

procedure TKorisnikForm.ZatvoriClick(Sender: TObject);
begin
  self.Close();
end;

end.
