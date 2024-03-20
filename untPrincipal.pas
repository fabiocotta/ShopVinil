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
    imgEditarVinil: TImage;
    imgTrackes: TImage;
    imgPreview: TImage;
    imgCapaVinil: TImage;
    procedure imgAddClick(Sender: TObject);
    procedure listPrincipalItemClickEx(const Sender: TObject;
      ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
    procedure imgCapaVinilClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
       procedure AbrirCadVinil(idVinil: integer);
    procedure AddVinilLista(idVinil: integer; nomeVinil: string; artistaVinil: string;
      valorVinil: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses untCadVinil, untTrackes;

procedure TfrmPrincipal.AddVinilLista(idVinil: integer; nomeVinil:string; artistaVinil:string; valorVinil:string);
begin
  with listPrincipal.Items.Add do
  begin
    Height := 150;
    TListItemText(Objects.FindDrawable('txtTituloVinil')).Text    := nomeVinil;
    TListItemText(Objects.FindDrawable('txtArtistaVinil')).Text   := artistaVinil;
    TListItemText(Objects.FindDrawable('txtValorVinil')).Text     := valorVinil;
    TListItemImage(Objects.FindDrawable('imgCapaVinil')).Bitmap   := imgCapaVinil.Bitmap;
    TListItemImage(Objects.FindDrawable('imgEditar')).Bitmap      := imgEditarVinil.Bitmap;
    TListItemImage(Objects.FindDrawable('imgTrackes')).Bitmap     := imgTrackes.Bitmap;
  end;

end;


procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  AddVinilLista(0, 'Nevermind [Disco de Vinil]','NIRVANA','R$ 140,00');
  AddVinilLista(0, 'Nevermind [Disco de Vinil]','NIRVANA','R$ 140,00');

end;

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

procedure TfrmPrincipal.imgCapaVinilClick(Sender: TObject);
begin

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
