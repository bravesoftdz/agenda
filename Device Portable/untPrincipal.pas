unit untPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.MultiView, FMX.Layouts, smFrmBaseForAll,
  FMX.ListBox, FMX.Objects, untDmGetServer, untTesteGeralApp

{$IFDEF ANDROID}
    , Androidapi.Helpers
{$ENDIF}
    ;

type
  TfrmPrincipal = class(TfrmBaseForAll)
    layPrincipal: TLayout;
    MultiView1: TMultiView;
    lstMnuMain: TListBox;
    lstGroupHeaderTestes: TListBoxGroupHeader;
    lstItemTesteGeralApp: TListBoxItem;
    ToolBarPincipal: TToolBar;
    btnMenu: TSpeedButton;
    lblTitulo: TLabel;
    layToolBarMenu: TLayout;
    layMenu: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    imgMenu: TImage;
    lstItemSobre: TListBoxItem;
    lstItemTesteLogin: TListBoxItem;
    imgAgenda: TImage;
    lblAgenda: TLabel;
    imgMeuPerfil: TImage;
    lblMensagens: TLabel;
    imgConfiguracoes: TImage;
    Label1: TLabel;
    imgEnviar: TImage;
    Label3: TLabel;
    lstItemUsuario: TListBoxItem;
    imgLogoff: TImage;
    Label2: TLabel;
    layInternet: TLayout;
    recInternet: TRectangle;
    lblInternet: TLabel;
    tmInternet: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure lstItemTesteGeralAppClick(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure lstItemTesteLoginClick(Sender: TObject);
    procedure lstItemSobreClick(Sender: TObject);
    procedure imgAgendaClick(Sender: TObject);
    procedure imgMensagensClick(Sender: TObject);
    procedure lblAgendaClick(Sender: TObject);
    procedure lblMensagensClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure imgLogoffClick(Sender: TObject);
    procedure imgMeuPerfilClick(Sender: TObject);
    procedure imgConfiguracoesClick(Sender: TObject);
    procedure tmInternetTimer(Sender: TObject);
  private
    { Private declarations }
    fShowForm: Boolean;
    fShowMenuPrincipal: Boolean;
    fActiveForm: TForm;
    fAllowCloseForm: Boolean;
    LayoutBase, btnVoltarForms: TComponent;

    iModoDesenvolvedor: Integer;
    procedure BotaoVoltarOnClick(Sender: TObject);
    procedure ShowMenuPrincipal;
    procedure HideMenuPrincipal;
    procedure AbrirAgenda;
    procedure AbrirMensagens;
    procedure Sair;
    procedure Logoff;

    procedure SetModoDesenvolvedor;
    procedure SetUsuario;
    procedure PrimeiroAcesso;
    function OpenAgendaAlunoAutomatico: Boolean;
    procedure SetInternetDisconect;
  protected

  public
    procedure OpenForm(aFormClass: TComponentClass);
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses untLogin,
  untLibDevicePortable, untDMStyles, untDM, untMensagens, smGeralFMX,
  untAgendaSelect, untAgendaAdd, untDmAgenda,
  untDmResponsavel, smMensagensFMX, smNetworkState
  // , untConfiguracoes

    , untPerfil, untTypes, untSobre, untConfiguracoes, untAgendaView,
  untResourceString, untDMCloudMessaging;

{ TfrmPrincipal }

function TfrmPrincipal.OpenAgendaAlunoAutomatico: Boolean;
begin
  Result := False;

  if Usuario.Tipo = Funcionario then
    Exit;

  Dm.OpenAlunos;
  if Dm.fdqAluno.RecordCount = 1 then
  begin
    if not Assigned(frmAgendaView) then
      Application.CreateForm(TfrmAgendaView, frmAgendaView);

    frmAgendaView.AlunoId := Dm.fdqAluno.FieldByName('aluno_id').AsInteger;
    frmAgendaView.OwnerAgenda := Dm.fdqAluno.FieldByName('nome').AsString;
    frmAgendaView.NomeCompleto := Dm.fdqAluno.FieldByName
      ('nome_completo').AsString;
    frmAgendaView.DataSetAgenda := DmAgenda.fdqAgenda;
    frmAgendaView.TurmaId := 0;
    Result := True;
    frmAgendaView.Show;
  end;
end;

procedure TfrmPrincipal.OpenForm(aFormClass: TComponentClass);
begin
  if Assigned(fActiveForm) then
  begin
    if fActiveForm.ClassType = aFormClass then
    begin
      // exit
      fActiveForm.DisposeOf;
      fActiveForm := nil;
    end
    else
    begin
      fActiveForm.DisposeOf;
      fActiveForm := nil;
    end;
  end;

  Application.CreateForm(aFormClass, fActiveForm);

  fShowMenuPrincipal := False;
  fShowForm := True;

  // Encontra o Layout Base no form a ser exibido para adicionar ao frmPrincipal
  LayoutBase := fActiveForm.FindComponent('layBase');
  if Assigned(LayoutBase) then
  begin
    layPrincipal.AddObject(TLayout(LayoutBase));
    layMenu.Visible := False;
    layPrincipal.Visible := True;
    layInternet.Parent := layPrincipal;
  end;

  btnVoltarForms := fActiveForm.FindComponent('btnVoltar');
  if Assigned(btnVoltarForms) then
    TControl(btnVoltarForms).OnClick := BotaoVoltarOnClick;

  MultiView1.HideMaster;
  ToolBarPincipal.Visible := False;
end;

procedure TfrmPrincipal.PrimeiroAcesso;
begin

  Dm.PrimeiroAcessoVerificar;
  if PrimeiroAcessoOK then
    Exit;

  if Dm.fgActivityDialog.IsShown Then
    Dm.fgActivityDialog.Hide;

  FActivityDialogThread := TThread.CreateAnonymousThread(
    procedure
    begin
      try
        TThread.Synchronize(nil,
          procedure
          begin
            GridPanelLayout1.Enabled := False;
            lstMnuMain.Enabled := False;
            ToolBarPincipal.Enabled := False;

            Dm.fgActivityDialog.Cancellable := False;
            Dm.fgActivityDialog.Message :=
              'Atualizando informa��es para seu primeiro acesso.';
            Dm.fgActivityDialog.Show;
          end);

        Dm.PrimeiroAcessoExecutar;

        if TThread.CheckTerminated then
          TThread.Synchronize(nil,
            procedure
            begin
              GridPanelLayout1.Enabled := True;
              lstMnuMain.Enabled := True;
              ToolBarPincipal.Enabled := True;
              Application.ProcessMessages;
              Exit;
            end);

      finally
        if not TThread.CheckTerminated then
          TThread.Synchronize(nil,
            procedure
            begin
              Dm.fgActivityDialog.Hide;
              GridPanelLayout1.Enabled := True;
              lstMnuMain.Enabled := True;
              ToolBarPincipal.Enabled := True;
              Application.ProcessMessages;
            end);
      end;
    end);
  FActivityDialogThread.FreeOnTerminate := False;
  FActivityDialogThread.Start;
end;

procedure TfrmPrincipal.Sair;
begin
  MessageDlg('Deseja realmente fechar o L�pis Verde?',
    System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes,
    System.UITypes.TMsgDlgBtn.mbNo], 0,
    procedure(const BotaoPressionado: TModalResult)
    begin
      case BotaoPressionado of
        mrYes:
          begin
            Application.Terminate;
          end;
        mrNo:
          begin
            Abort;
          end;
      end;
    end);
end;

procedure TfrmPrincipal.SetInternetDisconect;
begin
  layInternet.Visible := not(smNetworkState.IsConnected);

  if not(layInternet.Visible) then
    Exit;

  if lblInternet.Text = rs_sem_conexao_internet then
  begin
    lblInternet.Text := rs_informacoes_desatualizadas;
    Exit;
  end;

  if (lblInternet.Text = rs_informacoes_desatualizadas) or
    (lblInternet.Text = '') then
  begin
    lblInternet.Text := rs_sem_conexao_internet;
    Exit;
  end;

end;

procedure TfrmPrincipal.SetModoDesenvolvedor;
begin
  lstGroupHeaderTestes.Visible := IsModoDesenvolvedor;
  lstItemTesteGeralApp.Visible := IsModoDesenvolvedor;
  lstItemTesteLogin.Visible := IsModoDesenvolvedor;
end;

procedure TfrmPrincipal.SetUsuario;
begin
  lstItemUsuario.Text := Usuario.Nome;
end;

procedure TfrmPrincipal.ShowMenuPrincipal;
begin
  layPrincipal.Visible := False;
  layInternet.Parent := layMenu;
  layMenu.Visible := True;
  ToolBarPincipal.Visible := True;
  MultiView1.HideMaster;
  fShowMenuPrincipal := True;
  fShowForm := False;
end;

procedure TfrmPrincipal.tmInternetTimer(Sender: TObject);
begin
  inherited;
  SetInternetDisconect;
end;

procedure TfrmPrincipal.AbrirAgenda;
begin
  Dm.SyncronizarDadosServerBasico;

  if not OpenAgendaAlunoAutomatico then
    OpenForm(TfrmAgendaSelect);
end;

procedure TfrmPrincipal.AbrirMensagens;
begin
  OpenForm(TfrmMensagens);
end;

procedure TfrmPrincipal.BotaoVoltarOnClick(Sender: TObject);
begin
  ShowMenuPrincipal;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Sair;
end;

procedure TfrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // if (IsSysOSAndroid) or (IsSysOSiOS)then
  CanClose := fAllowCloseForm;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  inherited;
  if IsSysOSWindows then
  begin
    self.Width := 400;
    self.Height := 600;
  end;

  fAllowCloseForm := True;
  SetStyle(self);
  fShowMenuPrincipal := True;
  fShowForm := False;
  iModoDesenvolvedor := 0;
  SetModoDesenvolvedor;
  SetUsuario;

  { TODO : Implentar uma sauda��o para usu�rio }
end;

procedure TfrmPrincipal.FormKeyUp(Sender: TObject; var Key: Word;
var KeyChar: Char; Shift: TShiftState);
begin
  inherited;

  if Key = vkHardwareBack then
    // Caso o menu estiver aberto
    if (MultiView1.IsShowed) then
    begin
      Key := 0;
      MultiView1.HideMaster;
      Exit;
    end
    // Caso tenha algum form aberto
    else if (Assigned(fActiveForm) and not(fShowMenuPrincipal) and (fShowForm))
    then
    begin
      Key := 0;
      BotaoVoltarOnClick(self);
    end
    else
    begin
      Key := 0;
      Sair;
    end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  inherited;
  if Assigned(frmLogin) then
  begin
    frmLogin.Close;
    frmLogin.DisposeOf;
    frmLogin := nil;
  end;

  PrimeiroAcesso;
  DMCloudMessaging.GetDeviceInfo;

  Dm.OpenQuerys;

  lblInternet.Text := '';
  SetInternetDisconect;
end;

procedure TfrmPrincipal.HideMenuPrincipal;
begin
  layPrincipal.Visible := False;
  layMenu.Visible := True;
  ToolBarPincipal.Visible := True;
  MultiView1.HideMaster;

end;

procedure TfrmPrincipal.imgLogoffClick(Sender: TObject);
begin
  inherited;
  Logoff;
end;

procedure TfrmPrincipal.imgMensagensClick(Sender: TObject);
begin
  inherited;
  AbrirMensagens;
end;

procedure TfrmPrincipal.imgAgendaClick(Sender: TObject);
begin
  inherited;
  // AbrirAgenda;

  if not Dm.fgActivityDialog.IsShown then
  begin
    FActivityDialogThread := TThread.CreateAnonymousThread(
      procedure
      begin
        try
          TThread.Synchronize(nil,
            procedure
            begin
              GridPanelLayout1.Enabled := False;
              lstMnuMain.Enabled := False;
              ToolBarPincipal.Enabled := False;

              Dm.fgActivityDialog.Message := rs_sync_informacoes;
              Dm.fgActivityDialog.Show;
            end);

          // AbrirAgenda;
          if FirstSyncExecute then
            Dm.SyncronizarDadosServerBasico
          else
            Dm.SyncronizarDadosServerGeral;

          if TThread.CheckTerminated then
          begin
            TThread.Synchronize(nil,
              procedure
              begin
                Dm.fgActivityDialog.Hide;
                GridPanelLayout1.Enabled := True;
                lstMnuMain.Enabled := True;
                ToolBarPincipal.Enabled := True;

                if not OpenAgendaAlunoAutomatico then
                  OpenForm(TfrmAgendaSelect);

                Application.ProcessMessages;
              end);
          end;

        finally
          if not TThread.CheckTerminated then
            TThread.Synchronize(nil,
              procedure
              begin
                Dm.fgActivityDialog.Hide;
                GridPanelLayout1.Enabled := True;
                lstMnuMain.Enabled := True;
                ToolBarPincipal.Enabled := True;

                if not OpenAgendaAlunoAutomatico then
                  OpenForm(TfrmAgendaSelect);

                Application.ProcessMessages;
              end);
        end;
      end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
  end;

end;

procedure TfrmPrincipal.imgConfiguracoesClick(Sender: TObject);
begin
  inherited;
  OpenForm(TfrmConfiguracoes);
end;

procedure TfrmPrincipal.imgMenuClick(Sender: TObject);
begin
  inherited;
  btnMenu.OnClick(self);
end;

procedure TfrmPrincipal.imgMeuPerfilClick(Sender: TObject);
begin
  inherited;
  if not smNetworkState.ValidarConexao then
    Exit;

  OpenForm(TfrmPerfil);
end;

procedure TfrmPrincipal.lblAgendaClick(Sender: TObject);
begin
  inherited;
  AbrirAgenda;
end;

procedure TfrmPrincipal.lblMensagensClick(Sender: TObject);
begin
  inherited;
  AbrirMensagens;
end;

procedure TfrmPrincipal.Logoff;
begin
  MessageDlg('Deseja realmente desconectar este usu�rio?',
    System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes,
    System.UITypes.TMsgDlgBtn.mbNo], 0,
    procedure(const BotaoPressionado: TModalResult)
    begin
      case BotaoPressionado of
        mrYes:
          begin
            Dm.OpenLoginUltimo;

            Dm.fdqLoginUltimo.Edit;
            Dm.fdqLoginUltimo.FieldByName('realizou_logoff').AsString := 'S';
            Dm.fdqLoginUltimo.Post;
            Application.Terminate;
          end;
        mrNo:
          begin
            Abort;
          end;
      end;
    end);

end;

procedure TfrmPrincipal.lstItemSobreClick(Sender: TObject);
var
  InputString: string;
begin
  inherited;
  OpenForm(TfrmSobre);
  Inc(iModoDesenvolvedor);

  if iModoDesenvolvedor >= 6 then
  begin

    InputBox('Inserir senha para habilitar modo desenvolvedor!',
             '', '',
      procedure(const AResult: TModalResult; const AValue: string)
      begin
        case AResult of
          mrOk:
            begin
              if AValue = 'zxc' then
              begin
                MsgPoupUp('Modo desenvolvedor habilitado!');
                Dm.IsModoDesenvolvedor := True;
                Dm.SetModoDesenvolvedor;
                SetModoDesenvolvedor;
              end;
            end;
          mrCancel:
            begin
            end;
        end;
      end);
  end;
end;

procedure TfrmPrincipal.lstItemTesteGeralAppClick(Sender: TObject);
begin
  inherited;
  OpenForm(TfrmTesteGeralApp);
end;

procedure TfrmPrincipal.lstItemTesteLoginClick(Sender: TObject);
begin
  inherited;
  OpenForm(TfrmLogin);
end;

end.
