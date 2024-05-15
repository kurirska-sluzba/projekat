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
var i: Integer;
begin
  FDQuery2.Open;
  FDQuery2.Active := True;

  StringGrid1.RowCount := 1;
  StringGrid1.ColCount := 3;

  StringGrid1.Cells[0, 0] := 'Naziv';
  StringGrid1.Cells[1, 0] := 'Cena';
  StringGrid1.Cells[2, 0] := 'Kolicina';

  StringGrid1.RowCount := FDQuery2.RecordCount + 1;

  FDQuery2.First;

  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    StringGrid1.Cells[0, i] := FDQuery2.FieldByName('naziv').AsString;
    StringGrid1.Cells[1, i] := FDQuery2.FieldByName('cena').AsString;
    StringGrid1.Cells[2, i] := FDQuery2.FieldByName('kolicina').AsString;
    FDQuery2.Next;
  end;
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
