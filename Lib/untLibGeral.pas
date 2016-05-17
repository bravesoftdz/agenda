unit untLibGeral;

interface

Uses Data.DB,untTypes, System.JSON, Data.DBXJSONReflect;


  Type

    TUsuario = class
  private
    function GetMarshalValue: TJSONValue;
    public
      Id:Integer;
      Tipo:TUsuarioTipo;
      FMarshalValue: TJSONValue;

      constructor Create;
      function Marshal:TJSONValue;
      function UnMarshal(oObjetoJSON:TJSONValue):TUsuario;

      //N�o utilizar esta propriedade esta dando acess violation
      property MarshalValue: TJSONValue read GetMarshalValue write FMarshalValue;
    end;


implementation

uses System.SysUtils, smGeralFMX, System.Variants, System.Rtti;

{ TUsuario }

constructor TUsuario.Create;
begin
  inherited Create;
  Tipo:= NaoDefinido;
end;

function TUsuario.GetMarshalValue: TJSONValue;
begin
  if FMarshalValue = nil then
    FMarshalValue := self.Marshal;
  Result:=FMarshalValue;
end;

function TUsuario.Marshal: TJSONValue;
var
  Marshal : TJSONMarshal;
begin
  //Verificando se o objeto foi criado
  if Assigned(self) then
    begin
      //Instanciando o objeto respons�vel por serializar
      Marshal := TJSONMarshal.Create;
      try
        //Serializando de fato o objeto Usario para JSON
        Result := Marshal.Marshal(self);
      finally
        //Liberando o serializador
        Marshal.DisposeOf;
      end;
    end
    else
      //Caso o Objeto Usuario n�o tenha sido inst�nciado ser� enviado um objeto do tipo JSONNull
      Result := TJSONNull.Create;
end;

function TUsuario.UnMarshal(oObjetoJSON: TJSONValue): TUsuario;
var
  CTX : TRttiContext;
  UnMarshal : TJSONUnMarshal;
begin
  CTX.GetType(TypeInfo(TUsuario));

  //Verificando se o objeto � igual a null ou nil.
  if oObjetoJSON is TJSONNull then
    Exit;

  //Instanciando o TJSONUnMarshal, respons�vel por deserializar o objeto
  UnMarshal := TJSONUnMarshal.Create;
  try
    //Deserializa o objeto JSON e faz um TypeCast para trasnformar efetivamente em TUsuario
    Result := TUsuario(UnMarshal.Unmarshal(oObjetoJSON));
  finally
    //Libera o Objeto da memoria
    UnMarshal.DisposeOf;
  end;
end;

end.
