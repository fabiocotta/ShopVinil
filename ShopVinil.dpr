program ShopVinil;

uses
  System.StartUpCopy,
  FMX.Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  untCadVinil in 'untCadVinil.pas' {FrmCadVinil},
  untTrackes in 'untTrackes.pas' {FrmTrackes},
  untCadTracke in 'untCadTracke.pas' {frmCadTracke};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
