program Atualizador;

uses
  Forms,
  fPrincipal in 'fPrincipal.pas' {fAtualiza};
  

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Atualizador autom�tico de m�dulos';
  Application.CreateForm(TfAtualiza, fAtualiza);
  Application.Run;
end.
