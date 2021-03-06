unit untCadastroResponsavel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, smCadFD, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, Vcl.ImgList, Vcl.DBActns, System.Actions, Vcl.ActnList, smCadPadrao, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids,
  smDBGrid, Vcl.StdCtrls, Vcl.Buttons, Vcl.ToolWin, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, cxMemo, cxDBEdit, cxImageComboBox, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, cxCheckBox, cxMaskEdit, cxTextEdit, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, Vcl.ExtCtrls, Vcl.DBCtrls, cxGroupBox, dxBarBuiltInMenu, cxPC, Vcl.Menus, cxButtons, cxLabel;

type
  TfrmCadastroResponsavel = class(TfrmCadFD)
    fdqResponsavelTipo: TFDQuery;
    dsResponsavelTipo: TDataSource;
    fdqTelefoneTipo: TFDQuery;
    dsTelefoneTipo: TDataSource;
    dsTelefone: TDataSource;
    fdqTelefone: TFDQuery;
    fdqAlunos: TFDQuery;
    dsAlunos: TDataSource;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    grbxAlunos: TcxGroupBox;
    cxGridAlunosDBTableView1: TcxGridDBTableView;
    cxGridAlunosLevel1: TcxGridLevel;
    cxGridAlunos: TcxGrid;
    cxGridAlunosDBTableView1nome: TcxGridDBColumn;
    cxGridAlunosDBTableView1sobrenome: TcxGridDBColumn;
    fdqAlunosLookup: TFDQuery;
    dsAlunosLookup: TDataSource;
    Bevel3: TBevel;
    cxLabel1: TcxLabel;
    btnAlunosAdd: TcxButton;
    btnAlunosExcluir: TcxButton;
    fdqAlunosresponsavel_id: TIntegerField;
    fdqAlunosaluno_id: TIntegerField;
    ScrollBox1: TScrollBox;
    cxGroupBox2: TcxGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    cxDBTextEdit1: TcxDBTextEdit;
    cxDBTextEdit2: TcxDBTextEdit;
    cxDBMaskEdit1: TcxDBMaskEdit;
    cxDBMaskEdit2: TcxDBMaskEdit;
    cxDBImageComboBox1: TcxDBImageComboBox;
    cxDBTextEdit3: TcxDBTextEdit;
    cxLabel2: TcxLabel;
    btnPesquisarResponsavel: TcxButton;
    cxGroupBox1: TcxGroupBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    DBNavigator1: TDBNavigator;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1escola_telefone_id: TcxGridDBColumn;
    cxGrid1DBTableView1escola_id: TcxGridDBColumn;
    cxGrid1DBTableView1telefone_tipo_id: TcxGridDBColumn;
    cxGrid1DBTableView1numero: TcxGridDBColumn;
    cxGrid1DBTableView1TelefoneTipo: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cxGroupBox3: TcxGroupBox;
    Label9: TLabel;
    Label5: TLabel;
    cxDBMemo1: TcxDBMemo;
    cmbTipoResponsavel: TcxDBLookupComboBox;
    cxDBCheckBox1: TcxDBCheckBox;
    dsResp: TDataSource;
    fdqResp: TFDQuery;
    fdqCadresponsavel_id: TIntegerField;
    fdqCadescola_id: TIntegerField;
    fdqCadativo: TStringField;
    fdqCadinformacoes_gerais: TMemoField;
    fdqCadresponsavel_tipo_id: TSmallintField;
    procedure fdqCadNewRecord(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure fdqTelefoneBeforeEdit(DataSet: TDataSet);
    procedure AcCancelarExecute(Sender: TObject);
    procedure fdqTelefoneBeforeInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure fdqBuscaBeforeOpen(DataSet: TDataSet);
    procedure fdqAlunosBeforeEdit(DataSet: TDataSet);
    procedure fdqAlunosBeforeInsert(DataSet: TDataSet);
    procedure grPesquisaDblClick(Sender: TObject);
    procedure grPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure fdqCadAfterOpen(DataSet: TDataSet);
    procedure fdqAlunosLookupBeforeOpen(DataSet: TDataSet);
    procedure btnAlunosAddClick(Sender: TObject);
    procedure btnAlunosExcluirClick(Sender: TObject);
    procedure dsAlunosStateChange(Sender: TObject);
    procedure fdqAlunosAfterScroll(DataSet: TDataSet);
    procedure fdqAlunosBeforeDelete(DataSet: TDataSet);
    procedure BuProcessarClick(Sender: TObject);
    procedure btnPesquisarResponsavelClick(Sender: TObject);
    procedure fdqCadBeforeOpen(DataSet: TDataSet);
    procedure AcApplyUpdateExecute(Sender: TObject);
  private
    procedure OpenQuerys;
    procedure OpenResponsavel(ResponsavelId:Integer);
    procedure SetPgtCtrlDefaut;
    procedure SetStateButtonsAlunos;
    function  ValidarCadastro:Boolean;
  public
    { Public declarations }
  end;

var
  frmCadastroResponsavel: TfrmCadastroResponsavel;

implementation

{$R *.dfm}

uses untDM, smDBFireDac, untFuncoes, untPesquisaAluno, smGeral, untPesquisaResponsavel, smMensagens;

procedure TfrmCadastroResponsavel.AcApplyUpdateExecute(Sender: TObject);
begin
  self.SetFocus;
  ValidarCadastro;
  inherited;
end;

procedure TfrmCadastroResponsavel.AcCancelarExecute(Sender: TObject);
begin
//  fdqTelefone.Cancel;
//  fdqTelefone.CancelUpdates;

  fdqAlunos.Cancel;
  fdqAlunos.CancelUpdates;
  inherited;
end;

procedure TfrmCadastroResponsavel.btnAlunosAddClick(Sender: TObject);
var
  AlunoId:integer;
begin
  AlunoId:=frmPesquisaAluno.Open;

  if AlunoId <= 0 then
    Exit;

  if fdqAlunos.Locate('aluno_id',AlunoId,[]) then
    Exit;

  fdqAlunos.Append;
  fdqAlunos.FieldByName('aluno_id').AsInteger:= AlunoID;
  fdqAlunos.Post;
end;

procedure TfrmCadastroResponsavel.btnAlunosExcluirClick(Sender: TObject);
begin
  inherited;
  if fdqAlunos.IsEmpty then
    Exit;

  fdqAlunos.Delete;
end;

procedure TfrmCadastroResponsavel.btnPesquisarResponsavelClick(Sender: TObject);
var
  ResponsavelId:integer;
begin
  ResponsavelId:=frmPesquisaResponsavel.Open(Geral);

  if ResponsavelId <= 0 then
    Exit;

  if (ResponsavelId <> fdqCadresponsavel_id.AsInteger) and (fdqCadresponsavel_id.AsInteger > 0)then
    if not Msg('Deseja alterar o responsável deste cadastro?',mtConfirmacao,Sim_Nao_Cancelar) then
      Exit;

  OpenResponsavel(ResponsavelId);
  fdqCadresponsavel_id.AsInteger := ResponsavelId;
end;

procedure TfrmCadastroResponsavel.BuProcessarClick(Sender: TObject);
var
  ValorEdit: string;
  ValorSomenteNumero: string;
begin

  if ( (UpperCase(CoBoCampos.Text) = 'RG') or (UpperCase(CoBoCampos.Text) = 'CPF')) then
  begin
    try
      ValorEdit:= EdConteudoTexto.Text;
      ValorSomenteNumero:= SomenteNumero(ValorEdit);
      EdConteudoTexto.Text:= ValorSomenteNumero;
      inherited;
    finally
      EdConteudoTexto.Text:= ValorEdit;
    end;
  end
  else
    inherited;

end;

procedure TfrmCadastroResponsavel.dsAlunosStateChange(Sender: TObject);
begin
  inherited;
  SetStateButtonsAlunos;
end;

procedure TfrmCadastroResponsavel.fdqAlunosAfterScroll(DataSet: TDataSet);
begin
  inherited;
  SetStateButtonsAlunos;
end;

procedure TfrmCadastroResponsavel.fdqAlunosBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  SalvarQueryMaster(fdqCad);
end;

procedure TfrmCadastroResponsavel.fdqAlunosBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  SalvarQueryMaster(fdqCad);
end;

procedure TfrmCadastroResponsavel.fdqAlunosBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  SalvarQueryMaster(fdqCad);
end;

procedure TfrmCadastroResponsavel.fdqBuscaBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  SetIdEscolaParamBusca(fdqBusca);
end;

procedure TfrmCadastroResponsavel.fdqCadAfterOpen(DataSet: TDataSet);
begin
  inherited;
  OpenQuerys;
end;

procedure TfrmCadastroResponsavel.fdqCadBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  SetIdEscolaParamBusca(fdqCad);
end;

procedure TfrmCadastroResponsavel.fdqCadNewRecord(DataSet: TDataSet);
begin
  inherited;
  OpenQuerys;
  fdqCadresponsavel_id.AsInteger:= 0;
  fdqCadativo.AsString:= 'S';
  SetIdEscolaCadastro(fdqCad);
end;

procedure TfrmCadastroResponsavel.fdqTelefoneBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  SalvarQueryMaster(fdqCad);
end;

procedure TfrmCadastroResponsavel.fdqTelefoneBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  SalvarQueryMaster(fdqCad);
end;

procedure TfrmCadastroResponsavel.fdqAlunosLookupBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  SetIdEscolaParamBusca(fdqAlunosLookup);
end;

procedure TfrmCadastroResponsavel.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmCadastroResponsavel:=nil;
end;

procedure TfrmCadastroResponsavel.FormCreate(Sender: TObject);
begin
  inherited;
  //SetSQLEscolaIdBusca(smCadPadrao);
end;

procedure TfrmCadastroResponsavel.FormShow(Sender: TObject);
begin
  inherited;
  OpenQuerys;
  SetPgtCtrlDefaut;
end;

procedure TfrmCadastroResponsavel.grPesquisaDblClick(Sender: TObject);
begin
  inherited;
  SetPgtCtrlDefaut;
end;

procedure TfrmCadastroResponsavel.grPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SetPgtCtrlDefaut;
end;

procedure TfrmCadastroResponsavel.OpenQuerys;
begin
  fdqResponsavelTipo.Close;
  fdqResponsavelTipo.Open;

  fdqTelefone.Close;
  fdqTelefone.Open;

  fdqTelefoneTipo.Close;
  fdqTelefoneTipo.Open;

  fdqAlunos.Close;
  fdqAlunos.Open;

  fdqAlunosLookup.Close;
  fdqAlunosLookup.Open;

  OpenResponsavel(fdqCadresponsavel_id.AsInteger);
end;

procedure TfrmCadastroResponsavel.OpenResponsavel(ResponsavelId: Integer);
begin
  fdqResp.Close;
  fdqResp.ParamByName('responsavel_id').AsInteger := ResponsavelId;
  fdqResp.Open;
end;

procedure TfrmCadastroResponsavel.SetPgtCtrlDefaut;
begin
  cxPageControl1.ActivePageIndex:=0;
end;

procedure TfrmCadastroResponsavel.SetStateButtonsAlunos;
begin
  btnAlunosAdd.Enabled := fdqAlunos.State in [dsBrowse, dsInactive, dsEdit];
  btnAlunosExcluir.Enabled := (fdqAlunos.State in [dsEdit, dsBrowse, dsInactive]) and (fdqAlunos.RecordCount >= 1);
end;

function TfrmCadastroResponsavel.ValidarCadastro: Boolean;
begin
  Result:=False;

 { if cmbTipoResponsavel.ItemIndex <=0 then
  begin
    Msg('obri');

  end;
  }

  ValidarCampo(fdqCadresponsavel_tipo_id);

  Result:=True;
end;

end.
