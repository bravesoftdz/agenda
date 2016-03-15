unit untAgendaEscolaView;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  smFrmBaseToolBar, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  MultiDetailAppearanceU, FMX.ListView, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope;

type
  TfrmAgendaEscolaView = class(TfrmBaseToolBar)
    lstAgenda: TListView;
    bsAgenda: TBindSourceDB;
    blAgenda: TBindingsList;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    LinkListControlToField1: TLinkListControlToField;
    procedure FormCreate(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure lstAgendaUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
  private
    procedure SetTitulo;

  public
    AlunoId:Integer;
    TurmaId:Integer;
    Titulo:String;
  end;

var
  frmAgendaEscolaView: TfrmAgendaEscolaView;

implementation

{$R *.fmx}

uses untFuncoes, untDmEscola, untDM, untAgendaEscolaAdd, untPrincipal,
  untDMStyles;

procedure TfrmAgendaEscolaView.btnVoltarClick(Sender: TObject);
begin
  fAllowCloseForm:=True;
  Close;
  inherited;
end;

procedure TfrmAgendaEscolaView.FormCreate(Sender: TObject);
begin
  inherited;
  SetStyle(Self);
end;

procedure TfrmAgendaEscolaView.FormShow(Sender: TObject);
begin
  inherited;
  DmEscola.OpenAgenda(AlunoId,TurmaId);
  SetTitulo;
  lstAgenda.ItemAppearanceObjects.ItemObjects.Detail.WordWrap:= True;
  //lstAgenda.ItemAppearanceObjects.ItemObjects.Detail.Trimming:=1;
end;

procedure TfrmAgendaEscolaView.lstAgendaUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
  // In order for text to be truncated properly, shorten text object
//  AItem.Objects.TextObject.Width := AItem.Objects.TextObject.Width - (5 + AItem.Objects.AccessoryObject.Width);

  AItem.Objects.TextObject.Height := Length(DmEscola.fdqAgenda.FieldByName('descricao').Text) * 25;
  // Restore checked state when device is rotated.
  // When listview is resized because of rotation, accessory properties will be reset to default values
 // AItem.Objects.AccessoryObject.Visible := FChecked.Contains(AItem.Index);

end;

procedure TfrmAgendaEscolaView.SetTitulo;
begin
  lblTitulo.Text := Titulo;
end;

procedure TfrmAgendaEscolaView.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  DmEscola.GetAgenda;
  DmEscola.OpenAgenda(AlunoId,TurmaId);
  DmEscola.SalvarDadosServer;
  Dm.SalvarDadosServer;
end;

procedure TfrmAgendaEscolaView.SpeedButton2Click(Sender: TObject);
begin
  inherited;
 if not Assigned(frmAgendaEscolaAdd) then
    Application.CreateForm(TfrmAgendaEscolaAdd, frmAgendaEscolaAdd);

  frmAgendaEscolaAdd.AlunoId:= AlunoId;
  frmAgendaEscolaAdd.TurmaId:= TurmaId;
  frmAgendaEscolaAdd.Titulo:= Titulo;
  frmAgendaEscolaAdd.Show;
end;

end.
