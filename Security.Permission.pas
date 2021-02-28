unit Security.Permission;

interface

uses
   System.SysUtils, System.Classes, Vcl.ExtCtrls, System.UITypes, Vcl.StdCtrls, Vcl.Forms,

   Security.Permission.Interfaces,
   Security.Permission.View
     ;

type
   TPermissionNotifyEvent  = Security.Permission.Interfaces.TPermissionNotifyEvent;
   TResultNotifyEvent      = Security.Permission.Interfaces.TResultNotifyEvent;
   TSecurityPermissionView = Security.Permission.View.TSecurityPermissionView;

   TSecurityPermission = class(TComponent)
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      strict private
         FView: TSecurityPermissionView;

         FOnPermission: TPermissionNotifyEvent;
         FOnResult    : TResultNotifyEvent;

      strict private
         { Strict private declarations }
         function getID: Int64;
         procedure setID(const Value: Int64);

         function getUpdatedAt: TDateTime;
         procedure setUpdatedAt(const Value: TDateTime);

         function getCan: string;
         procedure setCan(const Value: string);

         function getNamePermission: string;
         procedure setNamePermission(const Value: string);
      private
         procedure SetComputerIP(const Value: string);
         procedure SetServerIP(const Value: string);
         procedure SetSigla(const Value: string);
         procedure setUpdatedIn(const Value: string);
         procedure SetVersion(const Value: string);

         function getComputerIP: string;
         function getLogo: TImage;
         function getServerIP: string;
         function getSigla: string;
         function getUpdatedIn: string;
         function getVersion: string;
         { Private declarations }
      protected
         { Protected declarations }
      public
         { Public declarations }
         function View: iPermissionView;

         property Logo: TImage read getLogo;

         procedure Execute;
      public
         { Published hide declarations }
         property ServerIP  : string read getServerIP write SetServerIP;
         property ComputerIP: string read getComputerIP write SetComputerIP;
         property Sigla     : string read getSigla write SetSigla;
         property Version   : string read getVersion write SetVersion;
         property UpdatedIn : string read getUpdatedIn write setUpdatedIn;

      published
         { Published declarations }

         property ID            : Int64 read getID write setID;
         property UpdatedAt     : TDateTime read getUpdatedAt write setUpdatedAt;
         property Can           : string read getCan write setCan;
         property NamePermission: string read getNamePermission write setNamePermission;

         property OnPermission: TPermissionNotifyEvent read FOnPermission write FOnPermission;
         property OnResult    : TResultNotifyEvent read FOnResult write FOnResult;
   end;

implementation

{ -$R Security.Permission.rc Security.Permission.dcr }

uses
   Security.Internal;

{ TSecurityPermission }

constructor TSecurityPermission.Create(AOwner: TComponent);
begin
   FView := TSecurityPermissionView.Create(Screen.FocusedForm);
   inherited;
end;

destructor TSecurityPermission.Destroy;
begin
   FreeAndNil(FView);
   inherited;
end;

function TSecurityPermission.getCan: string;
begin
   Result := FView.EditCan.Text;
end;

function TSecurityPermission.getComputerIP: string;
begin
   Result := FView.LabelIPComputerValue.Caption;
end;

function TSecurityPermission.getLogo: TImage;
begin
   Result := FView.ImageLogo;
end;

function TSecurityPermission.getNamePermission: string;
begin
   Result := FView.EditName.Text;
end;

function TSecurityPermission.getServerIP: string;
begin
   Result := FView.LabelIPServerValue.Caption;
end;

function TSecurityPermission.getSigla: string;
begin
   Result := FView.PanelTitleLabelSigla.Caption;
end;

function TSecurityPermission.getUpdatedAt: TDateTime;
begin
   Result := FView.UpdatedAt;
end;

function TSecurityPermission.getUpdatedIn: string;
begin
   Result := FView.PanelTitleAppInfoUpdatedValue.Caption;
end;

function TSecurityPermission.getVersion: string;
begin
   Result := FView.PanelTitleAppInfoVersionValue.Caption;
end;

procedure TSecurityPermission.setCan(const Value: string);
begin
   FView.Can := Value;
end;

procedure TSecurityPermission.SetComputerIP(const Value: string);
begin
   FView.LabelIPComputerValue.Caption := Value;
end;

procedure TSecurityPermission.setID(const Value: Int64);
begin
   FView.ID := Value;
end;

procedure TSecurityPermission.setNamePermission(const Value: string);
begin
   FView.NamePermission := Value;
end;

function TSecurityPermission.getID: Int64;
begin
   Result := FView.ID;
end;

procedure TSecurityPermission.SetServerIP(const Value: string);
begin
   FView.LabelIPServerValue.Caption := Value;
end;

procedure TSecurityPermission.SetSigla(const Value: string);
begin
   FView.PanelTitleLabelSigla.Caption := Value;
end;

procedure TSecurityPermission.setUpdatedAt(const Value: TDateTime);
begin
   FView.UpdatedAt := Value;
end;

procedure TSecurityPermission.setUpdatedIn(const Value: string);
begin
   FView.PanelTitleAppInfoUpdatedValue.Caption := Value;
end;

procedure TSecurityPermission.SetVersion(const Value: string);
begin
   FView.PanelTitleAppInfoVersionValue.Caption := Value;
end;

function TSecurityPermission.View: iPermissionView;
begin
   Result := FView;
end;

procedure TSecurityPermission.Execute;
begin
   Internal.Required(Self.FOnPermission);

   FView.OnPermission := Self.FOnPermission;
   FView.OnResult     := Self.FOnResult;

   FView.Show;
end;

end.
