unit untCriarConta;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  smFrmBase, FMX.Layouts, FMX.Controls.Presentation, FMX.TabControl, FMX.Edit,
  FMX.Objects,FMX.VirtualKeyboard, FMX.ListBox;

type
  TfrmCriarConta = class(TfrmBase)
    tbCtrlPrincipal: TTabControl;
    tbItemNome: TTabItem;
    tbItemEmail: TTabItem;
    tbItemSenha: TTabItem;
    ToolBarNome: TToolBar;
    lblTituloNome: TLabel;
    layRodapeNome: TLayout;
    layPrincipalNome: TLayout;
    btnProximaNome: TSpeedButton;
    edtNome: TEdit;
    edtSobrenome: TEdit;
    btnVoltarNome: TSpeedButton;
    tbItemTelefone: TTabItem;
    tbItemDadosPessoais: TTabItem;
    layNome: TLayout;
    laySobrenome: TLayout;
    layCabecalhoNome: TLayout;
    imgProximaNome: TImage;
    imgVoltarNome: TImage;
    layCabecalhoEmail: TLayout;
    layPrincipalEmail: TLayout;
    layEmail: TLayout;
    edtEmail: TEdit;
    layRodapeEmail: TLayout;
    btnProximaEmail: TSpeedButton;
    imgProximaEmail: TImage;
    btnVoltarEmail: TSpeedButton;
    imgVoltarEmail: TImage;
    ToolBarEmail: TToolBar;
    lblTituloEmail: TLabel;
    layCabecalhoSenha: TLayout;
    layPrincipalSenha: TLayout;
    layCriarSenha: TLayout;
    edtCriarSenha: TEdit;
    layConfirmarSenha: TLayout;
    edtConfirmarSenha: TEdit;
    layRodapeSenha: TLayout;
    btnProximaSenha: TSpeedButton;
    imgProximaSenha: TImage;
    btnVoltarSenha: TSpeedButton;
    imgVoltarSenha: TImage;
    ToolBarSenha: TToolBar;
    lblTituloSenha: TLabel;
    layCabecalhoTelefone: TLayout;
    layPrincipalTelefone: TLayout;
    layTelefone: TLayout;
    edtTelefone: TEdit;
    layRodapeTelefone: TLayout;
    btnProximaTelefone: TSpeedButton;
    imgProximaTelefone: TImage;
    btnVoltarTelefone: TSpeedButton;
    imgVoltarTelefone: TImage;
    ToolBarTelefone: TToolBar;
    lblTituloTelefone: TLabel;
    layCabecalhoDadosPessoais: TLayout;
    layPrincipalDadosPrincipais: TLayout;
    layCPF: TLayout;
    edtCPF: TEdit;
    layRG: TLayout;
    edtRG: TEdit;
    layRodapeDadosPrincipais: TLayout;
    btnFinalizar: TSpeedButton;
    imgFinalizar: TImage;
    btnVoltarDadosPessoais: TSpeedButton;
    imgVoltarDadosPessoais: TImage;
    ToolBarDadosPessoais: TToolBar;
    lblTituloDadosPessoais: TLabel;
    laySexo: TLayout;
    cmbSexo: TComboBox;
    lblSexo: TLabel;
    layErrorSenha: TLayout;
    lblErrorSenhas: TLabel;
    layErrorEmail: TLayout;
    lblErrorEmail: TLabel;
    Layout1: TLayout;
    lblErrorCriarConta: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnProximaNomeClick(Sender: TObject);
    procedure btnVoltarNomeClick(Sender: TObject);
    procedure imgProximaNomeClick(Sender: TObject);
    procedure imgVoltarNomeClick(Sender: TObject);
    procedure edtNomeChange(Sender: TObject);
    procedure edtSobrenomeChange(Sender: TObject);
    procedure edtNomeKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtSobrenomeKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cmbSexoChange(Sender: TObject);
    procedure btnProximaEmailClick(Sender: TObject);
    procedure btnProximaSenhaClick(Sender: TObject);
    procedure btnVoltarEmailClick(Sender: TObject);
    procedure btnVoltarSenhaClick(Sender: TObject);
    procedure btnVoltarTelefoneClick(Sender: TObject);
    procedure btnVoltarDadosPessoaisClick(Sender: TObject);
    procedure btnProximaTelefoneClick(Sender: TObject);
    procedure imgVoltarEmailClick(Sender: TObject);
    procedure imgVoltarSenhaClick(Sender: TObject);
    procedure imgVoltarTelefoneClick(Sender: TObject);
    procedure imgVoltarDadosPessoaisClick(Sender: TObject);
    procedure imgProximaEmailClick(Sender: TObject);
    procedure imgProximaSenhaClick(Sender: TObject);
    procedure imgProximaTelefoneClick(Sender: TObject);
    procedure imgFinalizarClick(Sender: TObject);
    procedure edtEmailChange(Sender: TObject);
    procedure edtCriarSenhaChange(Sender: TObject);
    procedure edtConfirmarSenhaChange(Sender: TObject);
    procedure edtTelefoneChange(Sender: TObject);
    procedure edtCPFChange(Sender: TObject);
    procedure edtRGChange(Sender: TObject);
    procedure edtEmailKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtCriarSenhaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtConfirmarSenhaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtTelefoneKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtCPFKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtRGKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure cmbSexoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtNomeChangeTracking(Sender: TObject);
    procedure edtSobrenomeChangeTracking(Sender: TObject);
    procedure edtEmailChangeTracking(Sender: TObject);
    procedure edtCriarSenhaChangeTracking(Sender: TObject);
    procedure edtConfirmarSenhaChangeTracking(Sender: TObject);
    procedure edtTelefoneChangeTracking(Sender: TObject);
    procedure edtCPFChangeTracking(Sender: TObject);
    procedure edtRGChangeTracking(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
  private
    MsgCriarConta:String;
    fActivityDialogThread: TThread;
    fEmailOk:Boolean;
    fCPFOk:Boolean;
    fCriarContaOk:Boolean;
    fNome:String;
    fSobreNome: String;
    fEmail: String;
    fSenha: String;
    fTelefone: String;
    fCPF: String;
    fRG: String;
    fSexo: String;
    procedure SetStateButtonsNome;
    procedure SetStateButtonsEmail;
    procedure SetStateButtonsSenha;
    procedure SetStateButtonsTelefone;
    procedure SetStateButtonsDadosPessoais;
    procedure SetNotVisibleObjects;
    procedure ValidarEmail;
    function ValidarSenha:Boolean;
    function ValidarCPF:Boolean;
    procedure CriarConta;
    procedure SetClearFields;
    procedure SetFields;
    procedure SetVisibleLabelSexo;
  public
    { Public declarations }
  end;

var
  frmCriarConta: TfrmCriarConta;

implementation

{$R *.fmx}

uses smGeralFMX, untFuncoes, untDMStyles, untDM, untModuloCliente, smCrypt;

procedure TfrmCriarConta.btnProximaNomeClick(Sender: TObject);
begin
  inherited;
  tbCtrlPrincipal.ActiveTab := tbItemEmail;
end;

procedure TfrmCriarConta.btnVoltarNomeClick(Sender: TObject);
begin
  inherited;
  frmCriarConta.Close;
  //frmCriarConta.DisposeOf;
  //frmCriarConta:= nil;
end;

procedure TfrmCriarConta.cmbSexoChange(Sender: TObject);
begin
  inherited;
  SetVisibleLabelSexo;
  SetStateButtonsDadosPessoais;
end;

procedure TfrmCriarConta.cmbSexoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
    KeyboardHide;
end;

procedure TfrmCriarConta.CriarConta;
begin
  SetFields;

  if not ValidarCPF Then
  begin
    fCriarContaOk:=False;
    fCPFOk:=False;
    lblErrorCriarConta.Text := 'Este CPF j� est� cadastrado';
    lblErrorCriarConta.Visible:=True;
    Application.ProcessMessages;
    Exit;
  end;

  try
    MsgCriarConta:= ModuloCliente.SrvServerMetodosClient.CriarUsuarioResponsavel(fNome,fSobreNome,fEmail,fSenha,fTelefone,fCPF,fRG,fSexo);
  except on E:Exception do
    begin
      fCriarContaOk:=False;
      ShowMessage('Erro ao criar conta' + #13 + E.Message);
      lblErrorCriarConta.Text := 'Erro ao criar conta' + #13 + E.Message;
      lblErrorCriarConta.Visible:=True;
      Application.ProcessMessages;
      //Abort;
    end;
  end;


  if (MsgCriarConta = 'OK') then
  begin
    fCriarContaOk:=True;
  end
  else
    fCriarContaOk:=False;
end;


procedure TfrmCriarConta.edtConfirmarSenhaChange(Sender: TObject);
begin
  inherited;
  SetStateButtonsSenha;
end;

procedure TfrmCriarConta.edtConfirmarSenhaChangeTracking(Sender: TObject);
begin
  inherited;
  SetStateButtonsSenha;
end;

procedure TfrmCriarConta.edtConfirmarSenhaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
    KeyboardHide;
end;

procedure TfrmCriarConta.edtCPFChange(Sender: TObject);
begin
  inherited;
  SetStateButtonsDadosPessoais;
end;

procedure TfrmCriarConta.edtCPFChangeTracking(Sender: TObject);
begin
  inherited;
  SetStateButtonsDadosPessoais;
end;

procedure TfrmCriarConta.edtCPFKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
    KeyboardHide;
end;

procedure TfrmCriarConta.edtCriarSenhaChange(Sender: TObject);
begin
  inherited;
  SetStateButtonsSenha;
end;

procedure TfrmCriarConta.edtCriarSenhaChangeTracking(Sender: TObject);
begin
  inherited;
  SetStateButtonsSenha;
end;

procedure TfrmCriarConta.edtCriarSenhaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
    KeyboardHide;
end;

procedure TfrmCriarConta.edtEmailChange(Sender: TObject);
begin
  inherited;
  SetStateButtonsEmail;
end;

procedure TfrmCriarConta.edtEmailChangeTracking(Sender: TObject);
begin
  inherited;
  SetStateButtonsEmail;
end;

procedure TfrmCriarConta.edtEmailKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
    KeyboardHide;
end;

procedure TfrmCriarConta.edtNomeChange(Sender: TObject);
begin
  inherited;
  SetStateButtonsNome;
end;

procedure TfrmCriarConta.edtNomeChangeTracking(Sender: TObject);
begin
  inherited;
  SetStateButtonsNome;
end;

procedure TfrmCriarConta.edtNomeKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
    KeyboardHide;
end;

procedure TfrmCriarConta.edtRGChange(Sender: TObject);
begin
  inherited;
  SetStateButtonsDadosPessoais;
end;

procedure TfrmCriarConta.edtRGChangeTracking(Sender: TObject);
begin
  inherited;
  SetStateButtonsDadosPessoais;
end;

procedure TfrmCriarConta.edtRGKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
    KeyboardHide;
end;

procedure TfrmCriarConta.edtSobrenomeChange(Sender: TObject);
begin
  inherited;
  SetStateButtonsNome;
end;

procedure TfrmCriarConta.edtSobrenomeChangeTracking(Sender: TObject);
begin
  inherited;
  SetStateButtonsNome;
end;

procedure TfrmCriarConta.edtSobrenomeKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
    KeyboardHide;
end;

procedure TfrmCriarConta.edtTelefoneChange(Sender: TObject);
begin
  inherited;
  SetStateButtonsTelefone;
end;

procedure TfrmCriarConta.edtTelefoneChangeTracking(Sender: TObject);
begin
  inherited;
  SetStateButtonsTelefone;
end;

procedure TfrmCriarConta.edtTelefoneKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
    KeyboardHide;
end;

procedure TfrmCriarConta.FormCreate(Sender: TObject);
begin
  inherited;
  SetStyle(Self);
  tbCtrlPrincipal.ActiveTab:= tbItemNome;
  tbCtrlPrincipal.TabPosition:= TTabPosition.None;
end;

procedure TfrmCriarConta.FormShow(Sender: TObject);
begin
  inherited;
  SetStateButtonsNome;
  SetStateButtonsEmail;
  SetStateButtonsSenha;
  SetStateButtonsTelefone;
  SetStateButtonsDadosPessoais;
  SetNotVisibleObjects;
end;

procedure TfrmCriarConta.imgFinalizarClick(Sender: TObject);
begin
  inherited;
  btnFinalizar.OnClick(self);
end;

procedure TfrmCriarConta.imgProximaEmailClick(Sender: TObject);
begin
  inherited;
  btnProximaEmail.OnClick(self);
end;

procedure TfrmCriarConta.imgProximaNomeClick(Sender: TObject);
begin
  inherited;
  btnProximaNome.OnClick(self);
end;

procedure TfrmCriarConta.imgProximaSenhaClick(Sender: TObject);
begin
  inherited;
  btnProximaSenha.OnClick(self);
end;

procedure TfrmCriarConta.imgProximaTelefoneClick(Sender: TObject);
begin
  inherited;
  btnProximaTelefone.OnClick(self);
end;

procedure TfrmCriarConta.imgVoltarDadosPessoaisClick(Sender: TObject);
begin
  inherited;
  btnVoltarDadosPessoais.OnClick(self);
end;

procedure TfrmCriarConta.imgVoltarEmailClick(Sender: TObject);
begin
  inherited;
  btnVoltarEmail.OnClick(self);
end;

procedure TfrmCriarConta.imgVoltarNomeClick(Sender: TObject);
begin
  inherited;
  btnVoltarNome.OnClick(self);
end;

procedure TfrmCriarConta.imgVoltarSenhaClick(Sender: TObject);
begin
  inherited;
  btnVoltarSenha.OnClick(self);
end;

procedure TfrmCriarConta.imgVoltarTelefoneClick(Sender: TObject);
begin
  inherited;
  btnVoltarTelefone.OnClick(self);
end;

procedure TfrmCriarConta.SetClearFields;
begin
  fNome:= EmptyStr;
  fSobreNome:=EmptyStr;
  fEmail:=EmptyStr;
  fSenha:=EmptyStr;
  fTelefone:= EmptyStr;
  fCPF:=EmptyStr;
  fRG:=EmptyStr;
  fSexo:= EmptyStr;
end;

procedure TfrmCriarConta.SetFields;
begin
  SetClearFields;
  fNome:= edtNome.Text;
  fSobreNome:=edtSobrenome.Text;
  fEmail:=edtEmail.Text;
  fSenha:=Encrypt(edtCriarSenha.Text);
  fTelefone:= SomenteNumero(edtTelefone.Text);
  fCPF:=SomenteNumero(edtCPF.Text);
  fRG:=SomenteNumero(edtRG.Text);
  fSexo:= Copy(cmbSexo.Selected.Text,0,1);
end;

procedure TfrmCriarConta.SetNotVisibleObjects;
begin
  lblErrorEmail.Visible:=False;
  lblErrorSenhas.Visible:=False;
  lblErrorCriarConta.Visible:=False;
end;

procedure TfrmCriarConta.SetStateButtonsDadosPessoais;
begin
  btnFinalizar.Enabled := ( (edtCPF.Text <> EmptyStr) and
                              (edtRG.Text <> EmptyStr)and
                              (cmbSexo.ItemIndex >= 0));

  imgFinalizar.Enabled := ( (edtCPF.Text <> EmptyStr) and
                              (edtRG.Text <> EmptyStr)and
                              (cmbSexo.ItemIndex >= 0));
end;

procedure TfrmCriarConta.SetStateButtonsEmail;
begin
  btnProximaEmail.Enabled := (edtEmail.Text <> EmptyStr);
  imgProximaEmail.Enabled := (edtEmail.Text <> EmptyStr);
end;

procedure TfrmCriarConta.SetStateButtonsNome;
begin
  btnProximaNome.Enabled := ( (edtNome.Text <> EmptyStr) and
                              (edtSobrenome.Text <> EmptyStr));

  imgProximaNome.Enabled := ( (edtNome.Text <> EmptyStr) and
                              (edtSobrenome.Text <> EmptyStr));

end;

procedure TfrmCriarConta.SetStateButtonsSenha;
begin
  btnProximaSenha.Enabled := ( (edtCriarSenha.Text <> EmptyStr) and
                              (edtConfirmarSenha.Text <> EmptyStr)
                             );


  imgProximaSenha.Enabled := ( (edtCriarSenha.Text <> EmptyStr) and
                               (edtConfirmarSenha.Text <> EmptyStr)
                             );
end;

procedure TfrmCriarConta.SetStateButtonsTelefone;
begin
  btnProximaTelefone.Enabled := (edtTelefone.Text <> EmptyStr);
  imgProximaTelefone.Enabled := (edtTelefone.Text <> EmptyStr);
end;


procedure TfrmCriarConta.SetVisibleLabelSexo;
begin
  lblSexo.Visible:= cmbSexo.ItemIndex = -1;
end;

function TfrmCriarConta.ValidarCPF: Boolean;
begin
  try
    if not ModuloCliente.SrvServerMetodosClient.ValidarCPFExistenteResponsavel(edtCPF.Text) then
    begin
      fCPFOk:= False;
      lblErrorCriarConta.Visible:= True;
      Application.ProcessMessages;
      Exit;
    end;
  except on E:Exception do
    begin
      fCPFOk:= False;
      ShowMessage('Erro ao validar CPF' + #13 + E.Message);
      Application.ProcessMessages;
      //Abort;
    end;
  end;
  fCPFOk:=True;
  Result:=fCPFOk;
end;

procedure TfrmCriarConta.ValidarEmail;
begin
  if not (smGeralFMX.ValidarEMail(edtEmail.Text))Then
  begin
    fEmailOk:= False;
    lblErrorEmail.Text:= 'Endere�o de E-mail inv�lido!';
    Exit;
  end;

  try
    if not ModuloCliente.SrvServerMetodosClient.ValidarEmailExistenteResponsavel(edtEmail.Text) then
    begin
      fEmailOk:= False;
      lblErrorEmail.Text:= 'Este E-mail j� est� cadastrado';
      Application.ProcessMessages;
      Exit;
    end;
  except on E:Exception do
    begin
      ShowMessage('Erro ao validar E-mail' + #13 + E.Message);
      //Abort;
    end;
  end;
  fEmailOk:=True;
end;

function TfrmCriarConta.ValidarSenha: Boolean;
begin
  Result:=((edtCriarSenha.Text = edtConfirmarSenha.Text) and
           (edtCriarSenha.Text <> EmptyStr) and
           (edtConfirmarSenha.Text <> EmptyStr)
           );
  lblErrorSenhas.Visible:= not Result;
end;

procedure TfrmCriarConta.btnFinalizarClick(Sender: TObject);
begin
 SetClearFields;
 if not DM.fgActivityDialog.IsShown then
  begin
    fCriarContaOk:=False;
    lblErrorCriarConta.Visible:= False;
    FActivityDialogThread := TThread.CreateAnonymousThread(procedure
      begin
        try
          TThread.Synchronize(nil, procedure
          begin
            layPrincipalDadosPrincipais.Enabled:=False;
            DM.fgActivityDialog.Message := 'Criando conta';
            DM.fgActivityDialog.Show;
          end);


          Sleep(200);
          CriarConta;

          if TThread.CheckTerminated then
            Exit;


        finally
          if not TThread.CheckTerminated then
            TThread.Synchronize(nil, procedure
            begin
              if fCriarContaOk then
              begin
                DM.fgActivityDialog.Hide;
                layPrincipalDadosPrincipais.Enabled:=True;
                ShowMessage('Conta criada com sucesso!');
                frmCriarConta.Close;
                //frmCriarConta.DisposeOf;
                //frmCriarConta:= nil;
                Application.ProcessMessages;
              end
              else
              begin
                if not ValidarCPF Then
                begin
                  lblErrorCriarConta.Text := 'Este CPF j� est� cadastrado';
                  lblErrorCriarConta.Visible:=True;
                  Application.ProcessMessages;
                end;

                if not fCriarContaOk Then
                begin
                  lblErrorCriarConta.Text := 'Erro ao criar conta';
                  lblErrorCriarConta.Visible:=True;
                  Application.ProcessMessages;
                end;

                DM.fgActivityDialog.Hide;
                layPrincipalDadosPrincipais.Enabled:=True;
                Application.ProcessMessages;
              end;
            end);
        end;
      end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
  end;

end;

procedure TfrmCriarConta.btnProximaEmailClick(Sender: TObject);
begin
 if not DM.fgActivityDialog.IsShown then
  begin
    fEmailOk:=False;
    lblErrorEmail.Visible:=False;
    FActivityDialogThread := TThread.CreateAnonymousThread(procedure
      begin
        try
          TThread.Synchronize(nil, procedure
          begin
            layPrincipalEmail.Enabled:=False;
            DM.fgActivityDialog.Message := 'Validando E-Mail';
            DM.fgActivityDialog.Show;
          end);

          Sleep(200);
          ValidarEmail;

          if TThread.CheckTerminated then
            Exit;


        finally
          if not TThread.CheckTerminated then
            TThread.Synchronize(nil, procedure
            begin
              if fEmailOk then
              begin
                DM.fgActivityDialog.Hide;
                layPrincipalEmail.Enabled:=True;
                tbCtrlPrincipal.ActiveTab := tbItemSenha;
                Application.ProcessMessages;
              end
              else
              begin
                DM.fgActivityDialog.Hide;
                layPrincipalEmail.Enabled:=True;
                Application.ProcessMessages;
                lblErrorEmail.Visible:=True;
              end;
            end);
        end;
      end);
    FActivityDialogThread.FreeOnTerminate := False;
    FActivityDialogThread.Start;
  end;
end;

procedure TfrmCriarConta.btnVoltarEmailClick(Sender: TObject);
begin
  inherited;
  tbCtrlPrincipal.ActiveTab := tbItemNome;
end;

procedure TfrmCriarConta.btnProximaSenhaClick(Sender: TObject);
begin
  inherited;
  lblErrorSenhas.Visible:= False;;
  if ValidarSenha then
  begin
    tbCtrlPrincipal.ActiveTab := tbItemTelefone;
  end;
end;

procedure TfrmCriarConta.btnVoltarSenhaClick(Sender: TObject);
begin
  inherited;
  tbCtrlPrincipal.ActiveTab := tbItemEmail;
end;

procedure TfrmCriarConta.btnProximaTelefoneClick(Sender: TObject);
begin
  inherited;
  tbCtrlPrincipal.ActiveTab := tbItemDadosPessoais;
end;

procedure TfrmCriarConta.btnVoltarTelefoneClick(Sender: TObject);
begin
  inherited;
  tbCtrlPrincipal.ActiveTab := tbItemSenha;
end;

procedure TfrmCriarConta.btnVoltarDadosPessoaisClick(Sender: TObject);
begin
  inherited;
  tbCtrlPrincipal.ActiveTab := tbItemTelefone;
end;

end.
