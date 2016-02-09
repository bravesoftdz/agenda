unit untModuloCliente;

interface

uses
  System.SysUtils, System.Classes, Proxy, IPPeerClient, Datasnap.DSClientRest;

type
  TModuloCliente = class(TDataModule)
    DSRestConnection1: TDSRestConnection;
    DSRestConnectionLocal: TDSRestConnection;
    DSRestConnectionAWS: TDSRestConnection;
  private
    FInstanceOwner: Boolean;
    FSrvServerMetodosClient: TSrvServerMetodosClient;
    function GetSrvServerMetodosClient: TSrvServerMetodosClient;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property SrvServerMetodosClient: TSrvServerMetodosClient read GetSrvServerMetodosClient write FSrvServerMetodosClient;

end;

var
  ModuloCliente: TModuloCliente;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

constructor TModuloCliente.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TModuloCliente.Destroy;
begin
  FSrvServerMetodosClient.Free;
  inherited;
end;

function TModuloCliente.GetSrvServerMetodosClient: TSrvServerMetodosClient;
begin
  if FSrvServerMetodosClient = nil then
    FSrvServerMetodosClient:= TSrvServerMetodosClient.Create(DSRestConnection1, FInstanceOwner);
  Result := FSrvServerMetodosClient;
end;

end.
