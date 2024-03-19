program ShopVinil;

uses
  System.StartUpCopy,
  FMX.Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  untCadVinil in 'untCadVinil.pas' {FrmCadVinil},
  untTrackes in 'untTrackes.pas' {FrmTrackes};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TFrmCadVinil, FrmCadVinil);
  Application.CreateForm(TFrmTrackes, FrmTrackes);
  Application.Run;
end.
