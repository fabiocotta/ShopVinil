program ShopVinil;

uses
  System.StartUpCopy,
  FMX.Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  untCadVinil in 'untCadVinil.pas' {FrmCadVinil};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TFrmCadVinil, FrmCadVinil);
  Application.Run;
end.
