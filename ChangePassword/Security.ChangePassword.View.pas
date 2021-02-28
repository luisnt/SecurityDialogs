unit Security.ChangePassword.View;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.Hash, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
   Vcl.Buttons, Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg,

   PngSpeedButton, PngFunctions,

   Security.ChangePassword.Interfaces
     ;

type
   TSecurityChangePasswordView = class(TForm, iChangePasswordView, iChangePasswordViewEvents)
      ShapeBodyRight: TShape;
      ShapeBodyLeft: TShape;
      ImageLogo: TImage;
      LabelUsuario: TLabel;
      LabelPassword: TLabel;
      PanelTitle: TPanel;
      ShapePanelTitleRight: TShape;
      ShapePanelTitleLeft: TShape;
      ShapePanelTitleTop: TShape;
      PanelTitleBackgroung: TPanel;
      PanelTitleLabelAutenticacao: TLabel;
      PanelTitleDOT: TLabel;
      PanelTitleLabelSigla: TLabel;
      PanelTitleAppInfo: TPanel;
      PanelTitleAppInfoVersion: TPanel;
      PanelTitleAppInfoVersionValue: TLabel;
      PanelTitleAppInfoVersionCaption: TLabel;
      PanelTitleAppInfoUpdated: TPanel;
      PanelTitleAppInfoUpdatedValue: TLabel;
      PanelTitleAppInfoUpdatedCaption: TLabel;
      PanelStatus: TPanel;
      PanelStatusShapeLeft: TShape;
      PanelStatusShapeRight: TShape;
      PanelStatusShapeBottom: TShape;
      PanelStatusBackground: TPanel;
      LabelIPServerCaption: TLabel;
      LabelIPComputerValue: TLabel;
      PanelStatusBackgroundClient: TPanel;
      LabelIPComputerCaption: TLabel;
      LabelIPServerValue: TLabel;
      PanelToolbar: TPanel;
      ShapeToolbarLeft: TShape;
      ShapeToolbarRight: TShape;
      PanelPassword: TPanel;
      PanelImagePassword: TPanel;
      ImagePassword: TImage;
      PanelImagePasswordError: TPanel;
      ImagePasswordError: TImage;
      EditPassword: TEdit;
      PanelUsuario: TPanel;
      PanelImageUsuario: TPanel;
      ImageUsuario: TImage;
      EditUsuario: TEdit;
      LabelNewPassword: TLabel;
      PanelNewPassword: TPanel;
      PanelImageNewPassword: TPanel;
      ImageNewPassword: TImage;
      PanelImageNewPasswordError: TPanel;
      ImageNewPasswordError: TImage;
      EditNewPassword: TEdit;
      LabelConfirmNewPassword: TLabel;
      PanelConfirmNewPassword: TPanel;
      PanelImageConfirmNewPassword: TPanel;
      ImageConfirmNewPassword0: TImage;
      PanelImageConfirmNewPasswordError: TPanel;
      ImageConfirmNewPasswordError: TImage;
      EditConfirmNewPassword: TEdit;
      ShapePanelTitleBottom: TShape;
      pl_Fundo: TPanel;
      PngSpeedButtonOk: TPngSpeedButton;
      PngSpeedButtonCancelar: TPngSpeedButton;
      ShapeToolbarTop: TShape;
      ShapeToolbarBottom: TShape;
      procedure PngSpeedButtonCancelarClick(Sender: TObject);
      procedure PngSpeedButtonOkClick(Sender: TObject);
      procedure FormDestroy(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure EditPasswordChange(Sender: TObject);
      procedure EditNewPasswordChange(Sender: TObject);
      procedure EditConfirmNewPasswordChange(Sender: TObject);
      procedure FormActivate(Sender: TObject);

      strict private
         FID             : Int64;
         FUsuario        : string;
         FPassword       : string;
         FNewPassword    : String;
         FChangedPassword: boolean;

         FOnChangePassword: Security.ChangePassword.Interfaces.TChangePasswordNotifyEvent;
         FOnResult        : Security.ChangePassword.Interfaces.TResultNotifyEvent;

         { Strict private declarations }
         function getUsuario: string;
         procedure setUsuario(const Value: string);

         function getID: Int64;
         procedure setID(const Value: Int64);

         function getPassword: string;
         procedure setPassword(const Value: string);

         function getNewPassword: string;

         procedure setOnChangePassword(const Value: Security.ChangePassword.Interfaces.TChangePasswordNotifyEvent);
         function getOnChangePassword: Security.ChangePassword.Interfaces.TChangePasswordNotifyEvent;

         procedure setOnResult(const Value: Security.ChangePassword.Interfaces.TResultNotifyEvent);
         function getOnResult: Security.ChangePassword.Interfaces.TResultNotifyEvent;
      private
         { Private declarations }
         procedure Validate;
         procedure doChangePassword;
         procedure doResult;
      public
         { Public declarations }
         function Events: iChangePasswordViewEvents;
      published
         { Published declarations }
         property Usuario    : string read getUsuario write setUsuario;
         property ID         : Int64 read getID write setID;
         property Password   : string read getPassword write setPassword;
         property NewPassword: string read getNewPassword;

         property OnChangePassword: Security.ChangePassword.Interfaces.TChangePasswordNotifyEvent read getOnChangePassword write setOnChangePassword;
         property OnResult        : TResultNotifyEvent read getOnResult write setOnResult;
   end;

var
   SecurityChangePasswordView: TSecurityChangePasswordView;

implementation

uses
   Security.Internal;

{$R *.dfm}


procedure TSecurityChangePasswordView.Validate;
const
   ERR_EDIT_PASSWORD = 'A [Senha Atual] inválida. Acesso negado!';
   ERR_EDIT_NEW_PASS = 'A [Nova Senha] deve ser diferente da [Senha Atual].';
   ERR_EDIT_CONFIRMA = 'A [Confirmação] deve ser igual a [Nova Senha].';

var
   LPassword              : string;
   LEditPassword          : string;
   LEditNewPassword       : string;
   LEditConfirmNewPassword: string;
begin
   LPassword               := Password;
   LEditPassword           := Trim(EditPassword.Text);
   LEditNewPassword        := Trim(EditNewPassword.Text);
   LEditConfirmNewPassword := Trim(EditConfirmNewPassword.Text);

   // Validações
   Internal.Required(EditPassword, LEditPassword);
   Internal.Required(EditNewPassword, LEditNewPassword);
   Internal.Required(EditConfirmNewPassword, LEditConfirmNewPassword);

   LEditPassword           := Internal.MD5(LEditPassword.ToUpper);
   LEditNewPassword        := Internal.MD5(LEditNewPassword.ToUpper);
   LEditConfirmNewPassword := Internal.MD5(LEditConfirmNewPassword.ToUpper);

   Internal.Validate(EditPassword, not SameStr(LPassword, LEditPassword), ERR_EDIT_PASSWORD, PanelImagePasswordError, ImagePasswordError);
   Internal.Validate(EditNewPassword, SameStr(LPassword, LEditNewPassword), ERR_EDIT_NEW_PASS, PanelImageNewPasswordError, ImageNewPasswordError);
   Internal.Validate(EditConfirmNewPassword, not SameStr(LEditNewPassword, LEditConfirmNewPassword), ERR_EDIT_CONFIRMA, PanelImageConfirmNewPasswordError, ImageConfirmNewPasswordError);

   FNewPassword := LEditNewPassword;
end;

procedure TSecurityChangePasswordView.doChangePassword;
var
   LError: string;
begin
   SelectFirst;

   Validate;

   FChangedPassword := False;

   OnChangePassword(ID, NewPassword, LError, FChangedPassword); // Atricuição da nova senha

   Internal.Die(LError);

   if FChangedPassword then
      Close;
end;

procedure TSecurityChangePasswordView.doResult;
begin
   try
      if not Assigned(FOnResult) then
         Exit;

      FOnResult(FChangedPassword);
   finally
      Application.NormalizeAllTopMosts;
      BringToFront;
   end;
end;

procedure TSecurityChangePasswordView.EditConfirmNewPasswordChange(Sender: TObject);
begin
   PanelImageConfirmNewPasswordError.Visible := False;
end;

procedure TSecurityChangePasswordView.EditNewPasswordChange(Sender: TObject);
begin
   PanelImageNewPasswordError.Visible := False;
end;

procedure TSecurityChangePasswordView.EditPasswordChange(Sender: TObject);
begin
   PanelImagePasswordError.Visible := False;
end;

function TSecurityChangePasswordView.Events: iChangePasswordViewEvents;
begin
   Result := Self;
end;

procedure TSecurityChangePasswordView.FormActivate(Sender: TObject);
begin
   EditPassword.Clear;
   EditNewPassword.Clear;
   EditConfirmNewPassword.Clear;
   FChangedPassword := False;

   BringToFront;
   Application.NormalizeAllTopMosts;

   EditPassword.SetFocus;
end;

procedure TSecurityChangePasswordView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Application.RestoreTopMosts;
   doResult;
end;

procedure TSecurityChangePasswordView.FormDestroy(Sender: TObject);
begin
   // if Assigned(DataSourceUser.DataSet) then
   // DataSourceUser.DataSet.Free;
end;

procedure TSecurityChangePasswordView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_RETURN:
         begin
            if ActiveControl = EditConfirmNewPassword then
               PngSpeedButtonOk.Click
            else
               SelectNext(ActiveControl, True, True);
            Key := VK_CANCEL;
         end;
   end;
end;

procedure TSecurityChangePasswordView.PngSpeedButtonCancelarClick(Sender: TObject);
begin
   FChangedPassword := False;
   Close;
end;

procedure TSecurityChangePasswordView.PngSpeedButtonOkClick(Sender: TObject);
begin
   doChangePassword;
end;

procedure TSecurityChangePasswordView.setID(const Value: Int64);
begin
   FID := Value;
end;

function TSecurityChangePasswordView.getID:
  Int64;
begin
   Result := FID;
end;

procedure TSecurityChangePasswordView.setUsuario(const Value: string);
begin
   FUsuario         := Value;
   EditUsuario.Text := Value;
end;

function TSecurityChangePasswordView.getUsuario: string;
begin
   Result := FUsuario;
end;

procedure TSecurityChangePasswordView.setPassword(const Value: string);
begin
   FPassword := Value;
end;

function TSecurityChangePasswordView.getPassword: string;
begin
   Result := FPassword;
end;

function TSecurityChangePasswordView.getNewPassword: string;
begin
   Result := FNewPassword;
end;

procedure TSecurityChangePasswordView.setOnChangePassword(const Value: Security.ChangePassword.Interfaces.TChangePasswordNotifyEvent);
begin
   FOnChangePassword := Value;
end;

function TSecurityChangePasswordView.getOnChangePassword: Security.ChangePassword.Interfaces.TChangePasswordNotifyEvent;
begin
   Result := FOnChangePassword;
end;

procedure TSecurityChangePasswordView.setOnResult(const Value: Security.ChangePassword.Interfaces.TResultNotifyEvent);
begin
   FOnResult := Value;
end;

function TSecurityChangePasswordView.getOnResult: Security.ChangePassword.Interfaces.TResultNotifyEvent;
begin
   Result := FOnResult;
end;

end.
