unit Security.Manage;

interface

uses
   System.SysUtils, System.Classes, Vcl.ExtCtrls, System.UITypes, Vcl.StdCtrls, Vcl.Forms

     , Security.Login
     , Security.ChangePassword
     , Security.Permission
     , Security.Matrix
     , Security.User
     ;

type
   TSecurityManage = class(TComponent)
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      strict private
         FLogin         : TSecurityLogin;
         FChangePassword: TSecurityChangePassword;
         FPermission    : TSecurityPermission;
         FMatrix        : TSecurityMatrix;
         FUser          : TSecurityUser;
         { Strict private declarations }
      private
         { Private declarations }
      protected
         { Protected declarations }
         procedure Notification(AComponent: TComponent; Operation: TOperation); override;
      public
         { Public declarations }
      published
         { Published declarations }
         property Login         : TSecurityLogin read FLogin write FLogin;
         property ChangePassword: TSecurityChangePassword read FChangePassword write FChangePassword;
         property Permission    : TSecurityPermission read FPermission write FPermission;
         property Matrix        : TSecurityMatrix read FMatrix write FMatrix;
         property User          : TSecurityUser read FUser write FUser;
   end;

implementation

uses
   Security.Internal;

{ TSecurityManage }

constructor TSecurityManage.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   // FView := TSecurityManageView.Create(Screen.FocusedForm);
end;

destructor TSecurityManage.Destroy;
begin
   inherited;
end;

procedure TSecurityManage.Notification(AComponent: TComponent; Operation: TOperation);
begin
   inherited Notification(AComponent, Operation);
end;

end.
