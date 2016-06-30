unit untPerfil;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  smFrmBaseToolBar, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  FMX.Edit, FMX.ListBox,smNetworkState

  {$IFDEF ANDROID}
   ,Androidapi.Helpers
  {$ENDIF}
  ;

type
  TfrmPerfil = class(TfrmBaseToolBar)
    fdqFunc: TFDQuery;
    fdmPerfil: TFDMemTable;
    fdqFuncfuncionario_id: TIntegerField;
    fdqFuncnome: TStringField;
    fdqFuncsobrenome: TStringField;
    fdqFuncsexo: TStringField;
    fdqFuncrg: TStringField;
    fdqFunccpf: TLargeintField;
    fdqFuncativo: TStringField;
    fdqFuncemail: TStringField;
    fdqFuncsenha: TStringField;
    fdqFuncinformacoes_gerais: TBlobField;
    fdqFuncfuncionario_tipo_id: TSmallintField;
    fdqFuncescola_id: TIntegerField;
    fdmPerfilfuncionario_id: TIntegerField;
    fdmPerfilnome: TStringField;
    fdmPerfilsobrenome: TStringField;
    fdmPerfilsexo: TStringField;
    fdmPerfilrg: TStringField;
    fdmPerfilcpf: TLargeintField;
    fdmPerfilativo: TStringField;
    fdmPerfilemail: TStringField;
    fdmPerfilsenha: TStringField;
    fdmPerfilinformacoes_gerais: TBlobField;
    fdmPerfilfuncionario_tipo_id: TSmallintField;
    fdmPerfilescola_id: TIntegerField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    edtNome: TEdit;
    edtSobrenome: TEdit;
    edtEmail: TEdit;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkFillControlToField1: TLinkFillControlToField;
    LinkControlToField5: TLinkControlToField;
    lblNome: TLabel;
    ListBox1: TListBox;
    lstItemNome: TListBoxItem;
    lstItemSobrenome: TListBoxItem;
    Label1: TLabel;
    lstItemEmail: TListBoxItem;
    Label2: TLabel;
    lstItemSenha: TListBoxItem;
    lstItemCPF: TListBoxItem;
    lstItemRG: TListBoxItem;
    lstItemSexo: TListBoxItem;
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    edtSenha: TEdit;
    Label3: TLabel;
    edtCPF: TEdit;
    edtRG: TEdit;
    cmbSexo: TComboBox;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    lstItemTelefone: TListBoxItem;
    Label4: TLabel;
    edtTelefone: TEdit;
    imgSalvar: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure imgSalvarClick(Sender: TObject);
  private
    FActivityDialogThread: TThread;
    procedure GetPerfil;
    procedure SalvarPerfil;
  public
    { Public declarations }
  end;

var
  frmPerfil: TfrmPerfil;

implementation

{$R *.fmx}

uses untDMStyles, untDmGetServer, untDM, untTypes, smCrypt, untRestClient,
  untDmSaveServer, smMensagensFMX, untResourceString;

{ TfrmPerfilFuncionario }

procedure TfrmPerfil.FormCreate(Sender: TObject);
begin
  inherited;
  if not DM.fgActivityDialog.IsShown then
  begin
    FActivityDialogThread := TThread.CreateAnonymousThread(procedure
      begin
        try
          TThread.Synchronize(nil, procedure
          begin
            layBase.Enabled:=False;
            DM.fgActivityDialog.Message := rs_carregando_informacoes;
            DM.fgActivityDialog.Show;
          end);

          GetPerfil;

          if TThread.CheckTerminated then
            Exit;


        finally
          if not TThread.CheckTerminated then
            TThread.Synchronize(nil, procedure
            begin
               DM.fgActivityDialog.Hide;
               layBase.Enabled:=True;
               Application.ProcessMessages;
            end);
        end;
      end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
  end;

end;

procedure TfrmPerfil.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
   MsgPoupUp('FormKeyUp');

  if Key = vkHardwareBack then
  begin
    if DM.fgActivityDialog.IsShown  Then
    begin
      FActivityDialogThread.Terminate;
      MsgPoupUp('FActivityDialogThread.Terminate;');
    end;
  end;
  inherited;
end;

procedure TfrmPerfil.GetPerfil;
var
  DataSet:TFDDataSet;
begin
  if not smNetworkState.ValidarConexao  then
  begin
    imgVoltar.OnClick(self);
    Exit;
  end;

  DataSet:= DmGetServer.GetFuncionario(Usuario.Id);

  fdmPerfil.Close;
  fdmPerfil.AppendData(DataSet);

  fdmPerfil.Edit;
  fdmPerfil.FieldByName('senha').AsString := Decrypt(fdmPerfil.FieldByName('senha').AsString);

  if (fdmPerfil.FieldByName('sexo').AsString ='M')then
    cmbSexo.ItemIndex := 0
  else if (fdmPerfil.FieldByName('sexo').AsString ='F')then
    cmbSexo.ItemIndex := 1
  else
    cmbSexo.ItemIndex := -1;

  lstItemTelefone.Visible := (Usuario.Tipo = Responsavel);

  fdmPerfil.Post;
end;


procedure TfrmPerfil.imgSalvarClick(Sender: TObject);
begin
  inherited;
  if not smNetworkState.ValidarConexao  then
  begin
    Exit;
  end;

  if not DM.fgActivityDialog.IsShown then
  begin
    FActivityDialogThread := TThread.CreateAnonymousThread(procedure
      begin
        try
          TThread.Synchronize(nil, procedure
          begin
            layBase.Enabled:=False;
            DM.fgActivityDialog.Message := rs_salvando_informacoes;
            DM.fgActivityDialog.Show;
          end);

          SalvarPerfil;

          if TThread.CheckTerminated then
            Exit;


        finally
          if not TThread.CheckTerminated then
            TThread.Synchronize(nil, procedure
            begin
               DM.fgActivityDialog.Hide;
               layBase.Enabled:=True;
               Application.ProcessMessages;
               imgVoltar.OnClick(self);
            end);
        end;
      end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
  end;
end;

procedure TfrmPerfil.SalvarPerfil;
var
  fdmSalvar: TFDMemTable;
begin
  try
    fdmSalvar := TFDMemTable.Create(Application);

    fdmSalvar.AppendData(fdmPerfil);
    fdmSalvar.Edit;
    fdmSalvar.FieldByName('senha').AsString := Encrypt(fdmSalvar.FieldByName('senha').AsString);

    if cmbSexo.ItemIndex >= 0 then
      fdmSalvar.FieldByName('sexo').AsString := Copy(cmbSexo.Selected.Text,0,1)
    else
      fdmSalvar.FieldByName('sexo').Clear;

    fdmSalvar.Post;

    if Usuario.Tipo = Funcionario then
      DmSaveServer.SaveFuncionario(fdmSalvar);

    MsgPoupUp('Perfil atualizado com sucesso!');
  finally
    fdmSalvar.DisposeOf;
  end;

end;

end.
