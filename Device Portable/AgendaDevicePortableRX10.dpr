program AgendaDevicePortableRX10;

uses
  System.StartUpCopy,
  FMX.Forms,
  System.UITypes,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  untDM in 'untDM.pas' {DM: TDataModule},
  untModuloCliente in 'untModuloCliente.pas' {ModuloCliente: TDataModule},
  smFrmBaseForAll in 'C:\Componentes\sum182\D15\Forms\FireMonkey\smFrmBaseForAll.pas' {frmBaseForAll},
  smFrmBase in 'C:\Componentes\sum182\D15\Forms\FireMonkey\smFrmBase.pas' {frmBase},
  untTesteClientes in 'Testes\untTesteClientes.pas' {frmTesteClientes},
  untTesteFornecedores in 'Testes\untTesteFornecedores.pas' {frmTesteFornecedores},
  untTesteProduto in 'Testes\untTesteProduto.pas' {frmTesteProduto},
  untTesteString in 'Testes\untTesteString.pas' {frmTesteString},
  untTesteJsonFdMem in 'Testes\untTesteJsonFdMem.pas' {frmTesteJsonFdMem},
  untTesteJsonXSqLite in 'Testes\untTesteJsonXSqLite.pas' {frmTesteJsonXSqLite},
  Proxy in 'Proxy.pas',
  untLogin in 'untLogin.pas' {frmLogin},
  smCrypt in 'C:\Componentes\sum182\D15\Units\smCrypt.pas',
  smGeralFMX in 'C:\Componentes\sum182\D15\Units\FMX\smGeralFMX.pas';

{$R *.res}

begin
 Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TModuloCliente, ModuloCliente);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
