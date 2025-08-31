unit minhas_funcoes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,sqldb,ZDataset;

Procedure exibir_clientes(Query:TZQuery);

Procedure Incluir_Cliente(Query:TZQuery;Nome:String;Endereco:String;
  Cidade:String;Estado:String;Celular:String;CEP:String;Cpf:String;
  Email:String);

Procedure Alterar_Cliente(Query:TZQuery;Nome:String;Endereco:String;
  Cidade:String;Estado:String;Celular:String;CEP:String;
  Cpf:String;Email:String; Id:integer);

Procedure Excluir_Cliente(Query:TZQuery; Id: integer);
//=================================================
Procedure exibir_produtos(query:TZQuery);

Procedure incluir_produto(query:TZQuery;Descricao:String;Estoque:Double;
  precoCusto:Double;precoVenda:Double);

Procedure Alterar_produto(query:TZQuery;Descricao:String;Estoque:Double;
  precoCusto:Double;precoVenda:Double;Id:Integer);

procedure Excluir_Produto(Query:TZQuery; Id:integer);

procedure incluir_venda(Query:TZQuery; IdCliente:integer;DataVenda:TDate;
  valorTotal:Double;Desconto:Double;ValorPago:Double);

function  codigo_ultima_venda(Query:TZQuery):integer;

procedure incluir_item(Query:TZQuery;IdVenda:integer; IdProduto:integer;
  quantidade:double);

procedure diminuir_Estoque_Produto(Query:TZQuery;IdProduto:integer;quantidade:Double);

procedure exibir_vendas(Query:TZQuery);

procedure exibir_itens_venda(Query:TZQuery;IdVenda: integer);

procedure excluir_venda(Query:TZQuery;Id:integer);

procedure aumenta_estoque_produto(Query:TZQuery;idProduto:integer;quantidade:Double);

procedure Exclui_Item_venda(Query:TZQuery;id:integer);
// --------------------------------------------------------------------

procedure incluir_orcamento(Query:TZQuery; IdCliente:integer;DataVenda:TDate;
  valorTotal:Double;Desconto:Double;ValorPago:Double);

function  codigo_ultimo_orcamento(Query:TZQuery):integer;

procedure incluir_itemorcamento(Query:TZQuery;Idorcamento:integer; IdProduto:integer;
  quantidade:double);

procedure exibir_orcamentos(Query:TZQuery);

procedure exibir_itens_orcamento(Query:TZQuery;Idorcamento: integer);

procedure excluir_orcamento(Query:TZQuery;Id:integer);

procedure atualiza_estoque_produto(Query:TZQuery;idProduto:integer;quantidade:Double);

procedure Exclui_Item_orcamento(Query:TZQuery;id:integer);

//--------------------------------------------------------------------------
Procedure exibir_usuarios(Query:TZQuery);

Procedure Incluir_usuario(Query:TZQuery;Login:String;Senha:String;
  Tipo:String);

Procedure Alterar_usuario(Query:TZQuery;Login:String;Senha:String;
  Tipo:String; id:Integer);

Procedure Excluir_usuarios(Query:TZQuery; Id: integer);

implementation
Procedure exibir_clientes(Query:TZQuery);
Begin
   Query.Close;
   Query.SQL.Clear;
   Query.SQL.Add('SELECT * FROM cliente');
   Query.ExecSQL;
   Query.Open;

end;
Procedure Incluir_Cliente(Query:TZQuery;Nome:String;Endereco:String;
  Cidade:String; Estado:String;Celular:String;CEP:String;Cpf:String;Email:String);
begin
   Query.Close;
   Query.SQL.Clear;
   Query.SQL.Add('INSERT INTO cliente(NOME,ENDERECO,CIDADE,ESTADO,CELULAR,CEP,CPF)');
   Query.SQL.Add(' VALUES(:NOME,:ENDERECO,:CIDADE,:ESTADO,:CELULAR,:CEP,:CPF,:EMAIL)');

   Query.Params[0].AsString := Nome;
   Query.Params[1].AsString := Endereco;
   Query.Params[2].AsString := Cidade;
   Query.Params[3].AsString := Estado;
   Query.Params[4].AsString := Celular;
   Query.Params[5].AsString := CEP;
   Query.Params[6].AsString := CPF;
   Query.Params[6].AsString := EMAIL;

   Query.ExecSQL;

end;

Procedure Alterar_Cliente(Query:TZQuery;Nome:String;Endereco:String;
  Cidade:String; Estado:String;Celular:String;CEP:String;CPF:String;
  Email:String;  Id:integer);
begin
   Query.Close;
   Query.SQL.Clear;
   Query.SQL.Add('UPDATE cliente SET NOME=:NOME,ENDERECO=:ENDERECO,CIDADE=:CIDADE,');
   Query.SQL.Add('ESTADO=:ESTADO,CELULAR=:CELULAR,CEP=:CEP,CPF=:CPF,EMAIL=:EMAIL');
   Query.SQL.Add('WHERE IDCLIENTE =:ID');

   Query.Params[0].AsString := Nome;
   Query.Params[1].AsString := Endereco;
   Query.Params[2].AsString := Cidade;
   Query.Params[3].AsString := Estado;
   Query.Params[4].AsString := Celular;
   Query.Params[5].AsString := CEP;
   Query.Params[6].AsString := CPF;
   Query.Params[7].AsString := EMAIL;
   Query.Params[8].AsInteger := ID;

   Query.ExecSQL;

end;

Procedure Excluir_Cliente(Query:TZQuery; Id: integer);
begin
   Query.Close;
   Query.SQL.Clear;
   Query.SQL.Add('DELETE FROM cliente WHERE IDCLIENTE=:ID');

   Query.Params[0].AsInteger:= ID;

   Query.ExecSQL;

end;

Procedure exibir_produtos(query:TZQuery);
begin
   Query.Close;
   Query.SQL.Clear;
   Query.SQL.Add('SELECT * FROM produto');
   Query.ExecSQL;
   Query.Open;

end;

Procedure incluir_produto(query:TZQuery;Descricao:String;Estoque:Double;
  precoCusto:Double;precoVenda:Double);
begin
   Query.Close;
   Query.Sql.Clear;
   Query.Sql.Add('INSERT INTO produto(DESCRICAO,ESTOQUE,PRECOCUSTO,PRECOVENDA) ');
   Query.Sql.Add('VALUES(:DESCRICAO,:ESTOQUE,:PRECOCUSTO,:PRECOVENDA) ');

   Query.Params[0].AsString:=Descricao;
   Query.Params[1].AsFloat:= Estoque;
   Query.Params[2].AsFloat:= PrecoCusto;
   Query.Params[3].AsFloat:= precoVenda;

   Query.ExecSQL;


end;

Procedure Alterar_produto(query:TZQuery;Descricao:String;Estoque:Double;
  precoCusto:Double;precoVenda:Double;Id:Integer);
begin
   Query.Close;
   query.Sql.Clear;
   Query.Sql.Add('UPDATE produto SET DESCRICAO=:DESCRICAO,ESTOQUE=:ESTOQUE,');
   Query.Sql.Add('PRECOCUSTO=:PRECOCUSTO,PRECOVENDA=:PRECOVENDA');
   Query.Sql.Add(' WHERE IDPRODUTO=:ID');

   Query.Params[0].AsString:=Descricao;
   Query.Params[1].AsFloat:= Estoque;
   Query.Params[2].AsFloat:= PrecoCusto;
   Query.Params[3].AsFloat:= precoVenda;
   Query.Params[4].AsInteger:= iD;

   Query.ExecSQL;

end;

procedure Excluir_Produto(Query:TZQuery; Id:integer);
begin
   Query.Close;
   Query.SQL.Clear;
   Query.SQL.Add('DELETE FROM produto WHERE IDPRODUTO =:ID');

   Query.Params[0].AsInteger:= Id;
   Query.ExecSQL;

end;

procedure incluir_venda(Query:TZQuery; IdCliente:integer;DataVenda:TDate;
valorTotal:Double;Desconto:Double;ValorPago:Double);
 begin
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('INSERT INTO venda(ID_CLIENTE,DATA,VALORTOTAL,VALORPAGO,DESCONTO)');
    Query.SQL.Add('VALUES (:ID_CLIENTE,:DATA,:VALORTOTAL,:VALORPAGO,:DESCONTO)');

   Query.Params[0].AsInteger:=IdCliente;
   Query.Params[1].AsDate:= DataVenda;
   Query.Params[2].AsFloat:= ValorTotal;
   Query.Params[3].AsFloat:= ValorPago;
   Query.Params[4].AsFloat:= Desconto;

   Query.ExecSQL;

 end;

function  codigo_ultima_venda(Query:TZQuery):integer;
   begin
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT LAST_INSERT_ID() AS RESULTADO FROM venda');

    Query.ExecSQL;
    Query.Open;

    Result:=Query.FieldValues['RESULTADO'];
    Query.Close;

   end;
   procedure incluir_item(Query:TZQuery;IdVenda:integer; IdProduto:integer;
  quantidade:double);
   begin
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('INSERT INTO item(ID_VENDA,ID_PRODUTO,QUANTIDADE)');
    Query.SQL.Add('VALUES (:ID_VENDA,:ID_PRODUTO,:QUANTIDADE)');

   Query.Params[0].AsInteger:= IdVenda;
   Query.Params[1].AsInteger:= IdProduto;
   Query.Params[2].AsFloat:= quantidade;

   Query.ExecSQL;


   end;

   procedure diminuir_Estoque_Produto(Query:TZQuery;IdProduto:integer;quantidade:Double);
   begin
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('UPDATE produto SET ESTOQUE = ESTOQUE - :QUANTIDADE');
    Query.SQL.Add('WHERE IDPRODUTO=:IDPRODUTO');

   Query.Params[0].AsFloat:= quantidade;
   Query.Params[1].AsInteger:= IdProduto;

   Query.ExecSQL;

   end;

  procedure exibir_vendas(Query:TZQuery);

  begin
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT distinct V.IDVENDA, V.ID_CLIENTE,V.DATA,V.VALORTOTAL,');
    Query.SQL.Add('V.VALORPAGO,V.DESCONTO,C.NOME AS NOME_CLIENTE');
    Query.SQL.Add('FROM venda V, cliente C WHERE V.ID_CLIENTE = C.IDCLIENTE');
    Query.ExecSQL;
    Query.Open;

end;
 procedure exibir_itens_venda(Query:TZQuery;IdVenda: integer);
 begin
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT distinct I.IDITEM as ID_ITEM,P.IDPRODUTO as IDPRODUTO,');
    Query.SQL.Add('P.DESCRICAO as NOME_PRODUTO,I.QUANTIDADE as QUANTIDADE,');
    Query.SQL.Add('P.PRECOVENDA as PRECO_VENDA,');
    Query.SQL.Add('(I.QUANTIDADE * P.PRECOVENDA) as SUB_TOTAL');
    Query.SQL.Add('FROM produto P, venda V, item I');
    Query.SQL.Add('WHERE (I.ID_VENDA = V.IDVENDA) and (I.ID_PRODUTO = P.IDPRODUTO)');
    Query.SQL.Add('and (V.IDVENDA=:IDVENDA)');

    Query.Params [0].AsInteger := Idvenda;

    Query.ExecSQL;
    Query.Open;

   end;

  procedure excluir_venda(Query:TZQuery;Id:integer);
  begin
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('DELETE FROM venda WHERE IDVENDA=:ID');
    Query.Params[0].AsInteger := ID;
    Query.ExecSQL;

  end;
  procedure aumenta_estoque_produto(Query:TZQuery;idProduto:integer;quantidade:Double);
  begin
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('UPDATE produto SET ESTOQUE = ESTOQUE + :QUANTIDADE');
    Query.SQL.Add('WHERE IDPRODUTO=:IDPRODUTO');

   Query.Params[0].AsFloat:= quantidade;
   Query.Params[1].AsInteger:= IdProduto;

   Query.ExecSQL;
  end;
 procedure Exclui_Item_venda(Query:TZQuery;id:integer);
 begin
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('DELETE FROM item WHERE IDITEM=:ID');
    Query.Params[0].AsInteger:= id;
    Query.ExecSQL;

     end;
  procedure incluir_orcamento(Query:TZQuery; IdCliente:integer;DataVenda:TDate;
  valorTotal:Double;Desconto:Double;ValorPago:Double);
  begin
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('INSERT INTO orcamento(ID_CLIENTE,DATA,VALORTOTAL,VALORPAGO,DESCONTO)');
    Query.SQL.Add('VALUES (:ID_CLIENTE,:DATA,:VALORTOTAL,:VALORPAGO,:DESCONTO)');

   Query.Params[0].AsInteger:=IdCliente;
   Query.Params[1].AsDate:= DataVenda;
   Query.Params[2].AsFloat:= ValorTotal;
   Query.Params[3].AsFloat:= ValorPago;
   Query.Params[4].AsFloat:= Desconto;

   Query.ExecSQL;

  end;
 function  codigo_ultimo_orcamento(Query:TZQuery):integer;
   begin
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT last_insert_id() AS RESULTADO FROM orcamento');

    Query.ExecSQL;
    Query.Open;

    Result:=Query.FieldValues['RESULTADO'];
    Query.Close;

   end;
 procedure incluir_itemorcamento(Query:TZQuery;Idorcamento:integer;IdProduto:integer;
 quantidade:double);
    begin
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('INSERT INTO itemorcamento(ID_ORCAMENTO,ID_PRODUTO,QUANTIDADE)');
    Query.SQL.Add('VALUES (:ID_ORCAMENTO,:ID_PRODUTO,:QUANTIDADE)');

   Query.Params[0].AsInteger:=IdOrcamento;
   Query.Params[1].AsInteger:= IdProduto;
   Query.Params[2].AsFloat:= quantidade;

   Query.ExecSQL;
   end;
  procedure exibir_orcamentos(Query:TZQuery);
  begin
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT distinct V.IDORCAMENTO, V.ID_CLIENTE,V.DATA,V.VALORTOTAL,');
    Query.SQL.Add('V.VALORPAGO,V.DESCONTO,C.NOME AS NOME_CLIENTE');
    Query.SQL.Add('FROM orcamento V, cliente C WHERE V.ID_CLIENTE = C.IDCLIENTE');
    Query.ExecSQL;
    Query.Open;

  end;
 procedure exibir_itens_orcamento(Query:TZQuery;Idorcamento: integer);
 begin
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT distinct I.IDITEMORCAMENTO as ID_ITEMORCAMENTO,P.IDPRODUTO as IDPRODUTO,');
    Query.SQL.Add('P.DESCRICAO as NOME_PRODUTO,I.QUANTIDADE as QUANTIDADE,');
    Query.SQL.Add('P.PRECOVENDA as PRECO_VENDA,');
    Query.SQL.Add('(I.QUANTIDADE * P.PRECOVENDA) as SUB_TOTAL');
    Query.SQL.Add('FROM produto P, orcamento V, itemorcamento I');
    Query.SQL.Add('WHERE (I.ID_ORCAMENTO = V.IDORCAMENTO) and (I.ID_PRODUTO = P.IDPRODUTO)');
    Query.SQL.Add('and (V.IDORCAMENTO=:IDORCAMENTO)');

    Query.Params [0].AsInteger := Idorcamento;

    Query.ExecSQL;
    Query.Open;
   end;
 procedure excluir_orcamento(Query:TZQuery;Id:integer);
 begin
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('DELETE FROM orcamento WHERE IDORCAMENTO=:ID');
    Query.Params[0].AsInteger := ID;
    Query.ExecSQL;

 end;
 procedure atualiza_estoque_produto(Query:TZQuery;idProduto:integer;quantidade:Double);
 begin
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('UPDATE produto SET ESTOQUE = :QUANTIDADE');
    Query.SQL.Add('WHERE IDPRODUTO=:IDPRODUTO');

   Query.Params[0].AsFloat:= quantidade;
   Query.Params[1].AsInteger:= IdProduto;

   Query.ExecSQL;

    end;

   procedure Exclui_Item_orcamento(Query:TZQuery;id:integer);
   begin
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('DELETE FROM itemorcamento WHERE IDITEMORCAMENTO=:ID');
    Query.Params[0].AsInteger:= id;
    Query.ExecSQL;

   end;
  Procedure exibir_usuarios(Query:TZQuery);
 begin
   Query.Close;
   Query.SQL.Clear;
   Query.SQL.Add('SELECT * FROM login');
   Query.ExecSQL;
   Query.Open;
 end;
 Procedure Incluir_usuario(Query:TZQuery;Login:String;Senha:String;
  Tipo:String);
 begin
   Query.Close;
   Query.SQL.Clear;
   Query.SQL.Add('INSERT INTO login(LOGIN,SENHA,TIPO)');
   Query.SQL.Add(' VALUES(:LOGIN,:SENHA,:TIPO)');

   Query.Params[0].AsString := Login;
   Query.Params[1].AsString := Senha;
   Query.Params[2].AsString := Tipo;

   Query.ExecSQL;
 end;
  Procedure Alterar_usuario(Query:TZQuery;Login:String;Senha:String;
  Tipo:String;Id:Integer);

  begin
   Query.Close;
   Query.SQL.Clear;
   Query.SQL.Add('UPDATE login SET LOGIN=:LOGIN,SENHA=:SENHA,TIPO=:TIPO,');
   Query.SQL.Add(' WHERE IDLOGIN =:ID');

   Query.Params[0].AsString := Login;
   Query.Params[1].AsString := Senha;
   Query.Params[2].AsString := Tipo;

   Query.ExecSQL;
  end;
   Procedure Excluir_usuarios(Query:TZQuery; Id: integer);
begin
   Query.Close;
   Query.SQL.Clear;
   Query.SQL.Add('DELETE FROM login WHERE IDLOGIN=:ID');

   Query.Params[0].AsInteger:= ID;

   Query.ExecSQL;
end;
        end.


