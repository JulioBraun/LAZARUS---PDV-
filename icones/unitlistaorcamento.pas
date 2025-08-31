unit unitListaOrcamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, FileUtil,
  minhas_funcoes, unitDM, LR_Class, LR_DBSet, ZDataset, ZAbstractRODataset, DB,
  LCLType, DBGrids, Buttons;

type

  { TFormListaOrcamento }

  TFormListaOrcamento = class(TForm)
    DBGrid1: TDBGrid;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FormListaOrcamento: TFormListaOrcamento;

implementation

{$R *.lfm}

{ TFormListaOrcamento }

procedure TFormListaOrcamento.FormShow(Sender: TObject);
begin
   exibir_orcamentos(DM.ZQueryOrcamento);
end;

end.

