program projectPrincipal;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, zcomponent, unitPrincipal, unitclientes, minhas_funcoes,
  unitDM, unitprodutos, unitvendapdv, unitlListaVendas, unitRelatorios, 
unitLogin, unitorcamentopdv, unitOrcamentoLista, unitUsuarios;
  { you can add units after this }

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormOrcamentoPDV, FormOrcamentoPDV);
  Application.CreateForm(TFormOrcamentoLista, FormOrcamentoLista);
  Application.CreateForm(TFormUsuarios, FormUsuarios);
  Application.Run;
end.

