unit Security.ChangePassword.Interfaces;

interface

Type
   TChangePasswordNotifyEvent = procedure(const aID: Int64; const aNewPassword: string; var aError: string; var aChanged: boolean) of Object;
   TResultNotifyEvent         = procedure(const aResult: boolean = false) of Object;

Type
   iPrivateChangePasswordEvents = interface
      ['{DCE42688-962D-4AA4-B719-7058C8714386}']
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
   end;

   iChangePasswordViewEvents = interface(iPrivateChangePasswordEvents)
      ['{9047BD6E-6181-49F0-95CD-123155EC0EA9}']
      { Public declarations }
      property OnChangePassword: TChangePasswordNotifyEvent read getOnChangePassword write setOnChangePassword;
      property OnResult: TResultNotifyEvent read getOnResult write setOnResult;
   end;

   iPrivateChangePasswordViewProperties = interface
      ['{DCE42688-962D-4AA4-B719-7058C8714386}']
      { Private declarations }
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
   end;

   iChangePasswordViewProperties = interface(iPrivateChangePasswordViewProperties)
      ['{9047BD6E-6181-49F0-95CD-123155EC0EA9}']
      { Public declarations }

      property ComputerIP: string read getComputerIP write setComputerIP;
      property ServerIP: string read getServerIP write setServerIP;
      property Sigla: string read getSigla write setSigla;
      property Version: string read getVersion write setVersion;
      property UpdatedAt: string read getUpdatedAt write setUpdatedAt;
   end;

   iChangePasswordView = interface
      ['{87FEC43E-4C47-47D7-92F6-E0B6A532E49D}']
      // function Properties: iChangePasswordViewProperties;
      function Events: iChangePasswordViewEvents;
   end;

implementation

end.
