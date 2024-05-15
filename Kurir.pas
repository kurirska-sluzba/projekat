unit Kurir;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  KurirForm: TKurirForm;

implementation

{$R *.dfm}

end.
