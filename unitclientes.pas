unit unitclientes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, Buttons, StdCtrls, MaskEdit, DBGrids,unitDM,minhas_funcoes, db,
  LCLType;

type

  { TFormClientes }

  TFormClientes = class(TForm)
    btGravar: TBitBtn;
    btCancelar: TBitBtn;
    btExcluir: TBitBtn;
    btAlterar: TBitBtn;
    btIncluir: TBitBtn;
    btSair: TBitBtn;
    ComboBoxEstado: TComboBox;
    DSCliente: TDataSource;
    DBGrid1: TDBGrid;
    EditEmail: TEdit;
    EditCidade: TEdit;
    EditEndereco: TEdit;
    EditNome: TEdit;
    EditId: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    MaskEditCPF: TMaskEdit;
    MaskEditCEP: TMaskEdit;
    MaskEditCelular: TMaskEdit;
    Pagina1: TPageControl;
    Panel1: TPanel;
    TabArquivo: TTabSheet;
    TabDadosCliente: TTabSheet;
    procedure btAlterarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure DSClienteDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LimpaCampos;
    procedure HabilitarCampos(valor:Boolean);
    procedure Hab_Botoes(sender:TObject);
    procedure Desab_Botoes(Sender:TObject);
    procedure MaskEditCelularChange(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure TabArquivoShow(Sender: TObject);
    procedure BancosParaInterface;

  private

  public

  end;

var
  FormClientes: TFormClientes;
  situacao: integer;// situacao  = 1 (incluir)  / situacao = 2 (alterar)

implementation

{$R *.lfm}

{ TFormClientes }

procedure TFormClientes.btSairClick(Sender: TObject);
begin
  FormClientes.Close;
end;

procedure TFormClientes.DSClienteDataChange(Sender: TObject; Field: TField);
begin
  try
     BancosParaInterface;
  except
    ShowMessage('Erro ao exibir dados do banco!');
  end;
end;

procedure TFormClientes.btIncluirClick(Sender: TObject);
begin
  TabArquivo.TabVisible:=false;
  TabDadosCliente.TabVisible:=true;
  Pagina1.ActivePage:= (TabDadosCliente);
  situacao := 1;
  LimpaCampos;
  HabilitarCampos(true);
  Desab_Botoes(FormClientes);
  EditNome.SetFocus;

end;

procedure TFormClientes.btAlterarClick(Sender: TObject);
begin
   TabArquivo.TabVisible:=false;
   TabDadosCliente.TabVisible:=true;
   Pagina1.ActivePage:=(TabDadosCliente);
   Desab_Botoes(FormClientes);
   situacao := 2;
   HabilitarCampos(true);
   EditNome.SetFocus;
end;

procedure TFormClientes.btCancelarClick(Sender: TObject);
begin
  TabArquivo.TabVisible:=true;
  Pagina1.ActivePage:=(TabArquivo);
  TabArquivo.SetFocus;
  Hab_Botoes(FormClientes);
  HabilitarCampos(false);
end;

procedure TFormClientes.btExcluirClick(Sender: TObject);
var
  id_cliente:integer;
begin
  if(Application.MessageBox('Confirma Exclusão deste Cliente ?', ' Exclusão',
  MB_YesNo + MB_ICONINFORMATION)) = IDYES then
  begin

    id_cliente:= DM.ZQueryCliente.FieldByName('IDCLIENTE').AsInteger;

      Excluir_Cliente(DM.ZQueryAux,id_cliente);
  end;

    exibir_clientes(DM.ZQueryCliente);

    TabDadosCliente.TabVisible:=true;
    TabArquivo.TabVisible:=true;
    Pagina1.ActivePage:=(TabArquivo);

end;

procedure TFormClientes.btGravarClick(Sender: TObject);
begin
  if Application.MessageBox('Confirma a Inclusão ou Alteração deste Cliente?',
  'Confirmação',MB_YESNO + MB_ICONINFORMATION) = IDYES then
  begin
     case situacao of
     1: // inclusão de novo cliente
      begin
          Incluir_Cliente(Dm.ZQueryAux,EditNome.Text, EditEndereco.Text,
          EditCidade.Text, ComboBoxEstado.Text, MaskEditCelular.Text,
           MaskEditCEP.Text, MaskEditCPF.Text, EditEmail.Text);
      end;
     2: //alteração de um cliente
      begin
          Alterar_Cliente(Dm.ZQueryAux,EditNome.Text, EditEndereco.Text,
          EditCidade.Text, ComboBoxEstado.Text, MaskEditCelular.Text,
           MaskEditCEP.Text, MaskEditCPF.Text, EditEmail.Text, StrToInt(EditId.Text));
      end;

     end; // case

  end; // if

  TabDadosCliente.TabVisible:=true;
  TabArquivo.TabVisible:= true;
  pagina1.ActivePage:= (TabArquivo);
  TabArquivo.SetFocus;
  Hab_Botoes(FormClientes);
  HabilitarCampos(false);
  situacao:= -1;


end;

procedure TFormClientes.FormActivate(Sender: TObject);
begin
  Hab_Botoes(FormClientes);
end;

procedure TFormClientes.FormCreate(Sender: TObject);
begin
  Pagina1.ActivePage:=(TabArquivo);
end;

procedure TFormClientes.FormShow(Sender: TObject);
begin
  situacao := -1;
end;

procedure TFormClientes.LimpaCampos;
begin
  EditId.Caption:='';
  EditNome.Caption:='';
  EditEndereco.Caption:='';
  EditCidade.Caption:='';
  ComboBoxEstado.Caption:='AC';
  MaskEditCelular.Caption:='';
  MaskEditCEP.Caption:='';
  MaskEditCPF.Caption:='';
  EditEmail.Caption:='';

end;

procedure TFormClientes.HabilitarCampos(valor:Boolean);
begin
   EditId.Enabled:=valor;
   EditNome.Enabled:=valor;
   EditEndereco.Enabled:=valor;
   EditCidade.Enabled:=valor;
   ComboBoxEstado.Enabled:=valor;
   MaskEditCelular.Enabled:=valor;
   MaskEditCEP.Enabled:=valor;
   MaskEditCPF.Enabled:=valor;
   EditEmail.Enabled:=valor;
end;

procedure TFormClientes.Hab_Botoes(Sender:TObject);
begin
   btIncluir.Enabled:= true;
   btAlterar.Enabled:=true;
   btExcluir.Enabled:=true;
   btCancelar.Enabled:=false;
   btGravar.Enabled:=false;
   btSair.Enabled:=true;

end;

procedure TFormClientes.Desab_Botoes(Sender:TObject);
begin

   btIncluir.Enabled:= false;
   btAlterar.Enabled:=false;
   btExcluir.Enabled:=false;
   btCancelar.Enabled:=true;
   btGravar.Enabled:=true;
   btSair.Enabled:=false;

end;

procedure TFormClientes.MaskEditCelularChange(Sender: TObject);
begin

end;

procedure TFormClientes.Panel1Click(Sender: TObject);
begin

end;

procedure TFormClientes.TabArquivoShow(Sender: TObject);
begin
   try
       exibir_clientes(DM.ZQueryCliente);
   except

     ShowMessage('Erro ao listar os clientes');

   end;


end;

procedure TFormClientes.BancosParaInterface;
begin
   EditId.text := DM.ZQueryCliente.FieldByName('IDCLIENTE').AsString;
   EditNome.Text:= DM.ZQueryCliente.FieldByName('NOME').AsString;
   EditEndereco.Text:= DM.ZQueryCliente.FieldByName('ENDERECO').AsString;
   EditCidade.Text:= DM.ZQueryCliente.FieldByName('CIDADE').AsString;
   ComboBoxEstado.Text:=DM.ZQueryCliente.FieldByName('ESTADO').AsString;
   MaskEditCelular.Text:=DM.ZQueryCliente.FieldByName('CELULAR').AsString;
   MaskEditCEP.Text:=DM.ZQueryCliente.FieldByName('CEP').AsString;
   MaskEditCPF.Text:=DM.ZQueryCliente.FieldByName('CPF').AsString;
   EditEmail.Text:=DM.ZQueryCliente.FieldByName('EMAIL').AsString;

end;

end.

