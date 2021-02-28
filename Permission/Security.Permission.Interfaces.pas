unit Security.Permission.Interfaces;

interface

Type
   TPermissionNotifyEvent = procedure(aID: Int64; aCan: string; aName: string; var aError: string; var aChanged: boolean) of Object;
   TResultNotifyEvent           = procedure(const aResult: boolean = false) of Object;

Type
   iPrivatePermissionEvents = interface
      ['{DCE42688-962D-4AA4-B719-7058C8714386}']
      { Strict private declarations }
      { Strict private declarations }
      function getID: Int64;
      procedure setID(const Value: Int64);

      function getUpdatedAt: TDateTime;
      procedure setUpdatedAt(const Value: TDateTime);

      function getCan: string;
      procedure setCan(const Value: string);

      function getNamePermission: string;
      procedure setNamePermission(const Value: string);

      procedure setOnPermission(const Value: Security.Permission.Interfaces.TPermissionNotifyEvent);
      function getOnPermission: Security.Permission.Interfaces.TPermissionNotifyEvent;

      procedure setOnResult(const Value: Security.Permission.Interfaces.TResultNotifyEvent);
      function getOnResult: Security.Permission.Interfaces.TResultNotifyEvent;
   end;

   iPermissionViewEvents = interface(iPrivatePermissionEvents)
      ['{9047BD6E-6181-49F0-95CD-123155EC0EA9}']
      { Public declarations }
      property OnPermission: TPermissionNotifyEvent read getOnPermission write setOnPermission;
      property OnResult: TResultNotifyEvent read getOnResult write setOnResult;
   end;

   iPrivatePermissionViewProperties = interface
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

   iPermissionViewProperties = interface(iPrivatePermissionViewProperties)
      ['{9047BD6E-6181-49F0-95CD-123155EC0EA9}']
      { Public declarations }

      property ComputerIP: string read getComputerIP write setComputerIP;
      property ServerIP: string read getServerIP write setServerIP;
      property Sigla: string read getSigla write setSigla;
      property Version: string read getVersion write setVersion;
      property UpdatedAt: string read getUpdatedAt write setUpdatedAt;
   end;

   iPermissionView = interface
      ['{87FEC43E-4C47-47D7-92F6-E0B6A532E49D}']
      // function Properties: iPermissionViewProperties;
      function Events: iPermissionViewEvents;
   end;

implementation

end.
