unit unitOrcamentoLista;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, FileUtil,
  minhas_funcoes, unitDM, LR_Class, LR_DBSet, ZDataset, ZAbstractRODataset, DB,
  LCLType, DBGrids, Buttons;

type

  { TFormOrcamentoLista }

  TFormOrcamentoLista = class(TForm)
    btImprimirOrcamento: TBitBtn;
    btExcluirorcamento: TBitBtn;
    btSair: TBitBtn;
    DSImprimeOrcamento: TDataSource;
    DSauxListaOrcamento: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    frDBDataSetImprimeOrcamento: TfrDBDataSet;
    frReportImprimeOrcamento: TfrReport;
    Label1: TLabel;
    Label2: TLabel;
    ZQueryImprimeOrcamento: TZQuery;
    ZQueryImprimeOrcamentoIDPRODUTO: TZIntegerField;
    ZQueryImprimeOrcamentoID_ITEMORCAMENTO: TZIntegerField;
    ZQueryImprimeOrcamentoNOME_PRODUTO: TZRawStringField;
    ZQueryImprimeOrcamentoPRECO_VENDA: TZDoubleField;
    ZQueryImprimeOrcamentoQUANTIDADE: TZDoubleField;
    ZQueryImprimeOrcamentoSUB_TOTAL: TZDoubleField;
    procedure btExcluirorcamentoClick(Sender: TObject);
    procedure btImprimirOrcamentoClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure DSauxListaOrcamentoDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FormOrcamentoLista: TFormOrcamentoLista;

implementation

{$R *.lfm}

{ TFormOrcamentoLista }

procedure TFormOrcamentoLista.FormShow(Sender: TObject);
begin
   exibir_orcamentos(DM.ZQueryOrcamento);

end;

procedure TFormOrcamentoLista.DSauxListaOrcamentoDataChange(Sender: TObject;
  Field: TField);
begin
   exibir_itens_orcamento(DM.ZQueryItemOrcamento,DM.ZQueryOrcamento.FieldByName('IDORCAMENTO').AsInteger);
end;

procedure TFormOrcamentoLista.btSairClick(Sender: TObject);
begin
  FormOrcamentoLista.Close;
end;

procedure TFormOrcamentoLista.btExcluirorcamentoClick(Sender: TObject);
begin
  if (Application.MessageBox('Confirma a Exclusão deste Orçamento?', 'Exclusão',
  MB_YESNO + MB_ICONINFORMATION)) = IDYES then
  begin
     DM.ZQueryItemOrcamento.First;

  // atualiza estoque

    while not(DM.ZQueryItemOrcamento.EOF) do
    begin
    atualiza_estoque_produto(DM.ZQueryAux,
    DM.ZQueryItemOrcamento.FieldByName('IDPRODUTO').AsInteger,
    DM.ZQueryItemOrcamento.FieldByName('QUANTIDADE').AsFloat);

  // remover item venda
       Exclui_Item_orcamento(DM.ZQueryAux,DM.ZQueryItemOrcamento.FieldByName('ID_ITEMORCAMENTO').AsInteger);

       DM.ZQueryItemOrcamento.Next;

     end;  //While

     excluir_orcamento(DM.ZQueryAux,DM.ZQueryOrcamento.FieldByName('IDORCAMENTO').AsInteger);

     exibir_orcamentos(DM.ZQueryOrcamento);

end;

  end;

procedure TFormOrcamentoLista.btImprimirOrcamentoClick(Sender: TObject);
  var
  data_orcamento,cliente_orcamento,valor_total,desconto,valor_pago: TfrObject;
begin
     try
    exibir_itens_orcamento(ZQueryImprimeOrcamento, DM.ZQueryOrcamento.FieldByName('IDORCAMENTO').AsInteger);
    ZQueryImprimeOrcamento.Open;
    frReportImprimeOrcamento.LoadFromFile('RelOrcamentoIndividual.lrf');

    data_orcamento:= frReportImprimeOrcamento.FindObject('MemoData');
    data_orcamento.Memo.Text := DM.ZQueryOrcamento.FieldByName('DATA').AsString;

    cliente_orcamento:= frReportImprimeOrcamento.FindObject('MemoCliente');
    Cliente_orcamento.Memo.Text := DM.ZQueryOrcamento.FieldByName('NOME_CLIENTE').AsString;

    valor_total:= frReportImprimeOrcamento.FindObject('MemoValorTotal');
    valor_total.Memo.Text := DM.ZQueryOrcamento.FieldByName('VALORTOTAL').AsString;

    desconto:= frReportImprimeOrcamento.FindObject('MemoDesconto');
    desconto.Memo.Text := DM.ZQueryOrcamento.FieldByName('DESCONTO').AsString;

    valor_pago:= frReportImprimeOrcamento.FindObject('MemoValorPago');
    valor_pago.Memo.Text := DM.ZQueryOrcamento.FieldByName('VALORPAGO').AsString;

    frReportImprimeOrcamento.ShowReport;
    ZQueryImprimeOrcamento.Close;

    except
        ShowMessage(' Erro ao geral o relatório individual de Orçamento!');
        Exit;
end;
          end;


end.

