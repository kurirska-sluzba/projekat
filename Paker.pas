unit Paker;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Math;

type
  TPakerForm = class(TForm)
    Label3: TLabel;
    Button2: TButton;
    FetchNaloziQuery: TFDQuery;
    StringGrid1: TStringGrid;
    nazivEdit: TEdit;
    cenaEdit: TEdit;
    AddPredmetQuery: TFDQuery;
    kolicinaEdit: TEdit;
    FDQuery1: TFDQuery;
    ukupnaCenaLabel: TLabel;
    adresaEdit: TEdit;
    gradEdit: TEdit;
    posBrojEdit: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    cenaProizvodaEdit: TEdit;
    cenaPostarineEdit: TEdit;
    ukupnaCenaEdit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure RefreshGrid();
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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

procedure AutoAdjustColumnSizes(StringGrid: TStringGrid);
var
  Col, Row: Integer;
  MaxWidth: array of Integer;
begin
  SetLength(MaxWidth, StringGrid.ColCount);
  for Col := 0 to StringGrid.ColCount - 1 do
    MaxWidth[Col] := 0;

  for Row := 0 to StringGrid.RowCount - 1 do
    for Col := 0 to StringGrid.ColCount - 1 do
      MaxWidth[Col] := Math.Max(MaxWidth[Col], StringGrid.Canvas.TextWidth(StringGrid.Cells[Col, Row]));

  for Col := 0 to StringGrid.ColCount - 1 do
    StringGrid.ColWidths[Col] := MaxWidth[Col] + StringGrid.DefaultColWidth;
end;

procedure TPakerForm.Button1Click(Sender: TObject);
var SQL: String;
begin
  SQL := 'INSERT INTO posiljka(korisnik_id, napravljeno, adresa_isporuke, grad_isporuke, postanski_broj_isporuke, datum_isporuke)' +
    'VALUES(:korisnik_id, :napravljeno, :adresa_isporuke, :grad_isporuke, :postanski_broj_isporuke, :datum_isporuke)';

  FDQuery1.SQL.Text := SQL;
  FDQuery1.Close;
  FDQuery1.ParamByName('korisnik_id').Value := '1';
  FDQuery1.ParamByName('napravljeno').Value := QuotedStr(FormatDateTime('YYYY-MM-DD', Now));
  FDQuery1.ParamByName('adresa_isporuke').Value := adresaEdit.Text;
  FDQuery1.ParamByName('grad_isporuke').Value := gradEdit.Text;
  FDQuery1.ParamByName('postanski_broj_isporuke').Value := posBrojEdit.Text;
  FDQuery1.ParamByName('datum_isporuke').Value := QuotedStr(FormatDateTime('YYYY-MM-DD', Now));


  FDQuery1.ExecSQL;
  FDQuery1.Close;
end;

procedure TPakerForm.Button2Click(Sender: TObject);
var Sum: Double;
var SQL: String;
begin
  SQL := 'INSERT INTO predmeti (naziv, cena) VALUES (:naziv, :cena)';

  AddPredmetQuery.SQL.Text := SQL;
  AddPredmetQuery.Close;
  AddPredmetQuery.ParamByName('naziv').Value := nazivEdit.Text;
  AddPredmetQuery.ParamByName('cena').Value := cenaEdit.Text;

  AddPredmetQuery.ExecSQL;

  AddPredmetQuery.SQL.Clear;
  AddPredmetQuery.Close;

  SQL := 'INSERT INTO posiljka_predmeti(posiljka_id, predmet_id, kolicina, ukupna_cena) VALUES (1, last_insert_rowid(), :kolicina, :ukupna_cena)';

  Sum := StrToFloat(cenaEdit.Text) * StrToInt(kolicinaEdit.Text);

  AddPredmetQuery.SQL.Text := SQL;
  AddPredmetQuery.ParamByName('kolicina').Value := kolicinaEdit.Text;
  AddPredmetQuery.ParamByName('ukupna_cena').Value := Sum;
  AddPredmetQuery.ExecSQL;

  RefreshGrid();
  AutoAdjustColumnSizes(StringGrid1);
end;

procedure TPakerForm.RefreshGrid();
var
  Col, Row: Integer;
begin
  FetchNaloziQuery.Open;

  StringGrid1.ColCount := FetchNaloziQuery.Fields.Count;


  for Col := 0 to FetchNaloziQuery.Fields.Count - 1 do
      StringGrid1.Cells[Col, 0] := FetchNaloziQuery.Fields[Col].FieldName;

    FetchNaloziQuery.First;

    Row := 1;
    while not FetchNaloziQuery.Eof do
    begin
      for Col := 0 to FetchNaloziQuery.Fields.Count - 1 do
        StringGrid1.Cells[Col, Row] := FetchNaloziQuery.Fields[Col].AsString;
      Inc(Row);
      FetchNaloziQuery.Next;
    end;

    FetchNaloziQuery.Close;
end;

procedure TPakerForm.FormCreate(Sender: TObject);
begin
  RefreshGrid();
  AutoAdjustColumnSizes(StringGrid1);
end;

end.
