program Project1;

uses
  Vcl.Forms,
  Login in 'Login.pas' {LoginForm},
  DB in 'DB.pas' {DataModule2: TDataModule},
  Korisnik in 'Korisnik.pas' {KorisnikForm},
  Kurir in 'Kurir.pas' {KurirForm},
  Paker in 'Paker.pas' {PakerForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLoginForm, LoginForm);
  Application.CreateForm(TDataModule2, DataModule2);
  Application.CreateForm(TKorisnikForm, KorisnikForm);
  Application.CreateForm(TKurirForm, KurirForm);
  Application.CreateForm(TPakerForm, PakerForm);
  Application.Run;
end.
