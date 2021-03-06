unit untDmGetServer;

interface

uses
  System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageBin,DateUtils,
  FMX.Types, FMX.Dialogs,Data.FireDACJSONReflect;

type
  TDmGetServer = class(TDataModule)
    fdStanStorageBinLink: TFDStanStorageBinLink;
    fdqAluno: TFDQuery;
    fdqTurma: TFDQuery;
    fdqTurmaAluno: TFDQuery;
    fdqResp: TFDQuery;
    fdqRespAluno: TFDQuery;
    fdqRespTelefone: TFDQuery;
    fdqFunc: TFDQuery;
    fdqAgenda: TFDQuery;
    fdqAgendaAluno: TFDQuery;
    fdqAgendaTurma: TFDQuery;
    fdqAgendaKeysInsert: TFDQuery;
    fdqRespEscola: TFDQuery;
    fdqRespTipo: TFDQuery;
    fdqConfiguracoes: TFDQuery;
    fdqProcessoAtualizacao: TFDQuery;
    fdqDeviceUsuario: TFDQuery;
  private
  public
    procedure OpenProcessoAtualizacao;
    procedure OpenAlunos;
    procedure OpenTurmas;
    procedure OpenFuncionarios;
    procedure OpenResponsaveis;
    procedure OpenConfiguracoes;
    procedure OpenDeviceUsuario;

    procedure GetProcessoAtualizacao;

    function GetDataSet(Nome: String;
                         UtilizaParamEscolaId:Boolean=True;
                         Condicoes: String='';
                         AtualizaDataSetLocal:Boolean=True
                         ):TFDDataSet;

    procedure GetEscola;
    procedure GetPeriodoTipo;
    procedure GetResponsavelTipo;
    procedure GetFuncionarioTipo;
    procedure GetTelefoneTipo;
    procedure GetAgendaTipo;
    procedure GetSistemaOperacionalTipo;
    procedure GetAlunos;
    procedure GetTurmas;
    procedure GetResponsaveis;
    procedure GetFuncionarios;
    function GetFuncionario(FuncionarioId:Integer):TFDDataSet;
    function GetResponsavel(ResponsavelId:Integer):TFDDataSet;
    procedure GetConfiguracoes;
    procedure GetDeviceUsuario;

    procedure GetAgenda(DtIni,DtFim:TDateTime);
    procedure GetAgendaTeste(DtIni,DtFim:TDateTime);

    //Agenda
    procedure OpenAgendaKeysInsert(DtIni,DtFim:TDateTime);
    function GetAgendaListKeysInsert(DtIni,DtFim:TDateTime):TFDJSONDataSets;
    function GetAgendaKeysInsert(DtIni,DtFim:TDateTime):String;

    procedure OpenAgenda(KeyValues:String);
    procedure OpenAgendaAluno(KeyValues:String);
    procedure OpenAgendaTurma(KeyValues:String);
    procedure SetSQLAgenda(KeyValues:String);overload;
    procedure SetSQLAgendaAluno(KeyValues:String);overload;
    procedure SetSQLAgendaTurma(KeyValues:String);overload;
    procedure CloseAgenda;

    procedure GetDadosServerGeral;
    procedure GetDadosServerBasico;
  end;

var
  DmGetServer: TDmGetServer;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses untDM, untRestClient, smDBFireDac,System.SysUtils, smGeralFMX, untLibDevicePortable, FMX.Forms,smMensagensFMX,smNetworkState,
  untLibGeral, Data.DBXJSONReflect, System.JSON, System.ZLib, untTypes, untSQLs;

{$R *.dfm}

{ TDmGetServer }

procedure TDmGetServer.CloseAgenda;
begin
  fdqAgenda.Active := False;
  fdqAgendaAluno.Active := False;
  fdqAgendaTurma.Active := False;
end;

procedure TDmGetServer.GetAgenda(DtIni, DtFim: TDateTime);
var
  LDataSetList: TFDJSONDataSets;
  LDataSet: TFDDataSet;
  KeyValues: string;
begin
  //M�todo para retornar as Agendas
  try
    try
      KeyValues:= EmptyStr;

      if not ValidacoesRestClientBeforeExecute then
        Exit;

      LDataSetList := RestClient.SmAgendaClient.GetAgenda( GetEscolaId,
                                                           Usuario.Marshal,
                                                           DtIni,
                                                           DtFim,
                                                           GetAgendaKeysInsert(DtIni,DtFim)
                                                          );

      //Pegando dados da agenda
      LDataSet := TFDJSONDataSetsReader.GetListValueByName(LDataSetList,'agenda');

      if LDataSet.IsEmpty then
        Exit;

      KeyValues:= GetKeyValuesDataSet(LDataSet,'agenda_id');
      OpenAgenda(KeyValues);
      CopyDataSet(LDataSet,fdqAgenda,False,[coAppend,coEdit]);

      //Pegando dados da agenda_aluno
      LDataSet := TFDJSONDataSetsReader.GetListValueByName(LDataSetList,'agenda_aluno');
      KeyValues:= GetKeyValuesDataSet(LDataSet,'agenda_id');
      OpenAgendaAluno(KeyValues);
      CopyDataSet(LDataSet,fdqAgendaAluno,False,[coAppend,coEdit]);

      //Pegando dados da agenda_turma
      LDataSet := TFDJSONDataSetsReader.GetListValueByName(LDataSetList,'agenda_turma');
      KeyValues:= GetKeyValuesDataSet(LDataSet,'agenda_id');
      OpenAgendaTurma(KeyValues);
      CopyDataSet(LDataSet,fdqAgendaTurma,False,[coAppend,coEdit]);
      MsgPoupUpTeste('DmGetServer.GetAgenda Executado: ' + DateToStr(DtIni) + ' � '+ DateToStr(DtFim));
    except on E:Exception do
    begin
      DM.SetLogError( E.Message,
                      GetApplicationName,
                      UnitName,
                      ClassName,
                      'GetAgenda',
                      Now,
                      'Erro na busca da agenda' + #13 + E.Message
                    );
      Raise;
    end;
    end;
  finally
  end;

end;

function TDmGetServer.GetAgendaKeysInsert(DtIni, DtFim: TDateTime): String;
begin
  OpenAgendaKeysInsert(DtIni,DtFim);
  Result:= GetKeyValuesDataSet(fdqAgendaKeysInsert,'agenda_id');
end;

procedure TDmGetServer.GetAgendaTeste(DtIni, DtFim: TDateTime);
var
  LDataSetList: TFDJSONDataSets;
  LDataSet: TFDDataSet;
  KeyValues: string;
  UsuarioJSONValue: TJSONValue;
  KeysInserts:String;
begin
  //M�todo para retornar as Agendas
  try
    try
      //MsgPoupUpTeste('Inicio DmGetServer.GetAgendaTeste');
      KeyValues:= EmptyStr;
      UsuarioJSONValue:= Usuario.MarshalValue;

      OpenAgendaKeysInsert(DtIni,DtFim);
      KeysInserts:= GetKeyValuesDataSet(fdqAgendaKeysInsert,'agenda_id');

      if not ValidacoesRestClientBeforeExecute then
        Exit;

      LDataSetList := RestClient.SmAgendaClient.GetAgendaTeste(GetEscolaId,
                                                                 Usuario.Marshal,
                                                                 DtIni,
                                                                 DtFim,
                                                                 KeysInserts
                                                                 );

      //Pegando dados da agenda
      LDataSet := TFDJSONDataSetsReader.GetListValueByName(LDataSetList,'agenda');

     if LDataSet.IsEmpty then
        Exit;

      KeyValues:= GetKeyValuesDataSet(LDataSet,'agenda_id');
      //ShowMessage(KeyValues);
      OpenAgenda(KeyValues);

      CopyDataSet(LDataSet,fdqAgenda,False,[coAppend,coEdit]);

      //Pegando dados da agenda_aluno
      LDataSet := TFDJSONDataSetsReader.GetListValueByName(LDataSetList,'agenda_aluno');
      KeyValues:= GetKeyValuesDataSet(LDataSet,'agenda_id');
      OpenAgendaAluno(KeyValues);
      CopyDataSet(LDataSet,fdqAgendaAluno,False,[coAppend,coEdit]);

      //Pegando dados da agenda_turma
      LDataSet := TFDJSONDataSetsReader.GetListValueByName(LDataSetList,'agenda_turma');
      KeyValues:= GetKeyValuesDataSet(LDataSet,'agenda_id');
      OpenAgendaTurma(KeyValues);
      CopyDataSet(LDataSet,fdqAgendaTurma,False,[coAppend,coEdit]);

    except on E:Exception do
    begin
      DM.SetLogError( E.Message,
                      GetApplicationName,
                      UnitName,
                      ClassName,
                      'GetAgenda',
                      Now,
                      '**Erro na busca da agenda Teste' + #13 + E.Message
                    );
       Raise;
    end;
    end;
  finally
    //ListKeysInsert.DisposeOf;
  end;
end;

procedure TDmGetServer.GetAgendaTipo;
begin
  GetDataSet('agenda_tipo',False);
end;

function TDmGetServer.GetFuncionario(FuncionarioId: Integer):TFDDataSet;
begin
  Result:= GetDataSet('funcionario',
              True,
              'and funcionario_id = ' + IntToStr(FuncionarioId),
              False);
end;

procedure TDmGetServer.GetFuncionarios;
var
  LDataSetList  : TFDJSONDataSets;
  LDataSet: TFDDataSet;
begin
  try
    try
      if not Dm.ProcessHasUpdate('funcionario') then
       Exit;

      if not ValidacoesRestClientBeforeExecute then
        Exit;

      OpenFuncionarios;
      LDataSetList := RestClient.SmMainClient.GetFuncionarios(GetEscolaId,Usuario.Marshal);
      LDataSet := TFDJSONDataSetsReader.GetListValueByName(LDataSetList,'funcionario');
      CopyDataSet(LDataSet,fdqFunc);

      DM.ProcessSaveUpdate('funcionario');
      MsgPoupUpTeste('DmGetServer.GetFuncionarios Executado');
    except on E:Exception do
    begin
      DM.SetLogError( E.Message,
                      GetApplicationName,
                      UnitName,
                      ClassName,
                      'GetFuncionarios',
                      Now,
                      'Erro na busca de Funcionarios' + #13 + E.Message
                      );
       Raise;
    end;
    end;
  finally
  end;
end;

procedure TDmGetServer.GetFuncionarioTipo;
begin
  GetDataSet('funcionario_tipo',False);
end;

function TDmGetServer.GetAgendaListKeysInsert(DtIni,
  DtFim: TDateTime): TFDJSONDataSets;
begin
  try
    Result:= TFDJSONDataSets.Create;
    OpenAgendaKeysInsert(DtIni,DtFim);
    TFDJSONDataSetsWriter.ListAdd(Result,fdqAgendaKeysInsert);
  finally
  end;
end;

procedure TDmGetServer.GetAlunos;
var
  LDataSetList  : TFDJSONDataSets;
  LDataSet: TFDDataSet;
begin
  try
    if not Dm.ProcessHasUpdate('aluno') then
      Exit;

    OpenAlunos;
    if not ValidacoesRestClientBeforeExecute then
      Exit;

    LDataSetList := RestClient.SmMainClient.GetAlunos(GetEscolaId,Usuario.Marshal);
    LDataSet := TFDJSONDataSetsReader.GetListValue(LDataSetList,0);
    CopyDataSet(LDataSet,fdqAluno);

    DM.ProcessSaveUpdate('aluno');
    MsgPoupUpTeste('DmGetServer.GetAlunos Executado');
  except on E:Exception do
  begin
    DM.SetLogError( E.Message,
                    GetApplicationName,
                    UnitName,
                    ClassName,
                    'GetAlunos',
                    Now,
                    'Erro na busca de alunos' + #13 + E.Message
                    );
     Raise;
  end;
  end;

end;

procedure TDmGetServer.GetConfiguracoes;
var
  LDataSetList  : TFDJSONDataSets;
  LDataSet: TFDDataSet;
begin
  try
    if not Dm.ProcessHasUpdate('configuracoes') then
      Exit;

    OpenConfiguracoes;
    if not ValidacoesRestClientBeforeExecute then
      Exit;

    LDataSetList := RestClient.SmMainClient.GetConfiguracoes(GetEscolaId,Usuario.Marshal);
    LDataSet := TFDJSONDataSetsReader.GetListValue(LDataSetList,0);
    CopyDataSet(LDataSet,fdqConfiguracoes);

    DM.ProcessSaveUpdate('configuracoes');
    MsgPoupUpTeste('DmGetServer.GetConfiguracoes Executado');
  except on E:Exception do
  begin
    DM.SetLogError( E.Message,
                    GetApplicationName,
                    UnitName,
                    ClassName,
                    'GetConfiguracoes',
                    Now,
                    'Erro na busca de configuracoes' + #13 + E.Message
                    );
     Raise;
  end;
  end;
end;

procedure TDmGetServer.GetDadosServerGeral;
begin
  try
    GetProcessoAtualizacao;
    //MsgPoupUpTeste('DmGetServer.GetTabelaAtualizacao OK');
  except on E:Exception do
    MsgPoupUp('DmGetServer.GetTabelaAtualizacao Erro:' + e.Message);
  end;

  try
    GetResponsaveis;
    //MsgPoupUpTeste('DmGetServer.GetResponsaveis OK');
  except on E:Exception do
    MsgPoupUp('DmGetServer.GetResponsaveis Erro:' + e.Message);
  end;

  try
    GetAlunos;
    //MsgPoupUpTeste('DmGetServer.GetAlunos OK');
  except on E:Exception do
    MsgPoupUp('DmGetServer.GetAlunos Erro:' + e.Message);
  end;

  try
    GetTurmas;
    //MsgPoupUpTeste('DmGetServer.GetTurmas OK');
  except on E:Exception do
    MsgPoupUp('DmGetServer.GetTurmas Erro:' + e.Message);
  end;

  try
    GetFuncionarios;
    //MsgPoupUpTeste('DmGetServer.GetFuncionarios OK');
  except on E:Exception do
    MsgPoupUp('DmGetServer.GetFuncionarios Erro:' + e.Message);
  end;

  try
    GetEscola;
    //MsgPoupUpTeste('DmGetServer.GetEscola OK');
  except on E:Exception do
    MsgPoupUp('DmGetServer.GetEscola Erro:' + e.Message);
  end;

  try
    GetPeriodoTipo;
    //MsgPoupUpTeste('DmGetServer.PeriodoTipo OK');
  except on E:Exception do
    MsgPoupUp('DmGetServer.PeriodoTipo Erro:' + e.Message);
  end;

  try
    GetResponsavelTipo;
    //MsgPoupUpTeste('DmGetServer.ResponsavelTipo OK');
  except on E:Exception do
    MsgPoupUp('DmGetServer.ResponsavelTipo Erro:' + e.Message);
  end;

  try
    GetSistemaOperacionalTipo;
    //MsgPoupUpTeste('DmGetServer.GetSistemaOperacionalTipo OK');
  except on E:Exception do
    MsgPoupUp('DmGetServer.GetSistemaOperacionalTipo Erro:' + e.Message);
  end;

  try
    GetFuncionarioTipo;
    //MsgPoupUpTeste('DmGetServer.FuncionarioTipo OK');
  except on E:Exception do
    MsgPoupUp('DmGetServer.FuncionarioTipo Erro:' + e.Message);
  end;

  try
    GetTelefoneTipo;
    //MsgPoupUpTeste('DmGetServer.TelefoneTipo OK');
  except on E:Exception do
    MsgPoupUp('DmGetServer.TelefoneTipo Erro:' + e.Message);
  end;

  try
    GetAgendaTipo;
    //MsgPoupUpTeste('DmGetServer.AgendaTipo OK');
  except on E:Exception do
    MsgPoupUp('DmGetServer.AgendaTipo Erro:' + e.Message);
  end;

  try
    GetConfiguracoes;
    //MsgPoupUpTeste('DmGetServer.GetConfiguracoes OK');
  except on E:Exception do
    MsgPoupUp('DmGetServer.GetConfiguracoes Erro:' + e.Message);
  end;

  try
    GetDeviceUsuario;
    //MsgPoupUpTeste('DmGetServer.GetConfiguracoes OK');
  except on E:Exception do
    MsgPoupUp('DmGetServer.GetDeviceUsuario Erro:' + e.Message);
  end;

  try
    GetAgenda(DtSyncGeralIni, DtSyncGeralFim);
    //MsgPoupUpTeste('DmGetServer.GetAgenda OK');
  except on E:Exception do
    MsgPoupUp('DmGetServer.GetAgenda Erro:' + e.Message);
  end;
end;

function TDmGetServer.GetDataSet(Nome: String; UtilizaParamEscolaId: Boolean;
  Condicoes: String;AtualizaDataSetLocal:Boolean):TFDDataSet;
var
  LDataSetList  : TFDJSONDataSets;
  LDataSetServer: TFDDataSet;
  fdqDataSet: TFDQuery;
begin
  try
    fdqDataSet := TFDQuery.Create(self);

    try
      if Nome = '' then
       raise Exception.Create('GetDataSet: Nome n�o definido');

      if not Dm.ProcessHasUpdate(Nome) and (AtualizaDataSetLocal) then
       Exit;

      if AtualizaDataSetLocal then
      begin
        fdqDataSet.Connection:=Dm.FDConnectionDB;

        fdqDataSet.Active := False;

        fdqDataSet.SQL.Clear;
        fdqDataSet.SQL.Add('select * from ' + Nome);
        fdqDataSet.SQL.Add('where 1 = 1');

        if UtilizaParamEscolaId then
          fdqDataSet.SQL.Add('and escola_id = ' + IntToStr(GetEscolaId));

        if Condicoes <> EmptyStr then
          fdqDataSet.SQL.Add(Condicoes);
      end;


      if not ValidacoesRestClientBeforeExecute then
        Exit;

      LDataSetList := RestClient.SmMainClient.GetDataSet(GetEscolaId,
                                                              Nome,
                                                              Usuario.Marshal,
                                                              UtilizaParamEscolaId,
                                                              Condicoes);



      LDataSetServer := TFDJSONDataSetsReader.GetListValue(LDataSetList,0);
      Result:= LDataSetServer;
      if AtualizaDataSetLocal then
      begin
        CopyDataSet(LDataSetServer,fdqDataSet,False,[coAppend,coEdit]);
        DM.ProcessSaveUpdate(Nome);
      end;

      MsgPoupUpTeste('DmGetServer.' + Nome + ' Executado');
    except on E:Exception do
    begin
      DM.SetLogError( E.Message,
                      GetApplicationName,
                      UnitName,
                      ClassName,
                      'GetDataSet:' + Nome,
                      Now,
                      'Erro na busca GetDataSet:' + Nome + #13 + E.Message
                     );
       Raise;
    end;
    end;
  finally
    //if AtualizaDataSetLocal then
     if Assigned(fdqDataSet) then
      fdqDataSet.DisposeOf;
  end;

end;

procedure TDmGetServer.GetDeviceUsuario;
var
  LDataSetList  : TFDJSONDataSets;
  LDataSet: TFDDataSet;
begin
  try
    if not Dm.ProcessHasUpdate('device_usuario') then
      Exit;

    OpenDeviceUsuario;
    if not ValidacoesRestClientBeforeExecute then
      Exit;

    LDataSetList := RestClient.SmMainClient.GetDeviceUsuario(GetEscolaId,Usuario.Marshal);
    LDataSet := TFDJSONDataSetsReader.GetListValue(LDataSetList,0);
    CopyDataSet(LDataSet,fdqDeviceUsuario);

    DM.ProcessSaveUpdate('device_usuario');
    MsgPoupUpTeste('DmGetServer.GetDeviceUsuario Executado');
  except on E:Exception do
  begin
    DM.SetLogError( E.Message,
                    GetApplicationName,
                    UnitName,
                    ClassName,
                    'GetDeviceUsuario',
                    Now,
                    'Erro na busca de device_usuario' + #13 + E.Message
                    );
     Raise;
  end;
  end;
end;

procedure TDmGetServer.GetEscola;
begin
  GetDataSet('escola');
end;

procedure TDmGetServer.GetProcessoAtualizacao;
var
  LDataSetList  : TFDJSONDataSets;
  LDataSet: TFDDataSet;
begin
  try
    OpenProcessoAtualizacao;
    if not ValidacoesRestClientBeforeExecute then
      Exit;

    LDataSetList := RestClient.SmMainClient.GetProcessoAtualizacao(GetEscolaId,Usuario.Marshal);
    LDataSet := TFDJSONDataSetsReader.GetListValue(LDataSetList,0);
    CopyDataSet(LDataSet,fdqProcessoAtualizacao,False,[coAppend,coEdit]);
    MsgPoupUpTeste('DmGetServer.GetTabelaAtualizacao Executado');
  except on E:Exception do
  begin
    DM.SetLogError( E.Message,
                    GetApplicationName,
                    UnitName,
                    ClassName,
                    'GetTabelaAtualizacao',
                    Now,
                    'Erro na busca de Tabelas Atualiza��o' + #13 + E.Message
                   );
    Raise;
  end;
  end;
end;

procedure TDmGetServer.OpenAgendaAluno(KeyValues: String);
begin
  fdqAgendaAluno.Active := False;
  SetSQLAgendaAluno(KeyValues);
  fdqAgendaAluno.Active := True;
end;

procedure TDmGetServer.OpenAgendaKeysInsert(DtIni, DtFim: TDateTime);
begin
  fdqAgendaKeysInsert.Close;
  fdqAgendaKeysInsert.ParamByName('dt_ini').AsDate := DtIni;
  fdqAgendaKeysInsert.ParamByName('dt_fim').AsDate := DtFim;
  fdqAgendaKeysInsert.Open;
end;

procedure TDmGetServer.OpenAgenda(KeyValues: String);
begin
  CloseAgenda;
  SetSQLAgenda(KeyValues);
  fdqAgenda.Active := True;
end;

procedure TDmGetServer.OpenAgendaTurma(KeyValues: String);
begin
  fdqAgendaTurma.Active := False;
  SetSQLAgendaTurma(KeyValues);
  fdqAgendaTurma.Active := True;
end;

procedure TDmGetServer.OpenAlunos;
begin
  fdqAluno.SQL.Clear;
  fdqAluno.SQL.Add(rs_SQLAluno);
  fdqAluno.SQL.Add(GetSQLEscolaId);
end;

procedure TDmGetServer.OpenConfiguracoes;
begin
  fdqConfiguracoes.Close;
  fdqConfiguracoes.SQL.Clear;
  fdqConfiguracoes.SQL.Add('select * from configuracoes');
  fdqConfiguracoes.SQL.Add('where 1=1');
  fdqConfiguracoes.SQL.Add('and ((responsavel_id is null) and (funcionario_id is null)');

  if Usuario.Tipo = Funcionario then
  begin
    fdqConfiguracoes.SQL.Add(' or (funcionario_id = :funcionario_id)');
    fdqConfiguracoes.ParamByName('funcionario_id').AsInteger:=Usuario.Id;
  end;

  if Usuario.Tipo = Responsavel then
  begin
    fdqConfiguracoes.SQL.Add(' or (responsavel_id = :responsavel_id)');
    fdqConfiguracoes.ParamByName('responsavel_id').AsInteger:=Usuario.Id;
  end;

  fdqConfiguracoes.SQL.Add(')');
  fdqConfiguracoes.Open;
end;

procedure TDmGetServer.OpenDeviceUsuario;
begin
  fdqDeviceUsuario.Close;
  fdqDeviceUsuario.SQL.Clear;
  fdqDeviceUsuario.SQL.Add('select * from device_usuario');
  fdqDeviceUsuario.SQL.Add('where ' + Usuario.FieldName + ' = ' + IntToStr(Usuario.Id));
  fdqDeviceUsuario.Open;
end;

procedure TDmGetServer.OpenFuncionarios;
begin
  fdqFunc.Close;
  fdqFunc.SQL.Clear;
  fdqFunc.SQL.Add(rs_SQLFuncionario);
  fdqFunc.SQL.Add(GetSQLEscolaId);
  fdqFunc.Open;
end;

procedure TDmGetServer.OpenProcessoAtualizacao;
begin
  fdqProcessoAtualizacao.Close;
  fdqProcessoAtualizacao.SQL.Clear;


  if Usuario.Tipo = Funcionario then
  begin
    fdqProcessoAtualizacao.SQL.Add('SELECT * FROM processo_atualizacao');
    fdqProcessoAtualizacao.SQL.Add('where ((escola_id = :escola_id) or (escola_id = 0) or (funcionario_id = :funcionario_id) )');
    fdqProcessoAtualizacao.ParamByName('escola_id').AsInteger := GetEscolaId;
    fdqProcessoAtualizacao.ParamByName('funcionario_id').AsInteger := Usuario.Id;
  end;


  if Usuario.Tipo = Responsavel then
  begin
    fdqProcessoAtualizacao.SQL.Add('SELECT * FROM processo_atualizacao');
    fdqProcessoAtualizacao.SQL.Add('where ((escola_id = 0) ' + GetSQLEscolaId('escola_id','or'));
    fdqProcessoAtualizacao.SQL.Add('or (responsavel_id = :responsavel_id))');
    fdqProcessoAtualizacao.ParamByName('responsavel_id').AsInteger := Usuario.Id;
  end;

  fdqProcessoAtualizacao.Open;
end;

procedure TDmGetServer.OpenResponsaveis;
begin
  //Tabela responsavel
  fdqResp.Active := False;
  fdqResp.SQL.Clear;
  fdqResp.SQL.Add(rs_SQLResposavel);
  fdqResp.SQL.Add(GetSQLEscolaId('re.escola_id'));

  //Tabela de responsavel_escola
  fdqRespEscola.Active := False;
  fdqRespEscola.SQL.Clear;
  fdqRespEscola.SQL.Add(rs_SQLResposavelEscola);
  fdqRespEscola.SQL.Add(GetSQLEscolaId('re.escola_id'));

  //Tabela de responsavel_aluno
  fdqRespAluno.Active := False;
  fdqRespAluno.SQL.Clear;
  fdqRespAluno.SQL.Add(rs_SQLResposavelAluno);
  fdqRespAluno.SQL.Add(GetSQLEscolaId('re.escola_id'));

  //Tabela de responsavel_telefone
  fdqRespTelefone.Active := False;
  fdqRespTelefone.SQL.Clear;
  fdqRespTelefone.SQL.Add(rs_SQLResposavelTelefone);
  fdqRespTelefone.SQL.Add(GetSQLEscolaId('re.escola_id'));

  fdqRespTipo.Close;
  fdqRespTipo.Open;
end;

procedure TDmGetServer.OpenTurmas;
begin
  fdqTurma.Close;
  fdqTurma.SQL.Clear;
  fdqTurma.SQL.Add(rs_SQLTurma);
  fdqTurma.SQL.Add(GetSQLEscolaId);
  fdqTurma.SQL.Add('order by nome');
  fdqTurma.Open;

  fdqTurmaAluno.Close;
  fdqTurmaAluno.SQL.Clear;
  fdqTurmaAluno.SQL.Add(rs_SQLTurmaAluno);
  fdqTurmaAluno.SQL.Add(GetSQLEscolaId());
  fdqTurmaAluno.Open;
end;

procedure TDmGetServer.SetSQLAgendaAluno(KeyValues: String);
begin
  if KeyValues = EmptyStr then
    KeyValues:= QuoTedStr('0');

  fdqAgendaAluno.SQL.Clear;
  fdqAgendaAluno.SQL.Add('select al.*');
  fdqAgendaAluno.SQL.Add('from agenda_aluno al');
  fdqAgendaAluno.SQL.Add('where agenda_id in (' + KeyValues + ')');
end;

procedure TDmGetServer.SetSQLAgenda(KeyValues: String);
begin
  if KeyValues = EmptyStr then
    KeyValues:= QuoTedStr('0');

  fdqAgenda.SQL.Clear;
  fdqAgenda.SQL.Add('select');
  fdqAgenda.SQL.Add('  ag.*,');
  fdqAgenda.SQL.Add('  strftime("%d/%m/%Y",ag.data_insert_local) as data_criacao,');
  fdqAgenda.SQL.Add('  strftime("%H:%M",data_insert_local) as hora_criacao');
  fdqAgenda.SQL.Add('from agenda ag');
  fdqAgenda.SQL.Add('where agenda_id in (' + KeyValues + ')');
  fdqAgenda.SQL.Add('order by ag.data_insert_local');
end;

procedure TDmGetServer.SetSQLAgendaTurma(KeyValues: String);
begin
  if KeyValues = EmptyStr then
    KeyValues:= QuoTedStr('0');

  fdqAgendaTurma.SQL.Clear;
  fdqAgendaTurma.SQL.Add('select at.*');
  fdqAgendaTurma.SQL.Add('from agenda_turma at');
  fdqAgendaTurma.SQL.Add('where agenda_id in (' + KeyValues + ')');
end;

procedure TDmGetServer.GetPeriodoTipo;
begin
  GetDataSet('periodo_tipo',False);
end;

procedure TDmGetServer.GetResponsaveis;
var
  LDataSetList  : TFDJSONDataSets;
  LDataSet: TFDDataSet;
begin
  try
    try
      if not Dm.ProcessHasUpdate('responsavel') and not (PrimeiroAcessoInExecute) then
       Exit;


      if not ValidacoesRestClientBeforeExecute then
        Exit;

      OpenResponsaveis;
      LDataSetList := RestClient.SmMainClient.GetResponsaveis(GetEscolaId,Usuario.Marshal);
      LDataSet := TFDJSONDataSetsReader.GetListValueByName(LDataSetList,'responsavel');
      CopyDataSet(LDataSet,fdqResp);

      LDataSet := TFDJSONDataSetsReader.GetListValueByName(LDataSetList,'responsavel_escola');
      CopyDataSet(LDataSet,fdqRespEscola);

      LDataSet := TFDJSONDataSetsReader.GetListValueByName(LDataSetList,'responsavel_aluno');
      CopyDataSet(LDataSet,fdqRespAluno);

      LDataSet := TFDJSONDataSetsReader.GetListValueByName(LDataSetList,'responsavel_telefone');
      CopyDataSet(LDataSet,fdqRespTelefone);

      DM.ProcessSaveUpdate('responsavel');
      MsgPoupUpTeste('DmGetServer.GetResponsaveis Executado');
    except on E:Exception do
    begin
      DM.SetLogError( E.Message,
                      GetApplicationName,
                      UnitName,
                      ClassName,
                      'GetResponsaveis',
                      Now,
                      'Erro na busca dos responsaveis' + #13 + E.Message
                      );
       Raise;
    end;
    end;
  finally
    //CloseResponsaveis;
  end;
end;

function TDmGetServer.GetResponsavel(ResponsavelId: Integer): TFDDataSet;
begin
  Result:= GetDataSet('responsavel',
              False,
              'and responsavel_id = ' + IntToStr(ResponsavelId),
              False);

end;

procedure TDmGetServer.GetResponsavelTipo;
begin
  GetDataSet('responsavel_tipo',False);
end;

procedure TDmGetServer.GetSistemaOperacionalTipo;
begin
  GetDataSet('sistema_operacional_tipo',False);
end;

procedure TDmGetServer.GetDadosServerBasico;
begin
  try
    GetAgenda(DtSyncBasicoIni, DtSyncBasicoFim);
    //MsgPoupUpTeste('DmGetServer.GetAgenda OK');
  except on E:Exception do
    MsgPoupUp('DmGetServer.GetAgenda Erro:' + e.Message);
  end;

end;

procedure TDmGetServer.GetTelefoneTipo;
begin
  GetDataSet('telefone_tipo',False);
end;

procedure TDmGetServer.GetTurmas;
var
  LDataSetList  : TFDJSONDataSets;
  LDataSet: TFDDataSet;
begin
  try
    if not Dm.ProcessHasUpdate('turma') then
      Exit;

    OpenTurmas;
    if not ValidacoesRestClientBeforeExecute then
      Exit;

    LDataSetList := RestClient.SmMainClient.GetTurmas(GetEscolaId,Usuario.Marshal);
    LDataSet := TFDJSONDataSetsReader.GetListValueByName(LDataSetList,'turma');
    CopyDataSet(LDataSet,fdqTurma);

    LDataSet := TFDJSONDataSetsReader.GetListValueByName(LDataSetList,'turma_aluno');
    CopyDataSet(LDataSet,fdqTurmaAluno);

    DM.ProcessSaveUpdate('turma');
    MsgPoupUpTeste('DmGetServer.GetTurmas Executado');
  except on E:Exception do
  begin
    DM.SetLogError( E.Message,
                    GetApplicationName,
                    UnitName,
                    ClassName,
                    'GetTurmas',
                    Now,
                    'Erro na busca das turmas' + #13 + E.Message
                    );
    Raise;
  end;
  end;
end;

end.
