﻿unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    korisnickoIme: TEdit;
    Label2: TLabel;
    sifra: TEdit;
    Button1: TButton;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Unit2, Unit3, Unit4, Unit5;

procedure TForm1.Button1Click(Sender: TObject);
var found: boolean;
begin
  DataModule2.NaloziTable.Open;

  begin
    DataModule2.NaloziTable.First;

      while (not DataModule2.NaloziTable.Eof) and (found = false) do
        begin
           if (DataModule2.NaloziTable['korisnicko_ime'] = korisnickoIme.Text) and (DataModule2.NaloziTable['sifra'] = sifra.Text) then
              begin
                  found := true;

                  if DataModule2.NaloziTable['tip'] = 'korisnik' then
                    begin
                      Form3.Show(); // prikazuje paker meni

                      Form1.Hide(); // gasi prozor za login
                    end;

                  if DataModule2.NaloziTable['tip'] = 'kurir' then
                    begin
                      Form4.Show(); // prikazuje paker meni

                      Form1.Hide(); // gasi prozor za login
                    end;

                  if DataModule2.NaloziTable['tip'] = 'paker' then
                    begin
                      Form5.Show(); // prikazuje paker meni

                      Form1.Hide(); // gasi prozor za login
                    end;

              end
            else
              DataModule2.NaloziTable.Next;
        end;
    end;
      if found = false then
        ShowMessage('Pogrešno korisničko ime / lozinka!');
    end;

end.
