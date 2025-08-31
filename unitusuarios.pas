unit unitUsuarios;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  Buttons, StdCtrls, DBGrids, unitDM, minhas_funcoes, DB,LCLType;

type

  { TFormUsuarios }

  TFormUsuarios = class(TForm)
    btGravar: TBitBtn;
    btCancelar: TBitBtn;
    btExcluir: TBitBtn;
    btAlterar: TBitBtn;
    btIncluir: TBitBtn;
    btSair: TBitBtn;
    ComboBoxTipo: TComboBox;
    DSUsuarios: TDataSource;
    DBGrid1: TDBGrid;
    EditSenha: TEdit;
    EditLogin: TEdit;
    EditId: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    PaginaUsuarios: TPageControl;
    Panelusuario: TPanel;
    Tabfile: TTabSheet;
    TabUsuario: TTabSheet;
    procedure btAlterarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure ComboBoxTipoChange(Sender: TObject);
    procedure DSUsuariosDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LimpaCampos;
    procedure HabilitarCampos(valor:Boolean);
    procedure Hab_Botoes(sender:TObject);
    procedure Desab_Botoes(Sender:TObject);
    procedure TabfileShow(Sender: TObject);
    procedure BancosParaInterface;
  private

  public

  end;

var
  FormUsuarios: TFormUsuarios;
  situacao: integer;// situacao  = 1 (incluir)  / situacao = 2 (alterar)
implementation

{$R *.lfm}

{ TFormUsuarios }

procedure TFormUsuarios.btSairClick(Sender: TObject);
begin
  FormUsuarios.Close;
end;

procedure TFormUsuarios.btIncluirClick(Sender: TObject);
begin
  TabFile.TabVisible:=false;
  TabUsuario.TabVisible:=true;
  PaginaUsuarios.ActivePage:= (TabUsuario);
  situacao := 1;
  LimpaCampos;
  HabilitarCampos(true);
  Desab_Botoes(FormUsuarios);
  EditLogin.SetFocus;
end;

procedure TFormUsuarios.btAlterarClick(Sender: TObject);
begin
   Tabfile.TabVisible:=false;
   TabUsuario.TabVisible:=true;
   PaginaUsuarios.ActivePage:=(TabUsuario);
   Desab_Botoes(FormUsuarios);
   situacao := 2;
   HabilitarCampos(true);
   EditLogin.SetFocus;
end;

procedure TFormUsuarios.btCancelarClick(Sender: TObject);
begin
  Tabfile.TabVisible:=true;
  PaginaUsuarios.ActivePage:=(Tabfile);
  Tabfile.SetFocus;
  Hab_Botoes(FormUsuarios);
  HabilitarCampos(false);
end;

procedure TFormUsuarios.btExcluirClick(Sender: TObject);
  var
  id_login:integer;
begin
  if(Application.MessageBox('Confirma Exclusão deste Usuário?', ' Exclusão',
  MB_YesNo + MB_ICONINFORMATION)) = IDYES then
  begin

    id_login:= DM.ZQueryUsuarios.FieldByName('IDLOGIN').AsInteger;

    Excluir_usuarios(DM.ZQueryAux,id_login);
    end;

    exibir_usuarios(DM.ZQueryUsuarios);

    TabUsuario.TabVisible:=true;
    Tabfile.TabVisible:=true;
    PaginaUsuarios.ActivePage:=(Tabfile);

end;
procedure TFormUsuarios.btGravarClick(Sender: TObject);
begin
  if Application.MessageBox('Confirma a Inclusão ou Alteração deste Usuário?',
  'Confirmação',MB_YESNO + MB_ICONINFORMATION) = IDYES then
begin
     case situacao of
     1: // inclusão de novo cliente
begin
     Incluir_usuario(DM.ZQueryAux,EditLogin.Text, EditSenha.Text,
     ComboBoxTipo.Text);

     end;
     2: //alteração de um cliente
      begin
        Alterar_usuario(DM.ZQueryAux,EditLogin.Text, EditSenha.Text,
     ComboBoxTipo.Text, StrToInt(EditId.Text));

      end;
      end; // case

  end; // if

  TabUsuario.TabVisible:=true;
  Tabfile.TabVisible:= true;
  paginaUsuarios.ActivePage:= (Tabfile);
  Tabfile.SetFocus;
  Hab_Botoes(FormUsuarios);
  HabilitarCampos(false);
  situacao:= -1;

end;
procedure TFormUsuarios.ComboBoxTipoChange(Sender: TObject);
begin

end;

procedure TFormUsuarios.DSUsuariosDataChange(Sender: TObject; Field: TField);
begin
   try
     BancosParaInterface;
  except
    ShowMessage('Erro ao exibir dados do banco!');
  end;
end;

procedure TFormUsuarios.FormActivate(Sender: TObject);
begin
   Hab_Botoes(FormUsuarios);
end;

procedure TFormUsuarios.FormCreate(Sender: TObject);
begin
   PaginaUsuarios.ActivePage:=(Tabfile);
end;

procedure TFormUsuarios.FormShow(Sender: TObject);
begin
  situacao := -1;
end;

 procedure TFormUsuarios.LimpaCampos;
begin
  EditId.Caption:='';
  EditLogin.Caption:='';
  EditSenha.Caption:='';
  ComboBoxTipo.Caption:='administrador';

end;
  procedure TFormUsuarios.HabilitarCampos(valor:Boolean);
begin
   EditId.Enabled:=valor;
   EditLogin.Enabled:=valor;
   EditSenha.Enabled:=valor;
   ComboBoxTipo.Enabled:=valor;
   end;
  procedure TFormUsuarios.Hab_Botoes(Sender:TObject);
begin
   btIncluir.Enabled:= true;
   btAlterar.Enabled:=true;
   btExcluir.Enabled:=true;
   btCancelar.Enabled:=false;
   btGravar.Enabled:=false;
   btSair.Enabled:=true;

end;
  procedure TFormUsuarios.Desab_Botoes(Sender:TObject);
begin

   btIncluir.Enabled:= false;
   btAlterar.Enabled:=false;
   btExcluir.Enabled:=false;
   btCancelar.Enabled:=true;
   btGravar.Enabled:=true;
   btSair.Enabled:=false;

end;

procedure TFormUsuarios.TabfileShow(Sender: TObject);
begin
   try
       exibir_usuarios(DM.ZQueryUsuarios);
   except

     ShowMessage('Erro ao listar os clientes');

   end;


end;
procedure TFormUsuarios.BancosParaInterface;
begin
   EditId.text := DM.ZQueryUsuarios.FieldByName('IDLOGIN').AsString;
   EditLogin.Text:= DM.ZQueryUsuarios.FieldByName('LOGIN').AsString;
   EditSenha.Text:= DM.ZQueryUsuarios.FieldByName('SENHA').AsString;
   ComboBoxTipo.Text:=DM.ZQueryUsuarios.FieldByName('TIPO').AsString;
   end;

  end.

