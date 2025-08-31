unit unitDM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, odbcconn, FileUtil, ZConnection, ZDataset;

type

  { TDM }

  TDM = class(TDataModule)
    DataSourceUsuarios: TDataSource;
    DataSourceItemOrcamento: TDataSource;
    DataSourceOrcamento: TDataSource;
    DataSourceItem: TDataSource;
    DataSourceVendas: TDataSource;
    DataSourceProduto: TDataSource;
    DataSourceAux: TDataSource;
    DataSourceCliente: TDataSource;
    ODBCConnection1: TODBCConnection;
    ZConnection1: TZConnection;
    ZQueryUsuarios: TZQuery;
    ZQueryItemOrcamento: TZQuery;
    ZQueryOrcamento: TZQuery;
    ZQueryItem: TZQuery;
    ZQueryVendas: TZQuery;
    ZQueryProduto: TZQuery;
    ZQueryAux: TZQuery;
    ZQueryCliente: TZQuery;
    procedure ZConnection1AfterConnect(Sender: TObject);
  private

  public

  end;

var
  DM: TDM;

implementation

{$R *.lfm}

{ TDM }

procedure TDM.ZConnection1AfterConnect(Sender: TObject);
begin

end;

end.

