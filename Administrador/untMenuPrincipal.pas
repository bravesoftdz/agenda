unit untMenuPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013White,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxSkinscxPCPainter,
  cxPCdxBarPopupMenu, cxPC, dxRibbonSkins, dxSkinsdxRibbonPainter,
  dxSkinsdxBarPainter, dxBar, cxClasses, dxRibbon, Vcl.ImgList,
  dxStatusBar, dxRibbonStatusBar, IniFiles, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxBarBuiltInMenu, dxRibbonCustomizationForm, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.Grids, Vcl.DBGrids, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmMenuPrincipal = class(TForm)
    pmAbas: TPopupMenu;
    FecharAba1: TMenuItem;
    FecharTodasAbas1: TMenuItem;
    pgPrinc: TcxPageControl;
    dxRibbonStatusBar1: TdxRibbonStatusBar;
    cxImageList1: TcxImageList;
    dxRibbon1: TdxRibbon;
    dxRibbon1Tab2: TdxRibbonTab;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1Tab3: TdxRibbonTab;
    dxRibbon1Tab6: TdxRibbonTab;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar2: TdxBar;
    dxBarManager1Bar3: TdxBar;
    dxBarManager1Bar4: TdxBar;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar5: TdxBar;
    dxBarManager1Bar6: TdxBar;
    dxBarManager1Bar7: TdxBar;
    dxBarManager1Bar9: TdxBar;
    dxBarManager1Bar10: TdxBar;
    dxBarManager1Bar11: TdxBar;
    dxBarSubItem1: TdxBarSubItem;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    dxBarLargeButton1: TdxBarLargeButton;
    dxBarButton5: TdxBarButton;
    dxBarLargeButton2: TdxBarLargeButton;
    dxBarLargeButton3: TdxBarLargeButton;
    dxBarButton6: TdxBarButton;
    dxBarButton7: TdxBarButton;
    dxBarLargeButton4: TdxBarLargeButton;
    dxBarLargeButton5: TdxBarLargeButton;
    dxBarLargeButton6: TdxBarLargeButton;
    dxBarLargeButton7: TdxBarLargeButton;
    dxBarLargeButton8: TdxBarLargeButton;
    dxBarLargeButton9: TdxBarLargeButton;
    dxBarLargeButton10: TdxBarLargeButton;
    dxBarLargeButton11: TdxBarLargeButton;
    dxBarLargeButton12: TdxBarLargeButton;
    dxBarLargeButton13: TdxBarLargeButton;
    dxBarButton8: TdxBarButton;
    dxBarLargeButton14: TdxBarLargeButton;
    dxBarLargeButton15: TdxBarLargeButton;
    dxBarLargeButton16: TdxBarLargeButton;
    dxBarLargeButton17: TdxBarLargeButton;
    dxBarLargeButton18: TdxBarLargeButton;
    dxBarGroup1: TdxBarGroup;
    dxBarGroup2: TdxBarGroup;
    dxBarGroup3: TdxBarGroup;
    dxBarButton9: TdxBarButton;
    dxBarLargeButton19: TdxBarLargeButton;
    dxBarLargeButton20: TdxBarLargeButton;
    dxBarLargeButton21: TdxBarLargeButton;
    dxBarLargeButton22: TdxBarLargeButton;
    dxBarButton10: TdxBarButton;
    dxBarSubItem2: TdxBarSubItem;
    dxBarButton11: TdxBarButton;
    procedure pgPrincCanClose(Sender: TObject; var ACanClose: Boolean);
    procedure FecharAba1Click(Sender: TObject);
    procedure FecharTodasAbas1Click(Sender: TObject);
    procedure dxBarLargeButton18Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dxBarLargeButton16Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure ActivePg(Classe: TFormClass);
    procedure OpenForm(Classe: TFormClass; var Form;
      sConstruct: Boolean = False);
    procedure CloseForm;
    procedure SetStatusBar;
  public
    { Public declarations }
  end;

var
  frmMenuPrincipal: TfrmMenuPrincipal;

implementation

{$R *.dfm}

uses
  smGeral, smMensagens,untDM, untSobre;

procedure TfrmMenuPrincipal.ActivePg(Classe: TFormClass);
var
  i: Integer;
  Form: String;
begin
  Form := Classe.ClassName;

  for i := 0 to ComponentCount - 1 do
    if (Components[i] is TcxTabSheet) then
      if (Components[i]).Name = 'TS' + Form then
        pgPrinc.ActivePageIndex := (Components[i] as TcxTabSheet).TabIndex;

end;

procedure TfrmMenuPrincipal.CloseForm;
var
  TbSheet: TcxTabSheet;
  sForm: String;
  frmClass: TFormClass;
  Form: TForm;
  i: Byte;
begin
  try
    TbSheet := pgPrinc.ActivePage;
    if Assigned(TbSheet) Then
    begin
      sForm := Copy(TbSheet.Name, 3, length(TbSheet.Name));
      frmClass := TFormClass(FindClass(sForm));

      for i := 0 to Screen.FormCount - 1 do
        if Screen.Forms[i] is frmClass then
        begin
          Form := Screen.Forms[i];

          if not(Form.CloseQuery) then
            Exit;

          Form.Close;
          Form.Free;
          Break;
        end;

      UnRegisterClass(frmClass);
      TbSheet.Free;

    end;
  except
    on EAbort do
      Exit
    else
      Msg('Erro ao fechar tela.');
  end;
end;

procedure TfrmMenuPrincipal.SetStatusBar;
begin
  dxRibbonStatusBar1.Panels[2].Text := 'Conex�o: ' + DM.GetPahConexao;
  dxRibbonStatusBar1.Panels[1].Text := 'Vers�o: ' + smGeral.GetVersion(Application.Exename);
  dxRibbonStatusBar1.Panels[0].Text := 'Usu�rio: ' + Dm.GetNomeUsuario;
end;



procedure TfrmMenuPrincipal.dxBarLargeButton16Click(Sender: TObject);
begin
  try
    FrmSobre := TFrmSobre.Create(nil);
    FrmSobre.ShowModal;
  finally
    FreeAndNil(FrmSobre);
  end;
end;

procedure TfrmMenuPrincipal.dxBarLargeButton18Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMenuPrincipal.FecharAba1Click(Sender: TObject);
begin
  CloseForm;
end;

procedure TfrmMenuPrincipal.FecharTodasAbas1Click(Sender: TObject);
var
  i: Integer;
begin
  for i := pgPrinc.PageCount - 1 downto 0 do
  begin
    pgPrinc.ActivePageIndex := i;
    CloseForm;
  end;
end;

procedure TfrmMenuPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FecharTodasAbas1Click(self);
end;

procedure TfrmMenuPrincipal.FormCreate(Sender: TObject);
begin
  SetStatusBar;
end;

procedure TfrmMenuPrincipal.FormShow(Sender: TObject);
begin
  dxRibbon1.ActiveTab:= dxRibbon1Tab2;
end;

procedure TfrmMenuPrincipal.OpenForm(Classe: TFormClass; var Form;
  sConstruct: Boolean);
var
  TbSheet: TcxTabSheet;
begin
  try
    if (TForm(Form) = nil) or (sConstruct) then
    begin
      RegisterClass(Classe);

      TbSheet := TcxTabSheet.Create(self);
      TbSheet.Parent := pgPrinc;

      if not sConstruct then
        TForm(Form) := Classe.Create(self);

      with TForm(Form) do
        try
          Parent := TbSheet;
          borderStyle := bsNone;
          align := alClient;
          Show;
          SetFocus;
        except
        end;

      SetLabelsTransparent(TForm(Form));
      TbSheet.Name := 'TS' + TForm(Form).ClassName;
      TbSheet.Caption := TForm(Form).Caption;
      pgPrinc.ActivePage := TbSheet;
    end
    else
      ActivePg(Classe);

  except
    Msg('Erro ao abrir tela');
  end;

end;

procedure TfrmMenuPrincipal.pgPrincCanClose(Sender: TObject;
  var ACanClose: Boolean);
begin
  ACanClose := False;
  CloseForm;
end;

end.
