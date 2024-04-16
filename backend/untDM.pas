unit untDM;

interface

uses

  System.SysUtils,
  System.Classes,
  uRESTDWDatamodule,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.FMXUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.VCLUI.Wait,
  FireDAC.DApt,
  uRESTDWComponentBase,
  uRESTDWServerEvents,
  uRESTDWConsts,
  uRESTDWParams,
  uRESTDWDataUtils,
  uRESTDWTools,
  uRESTDWBasicTypes,
  uRESTDWEncodeClass,
  uRESTDWResponseTranslator,
  uRESTDWJSON;


type
  TDM = class(TServerMethodDataModule)
    conn: TFDConnection;
    ServerEvents: TRESTDWServerEvents;
    procedure ServerEventsEventsdweventVinilReplyEventByType(
      var Params: TRESTDWParams; var Result: string;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
  private
    function  ListarVinil(id_vinil: integer; out status: integer): string;
    function   CriarVinil(id_vinil: integer; nome_vinil, artista_vinil, capa_vinil:string; out status: integer): string;
    function AlterarVinil(id_vinil: integer; nome_vinil, artista_vinil, capa_vinil:string; out status: integer): string;
    function DeletarVinil(id_vinil: integer; out status: integer): string;

    { Private declarations }
  public
    { Public declarations }
    function CarregarConfig: string;
  end;

var
  DM: TDM;

implementation

uses
 System.IniFiles, uRESTDWJSONInterface,  uRESTDWJSONObject,
 FMX.Graphics, uFunctions, System.JSON;


{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

// funcao para carregar dados do aquivo ini
function TDm.CarregarConfig(): string;
var
    arq_ini : string;
    ini : TIniFile;
begin
    try
        arq_ini := System.SysUtils.GetCurrentDir + '\servidor.ini';

        // Verifica se INI existe...
        if NOT FileExists(arq_ini) then
        begin
            Result := 'Arquivo INI n�o encontrado: ' + arq_ini;
            exit;
        end;

        // Instanciar arquivo INI...
        ini := TIniFile.Create(arq_ini);

        // Buscar dados do arquivo fisico...
        dm.conn.Params.Clear;
        dm.conn.Params.Values['DriverID'] := ini.ReadString('Banco de Dados', 'DriverID', '');
        dm.conn.Params.Values['Database'] := ini.ReadString('Banco de Dados', 'Database', '');
        dm.conn.Params.Values['User_name'] := ini.ReadString('Banco de Dados', 'User_name', '');
        dm.conn.Params.Values['Password'] := ini.ReadString('Banco de Dados', 'Password', '');

        try
            conn.Connected := true;
            Result := 'OK';
        except on ex:exception do
            Result := 'Erro ao acessar o banco: ' + ex.Message;
        end;

    finally
        if Assigned(ini) then
            ini.DisposeOf;
    end;
end;

// funcao de endpoint de LISTAR o vinil
function TDM.ListarVinil(id_vinil: integer;
                         out status: integer) : string;
var
  json : uRESTDWJSONObject.TJSONValue;
  erro : string;
  qry : TFDQuery;

begin
  try
    // instanciar o objeto
    qry := TFDQuery.Create(nil);
    //manda ele conectar com o banco
    qry.Connection := dm.conn;
    qry.SQL.Add('SELECT * FROM TAB_VINIL WHERE ID_VINIL=:ID_VINIL');
    qry.ParamByName('id_vinil').Value := ID_VINIL;
    qry.Open;

    // serializando com json

    json := uRESTDWJSONObject.TJSONValue.Create;
    json.LoadFromDataset('',qry,false,dmRaw,'dd/mm/yyyy hh:nn:ss');

    Result := json.ToJSON;
    status := 200;



  finally
    // limpa o objeto da memoria
    qry.DisposeOf;
    json.DisposeOf;

  end;


end;

// funcao de endpoint de CRIAR o vinil
function TDM.CriarVinil(id_vinil: integer;
                         nome_vinil, artista_vinil, capa_vinil :string;
                         out status: integer) : string;

var
  json : TJSONObject;
  erro : string;
  qry : TFDQuery;
  foto_bmp: TBitmap;

begin
  try
    // instanciar o objeto
    json := TJSONObject.Create;


    qry := TFDQuery.Create(nil);
    //manda ele conectar com o banco
    qry.Connection := dm.conn;

    if (nome_vinil = '') then
    begin
      json.AddPair('retorno', 'Informe todos os parametros');
      status := 400;
      Result := json.toString;
      exit;
    end;

    //validando a foto da capa do vinil
    try
      foto_bmp := TFunctions.BitmapFromBase64(capa_vinil)

    except on ex:exception do
      begin
        json.AddPair('retorno', 'erro ao criar capa vinil: ' + ex.Message);
        status := 400;
        Result := json.toString;
        exit;
      end;

    end;

    // serializando com json

    try
      qry.SQL.Add('INSERT into tab_vinil(ID_VINIL, NOME_VINIL, ARTISTA_VINIL, CAPA_VINIL, DT_GRAVACAO)');
      QRY.SQL.Add('VALUES(:ID_VINIL, :NOME_VINIL, :ARTISTA_VINIL, :CAPA_VINIL, current_timestamp)');
      qry.ParamByName('ID_VINIL').Value := ID_VINIL;
      qry.ParamByName('NOME_VINIL').Value := NOME_VINIL;
      qry.ParamByName('ARTISTA_VINIL').Value := ARTISTA_VINIL;
      qry.ParamByName('CAPA_VINIL').Assign(foto_bmp);
      qry.ExecSQL;

      qry.SQL.Clear;
      qry.SQL.Add('SELECT MAX(ID_VINIL) AS ID_VINIL FROM TAB_VINIL');
      qry.Active := True;

      json.AddPair('retorno', 'ok');
      json.AddPair('ID_VINIL', qry.FieldByName('ID_VINIL').AsString);
      status := 201;


      Result := json.ToString;

    except on ex:exception do
      begin
        json.AddPair('retorno', ex.Message);
        status := 500;

      end;


    end;

  finally
    // limpa o objeto da memoria
    qry.DisposeOf;
    json.DisposeOf;
    foto_bmp.DisposeOf;
  end;


end;

// funcao de endpoint de ALTERAR o vinil
function TDM.AlterarVinil(id_vinil: integer;
                          nome_vinil, artista_vinil, capa_vinil :string;
                          out status: integer) : string;
var
    json : TJSONObject;
    qry : TFDQuery;
    foto_bmp : TBitmap;
begin
    try
        json := TJSONObject.Create;

        qry := TFDQuery.Create(nil);
        qry.Connection := dm.conn;


        // Valida��es dos parametros...
        if (nome_vinil = '') then
        begin
            json.AddPair('retorno', 'Informe todos os par�metros');
            Status := 400;
            Result := json.ToString;
            exit;
        end;

        // Criar foto bitmap...
        try
            foto_bmp := TFunctions.BitmapFromBase64(capa_vinil);
        except on ex:exception do
            begin
                json.AddPair('retorno', 'Erro ao criar foto no servidor: ' + ex.Message);
                Status := 400;
                Result := json.ToString;
                exit;
            end;
        end;


        try
            qry.SQL.Add('UPDATE TAB_VINIL SET NOME_VINIL=:NOME_VINIL, ARTISTA_VINIL=:ARTISTA_VINIL, CAPA_VINIL=:CAPA_VINIL');
            qry.SQL.Add('WHERE ID_VINIL=:ID_VINIL');
            qry.ParamByName('ID_VINIL').Value := id_vinil;
            qry.ParamByName('NOME_VINIL').Value := nome_vinil;
            qry.ParamByName('ARTISTA_VINIL').Value := artista_vinil;
            qry.ParamByName('CAPA_VINIL').Assign(foto_bmp);
            qry.ExecSQL;

            json.AddPair('retorno', 'OK');
            json.AddPair('id_vinil', id_vinil.ToString);
            Status := 200;

        except on ex:exception do
            begin
                json.AddPair('retorno', ex.Message);
                Status := 500;
            end;
        end;


        Result := json.ToString;

    finally
        json.DisposeOf;
        qry.DisposeOf;
    end;

end;

// funcao de endpoint de DELETAR o vinil
function TDM.DeletarVinil(id_vinil: integer;
                          out status: integer): string;
var
  json : TJSONObject;
  qry : TFDQuery;

begin
  try


    //instanciando
    json := TJSONObject.Create;

    qry := TFDQuery.Create(nil);
    qry.Connection := dm.conn;

    //valida��es dos parametros...
    if (id_vinil <= 0) then
    begin
      json.AddPair('retorno', 'Informe todos os parametros');
      status := 400;
      Result := json.toString;
      exit;
    end;


    // serializando com json
    try
      dm.conn.StartTransaction;

      qry.SQL.Add('DELETE FROM TAB_VINIL');
      QRY.SQL.Add('WHERE ID_VINIL=:ID_VINIL');
      qry.ParamByName('ID_VINIL').Value := ID_VINIL;
      qry.ExecSQL;

      json.AddPair('retorno', 'ok');
      json.AddPair('ID_VINIL', ID_VINIL.ToString);
      status := 200;


      dm.conn.Commit;

    except on ex:exception do
      begin
        dm.conn.Rollback;
        json.AddPair('retorno', ex.Message);
        status := 500;

      end;


    end;

  finally
    // limpa o objeto da memoria
    qry.DisposeOf;
    json.DisposeOf;


    end;
end;





procedure TDM.ServerEventsEventsdweventVinilReplyEventByType(
  var Params: TRESTDWParams; var Result: string;
  const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
begin
  //aqui montamos o que vai acontecer quando a requisicao chegar
  //no caso de get vamos listar o vinil
  if RequestType = TRequestType.rtGet then
    Result := ListarVinil(Params.ItemsString['id_vinil'].AsInteger,
                          StatusCode )
  else
  if RequestType = TRequestType.rtPost then
    Result := CriarVinil(Params.ItemsString['id_vinil'].AsInteger,
                         Params.ItemsString['nome_vinil'].AsString,
                         Params.ItemsString['artista_vinil'].AsString,
                         Params.ItemsString['capa_vinil'].AsString,
                         StatusCode)
  else
  if RequestType = TRequestType.rtDelete then
    Result := DeletarVinil(Params.ItemsString['id_vinil'].AsInteger,
                           StatusCode)
  else
  if RequestType = TRequestType.rtPatch then
    Result := AlterarVinil(Params.ItemsString['id_vinil'].AsInteger,
                           Params.ItemsString['nome_vinil'].AsString,
                           Params.ItemsString['artista_vinil'].AsString,
                           Params.ItemsString['capa_vinil'].AsString,
                           StatusCode);




end;

end.

