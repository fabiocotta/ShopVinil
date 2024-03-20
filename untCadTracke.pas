unit untCadTracke;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Edit, FMX.Layouts;

type
  TfrmCadTracke = class(TForm)
    recToolbar: TRectangle;
    imgVoltar: TImage;
    imgRemover: TImage;
    lblTituloNovaTracke: TLabel;
    layNovoVinil: TLayout;
    lblNomeTracke: TLabel;
    edtNomeTracke: TEdit;
    recFooter: TRectangle;
    btnSalvarVinil: TSpeedButton;
    Layout1: TLayout;
    lblTempoTracke: TLabel;
    Edit1: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadTracke: TfrmCadTracke;

implementation

{$R *.fmx}

end.
