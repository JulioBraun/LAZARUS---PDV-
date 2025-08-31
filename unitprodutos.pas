unit unitprodutos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, Buttons, StdCtrls, MaskEdit, DBGrids,unitDM,minhas_funcoes, db,
  LCLType;

type

  { TFormProdutos }

  TFormProdutos = class(TForm)
    btGravar: TBitBtn;
    btCancelar: TBitBtn;
    btExcluir: TBitBtn;
    btAlterar: TBitBtn;
    btIncluir: TBitBtn;
    btSair: TBitBtn;
    DSProduto: TDataSource;
    DBGrid1: TDBGrid;
    EditPrecoVenda: TEdit;
    EditPrecoCusto: TEdit;
    EditEstoque: TEdit;
    EditDescricao: TEdit;
    EditId: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Pagina1: TPageControl;
    Panel1: TPanel;
    TabArquivo: TTabSheet;
    TabDadosProduto: TTabSheet;
    procedure btAlterarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure DSProdutoDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LimpaCampos;
    procedure HabilitarCampos(valor:Boolean);
    procedure Hab_Botoes(sender:TObject);
    procedure Desab_Botoes(Sender:TObject);
    procedure TabArquivoShow(Sender: TObject);
    procedure BancosParaInterface;

  private

  public

  end;

var
  FormProdutos: TFormProdutos;
  situacao: integer;// situacao  = 1 (incluir)  / situacao = 2 (alterar)

implementation

{$R *.lfm}

{ TFormProdutos }

procedure TFormProdutos.btSairClick(Sender: TObject);
begin
  FormProdutos.Close;
end;

procedure TFormProdutos.DSProdutoDataChange(Sender: TObject; Field: TField);
begin
  try
     BancosParaInterface;
  except
    ShowMessage('Erro ao exibir dados do banco!');
  end;
end;

procedure TFormProdutos.btIncluirClick(Sender: TObject);
begin
  TabArquivo.TabVisible:=false;
  TabDadosProduto.TabVisible:=true;
  Pagina1.ActivePage:= (TabDadosProduto);
  situacao := 1;
  LimpaCampos;
  HabilitarCampos(true);
  Desab_Botoes(FormProdutos);
  EditDescricao.SetFocus;


end;

procedure TFormProdutos.btAlterarClick(Sender: TObject);
begin
   TabArquivo.TabVisible:=false;
   TabDadosProduto.TabVisible:=true;
   Pagina1.ActivePage:=(TabDadosProduto);
   Desab_Botoes(FormProdutos);
   situacao := 2;
   HabilitarCampos(true);
   EditDescricao.SetFocus;

end;

procedure TFormProdutos.btCancelarClick(Sender: TObject);
begin
  TabArquivo.TabVisible:=true;
  Pagina1.ActivePage:=(TabArquivo);
  TabArquivo.SetFocus;
  Hab_Botoes(FormProdutos);
  HabilitarCampos(false);
end;

procedure TFormProdutos.btExcluirClick(Sender: TObject);
var
  id_produto:integer;
begin
  if(Application.MessageBox('Confirma Exclusão deste Produto ?', ' Exclusão',
  MB_YesNo + MB_ICONINFORMATION)) = IDYES then
  begin

    id_produto:= DM.ZQueryProduto.FieldByName('IDPRODUTO').AsInteger;

      Excluir_Produto(DM.ZQueryAux,id_produto);
  end;

    exibir_produtos(DM.ZQueryProduto);

    TabDadosProduto.TabVisible:=true;
    TabArquivo.TabVisible:=true;
    Pagina1.ActivePage:=(TabArquivo);

end;

procedure TFormProdutos.btGravarClick(Sender: TObject);
begin
  if Application.MessageBox('Confirma a Inclusão ou Alteração deste Produto?',
  'Confirmação',MB_YESNO + MB_ICONINFORMATION) = IDYES then
  begin

      //tratamento do valor do campo estoque

      try
         StrToFloat(EditEstoque.text);

      except

        ShowMessage('Informe um valor numérico para o Estoque');
        Exit;
      end;

      //tratamento do valor do preço de custo

      try
         StrToFloat(EditPrecoCusto.text);

      except

        ShowMessage('Informe um valor numérico para o Preço de Custo');
        Exit;
      end;

       //tratamento do valor do preço de venda

      try
         StrToFloat(EditPrecoVenda.text);

      except

        ShowMessage('Informe um valor numérico para o Preço de Venda');
        Exit;
      end;



     case situacao of
     1: // inclusão de novo produto
      begin


          Incluir_produto(Dm.ZQueryAux,EditDescricao.Text,
           StrToFloat(EditEstoque.Text),StrToFloat(EditPrecoCusto.Text),
           StrToFloat(EditPrecoVenda.Text) )


      end;
     2: //alteração de um produto
      begin

           alterar_produto(Dm.ZQueryAux,EditDescricao.Text,
           StrToFloat(EditEstoque.Text),StrToFloat(EditPrecoCusto.Text),
           StrToFloat(EditPrecoVenda.Text), STrToInt(EditId.text) )


      end;

     end; // case

  end; // if

  TabDadosProduto.TabVisible:=true;
  TabArquivo.TabVisible:= true;
  pagina1.ActivePage:= (TabArquivo);
  TabArquivo.SetFocus;
  Hab_Botoes(FormProdutos);
  HabilitarCampos(false);
  situacao:= -1;


end;

procedure TFormProdutos.FormActivate(Sender: TObject);
begin
  Hab_Botoes(FormProdutos);
end;

procedure TFormProdutos.FormCreate(Sender: TObject);
begin
  Pagina1.ActivePage:=(TabArquivo);
end;

procedure TFormProdutos.FormShow(Sender: TObject);
begin
  situacao := -1;
end;

procedure TFormProdutos.LimpaCampos;
begin
  EditId.Caption:='';
  EditDescricao.Caption:='';
  EditEstoque.Caption:='';
  EditPrecoCusto.Caption:='';
  EditPrecoVenda.Caption:='';


end;

procedure TFormProdutos.HabilitarCampos(valor:Boolean);
begin
  // EditId.Enabled:=valor;
   EditDescricao.Enabled:=valor;
   EditEstoque.Enabled:=valor;
   EditPrecoCusto.Enabled:=valor;
   EditPrecoVenda.Enabled:=valor;



end;

procedure TFormProdutos.Hab_Botoes(Sender:TObject);
begin
   btIncluir.Enabled:= true;
   btAlterar.Enabled:=true;
   btExcluir.Enabled:=true;
   btCancelar.Enabled:=false;
   btGravar.Enabled:=false;
   btSair.Enabled:=true;

end;

procedure TFormProdutos.Desab_Botoes(Sender:TObject);
begin

   btIncluir.Enabled:= false;
   btAlterar.Enabled:=false;
   btExcluir.Enabled:=false;
   btCancelar.Enabled:=true;
   btGravar.Enabled:=true;
   btSair.Enabled:=false;

end;

procedure TFormProdutos.TabArquivoShow(Sender: TObject);
begin
   try
       exibir_produtos(DM.ZQueryProduto);
   except

     ShowMessage('Erro ao listar os produtos');

   end;


end;

procedure TFormProdutos.BancosParaInterface;
begin
   EditId.text := DM.ZQueryProduto.FieldByName('IDPRODUTO').AsString;
   EditDescricao.Text:= DM.ZQueryProduto.FieldByName('DESCRICAO').AsString;
   EditEstoque.text:= DM.ZQueryProduto.FieldByName('ESTOQUE').AsString;
   EditPrecoCusto.text:= DM.ZQueryProduto.FieldByName('PRECOCUSTO').AsString;
   EditPrecoVenda.text:= DM.ZQueryProduto.FieldByName('PRECOVENDA').AsString;

end;

end.

