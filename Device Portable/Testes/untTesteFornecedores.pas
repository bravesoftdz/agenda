unit untTesteFornecedores;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, smFrmBase, FMX.Layouts,smFrmBaseToolBar,
  FMX.Controls.Presentation, FMX.Objects;

type
  TfrmTesteFornecedores = class(TfrmBaseToolBar)
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTesteFornecedores: TfrmTesteFornecedores;

implementation

{$R *.fmx}

uses untLibDevicePortable;

procedure TfrmTesteFornecedores.FormCreate(Sender: TObject);
begin
  inherited;
  SetStyle(Self);
end;

end.
