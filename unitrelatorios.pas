unit unitRelatorios;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, FileUtil, LR_Class, LR_DBSet, Controls, Graphics,
  Dialogs, StdCtrls, Buttons, ZDataset, ZAbstractRODataset, minhas_funcoes,
  unitDM, DB, LR_DSet;

type

  { TFormRelatorios }

  TFormRelatorios = class(TForm)
    btSair: TBitBtn;
    btImprimir: TBitBtn;
    ComboBoxRelatorio: TComboBox;
    DSRelOrcamento: TDataSource;
    DSProdutos: TDataSource;
    DSVendas: TDataSource;
    DSClientes: TDataSource;
    frDBDataSetRelOrcamento: TfrDBDataSet;
    frDBDataSetProdutos: TfrDBDataSet;
    frDBDataSetVendas: TfrDBDataSet;
    frDBDataSetClientes: TfrDBDataSet;
    frReportRelOrcamento: TfrReport;
    frReportProdutos: TfrReport;
    frReportVendas: TfrReport;
    frReportClientes: TfrReport;
    Label1: TLabel;
    ZQClientes: TZQuery;
    ZQClientesCELULAR: TZRawStringField;
    ZQClientesCEP: TZRawStringField;
    ZQClientesCIDADE: TZRawStringField;
    ZQClientesENDERECO: TZRawStringField;
    ZQClientesESTADO: TZRawStringField;
    ZQClientesIDCLIENTE: TZIntegerField;
    ZQClientesNOME: TZRawStringField;
    ZQProdutos: TZQuery;
    ZQProdutosDESCRICAO: TZRawStringField;
    ZQProdutosESTOQUE: TZDoubleField;
    ZQProdutosIDPRODUTO: TZIntegerField;
    ZQProdutosPRECOCUSTO: TZDoubleField;
    ZQProdutosPRECOVENDA: TZDoubleField;
    ZQRelOrcamento: TZQuery;
    ZQVendas: TZQuery;
    ZQVendasDATA: TZDateField;
    ZQVendasDESCONTO: TZDoubleField;
    ZQVendasIDVENDA: TZIntegerField;
    ZQVendasID_CLIENTE: TZIntegerField;
    ZQVendasNOME_CLIENTE: TZRawStringField;
    ZQVendasVALORPAGO: TZDoubleField;
    ZQVendasVALORTOTAL: TZDoubleField;
    procedure btImprimirClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure ComboBoxRelatorioChange(Sender: TObject);
    procedure frDBDataSetRelOrcamentoCheckEOF(Sender: TObject; var Eof: Boolean
      );
    procedure frDBDataSetVendasCheckEOF(Sender: TObject; var Eof: Boolean);
  private

  public

  end;

var
  FormRelatorios: TFormRelatorios;

implementation

{$R *.lfm}

{ TFormRelatorios }

procedure TFormRelatorios.btSairClick(Sender: TObject);
begin
   FormRelatorios.Close;
end;

procedure TFormRelatorios.ComboBoxRelatorioChange(Sender: TObject);
begin

end;

procedure TFormRelatorios.frDBDataSetRelOrcamentoCheckEOF(Sender: TObject;
  var Eof: Boolean);
begin

end;

procedure TFormRelatorios.frDBDataSetVendasCheckEOF(Sender: TObject;
  var Eof: Boolean);
begin

end;

procedure TFormRelatorios.btImprimirClick(Sender: TObject);
begin

  if ComboBoxRelatorio.Text= 'Clientes' then             //relatório e clientes
  begin
    try
      exibir_clientes(ZQClientes);
      ZQClientes.Open;
      frReportClientes.LoadFromFile('RelClientes.lrf');
      frReportClientes.ShowReport;
      ZQClientes.Close;

    except
      ShowMessage('Erro ao gerar Relatório de Clientes');
      Exit;
      end;

  end
   else if   ComboBoxRelatorio.text = 'Vendas' then      // relatório de vendas
   begin
     try
       exibir_vendas(ZQVendas);
       ZQVendas.Open;

        frReportVendas.LoadFromFile('RelListaVendas.lrf');
        frReportVendas.ShowReport;
        ZQVendas.Close;

     except
       ShowMessage('Erro ao gerar Relatório de Vendas!');
       Exit;
       end;

    end
   else if   ComboBoxRelatorio.text = 'Orçamentos' then      // relatório de orçamentos
    begin
     try
       exibir_orcamentos(ZQRelOrcamento);
       ZQRelOrcamento.Open;

        frReportRelOrcamento.LoadFromFile('RelListaOrcamentos.lrf');
        frReportRelOrcamento.ShowReport;
        ZQRelOrcamento.Close;

     except
       ShowMessage('Erro ao gerar Relatório de Orçamentos!');
       Exit;
       end;


    end
     else      //relatório de produtos
     begin
       try
          exibir_produtos(ZQProdutos);

          ZQProdutos.Open;

          frReportProdutos.LoadFromFile('RelProdutos.lrf');
          frReportProdutos.ShowReport;
          ZQProdutos.Close;
          except
            ShowMessage('Erro ao gerar Relatório de Produtos!');
            Exit;
   end;

      end;

end;

end.

