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
    procedure listPrincipalItemClickEx(const Sender: TObject;
      ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
  private
       procedure AbrirCadVinil(idVinil: integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses untCadVinil, untTrackes;

procedure TfrmPrincipal.AbrirCadVinil(idVinil: integer);
begin
   //chamando tela de cadastro de vinil
  if NOT assigned (FrmCadVinil) then
  begin
    Application.CreateForm(TFrmCadVinil, FrmCadVinil);

    //quando o FrmCadVinil for fechado ele atualiza a list do FrmPrincipal
    FrmCadVinil.ShowModal(
      procedure (ModalResult: TModalResult)
        begin

        end);
  end;
end;

procedure TfrmPrincipal.imgAddClick(Sender: TObject);
begin
  AbrirCadVinil(0);

end;

//vamos utilizar o onItemClickEx para pegar o objeto clicado
procedure TfrmPrincipal.listPrincipalItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
  if TListView(Sender).Selected <> nil then
    begin
      // Img Editar
      if ItemObject is TListItemImage then
        begin
          if TListItemImage(ItemObject).Name = 'imgEditar' then
          AbrirCadVinil(0);

        end;

      // Img Trackes
      if ItemObject is TListItemImage then
        begin
          if TListItemImage(ItemObject).Name = 'imgTrackes' then
          begin
          if NOT Assigned(FrmTrackes) then
          begin
            Application.CreateForm(TFrmTrackes, FrmTrackes);
            FrmTrackes.Show;
          end;


          end;

        end;

    end;


end;



end.
