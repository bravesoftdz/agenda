unit untTesteString;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, smFrmBase, FMX.Controls.Presentation, FMX.Edit,
  FMX.Layouts,smFrmBaseToolBar, FMX.Objects;

type
  TfrmTesteString = class(TfrmBaseToolBar)
    SpeedButton1: TSpeedButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTesteString: TfrmTesteString;

implementation

{$R *.fmx}

uses untModuloCliente, untFuncoes;

procedure TfrmTesteString.FormCreate(Sender: TObject);
begin
  inherited;
  SetStyle(Self);
end;

procedure TfrmTesteString.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  Edit1.Text := ModuloCliente.SrvServerMetodosClient.ReverseString(Edit1.Text);
end;

end.
