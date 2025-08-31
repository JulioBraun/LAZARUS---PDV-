unit unitlListaVendas;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, FileUtil,
  minhas_funcoes, unitDM, LR_Class, LR_DBSet, ZDataset, ZAbstractRODataset, DB,
  LCLType, DBGrids, Buttons;

type

  { TFormListaVendas }

  TFormListaVendas = class(TForm)
    btImprimir: TBitBtn;
    btExcluirVenda: TBitBtn;
    btSair: TBitBtn;
    DSRelVenda: TDataSource;
    DSAux: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    frDBDataSetRelVenda: TfrDBDataSet;
    frReportRelVenda: TfrReport;
    Label1: TLabel;
    Label2: TLabel;
    ZQrelVenda: TZQuery;
    ZQrelVendaIDPRODUTO: TZIntegerField;
    ZQrelVendaID_ITEM: TZIntegerField;
    ZQrelVendaNOME_PRODUTO: TZRawStringField;
    ZQrelVendaPRECO_VENDA: TZDoubleField;
    ZQrelVendaQUANTIDADE: TZDoubleField;
    ZQrelVendaSUB_TOTAL: TZDoubleField;
    procedure btExcluirVendaClick(Sender: TObject);
    procedure btImprimirClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure DSAuxDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FormListaVendas: TFormListaVendas;

implementation

{$R *.lfm}

{ TFormListaVendas }

procedure TFormListaVendas.FormShow(Sender: TObject);
begin
  exibir_vendas(DM.ZQueryVendas);
end;

procedure TFormListaVendas.DSAuxDataChange(Sender: TObject; Field: TField);
begin

  try
     exibir_itens_venda(DM.ZQueryItem, DM.ZQueryVendas.FieldByName('IDVENDA').AsInteger);

  except

  end;
end;

procedure TFormListaVendas.btSairClick(Sender: TObject);
begin
  FormListaVendas.Close;
end;

procedure TFormListaVendas.btExcluirVendaClick(Sender: TObject);
begin
  if(Application.MessageBox('Confirma a Exclusão desta Venda?','Exclusão',
  MB_YESNO + MB_ICONINFORMATION)) = IDYES then
  begin
     DM.ZQueryItem.First;

     while not(DM.ZQueryItem.EOF) do    // atualiza estoque
     begin
       aumenta_estoque_produto(DM.ZQueryAux,
       DM.ZQueryItem.FieldByName('IDPRODUTO').AsInteger,
       DM.ZQueryItem.FieldByName('QUANTIDADE').AsFloat);
                                       // remover item venda
       Exclui_Item_venda(DM.ZQueryAux,DM.ZQueryItem.FieldByName('ID_ITEM').AsInteger);

       DM.ZQueryItem.Next;

     end;  //While

     excluir_venda(DM.ZQueryAux,DM.ZQueryVendas.FieldByName('IDVENDA').AsInteger);

     exibir_vendas(DM.ZQueryVendas);

  end; //if
end;

procedure TFormListaVendas.btImprimirClick(Sender: TObject);
var
  data_venda,cliente_venda,valor_total,desconto,valor_pago: TfrObject;
  begin
    try
    exibir_itens_venda(ZQRelVenda, DM.ZQueryVendas.FieldByName('IDVENDA').AsInteger);
    ZQRelVenda.Open;
    frReportRelVenda.LoadFromFile('RelVendaIndividual.lrf');

    data_venda:= frReportRelVenda.FindObject('MemoData');
    data_venda.Memo.Text := DM.ZQueryVendas.FieldByName('DATA').AsString;

    cliente_venda:= frReportRelVenda.FindObject('MemoCliente');
    Cliente_venda.Memo.Text := DM.ZQueryVendas.FieldByName('NOME_CLIENTE').AsString;

    valor_total:= frReportRelVenda.FindObject('MemoValorTotal');
    valor_total.Memo.Text := DM.ZQueryVendas.FieldByName('VALORTOTAL').AsString;

    desconto:= frReportRelVenda.FindObject('MemoDesconto');
    desconto.Memo.Text := DM.ZQueryVendas.FieldByName('DESCONTO').AsString;

    valor_pago:= frReportRelVenda.FindObject('MemoValorPago');
    valor_pago.Memo.Text := DM.ZQueryVendas.FieldByName('VALORPAGO').AsString;

    frReportRelVenda.ShowReport;
    ZQRelVenda.Close;

    except
        ShowMessage(' Erro ao geral o relatório individual de vendas!');
        Exit;

    end;
end;

end.

