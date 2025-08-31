unit unitLogin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, ZDataset, ZAbstractRODataset, unitDM;

type

  { TFormLogin }

  TFormLogin = class(TForm)
    btEntrar: TBitBtn;
    btLimpar: TBitBtn;
    btSair: TBitBtn;
    EditSenha: TEdit;
    EditLogin: TEdit;
    GroupBoxLogin: TGroupBox;
    Image1: TImage;
    Image2: TImage;
    ZQueryLogin: TZQuery;
    ZQueryLoginLOGIN: TZRawStringField;
    ZQueryLoginSENHA: TZRawStringField;
    procedure btEntrarClick(Sender: TObject);
    procedure btLimparClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure EditSenhaKeyPress(Sender: TObject; var Key: char);

  private
  tentativa : integer;
  public

  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.lfm}

uses unitPrincipal;

{ TFormLogin }

procedure TFormLogin.btLimparClick(Sender: TObject);
begin
  EditLogin.Clear;
  EditSenha.Clear;
  EditLogin.SetFocus;
end;

procedure TFormLogin.btEntrarClick(Sender: TObject);
begin
  with ZQueryLogin do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT LOGIN, SENHA FROM login WHERE LOGIN = :PLOGIN AND SENHA =:PSENHA');
    ParamByName('PLOGIN').AsString:=EditLogin.text;
    ParamByName('PSENHA').AsString:=EditSenha.text;
    open;
    if ZQueryLogin.RecordCount > 0 then begin
    FormPrincipal.ShowModal


    end
    else begin
      ShowMessage('Login ou Senha invalidos');
      inc(tentativa);
      if tentativa = 3 then FormLogin.close;

    end;

  end;
end;

procedure TFormLogin.btSairClick(Sender: TObject);
begin
  Close;
end;
procedure TFormLogin.EditSenhaKeyPress(Sender: TObject; var Key: char);
begin
  begin
  if key = #13 then
  begin
    SelectNext(Sender as tWinControl, true, true);
    key := #0;
end;
 end;
    end;

end.
