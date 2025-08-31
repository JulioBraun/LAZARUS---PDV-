unit unitPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, Menus, ComCtrls, StdCtrls, unitclientes, unitprodutos, unitvendapdv,
  unitlListaVendas, unitRelatorios,unitorcamentopdv,unitOrcamentoLista,unitUsuarios;

type

  { TFormPrincipal }

  TFormPrincipal = class(TForm)
    btUsuariosCadastro: TBitBtn;
    btOrcamentoLista: TBitBtn;
    BtOrcamentoPdv: TBitBtn;
    btRelatorios: TBitBtn;
    btListaVendas: TBitBtn;
    btTerminalPdv: TBitBtn;
    btProdutos: TBitBtn;
    btClientes: TBitBtn;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Panel1: TPanel;
    StatusBar2: TStatusBar;
    Timer1: TTimer;
    procedure btClientesClick(Sender: TObject);
    procedure btListaVendasClick(Sender: TObject);
    procedure btOrcamentoListaClick(Sender: TObject);
    procedure BtOrcamentoPdvClick(Sender: TObject);
    procedure btProdutosClick(Sender: TObject);
    procedure btRelatoriosClick(Sender: TObject);
    procedure btTerminalPdvClick(Sender: TObject);
    procedure btUsuariosCadastroClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

  private

  public

  end;

var
  FormPrincipal: TFormPrincipal;

implementation

 uses  unitLogin;

{$R *.lfm}



{ TFormPrincipal }

procedure TFormPrincipal.btClientesClick(Sender: TObject);
begin
  try
   Application.CreateForm(TFormClientes,FormClientes);
   FormClientes.ShowModal;
  finally
    FormClientes.Close;
  end;
end;

procedure TFormPrincipal.btListaVendasClick(Sender: TObject);
begin
  try
   Application.CreateForm(TFormListaVendas,FormListaVendas);
   FormListaVendas.ShowModal;
  finally
    FormListaVendas.Close;
end;
end;

procedure TFormPrincipal.btOrcamentoListaClick(Sender: TObject);
begin
   try
   Application.CreateForm(TFormOrcamentoLista,FormOrcamentoLista);
   FormOrcamentoLista.ShowModal;
  finally
    FormOrcamentoLista.Close;
  end;
end;

procedure TFormPrincipal.BtOrcamentoPdvClick(Sender: TObject);
begin
   try
   Application.CreateForm(TFormOrcamentoPDV,FormOrcamentoPDV);
   FormOrcamentoPDV.ShowModal;
  finally
    FormOrcamentoPDV.Close;
  end;
end;

procedure TFormPrincipal.btProdutosClick(Sender: TObject);
begin
  try
   Application.CreateForm(TFormProdutos,FormProdutos);
   FormProdutos.ShowModal;
  finally
    FormProdutos.Close;
  end;
end;

procedure TFormPrincipal.btRelatoriosClick(Sender: TObject);
begin
   try
   Application.CreateForm(TFormRelatorios,FormRelatorios);
   FormRelatorios.ShowModal;
  finally
    FormRelatorios.Close;

  end;
end;

procedure TFormPrincipal.btTerminalPdvClick(Sender: TObject);
begin
  try
   Application.CreateForm(TFormVendaPdv,FormVendaPdv);
   FormVendaPdv.ShowModal;
  finally
    FormVendaPdv.Close;
  end;
end;

procedure TFormPrincipal.btUsuariosCadastroClick(Sender: TObject);
begin
  try
   Application.CreateForm(TFormUsuarios,FormUsuarios);
   FormUsuarios.ShowModal;
  finally
    FormUsuarios.Close;
  end;
end;

procedure TFormPrincipal.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Application.Terminate;
end;
procedure TFormPrincipal.FormShow(Sender: TObject);
begin
   StatusBar2.Panels[1].Text:= 'Usuário Logado: ' + FormLogin.ZQueryLogin.FieldByName('LOGIN').AsString;
   StatusBar2.Panels[2].Text:= ' Robótica Criativa 3D Sistemas - SGE 1.0 versão 64 bits';
end;
procedure TFormPrincipal.MenuItem10Click(Sender: TObject);
begin
   try
   Application.CreateForm(TFormOrcamentoPDV,FormOrcamentoPDV);
   FormOrcamentoPDV.ShowModal;
  finally
    FormOrcamentoPDV.Close;
  end;
end;

procedure TFormPrincipal.MenuItem11Click(Sender: TObject);
begin
   try
   Application.CreateForm(TFormOrcamentoLista,FormOrcamentoLista);
   FormOrcamentoLista.ShowModal;
  finally
    FormOrcamentoLista.Close;
  end;
end;

procedure TFormPrincipal.MenuItem13Click(Sender: TObject);
begin
    try
   Application.CreateForm(TFormUsuarios,FormUsuarios);
   FormUsuarios.ShowModal;
  finally
    FormUsuarios.Close;
  end;
end;

procedure TFormPrincipal.MenuItem2Click(Sender: TObject);
begin
   try
   Application.CreateForm(TFormClientes,FormClientes);
   FormClientes.ShowModal;
  finally
    FormClientes.Close;
  end;
end;

procedure TFormPrincipal.MenuItem3Click(Sender: TObject);
begin
  try
   Application.CreateForm(TFormProdutos,FormProdutos);
   FormProdutos.ShowModal;
  finally
    FormProdutos.Close;
  end;
end;

procedure TFormPrincipal.MenuItem5Click(Sender: TObject);
begin
   try
   Application.CreateForm(TFormVendaPdv,FormVendaPdv);
   FormVendaPdv.ShowModal;
  finally
    FormVendaPdv.Close;
  end;
end;

procedure TFormPrincipal.MenuItem6Click(Sender: TObject);
begin
   try
   Application.CreateForm(TFormListaVendas,FormListaVendas);
   FormListaVendas.ShowModal;
  finally
    FormListaVendas.Close;
end;
end;

procedure TFormPrincipal.MenuItem7Click(Sender: TObject);
begin
    try
   Application.CreateForm(TFormRelatorios,FormRelatorios);
   FormRelatorios.ShowModal;
  finally
    FormRelatorios.Close;

  end;
end;

procedure TFormPrincipal.MenuItem8Click(Sender: TObject);
begin
   Application.Terminate;
end;

procedure TFormPrincipal.Panel1Click(Sender: TObject);
begin

end;

procedure TFormPrincipal.Panel2Click(Sender: TObject);
begin

end;

procedure TFormPrincipal.Timer1Timer(Sender: TObject);
begin
   StatusBar2.Panels[0].Text:= 'Hora:  '+timetostr(now)  +  '     Data:  '+FormatDateTime('dddddd', date);

end;

end.

