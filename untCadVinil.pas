unit untCadVinil;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
  TFrmCadVinil = class(TForm)
    recToolbar: TRectangle;
    imgVoltar: TImage;
    imgRemover: TImage;
    lblTituloNovo: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadVinil: TFrmCadVinil;

implementation

{$R *.fmx}

end.
