unit Security.ChangePassword;

interface

uses
   System.SysUtils, System.Classes, Vcl.ExtCtrls, System.UITypes, Vcl.StdCtrls,

   Security.ChangePassword.Interfaces,
   Security.ChangePassword.View
     ;

type
   TChangePasswordNotifyEvent  = Security.ChangePassword.Interfaces.TChangePasswordNotifyEvent;
   TResultNotifyEvent          = Security.ChangePassword.Interfaces.TResultNotifyEvent;
   TSecurityChangePasswordView = Security.ChangePassword.View.TSecurityChangePasswordView;

   TSecurityChangePassword = class(TComponent)
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      strict private
         FView: TSecurityChangePasswordView;

         // FID             : Int64;
         // FUsuario        : string;
         // FPassword       : string;
         // FNewPassword    : String;
         // FChangedPassword: boolean;

         FOnChangePassword: TChangePasswordNotifyEvent;
         FOnResult        : TResultNotifyEvent;

      strict private
         { Strict private declarations }
         function getUsuario: string;
         procedure setUsuario(const Value: string);

         function getID: Int64;
         procedure setID(const Value: Int64);

         function getPassword: string;
         procedure setPassword(const Value: string);

         function getNewPassword: string;
      private
         procedure SetComputerIP(const Value: string);
         procedure SetServerIP(const Value: string);
         procedure SetSigla(const Value: string);
         procedure SetUpdatedAt(const Value: string);
         procedure SetVersion(const Value: string);

         function getComputerIP: string;
         function getLogo: TImage;
         function getServerIP: string;
         function getSigla: string;
         function getUpdatedAt: string;
         function getVersion: string;
         { Private declarations }
      protected
         { Protected declarations }
      public
         { Public declarations }
         function View: iChangePasswordView;

         property Logo: TImage read getLogo;

         procedure Execute;
      public
         { Published hide declarations }
         property ServerIP  : string read getServerIP write SetServerIP;
         property ComputerIP: string read getComputerIP write SetComputerIP;
         property Sigla     : string read getSigla write SetSigla;
         property Version   : string read getVersion write SetVersion;
         property UpdatedAt : string read getUpdatedAt write SetUpdatedAt;

      published
         { Published declarations }

         property Usuario    : string read getUsuario write setUsuario;
         property ID         : Int64 read getID write setID;
         property Password   : string read getPassword write setPassword;
         property NewPassword: string read getNewPassword;

         property OnChangePassword: TChangePasswordNotifyEvent read FOnChangePassword write FOnChangePassword;
         property OnResult        : TResultNotifyEvent read FOnResult write FOnResult;
   end;

implementation

{ -$R Security.ChangePassword.rc Security.ChangePassword.dcr }

uses
   Vcl.Forms
     , Security.Internal;

{ TSecurityChangePassword }

constructor TSecurityChangePassword.Create(AOwner: TComponent);
begin
   FView := TSecurityChangePasswordView.Create(Screen.FocusedForm);
   inherited;
end;

destructor TSecurityChangePassword.Destroy;
begin
   FreeAndNil(FView);
   inherited;
end;

function TSecurityChangePassword.getComputerIP: string;
begin
   Result := FView.LabelIPComputerValue.Caption;
end;

function TSecurityChangePassword.getLogo: TImage;
begin
   Result := FView.ImageLogo;
end;

function TSecurityChangePassword.getServerIP: string;
begin
   Result := FView.LabelIPServerValue.Caption;
end;

function TSecurityChangePassword.getSigla: string;
begin
   Result := FView.PanelTitleLabelSigla.Caption;
end;

function TSecurityChangePassword.getUpdatedAt: string;
begin
   Result := FView.PanelTitleAppInfoUpdatedValue.Caption;
end;

function TSecurityChangePassword.getVersion: string;
begin
   Result := FView.PanelTitleAppInfoVersionValue.Caption;
end;

procedure TSecurityChangePassword.SetComputerIP(const Value: string);
begin
   FView.LabelIPComputerValue.Caption := Value;
end;

procedure TSecurityChangePassword.setID(const Value: Int64);
begin
   FView.ID := Value;
end;

function TSecurityChangePassword.getID: Int64;
begin
   Result := FView.ID;
end;

procedure TSecurityChangePassword.setUsuario(const Value: string);
begin
   FView.Usuario := Value;
end;

function TSecurityChangePassword.getUsuario: string;
begin
   Result := FView.Usuario;
end;

function TSecurityChangePassword.getNewPassword: string;
begin
   Result := FView.NewPassword;
end;

procedure TSecurityChangePassword.setPassword(const Value: string);
begin
   FView.Password := Value;
end;

function TSecurityChangePassword.getPassword: string;
begin
   Result := FView.Password;
end;

procedure TSecurityChangePassword.SetServerIP(const Value: string);
begin
   FView.LabelIPServerValue.Caption := Value;
end;

procedure TSecurityChangePassword.SetSigla(const Value: string);
begin
   FView.PanelTitleLabelSigla.Caption := Value;
end;

procedure TSecurityChangePassword.SetUpdatedAt(const Value: string);
begin
   FView.PanelTitleAppInfoUpdatedValue.Caption := Value;
end;

procedure TSecurityChangePassword.SetVersion(const Value: string);
begin
   FView.PanelTitleAppInfoVersionValue.Caption := Value;
end;

function TSecurityChangePassword.View: iChangePasswordView;
begin
   Result := FView;
end;

procedure TSecurityChangePassword.Execute;
begin
   Internal.Required(ID, 'A propriedade ID não foi definida.');
   Internal.Required(Usuario, 'A propriedade Usuário não foi definida.');
   Internal.Required(Password, 'A propriedade Senha não foi definida.');
   Internal.Required(Self.FOnChangePassword);

   FView.OnChangePassword := Self.FOnChangePassword;
   FView.OnResult         := Self.FOnResult;

   FView.Show;
end;

end.
