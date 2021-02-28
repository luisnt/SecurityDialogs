unit Security.Login.Interfaces;

interface

uses Vcl.Forms, Vcl.ExtCtrls;

Type
   // TAuthNotifyEvent  = reference to procedure(const aEmail: string; const aPassword: string; var aAuthenticated: boolean; var aEmailError: string; var aPasswordError: string);
   // TResultNotifyEvent = reference to procedure(const aResult: boolean = false);

   TAuthNotifyEvent   = procedure(const aEmail: string; const aPassword: string; var aAuthenticated: boolean; var aEmailError: string; var aPasswordError: string) of Object;
   TResultNotifyEvent = procedure(const aResult: boolean = false) of Object;

Type
   iPrivateLoginEvents = interface
      ['{DCE42688-962D-4AA4-B719-7058C8714386}']
      { Strict private declarations }
      function getOnAuth: TAuthNotifyEvent;
      function getOnResult: TResultNotifyEvent;

      procedure setOnAuth(const Value: TAuthNotifyEvent);
      procedure setOnResult(const Value: TResultNotifyEvent);
   end;

   iLoginViewEvents = interface(iPrivateLoginEvents)
      ['{9047BD6E-6181-49F0-95CD-123155EC0EA9}']
      { Public declarations }
      property OnAuth: TAuthNotifyEvent read getOnAuth write setOnAuth;
      property OnResult: TResultNotifyEvent read getOnResult write setOnResult;
   end;

   iPrivateLoginViewProperties = interface
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

   iLoginViewProperties = interface(iPrivateLoginViewProperties)
      ['{9047BD6E-6181-49F0-95CD-123155EC0EA9}']
      { Public declarations }

      property ComputerIP: string read getComputerIP write setComputerIP;
      property ServerIP: string read getServerIP write setServerIP;
      property Sigla: string read getSigla write setSigla;
      property Version: string read getVersion write setVersion;
      property UpdatedAt: string read getUpdatedAt write setUpdatedAt;
   end;

   iLoginView = interface
      ['{87FEC43E-4C47-47D7-92F6-E0B6A532E49D}']
      function Properties: iLoginViewProperties;
      function Events: iLoginViewEvents;
   end;

implementation

end.
