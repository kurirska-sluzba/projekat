﻿unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TLoginForm = class(TForm)
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
  LoginForm: TLoginForm;

implementation

{$R *.dfm}

uses DB, Korisnik, Kurir, Paker;

procedure TLoginForm.Button1Click(Sender: TObject);
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
                      KorisnikForm.Show();

                      LoginForm.Hide();
                    end;

                  if DataModule2.NaloziTable['tip'] = 'kurir' then
                    begin
                      KurirForm.Show();

                      LoginForm.Hide();
                    end;

                  if DataModule2.NaloziTable['tip'] = 'paker' then
                    begin
                      PakerForm.Show();

                      LoginForm.Hide();
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
