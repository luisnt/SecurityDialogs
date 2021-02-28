unit Security.Login.View;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
   Vcl.Buttons, Vcl.AppEvnts, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,

   PngFunctions, PngSpeedButton,

   Security.Login.Interfaces
     ;

type
   TSecurityLoginView = class(TForm, iLoginView, iLoginViewProperties, iLoginViewEvents)
      EditEmail: TEdit;
      EditPassword: TEdit;
      ImageEmail: TImage;
      ImageEmailError: TImage;
      ImageLogo: TImage;
      ImagePassword: TImage;
      ImagePasswordError: TImage;
      LabelEmail: TLabel;
      LabelIPComputerCaption: TLabel;
      LabelComputerIPValue: TLabel;
      LabelIPServerCaption: TLabel;
      LabelServerIPValue: TLabel;
      LabelPassword: TLabel;
      PanelEmail: TPanel;
      PanelImageEmail: TPanel;
      PanelImageEmailError: TPanel;
      PanelImagePassword: TPanel;
      PanelImagePasswordError: TPanel;
      PanelPassword: TPanel;
      PanelStatus: TPanel;
      PanelStatusBackground: TPanel;
      PanelStatusBackgroundClient: TPanel;
      PanelStatusShapeBottom: TShape;
      PanelStatusShapeLeft: TShape;
      PanelStatusShapeRight: TShape;
      PanelTitle: TPanel;
      PanelTitleAppInfo: TPanel;
      PanelTitleAppInfoUpdated: TPanel;
      PanelTitleAppInfoUpdatedCaption: TLabel;
      PanelTitleAppInfoUpdatedValue: TLabel;
      PanelTitleAppInfoVersion: TPanel;
      PanelTitleAppInfoVersionCaption: TLabel;
      PanelTitleAppInfoVersionValue: TLabel;
      PanelTitleBackgroung: TPanel;
      PanelTitleDOT: TLabel;
      PanelTitleLabelSigla: TLabel;
      PanelTitleLabelAutenticacao: TLabel;
      PanelToolbar: TPanel;
      ShapeBodyLeft: TShape;
      ShapeBodyRight: TShape;
      ShapePanelTitleLeft: TShape;
      ShapePanelTitleRight: TShape;
      ShapePanelTitleTop: TShape;
      ShapeToolbarLeft: TShape;
      ShapeToolbarRight: TShape;
      ShapePanelTitleBottom: TShape;
      pl_Fundo: TPanel;
      PngSpeedButtonOk: TPngSpeedButton;
      PngSpeedButtonCancelar: TPngSpeedButton;
      Shape1: TShape;
      Shape2: TShape;
      procedure EditEmailChange(Sender: TObject);
      procedure EditPasswordChange(Sender: TObject);
      procedure PngSpeedButtonCancelarClick(Sender: TObject);
      procedure PngSpeedButtonOkClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure FormActivate(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      strict private
         FOnAuth       : Security.Login.Interfaces.TAuthNotifyEvent;
         FOnResult     : Security.Login.Interfaces.TResultNotifyEvent;
         FAuthenticated: Boolean;
         { Strict private declarations }

      private
         { Private declarations }
         function getOnAuth: Security.Login.Interfaces.TAuthNotifyEvent;
         function getOnResult: Security.Login.Interfaces.TResultNotifyEvent;

         procedure setOnAuth(const Value: Security.Login.Interfaces.TAuthNotifyEvent);
         procedure setOnResult(const Value: Security.Login.Interfaces.TResultNotifyEvent);

         function getComputerIP: string;
         function getServerIP: string;
         function getSigla: string;
         function getUpdatedAt: string;
         function getVersion: string;

         procedure setComputerIP(const Value: string);
         procedure setServerIP(const Value: string);
         procedure setSigla(const Value: string);
         procedure setUpdatedAt(const Value: string);
         procedure setVersion(const Value: string);

      protected
         { Protected declarations }
         procedure doLogin(const aEmail: string; const aPassword: string);
         procedure doResult;

      public
         { Public declarations }
         function Properties: iLoginViewProperties;
         function Events: iLoginViewEvents;

      published
         { Published declarations Properties }
         property ComputerIP: string read getComputerIP write setComputerIP;
         property ServerIP  : string read getServerIP write setServerIP;
         property Sigla     : string read getSigla write setSigla;
         property Version   : string read getVersion write setVersion;
         property UpdatedAt : string read getUpdatedAt write setUpdatedAt;

         { Published declarations Events }
         property OnAuth  : Security.Login.Interfaces.TAuthNotifyEvent read getOnAuth write setOnAuth;
         property OnResult: Security.Login.Interfaces.TResultNotifyEvent read getOnResult write setOnResult;
   end;

var
   SecurityLoginView: TSecurityLoginView;

implementation

uses Security.Internal;

{$R *.dfm}


procedure TSecurityLoginView.EditEmailChange(Sender: TObject);
begin
   PanelImageEmailError.Visible := false;
end;

procedure TSecurityLoginView.EditPasswordChange(Sender: TObject);
begin
   PanelImagePasswordError.Visible := false;
end;

procedure TSecurityLoginView.FormActivate(Sender: TObject);
begin
   EditEmail.Clear;
   EditPassword.Clear;
   FAuthenticated := false;

   BringToFront;
   Application.NormalizeAllTopMosts;
end;

procedure TSecurityLoginView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Application.RestoreTopMosts;
   doResult;
end;

procedure TSecurityLoginView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_RETURN:
         begin
            if ActiveControl = EditPassword then
               PngSpeedButtonOk.Click
            else
               SelectNext(ActiveControl, true, true);
            Key := VK_CANCEL;
         end;
      VK_F9:
         if DEBUG_PROCESS <> 0 then
         begin
            EditEmail.Text    := 'luisnt';
            EditPassword.Text := '7ujkl05';
            PngSpeedButtonOk.Click;
         end;
   end;
end;

function TSecurityLoginView.getComputerIP: string;
begin
   Result := LabelComputerIPValue.Caption;
end;

function TSecurityLoginView.getServerIP: string;
begin
   Result := LabelServerIPValue.Caption;
end;

function TSecurityLoginView.getOnAuth: Security.Login.Interfaces.TAuthNotifyEvent;
begin
   Result := FOnAuth;
end;

function TSecurityLoginView.getOnResult: Security.Login.Interfaces.TResultNotifyEvent;
begin
   Result := FOnResult;
end;

function TSecurityLoginView.getSigla: string;
begin
   Result := PanelTitleLabelSigla.Caption;
end;

function TSecurityLoginView.getUpdatedAt: string;
begin
   Result := PanelTitleAppInfoUpdatedValue.Caption;
end;

function TSecurityLoginView.getVersion: string;
begin
   Result := PanelTitleAppInfoVersionValue.Caption;
end;

procedure TSecurityLoginView.setComputerIP(const Value: string);
begin
   LabelComputerIPValue.Caption := Value;
end;

procedure TSecurityLoginView.setServerIP(const Value: string);
begin
   LabelServerIPValue.Caption := Value;
end;

procedure TSecurityLoginView.setOnAuth(const Value: Security.Login.Interfaces.TAuthNotifyEvent);
begin
   FOnAuth := Value;
end;

procedure TSecurityLoginView.setOnResult(const Value: Security.Login.Interfaces.TResultNotifyEvent);
begin
   FOnResult := Value;
end;

procedure TSecurityLoginView.setSigla(const Value: string);
begin
   PanelTitleLabelSigla.Caption := Value;
end;

procedure TSecurityLoginView.setUpdatedAt(const Value: string);
begin
   PanelTitleAppInfoUpdatedValue.Caption := Value;
end;

procedure TSecurityLoginView.setVersion(const Value: string);
begin
   PanelTitleAppInfoVersionValue.Caption := Value;
end;

procedure TSecurityLoginView.doLogin(const aEmail: string; const aPassword: string);
var
   LEmailError   : string;
   LPasswordError: string;
begin
   SelectFirst;

   LEmailError    := EmptyStr;
   LPasswordError := EmptyStr;
   FAuthenticated := false;

   Internal.Validate(EditEmail);
   Internal.Validate(EditPassword);
   Internal.Required(FOnAuth);

   OnAuth(aEmail, aPassword, FAuthenticated, LEmailError, LPasswordError);

   if FAuthenticated then
   begin
      Close;
      Exit;
   end;

   if SameStr(LEmailError + LPasswordError, EmptyStr) then
      LEmailError := 'Acesso negado!';

   Internal.Validate(LEmailError, EditEmail, ImageEmailError, PanelImageEmailError);
   Internal.Validate(LPasswordError, EditPassword, ImagePasswordError, PanelImagePasswordError);
end;

procedure TSecurityLoginView.doResult;
begin
   try
      if not Assigned(FOnResult) then
         Exit;

      FOnResult(FAuthenticated);
   finally
      Application.NormalizeAllTopMosts;
      BringToFront;
   end;
end;

function TSecurityLoginView.Properties: iLoginViewProperties;
begin
   Result := Self;
end;

function TSecurityLoginView.Events: iLoginViewEvents;
begin
   Result := Self;
end;

procedure TSecurityLoginView.PngSpeedButtonOkClick(Sender: TObject);
begin
   doLogin(EditEmail.Text, EditPassword.Text);
end;

procedure TSecurityLoginView.PngSpeedButtonCancelarClick(Sender: TObject);
begin
   FAuthenticated := false;
   Close;
end;

end.
