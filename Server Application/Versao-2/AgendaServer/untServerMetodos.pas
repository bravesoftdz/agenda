unit untServerMetodos;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet,Data.FireDACJSONReflect,
  FireDAC.Stan.StorageBin;

type
{$METHODINFO ON}
  TSrvServerMetodos = class(TDataModule)
    fdqAlunos: TFDQuery;
    FDConnection: TFDConnection;
    FDMySQLDriverLink: TFDPhysMySQLDriverLink;
    FDWaitCursor: TFDGUIxWaitCursor;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function GetAlunos:TFDJSONDataSets;
  end;
{$METHODINFO OFF}

implementation


{$R *.dfm}


uses System.StrUtils;

function TSrvServerMetodos.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TSrvServerMetodos.GetAlunos: TFDJSONDataSets;
begin
  //Devolve para o cliente o DataSet de Pedidos
  //Elimina cache
  fdqAlunos.Active := False;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, fdqAlunos);
end;

function TSrvServerMetodos.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

