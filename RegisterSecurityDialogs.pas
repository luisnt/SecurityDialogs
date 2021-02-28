unit RegisterSecurityDialogs;
interface

uses
   TypInfo, System.Classes;

procedure Register;

implementation

uses
   Security.Login,
   Security.ChangePassword,
   Security.Permission,
   Security.Matrix,
   Security.User,
   Security.Manage
     ;

const
   SPageName = 'Security Dialogs';

procedure Register;
begin
   // Register all components
   RegisterComponents(SPageName, [
         TSecurityLogin,
         TSecurityChangePassword,
         TSecurityPermission,
         TSecurityMatrix,
         TSecurityUser,
         TSecurityManage
        ]);
end;

end.

