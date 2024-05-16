unit Kurir;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TKurirForm = class(TForm)
    Label3: TLabel;
    Label2: TLabel;
    StringGrid1: TStringGrid;
    ListBox1: TListBox;
    Zatvori: TButton;
    Label1: TLabel;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    FDQuery1: TFDQuery;
    FDQuery2: TFDQuery;
    procedure Refresh();
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RefreshGrid();
    procedure CheckBox1Click(Sender: TObject);
  private
    selectedPosiljka: Integer;
  public
    { Public declarations }
  end;

var
  KurirForm: TKurirForm;

implementation

{$R *.dfm}

uses DB;

procedure TKurirForm.Button1Click(Sender: TObject);
begin
  FDQuery2.Open;
  FDQuery2.SQL.Text := 'UPDATE posiljka SET status = :status WHERE id = :id';
  FDQuery2.ParamByName('status').Value := ComboBox1.Text;
  FDQuery2.ParamByName('id').Value := selectedPosiljka;
  FDQuery2.ExecSQL;
  FDQuery2.Close;
  ShowMessage('Status posiljke je promenjen.');
end;

procedure TKurirForm.CheckBox1Click(Sender: TObject);
var SQL: String;
begin
  if CheckBox1.Checked then
    begin
      SQL := 'SELECT * FROM posiljka';

      FDQuery1.SQL.Text := SQL;
      FDQuery1.Active := True;

      Refresh();
    end
  else
    begin
       SQL := 'SELECT * FROM posiljka WHERE status = :status';

      FDQuery1.SQL.Text := SQL;
      FDQuery1.ParamByName('status').Value := 'U_OBRADI';
      FDQuery1.Active := True;

      Refresh();
    end;
end;

procedure TKurirForm.FormCreate(Sender: TObject);
var SQL: String;
begin
  CheckBox1.Checked := False;

  SQL := 'SELECT * FROM posiljka WHERE status = :status';

  FDQuery1.SQL.Text := SQL;
  FDQuery1.ParamByName('status').Value := 'U_OBRADI';
  FDQuery1.Active := True;

  ComboBox1.Items.Add('U_OBRADI');
  ComboBox1.Items.Add('DOSTAVLJENO');
  ComboBox1.Items.Add('NEUSPESNO_DOSTAVLJENO');

  Refresh();
end;

procedure TKurirForm.ListBox1Click(Sender: TObject);
var SQL: String;
begin
  if ListBox1.ItemIndex <> -1 then
  begin
    selectedPosiljka := strToInt(ListBox1.Items[ListBox1.ItemIndex]);

    SQL := 'SELECT pr.naziv, pr.cena, pp.kolicina, ps.status, pp.ukupna_cena ' +
      'FROM posiljka_predmeti pp ' +
      'INNER JOIN predmeti pr ON pp.predmet_id = pr.id ' +
      'INNER JOIN posiljka ps ON pp.posiljka_id = ps.id ' +
      'WHERE pp.posiljka_id = :id';

    FDQuery2.SQL.Text := SQL;
    FDQuery2.ParamByName('id').Value := selectedPosiljka;
    FDQuery2.Active := True;

    ComboBox1.Text := FDQuery2.FieldByName('status').AsString;

    RefreshGrid();
    Refresh();
  end;
end;

procedure TKurirForm.RefreshGrid();
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

procedure TKurirForm.Refresh();
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

end.
