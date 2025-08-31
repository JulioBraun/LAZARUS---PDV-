unit unitvendapdv;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, StdCtrls, DbCtrls, Grids, Buttons, ZDataset,unitDM,minhas_funcoes,LCLType;

type

  { TFormVendaPdv }

  TFormVendaPdv = class(TForm)
    btSair: TBitBtn;
    btGravar: TBitBtn;
    btExcluirProduto: TBitBtn;
    btIncluirProduto: TBitBtn;
    DSListaProdutos: TDataSource;
    DBLookupComboBoxProduto: TDBLookupComboBox;
    DSListaClientes: TDataSource;
    DBLookupComboBoxCliente: TDBLookupComboBox;
    DtpData: TDateTimePicker;
    EditDesconto: TEdit;
    EditQuantidade: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LabelValorPago: TLabel;
    LabelValorTotal: TLabel;
    StringGridProdutos: TStringGrid;
    ZQListaClientes: TZQuery;
    ZQListaClientesCELULAR: TStringField;
    ZQListaClientesCEP: TStringField;
    ZQListaClientesCIDADE: TStringField;
    ZQListaClientesENDERECO: TStringField;
    ZQListaClientesESTADO: TStringField;
    ZQListaClientesIDCLIENTE: TLongintField;
    ZQListaClientesNOME: TStringField;
    ZQListaProdutos: TZQuery;
    ZQListaProdutosDESCRICAO: TStringField;
    ZQListaProdutosESTOQUE: TFloatField;
    ZQListaProdutosIDPRODUTO: TLongintField;
    ZQListaProdutosPRECOCUSTO: TFloatField;
    ZQListaProdutosPRECOVENDA: TFloatField;
    procedure btExcluirProdutoClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btIncluirProdutoClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure EditDescontoExit(Sender: TObject);
    procedure EditDescontoKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FormVendaPdv: TFormVendaPdv;

implementation

{$R *.lfm}

{ TFormVendaPdv }

procedure TFormVendaPdv.FormShow(Sender: TObject);
begin

  ZQListaClientes.Open;

  ZQListaProdutos.Open;

  DtpData.Date:= now;

end;

procedure TFormVendaPdv.btIncluirProdutoClick(Sender: TObject);
var
  quantidade_linhas: integer;
  valorTotalAtual: Double; // Use Double ou Currency para valores monetários
  subtotalItem: Double;
begin
  try
    StrToFloat(EditQuantidade.text);
  except
    ShowMessage('Informe o valor válido para a quantidade!');
    EditQuantidade.Setfocus;
    Exit;
  end;

  if (StrToFloat(EditQuantidade.text) <= 0) then
  begin
    ShowMessage('Informe um valor positivo para a quantidade!');
    EditQuantidade.Setfocus;
    Exit;
  end;

  quantidade_linhas := StringGridProdutos.RowCount - 1;
  StringGridProdutos.RowCount := StringGridProdutos.RowCount + 1;

  // Calculo do subtotal antes de formatar para string
  subtotalItem := StrToFloat(EditQuantidade.text) * ZQListaProdutos.FieldByName('PRECOVENDA').AsFloat;

  StringGridProdutos.Cells[0, quantidade_linhas] := ZQListaProdutos.FieldByName('IDPRODUTO').AsString;
  StringGridProdutos.Cells[1, quantidade_linhas] := ZQListaProdutos.FieldByName('DESCRICAO').AsString;
  StringGridProdutos.Cells[2, quantidade_linhas] := ZQListaProdutos.FieldByName('PRECOVENDA').AsString;
  StringGridProdutos.Cells[3, quantidade_linhas] := EditQuantidade.text;
  StringGridProdutos.Cells[4, quantidade_linhas] := FormatFloat('#,##0.00', subtotalItem); // Aqui formata para exibição

  try
    // LIMPE O PONTO DE MILHAR ANTES DE CONVERTER LabelValorTotal.Caption
    // O ponto é o separador de milhares no formato '#,##0.00' para a localidade brasileira.
    // Substitua o ponto por uma string vazia para que StrToFloat funcione corretamente.
    valorTotalAtual := StrToFloat(StringReplace(LabelValorTotal.Caption, '.', '', [rfReplaceAll]));

    // Use o valor numérico do subtotalItem, não a string formatada da StringGrid
    LabelValorTotal.Caption := FloatToStr(valorTotalAtual + subtotalItem);

    LabelValorPago.Caption := LabelValorTotal.Caption; // Manter a consistência

  except
    ShowMessage('Erro ao calcular o valor total da venda!');
    Exit;
  end;
end;

procedure TFormVendaPdv.btSairClick(Sender: TObject);
begin
  if (Application.MessageBox('Sair da tela de Vendas ? ',' Saida',
  MB_YESNO +  MB_ICONINFORMATION)) = IdYes then
  begin
  FormVendaPdv.Close;
end;
    end;

procedure TFormVendaPdv.btExcluirProdutoClick(Sender: TObject);
var
  linha:integer;

begin
  linha:= StringGridProdutos.Row;

  try
    LabelValorTotal.Caption:= FloatToStr(
    StrToFloat(LabelValorTotal.Caption) -
    StrToFloat(StringGridProdutos.Cells[4,linha]));

  except
     ShowMessage('Erro ao calcular o valor total da venda!');
     Exit;

  end;

    EditDesconto.text := '0,0';
    LabelValorPago.Caption:= LabelValorTotal.Caption;

    StringGridProdutos.DeleteRow(linha);
end;

procedure TFormVendaPdv.btGravarClick(Sender: TObject);
var
  codigo_venda,linha: integer;
  idproduto,descricao,precovenda,quantidade,subtotal: string;
  begin
    if application.MessageBox('Confirma a Inclusão desta venda?','Confirma',
    Mb_YesNo + Mb_ICONINFORMATION) = IdYes then
    begin
       // verifica se existem produtos na venda
       if(StringGridProdutos.RowCount <=2) then
       begin
          ShowMessage('a venda deve possuir produtos!');
          Exit;
       end;
       // verifica se foi selecionado cliente

       if (DBLookupComboBoxCliente.Caption = '') then
       begin
          ShowMessage('a venda dever possuir um cliente!');
          Exit;
       end;


  incluir_venda(DM.ZQueryVendas,
  ZQListaClientes.FieldByName('IDCLIENTE').AsInteger,DtpData.Date,
  StrToFloat(LabelValorTotal.Caption),StrToFloat(EditDesconto.text),
  StrToFloat(LabelValorPago.Caption));

  codigo_venda:= codigo_ultima_venda(DM.ZQueryAUX);

   // incluir os itens da venda

   for linha:= 1 to StringGridProdutos.RowCount -2 do

   begin
     Idproduto:= StringGridProdutos.Cells[0,linha];
     quantidade:= StringGridProdutos.Cells[3,linha];

  incluir_item(DM.ZQueryItem, codigo_venda,StrToInt(idproduto),
  StrToFloat(quantidade));

  //diminuir estoque

  diminuir_Estoque_Produto(DM.ZQueryItem, StrToInt(idproduto),StrToFloat(quantidade));

    end;

   ShowMessage ('Venda salva com sucesso!');
    FormVendaPdv.Close;

    end;

  end;

procedure TFormVendaPdv.EditDescontoExit(Sender: TObject);
begin
  try
   StrToFloat(EditDesconto.text);

  Except
    ShowMessage('Informe um valor válido para o desconto!');
    EditDesconto.SetFocus;
    Exit;

  end;
    LabelValorPago.Caption:= FloatToStr(StrToFloat(LabelValorTotal.Caption) -
    StrToFloat(EditDesconto.text));


end;

procedure TFormVendaPdv.EditDescontoKeyPress(Sender: TObject; var Key: char);
begin

  if key=#13 then
  begin
      selectNext(ActiveControl as TwinControl,True,True);
      key:=#0;
  end;




end;




         end.


