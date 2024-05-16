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
    nazivEdit: TEdit;
    cenaEdit: TEdit;
    AddPredmetQuery: TFDQuery;
    kolicinaEdit: TEdit;
    FDQuery1: TFDQuery;
    ukupnaCenaLabel: TLabel;
    adresaEdit: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    cenaProizvodaEdit: TEdit;
    cenaPostarineEdit: TEdit;
    ukupnaCenaEdit: TEdit;
    ComboBox1: TComboBox;
    FetchGradoviQuery: TFDQuery;
    korisniciComboBox: TComboBox;
    StringGrid1: TStringGrid;
    FDQuery2: TFDQuery;
    procedure PopulateGradovi();
    procedure PopulateKorisnici();
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    posiljkaId: Integer;
    lastInsertedId: Integer;
    korisniciIds: TStringList;
    gradIds: TStringList;
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
var i: Integer;
begin
  posiljkaId := Random(MaxInt);

  SQL := 'INSERT INTO posiljka(id, korisnik_id, ukupna_cena, status, napravljeno, adresa_isporuke, grad_id, datum_isporuke)' +
    'VALUES(:id, :korisnik_id, :ukupna_cena, :status, :napravljeno, :adresa_isporuke, :grad_id, :datum_isporuke)';

  FDQuery1.SQL.Text := SQL;
  FDQuery1.Close;
  FDQuery1.ParamByName('id').Value := posiljkaId;
  FDQuery1.ParamByName('korisnik_id').Value := korisniciIds[korisniciComboBox.ItemIndex];
  FDQuery1.ParamByName('ukupna_cena').Value := ukupnaCenaEdit.Text;
  FDQuery1.ParamByName('status').Value := 'U_OBRADI';
  FDQuery1.ParamByName('napravljeno').Value := QuotedStr(FormatDateTime('YYYY-MM-DD', Now));
  FDQuery1.ParamByName('adresa_isporuke').Value := adresaEdit.Text;
  FDQuery1.ParamByName('grad_id').Value := gradIDs[ComboBox1.ItemIndex];
  FDQuery1.ParamByName('datum_isporuke').Value := QuotedStr(FormatDateTime('YYYY-MM-DD', Now));

  FDQuery1.ExecSQL;
  FDQuery1.Close;

  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    FDQuery1.SQL.Text := 'INSERT INTO predmeti (naziv, cena) VALUES (:naziv, :cena)';
    FDQuery1.ParamByName('naziv').AsString := StringGrid1.Cells[0, i];
    FDQuery1.ParamByName('cena').AsString := StringGrid1.Cells[1, i];
    FDQuery1.ExecSQL;
    FDQuery1.Close;

    FDQuery1.Close;
    FDQuery1.SQL.Text := 'SELECT MAX(id) AS LastID FROM predmeti';
    FDQuery1.Open;

    if not FDQuery1.IsEmpty then
    begin
      lastInsertedId := FDQuery1.FieldByName('LastID').AsInteger;
    end;
    FDQuery1.Close;

    FDQuery1.SQL.Text := 'INSERT INTO posiljka_predmeti(posiljka_id, predmet_id, kolicina, ukupna_cena) VALUES (:posiljka_id, :predmet_id, :kolicina, :ukupna_cena)';
    FDQuery1.ParamByName('posiljka_id').AsString := intToStr(posiljkaId);
    FDQuery1.ParamByName('predmet_id').AsString := intToStr(lastInsertedId);
    FDQuery1.ParamByName('kolicina').AsString := StringGrid1.Cells[2, i];
    FDQuery1.ParamByName('ukupna_cena').AsString := StringGrid1.Cells[3, i];
    FDQuery1.ExecSQL;
  end;

  FDQuery1.Close;
end;

procedure TPakerForm.Button2Click(Sender: TObject);
var RowIndex, Sum, TotalSum, i: Integer;
begin
  RowIndex := StringGrid1.RowCount;
  StringGrid1.RowCount := RowIndex + 1;

  Sum := strToInt(kolicinaEdit.Text) * strToInt(cenaEdit.Text);

  StringGrid1.Cells[0, RowIndex] := nazivEdit.Text;
  StringGrid1.Cells[1, RowIndex] := cenaEdit.Text;
  StringGrid1.Cells[2, RowIndex] := kolicinaEdit.Text;
  StringGrid1.Cells[3, RowIndex] := intToStr(Sum);

  TotalSum := TotalSum + Sum;

  nazivEdit.Clear;
  cenaEdit.Clear;
  kolicinaEdit.Clear;

  cenaProizvodaEdit.Text := intToStr(TotalSum);
  cenaPostarineEdit.Text := intToStr(500);
  ukupnaCenaEdit.Text := intToStr(TotalSum + 500);
end;

procedure TPakerForm.PopulateGradovi();
begin
  ComboBox1.Clear;

  gradIDs := TStringList.Create;

  FetchGradoviQuery.Open;

  while not FetchGradoviQuery.Eof do
  begin
    ComboBox1.Items.Add(FetchGradoviQuery.FieldByName('naziv').AsString);
    gradIDs.Add(FetchGradoviQuery.FieldByName('id').AsString);
    FetchGradoviQuery.Next;
  end;

  FetchGradoviQuery.Close;
end;

procedure TPakerForm.PopulateKorisnici();
begin
  korisniciComboBox.Clear;

  korisniciIds := TStringList.Create;

  FDQuery2.SQL.Text := 'SELECT id, ime FROM nalozi';
  FDQuery2.Open;
  FDQuery2.First;

  while not FDQuery2.Eof do
  begin
    korisniciComboBox.Items.Add(FDQuery2.FieldByName('ime').AsString);
    korisniciIds.Add(FDQuery2.FieldByName('id').AsString);
    FDQuery2.Next;
  end;

  FDQuery2.Close;
end;

procedure TPakerForm.FormCreate(Sender: TObject);
var HeaderNames: array of string;
begin
  StringGrid1.RowCount := 1;

  StringGrid1.Cells[0, 0] := 'Naziv';
  StringGrid1.Cells[1, 0] := 'Cena';
  StringGrid1.Cells[2, 0] := 'Kolicina';
  StringGrid1.Cells[3, 0] := 'Ukupna cena';

  PopulateGradovi();
  PopulateKorisnici();
end;

end.
