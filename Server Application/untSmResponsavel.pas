unit untSmResponsavel;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, untLibGeral, untLibServer;

type
{$METHODINFO ON}
  TSmResponsavel = class(TDataModule)
    fdqValidarEmailResponsavel: TFDQuery;
    fdqValidarCPFResponsavel: TFDQuery;
    fdqResponsavel: TFDQuery;
    fdqResponsavelTelefone: TFDQuery;
    fdqLoginResponsavel: TFDQuery;
  private
    { Private declarations }
  public
    function LoginResponsavel(Login:string; Senha:string):Boolean;
    function ValidarEmailExistenteResponsavel(Email:String):Boolean;
    function ValidarCPFExistenteResponsavel(CPF:String):Boolean;
    function CriarUsuarioResponsavel( Nome:String;
                                      SobreNome: String;
                                      Email: String;
                                      Senha: String;
                                      Telefone: String;
                                      CPF: String;
                                      RG: String;
                                      Sexo: String):String;

  end;

var
  SmResponsavel: TSmResponsavel;
{$METHODINFO OFF}

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses untSmMain;

{$R *.dfm}

{ TSmResponsavel }

function TSmResponsavel.CriarUsuarioResponsavel(Nome, SobreNome, Email, Senha,
  Telefone, CPF, RG, Sexo: String): String;
var
  LogServerRequest:TLogServerRequest;
begin
  //M�todo para Login de Responsaveis
  try
    try
      LogServerRequest:=TLogServerRequest.Create;
      LogServerRequest.SetLogServerRequest( UnitName,
                                            ClassName,
                                            'CriarUsuarioResponsavel'
                                          );



      fdqResponsavel.Close;
      fdqResponsavel.ParamByName('responsavel_id').AsInteger:=0;
      fdqResponsavel.Open;
      fdqResponsavel.Append;
      //fdqResponsavel.FieldByName('responsavel_id').AsString := 0;
      fdqResponsavel.FieldByName('nome').AsString := Nome;
      fdqResponsavel.FieldByName('sobrenome').AsString := SobreNome;
      fdqResponsavel.FieldByName('sexo').AsString := Sexo;
      fdqResponsavel.FieldByName('rg').AsString := RG;
      fdqResponsavel.FieldByName('cpf').AsString := CPF;
      fdqResponsavel.FieldByName('ativo').AsString := 'S';
      fdqResponsavel.FieldByName('email').AsString := Email;
      fdqResponsavel.FieldByName('senha').AsString := Senha;
      fdqResponsavel.Post;

      //Criando o Telefone
      fdqResponsavelTelefone.Close;
      fdqResponsavelTelefone.Open;
      fdqResponsavelTelefone.Append;
      fdqResponsavelTelefone.FieldByName('responsavel_id').AsInteger := fdqResponsavel.FieldByName('responsavel_id').AsInteger;
      fdqResponsavelTelefone.FieldByName('telefone_tipo_id').AsInteger := 2;
      fdqResponsavelTelefone.FieldByName('numero').AsString := Telefone;
      fdqResponsavelTelefone.Post;

      Result:= 'OK';

      SmMain.SaveLogServerRequest(LogServerRequest);
    except on E:Exception do
      begin
        Result:= 'Erro ao criar usu�rio ' + #13 + E.Message;
        LogServerRequest.SetError(E.Message);
        SmMain.SaveLogError(LogServerRequest);
      end;
    end;
  finally
    fdqLoginResponsavel.Active := False;
    LogServerRequest.Free;
  end;
end;

function TSmResponsavel.LoginResponsavel(Login, Senha: string): Boolean;
var
  LogServerRequest:TLogServerRequest;
begin
  //M�todo para Login de Responsaveis
  try
    try
      LogServerRequest:=TLogServerRequest.Create;
      LogServerRequest.SetLogServerRequest( UnitName,
                                            ClassName,
                                            'LoginResponsavel'
                                           );

      fdqLoginResponsavel.Close;
      fdqLoginResponsavel.ParamByName('login').AsString := Login;
      fdqLoginResponsavel.ParamByName('senha').AsString := Senha;
      fdqLoginResponsavel.Open;
      Result:= not (fdqLoginResponsavel.IsEmpty);
      SmMain.SaveLogServerRequest(LogServerRequest);
    except on E:Exception do
      begin
        LogServerRequest.SetError(E.Message);
        SmMain.SaveLogError(LogServerRequest);
      end;
    end;
  finally
    fdqLoginResponsavel.Active := False;
    LogServerRequest.Free;
  end;
end;

function TSmResponsavel.ValidarCPFExistenteResponsavel(CPF: String): Boolean;
var
  LogServerRequest:TLogServerRequest;
begin
  //M�todo para Login de Responsaveis
  try
    try
      LogServerRequest:=TLogServerRequest.Create;
      LogServerRequest.SetLogServerRequest( UnitName,
                                            ClassName,
                                            'ValidarCPFExistenteResponsavel'
                                           );



      fdqValidarCPFResponsavel.Close;
      fdqValidarCPFResponsavel.ParamByName('cpf').AsString := cpf;
      fdqValidarCPFResponsavel.Open;
      Result:=(fdqValidarCPFResponsavel.IsEmpty);
      SmMain.SaveLogServerRequest(LogServerRequest);
    except on E:Exception do
      begin
        LogServerRequest.SetError(E.Message);
        SmMain.SaveLogError(LogServerRequest);
      end;
    end;
  finally
    fdqLoginResponsavel.Active := False;
    LogServerRequest.Free;
  end;
end;

function TSmResponsavel.ValidarEmailExistenteResponsavel(
  Email: String): Boolean;
var
  LogServerRequest:TLogServerRequest;
begin
  //M�todo para Login de Responsaveis
  try
    try
      LogServerRequest:=TLogServerRequest.Create;
      LogServerRequest.SetLogServerRequest( UnitName,
                                            ClassName,
                                            'ValidarEmailExistenteResponsavel'
                                          );



      fdqValidarEmailResponsavel.Close;
      fdqValidarEmailResponsavel.ParamByName('email').AsString := Email;
      fdqValidarEmailResponsavel.Open;
      Result:= (fdqValidarEmailResponsavel.IsEmpty);
      SmMain.SaveLogServerRequest(LogServerRequest);
    except on E:Exception do
      begin
        LogServerRequest.SetError(E.Message);
        SmMain.SaveLogError(LogServerRequest);
      end;
    end;
  finally
    fdqLoginResponsavel.Active := False;
    LogServerRequest.Free;
  end;
end;

end.
