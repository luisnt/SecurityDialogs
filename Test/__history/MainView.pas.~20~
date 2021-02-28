unit MainView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls,

  Security.User, Security.Matrix, Security.Permission, Security.ChangePassword, Security.Login, Security.Manage

    ;

type
  TForm2 = class(TForm)
    FlowPanel: TFlowPanel;
    ButtonLogin: TButton;
    ButtonChangePassword: TButton;
    ButtonPermission: TButton;
    ButtonMatrix: TButton;
    ButtonUser: TButton;
    ButtonManage: TButton;
    MemoEvent: TMemo;
    Manage: TSecurityManage;
    Login: TSecurityLogin;
    ChangePassword: TSecurityChangePassword;
    Permission: TSecurityPermission;
    Matrix: TSecurityMatrix;
    User: TSecurityUser;
    procedure ButtonLoginClick(Sender: TObject);
    procedure OnAuthenticate(const aEmail, aPassword: string; var aAuthenticated: Boolean; var aEmailError, aPasswordError: string);
    procedure OnResult(const aResult: Boolean);
    procedure ButtonChangePasswordClick(Sender: TObject);
    procedure OnChangePassword(const aID: Int64; const aNewPassword: string; var aError: string; var aChanged: Boolean);
    procedure ButtonPermissionClick(Sender: TObject);
    procedure OnPermission(aID: Int64; aCan, aName: string; var aError: string; var aChanged: Boolean);
    procedure ButtonDevClick(Sender: TObject);
    procedure ButtonMatrixClick(Sender: TObject);
    procedure MatrixMatrix(aID: Int64; aName, aEmail: string; aActive: Boolean; aPassword: string; aMatrixID: Integer; aIsMatrix: Boolean; var aError: string; var aChanged: Boolean);
  private
    procedure SetLog(Legend: Variant; const Value: Variant);
    { Private declarations }
  public
    { Public declarations }
    property Log[Legend: Variant]: Variant write SetLog;
  end;

var
  Form2: TForm2;

implementation

uses System.Hash;

{$R *.dfm}


procedure TForm2.SetLog(Legend: Variant; const Value: Variant);
begin
  MemoEvent.Lines.Append(
    Format('%20-s = %s', [VarToStr(Legend), VarToStr(Value)])
    );
end;

procedure TForm2.ButtonDevClick(Sender: TObject);
begin
  Log['LOCAL'] := TButton(Sender).Name + ' Em Desenvolvimento';
end;

procedure TForm2.ButtonLoginClick(Sender: TObject);
begin
  with Manage do
  begin
    // Legendas
    Login.ServerIP   := '192.168.0.1';
    Login.ComputerIP := '192.168.0.12';
    Login.Sigla      := 'Test';
    Login.Version    := '1.0.0.1';
    Login.UpdatedAt  := DateToStr(Date);
    // Login.Logo.Picture.LoadFromFile('D:\res\Logo\Logo SETSL 150px.jpg');

    // Execute
    Log['ENTRADA'] := 'Login';

    Login.Execute;
  end;
end;

procedure TForm2.OnAuthenticate(const aEmail, aPassword: string; var aAuthenticated: Boolean; var aEmailError, aPasswordError: string);
begin
  Log['LOCAL']          := 'LoginAuthenticate';
  Log['aEmail']         := aEmail;
  Log['aPassword']      := aPassword;
  Log['aAuthenticated'] := aAuthenticated;
  Log['aEmailError']    := aEmailError;
  Log['aPasswordError'] := aPasswordError;

  if not aEmail.Equals('luisnt') then
    aEmailError := 'Login Inválido!';

  if not aPassword.Equals('7ujkl05') then
    aPasswordError := 'Senha Inválida!';

  aAuthenticated := SameStr(aEmailError + aPasswordError, EmptyStr);
end;

procedure TForm2.ButtonChangePasswordClick(Sender: TObject);
begin
  with Manage do
  begin
    // Legendas
    ChangePassword.ServerIP   := '192.168.0.1';
    ChangePassword.ComputerIP := '192.168.0.12';
    ChangePassword.Sigla      := 'Test';
    ChangePassword.Version    := '1.0.0.1';
    ChangePassword.UpdatedAt  := DateToStr(Date);
    // ChangePassword.Logo.Picture.LoadFromFile('D:\res\Logo\Logo SETSL 150px.jpg');
    ;
    // Config
    ChangePassword.ID       := 1;
    ChangePassword.Password := System.Hash.THashMD5.GetHashString('123').toUpper;
    ChangePassword.Usuario  := 'LuisNt : Luis Alfredo G Caldas Neto';

    // Execute
    Log['ENTRADA'] := 'ChangePassword';

    ChangePassword.Execute;
  end;
end;

procedure TForm2.OnChangePassword(const aID: Int64; const aNewPassword: string; var aError: string; var aChanged: Boolean);
begin
  aError              := EmptyStr;
  Log['LOCAL']        := 'ChangePassword';
  Log['aID']          := aID;
  Log['aNewPassword'] := aNewPassword;
  Log['aError']       := aError;
  Log['aChanged']     := aChanged;
  aChanged            := SameStr(aError, EmptyStr);
end;

procedure TForm2.ButtonPermissionClick(Sender: TObject);
begin
  with Manage do
  begin
    // Legendas
    Permission.ServerIP   := '192.168.0.1';
    Permission.ComputerIP := '192.168.0.12';
    Permission.Sigla      := 'Test';
    Permission.Version    := '1.0.0.1';
    Permission.UpdatedIn  := DateToStr(Date);
    // Permission.Logo.Picture.LoadFromFile('D:\res\Logo\Logo SETSL 150px.jpg');

    // Config
    Permission.ID             := 0;
    Permission.UpdatedAt      := Now;
    Permission.Can            := '01.01.01.00';
    Permission.NamePermission := 'Teste de Permissão';

    // Execute
    Log['ENTRADA'] := 'Permission';

    Permission.Execute;
  end;
end;

procedure TForm2.OnPermission(aID: Int64; aCan, aName: string; var aError: string; var aChanged: Boolean);
begin
  Log['LOCAL']    := 'Permission';
  Log['aID']      := aID;
  Log['aCan']     := aCan;
  Log['aName']    := aName;
  Log['aError']   := aError;
  Log['aChanged'] := aChanged;
  aChanged        := true;
end;

procedure TForm2.ButtonMatrixClick(Sender: TObject);
begin
  with Manage do
  begin
    // Legendas
    Matrix.ServerIP   := '192.168.0.1';
    Matrix.ComputerIP := '192.168.0.12';
    Matrix.Sigla      := 'Test';
    Matrix.Version    := '1.0.0.1';
    Matrix.UpdatedIn  := DateToStr(Date);
    // Matrix.Logo.Picture.LoadFromFile('D:\res\Logo\Logo SETSL 150px.jpg');

    // Config
    Matrix.ID         := 1;
    Matrix.UpdatedAt  := Now;
    Matrix.NameMatrix := 'Teste Matriz';
    Matrix.Email      := 'teste_matriz@gmail.com';
    Matrix.Password   := '321321';
    Matrix.MatrixID   := 1;
    Matrix.IsMatrix   := true;
    Matrix.Active     := true;

    // Execute
    Log['ENTRADA'] := 'Matrix';

    Matrix.Execute;
  end;
end;

procedure TForm2.MatrixMatrix(aID: Int64; aName, aEmail: string; aActive: Boolean; aPassword: string; aMatrixID: Integer;
  aIsMatrix: Boolean; var aError: string; var aChanged: Boolean);
begin
  Log['LOCAL']    := 'Matrix';
  Log['ID']       := aID;
  Log['Name']     := aName;
  Log['Email']    := aEmail;
  Log['Password'] := aPassword;
  Log['MatrixID'] := aMatrixID;
  Log['IsMatrix'] := aIsMatrix;
  Log['Active']   := aActive;

  Log['Error']    := aError;
  Log['Changed']  := aChanged;
  aChanged        := true;
end;

procedure TForm2.OnResult(const aResult: Boolean);
begin
  Log['SAIDA: '] := BoolToStr(aResult, true);
end;

initialization

ReportMemoryLeaksOnShutdown := true;

end.
