unit untAgendaSelect;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  smFrmBaseToolBar, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts,
  FMX.TabControl, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, MultiDetailAppearanceU,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.Async, FireDAC.DApt;

type
  TfrmAgendaSelect = class(TfrmBaseToolBar)
    tbctrlPrincipal: TTabControl;
    tbitTurma: TTabItem;
    tbitAlunos: TTabItem;
    lstTurmas: TListView;
    lstAlunos: TListView;
    bsAlunos: TBindSourceDB;
    BindingsList1: TBindingsList;
    bsTurmas: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    LinkListControlToField1: TLinkListControlToField;
    procedure FormCreate(Sender: TObject);
    procedure lstAlunosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lstTurmasItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
  public
    { Public declarations }
  end;

var
  frmAgendaSelect: TfrmAgendaSelect;

implementation

{$R *.fmx}

uses untModuloCliente, Data.FireDACJSONReflect, untDM, untDMEscola, untAgendaView,
  untPrincipal, untDMStyles, untFuncoes;

procedure TfrmAgendaSelect.FormCreate(Sender: TObject);
begin
  inherited;
  tbctrlPrincipal.ActiveTab := tbitTurma;
  DmEscola.OpenAlunos;
  DmEscola.OpenTurmas;
end;



procedure TfrmAgendaSelect.lstAlunosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  inherited;
  //frmPrincipal.OpenForm(TfrmAgenda);
  if not Assigned(frmAgendaView) then
    Application.CreateForm(TfrmAgendaView, frmAgendaView);

  frmAgendaView.AlunoId:= DmEscola.fdqAluno.FieldByName('aluno_id').AsInteger;
  frmAgendaView.OwnerAgenda:= DmEscola.fdqAluno.FieldByName('nome').AsString;
  frmAgendaView.NomeCompleto:= DmEscola.fdqAluno.FieldByName('nome_completo').AsString;
  frmAgendaView.DataSetAgenda:= DmEscola.fdqAgenda;
  frmAgendaView.TurmaId:= 0;
  frmAgendaView.Show;
end;

procedure TfrmAgendaSelect.lstTurmasItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  inherited;
  if not Assigned(frmAgendaView) then
    Application.CreateForm(TfrmAgendaView, frmAgendaView);

  frmAgendaView.AlunoId:= 0;
  frmAgendaView.TurmaId:= DmEscola.fdqTurma.FieldByName('turma_id').AsInteger;
  frmAgendaView.OwnerAgenda:= DmEscola.fdqTurma.FieldByName('nome').AsString;
  frmAgendaView.NomeCompleto:= '';
  frmAgendaView.DataSetAgenda:= DmEscola.fdqAgenda;
  frmAgendaView.Show;
end;

end.
