unit untPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView;

type
  TfrmPrincipal = class(TForm)
    recToolbar: TRectangle;
    imgMenu: TImage;
    imgAdd: TImage;
    lblTitulo: TLabel;
    listPrincipal: TListView;
    imgCapaVinil: TImage;
    imgEditarVinil: TImage;
    imgTracks: TImage;
    imgPreview: TImage;
    procedure imgAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses untCadVinil;

procedure TfrmPrincipal.imgAddClick(Sender: TObject);
begin
  //chamando tela de cadastro de vinil

end;

end.
