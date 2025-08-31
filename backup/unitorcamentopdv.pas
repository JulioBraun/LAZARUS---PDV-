unit unitorcamentopdv;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  Grids, Buttons, ZDataset, ZAbstractRODataset, DateTimePicker, unitDM,
  minhas_funcoes,LCLType;

type

  { TFormOrcamentoPDV }

  TFormOrcamentoPDV = class(TForm)
    btSairOrcamento: TBitBtn;
    btGravarOrcamento: TBitBtn;
    btExcluirProdutoOrcamento: TBitBtn;
    btIncluirOrcamento: TBitBtn;
    DSListaProdutosOrcamento: TDataSource;
    DBLookupComboBoxProdutoOrcamento: TDBLookupComboBox;
    DSListaOrcamento: TDataSource;
    DBLookupComboBoxOrcamento: TDBLookupComboBox;
    DtpData: TDateTimePicker;
    EditDescontoOrcamento: TEdit;
    EditQuantidadeOrcamento: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LabelValorOrcamento: TLabel;
    LabelOrcamentoTotal: TLabel;
    StringGridProdutosOrcamento: TStringGrid;
    ZQueryProdutosOrcamento: TZQuery;
    ZQueryClientesOrcamento: TZQuery;
    ZQueryClientesOrcamentoCELULAR: TZRawStringField;
    ZQueryClientesOrcamentoCEP: TZRawStringField;
    ZQueryClientesOrcamentoCIDADE: TZRawStringField;
    ZQueryClientesOrcamentoENDERECO: TZRawStringField;
    ZQueryClientesOrcamentoESTADO: TZRawStringField;
    ZQueryClientesOrcamentoIDCLIENTE: TZIntegerField;
    ZQueryClientesOrcamentoNOME: TZRawStringField;
    ZQueryProdutosOrcamentoDESCRICAO: TZRawStringField;
    ZQueryProdutosOrcamentoESTOQUE: TZDoubleField;
    ZQueryProdutosOrcamentoIDPRODUTO: TZIntegerField;
    ZQueryProdutosOrcamentoPRECOCUSTO: TZDoubleField;
    ZQueryProdutosOrcamentoPRECOVENDA: TZDoubleField;
    procedure btExcluirProdutoOrcamentoClick(Sender: TObject);
    procedure btGravarOrcamentoClick(Sender: TObject);
    procedure btIncluirOrcamentoClick(Sender: TObject);
    procedure btSairOrcamentoClick(Sender: TObject);
    procedure EditDescontoOrcamentoExit(Sender: TObject);
    procedure EditDescontoOrcamentoKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);

  private

  public

  end;

var
  FormOrcamentoPDV: TFormOrcamentoPDV;

implementation

{$R *.lfm}

{ TFormOrcamentoPDV }

procedure TFormOrcamentoPDV.FormShow(Sender: TObject);
begin
   ZQueryClientesOrcamento.Open;

   ZQueryProdutosOrcamento.Open;

   DtpData.Date:= now;

end;

procedure TFormOrcamentoPDV.btIncluirOrcamentoClick(Sender: TObject);
 var
quantidade_linhas:integer;
valorTotalorcamento: Double; // Use Double ou Currency para valores monetários
subtotalItemorcamento: Double;
begin
try
  StrToFloat(EditQuantidadeOrcamento.Text);

 except
  ShowMessage('Informe um valor válido para quantidade!');
  EditQuantidadeOrcamento.SetFocus;
  Exit;
 end;

 if (StrToFloat(EditQuantidadeOrcamento.Text) <= 0) then
 begin
  ShowMessage('Informe um valor Positivo para quantidade!');
  EditQuantidadeOrcamento.SetFocus;
  Exit;
 end;

  quantidade_linhas:= StringGridProdutosOrcamento.RowCount -1;
  StringGridProdutosOrcamento.RowCount:=  StringGridProdutosOrcamento.RowCount  + 1;

  // Calculo do subtotal antes de formatar para string
  subtotalItemorcamento := StrToFloat(EditQuantidadeOrcamento.text) * ZQueryProdutosOrcamento.FieldByName('PRECOVENDA').AsFloat;

  StringGridProdutosOrcamento.Cells[0,quantidade_linhas] := ZQueryProdutosOrcamento.FieldByName('IDPRODUTO').AsString;
  StringGridProdutosOrcamento.Cells[1,quantidade_linhas] := ZQueryProdutosOrcamento.FieldByName('DESCRICAO').AsString;
  StringGridProdutosOrcamento.Cells[2,quantidade_linhas] := ZQueryProdutosOrcamento.FieldByName('PRECOVENDA').AsString;
  StringGridProdutosOrcamento.Cells[3,quantidade_linhas] := EditQuantidadeOrcamento.Text;
  StringGridProdutosOrcamento.Cells[4,quantidade_linhas] :=
  FormatFloat('#,##0.00',StrToFloat(EditQuantidadeOrcamento.Text) * ZQueryProdutosOrcamento.FieldByName('PRECOVENDA').AsFloat);

 try
   // LIMPE O PONTO DE MILHAR ANTES DE CONVERTER LabelValorTotal.Caption
    // O ponto é o separador de milhares no formato '#,##0.00' para a localidade brasileira.
    // Substitua o ponto por uma string vazia para que StrToFloat funcione corretamente.
    valorTotalOrcamento := StrToFloat(StringReplace(LabelOrcamentoTotal.Caption, '.', '', [rfReplaceAll]));


    // Use o valor numérico do subtotalItem, não a string formatada da StringGrid
    LabelorcamentoTotal.Caption := FloatToStr(valorTotalOrcamento + subtotalItemorcamento);

 //  LabelOrcamentoTotal.Caption:= FloatToStr(StrTofloat(LabelOrcamentoTotal.Caption) +
 // StrToFloat(StringGridProdutosOrcamento.Cells[4,quantidade_linhas]));

  LabelValorOrcamento.Caption:= LabelOrcamentoTotal.Caption;

 except
  ShowMessage ('erro ao calcular o valor total do orçamento!');
  Exit;

end;

end;

procedure TFormOrcamentoPDV.btSairOrcamentoClick(Sender: TObject);
begin
 if (Application.MessageBox('Sair da tela de Orçamento ? ',  ' Saida',
 MB_YESNO + MB_ICONINFORMATION)) = IdYes then
begin
 FormOrcamentoPDV.Close;

end;

    end;

procedure TFormOrcamentoPDV.btExcluirProdutoOrcamentoClick(Sender: TObject);
var
   linha:integer;

begin
   linha:= StringGridProdutosOrcamento.Row;

  try
    LabelOrcamentoTotal.Caption:= FloatToStr(
    StrToFloat(LabelOrcamentoTotal.Caption) -
    StrToFloat(StringGridProdutosOrcamento.Cells[4,linha]));

  except
     ShowMessage('Erro ao calcular o valor total do orçamento!');
     Exit;

  end;

    EditDescontoOrcamento.text := '0,0';
    LabelValorOrcamento.Caption:= LabelOrcamentoTotal.Caption;

    StringGridProdutosOrcamento.DeleteRow(linha);
end;

procedure TFormOrcamentoPDV.btGravarOrcamentoClick(Sender: TObject);
 var
  codigo_orcamento,linha: integer;
  idproduto,descricao,precovenda,quantidade,subtotal: string;
  begin
    if application.MessageBox('Confirma a Inclusão deste orçamento?','Confirma',
    Mb_YesNo + Mb_ICONINFORMATION) = IdYes then
    begin
       // verifica se existem produtos no orçamento
       if(StringGridProdutosOrcamento.RowCount <=2) then
       begin
          ShowMessage('o orçamento deve possuir produtos!');
          Exit;
       end;
       // verifica se foi selecionado cliente

       if (DBLookupComboBoxOrcamento.Caption = '') then
       begin
          ShowMessage('o orçamento dever possuir um cliente!');
          Exit;
       end;

  incluir_orcamento(DM.ZQueryOrcamento,
  ZQueryClientesOrcamento.FieldByName('IDCLIENTE').AsInteger,DtpData.Date,
  StrToFloat(LabelOrcamentoTotal.Caption),StrToFloat(EditDescontoOrcamento.text),
  StrToFloat(LabelValorOrcamento.Caption));

  codigo_orcamento:= codigo_ultimo_orcamento(DM.ZQueryAUX);

   // incluir os itens do orçamento

   linha:= StringGridProdutosOrcamento.RowCount;

   for linha:= 1 to StringGridProdutosOrcamento.RowCount -2 do

   begin
     Idproduto:= StringGridProdutosOrcamento.Cells[0,linha];
     quantidade:= StringGridProdutosOrcamento.Cells[3,linha];

 incluir_itemorcamento(DM.ZQueryItemOrcamento,codigo_orcamento, StrToInt(IdProduto),
 StrToFloat(quantidade));

  //diminuir estoque

 // diminuir_Estoque_Produto(DM.ZQueryItemorcamento, StrToInt(idproduto),StrToFloat(quantidade));

    end;

   ShowMessage ('orçamento salvo com sucesso!');
   FormOrcamentoPDV.Close;

    end;

end;

procedure TFormOrcamentoPDV.EditDescontoOrcamentoExit(Sender: TObject);
begin
    try
   StrToFloat(EditDescontoOrcamento.text);

  Except
    ShowMessage('Informe um valor válido para o desconto!');
    EditDescontoOrcamento.SetFocus;
    Exit;

  end;
    LabelValorOrcamento.Caption:= FloatToStr(StrToFloat(LabelOrcamentoTotal.Caption) -
    StrToFloat(EditDescontoOrcamento.text));
end;

procedure TFormOrcamentoPDV.EditDescontoOrcamentoKeyPress(Sender: TObject; var Key: char);
begin

 if key=#13 then
 begin
  SelectNext(ActiveControl as TWinControl, True, True);
  key:=#0

 end;
end;

end.


