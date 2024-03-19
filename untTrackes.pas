unit untTrackes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
  TFrmTrackes = class(TForm)
    recToolbar: TRectangle;
    imgVoltar: TImage;
    lblTituloTrakes: TLabel;
    imgAddTracke: TImage;
    lblTituloVinil: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTrackes: TFrmTrackes;

implementation

{$R *.fmx}

end.