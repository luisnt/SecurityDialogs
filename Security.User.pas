unit Security.User;

interface

uses
  System.SysUtils, System.Classes, Vcl.ExtCtrls, System.UITypes, Vcl.StdCtrls, Vcl.Forms

    , Security.User.Interfaces
    , Security.User.View, System.StrUtils
    ;

type
  TPermissionNotifyEvent = Security.User.Interfaces.TUserNotifyEvent;
  TResultNotifyEvent     = Security.User.Interfaces.TResultNotifyEvent;
  TSecurityUserView    = Security.User.View.TSecurityUserView;

  TSecurityUser = class(TComponent)
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  strict private
    FView: TSecurityUserView;

    FOnUser: TUserNotifyEvent;
    FOnResult: TResultNotifyEvent;

    { Strict private declarations }
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
  private
    { Private declarations }
    procedure setID(Value: Int64);
    function getID: Int64;

    function getUpdatedAt: TDateTime;
    procedure setUpdatedAt(const Value: TDateTime);

    procedure setNameUser(Value: String);
    function getNameUser: String;

    procedure setEmail(Value: String);
    function getEmail: String;

    procedure setActive(Value: Boolean);
    function getActive: Boolean;

    procedure setPassword(Value: String);
    function getPassword: String;

    procedure setMatrixID(Value: Integer);
    function getMatrixID: Integer;

    procedure setIsMatrix(Value: Boolean);
    function getIsMatrix: Boolean;
  protected
    { Protected declarations }
  public
    { Public declarations }
    function View: iUserView;

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
    { Published declarations - Properties }
    property ID        : Int64 read getID write setID;
    property UpdatedAt : TDateTime read getUpdatedAt write setUpdatedAt;
    property NameUser: String read getNameUser write setNameUser;
    property Email     : String read getEmail write setEmail;
    property Active    : Boolean read getActive write setActive;
    property Password  : String read getPassword write setPassword;
    property MatrixID  : Integer read getUserID write setMatrixID;
    property IsMatrix  : Boolean read getIsUser write setIsMatrix;

    { Published declarations - Events }
    property OnUser: TUserNotifyEvent read FOnUser write FOnUser;
    property OnResult: TResultNotifyEvent read FOnResult write FOnResult;
  end;

implementation

uses
  Security.Internal;

{ TSecurityManage }

constructor TSecurityUser.Create(AOwner: TComponent);
begin
  FView := TSecurityUserView.Create(Screen.FocusedForm);
  inherited;
end;

destructor TSecurityUser.Destroy;
begin
  FreeAndNil(FView);
  inherited;
end;

procedure TSecurityUser.SetComputerIP(const Value: string);
begin
  FView.LabelIPComputerValue.Caption := Value;
end;

function TSecurityUser.getComputerIP: string;
begin
  Result := FView.LabelIPComputerValue.Caption;
end;

procedure TSecurityUser.SetServerIP(const Value: string);
begin
  FView.LabelIPServerValue.Caption := Value;
end;

function TSecurityUser.getServerIP: string;
begin
  Result := FView.LabelIPServerValue.Caption;
end;

procedure TSecurityUser.SetSigla(const Value: string);
begin
  FView.PanelTitleLabelSigla.Caption := Value;
end;

function TSecurityUser.getSigla: string;
begin
  Result := FView.PanelTitleLabelSigla.Caption;
end;

procedure TSecurityUser.setUpdatedIn(const Value: string);
begin
  FView.PanelTitleAppInfoUpdatedValue.Caption := Value;
end;

function TSecurityUser.getUpdatedIn: string;
begin
  Result := FView.PanelTitleAppInfoUpdatedValue.Caption;
end;

procedure TSecurityUser.SetVersion(const Value: string);
begin
  FView.PanelTitleAppInfoVersionValue.Caption := Value;
end;

function TSecurityUser.getVersion: string;
begin
  Result := FView.PanelTitleAppInfoVersionValue.Caption;
end;

function TSecurityUser.getLogo: TImage;
begin
  Result := FView.ImageLogo;
end;

function TSecurityUser.View: iUserView;
begin
  Result := FView;
end;

procedure TSecurityUser.setID(Value: Int64);
begin
  FView.ID := Value;
end;

function TSecurityUser.getID: Int64;
begin
  Result := FView.ID;
end;

procedure TSecurityUser.setNameUser(Value: String);
begin
  FView.NameUser := Value;
end;

function TSecurityUser.getNameUser: String;
begin
  Result := FView.NameUser;
end;

procedure TSecurityUser.setEmail(Value: String);
begin
  FView.Email := Value;
end;

function TSecurityUser.getEmail: String;
begin
  Result := FView.Email;
end;

procedure TSecurityUser.setActive(Value: Boolean);
begin
  FView.Active := Value;
end;

function TSecurityUser.getActive: Boolean;
begin
  Result := FView.Active;
end;

procedure TSecurityUser.setPassword(Value: String);
begin
  FView.Password := Value;
end;

function TSecurityUser.getPassword: String;
begin
  Result := FView.Password;
end;

procedure TSecurityUser.setUpdatedAt(const Value: TDateTime);
begin
  FView.UpdatedAt := Value;
end;

function TSecurityUser.getUpdatedAt: TDateTime;
begin
  Result := FView.UpdatedAt;
end;

procedure TSecurityUser.setUserID(Value: Integer);
begin
  FView.MatrixID := Value;
end;

function TSecurityUser.getMatrixID: Integer;
begin
  Result := FView.MatrixID;
end;

procedure TSecurityUser.setIsMatrix(Value: Boolean);
begin
  FView.IsMatrix := Value;
end;

function TSecurityUser.getIsMatrix: Boolean;
begin
  Result := FView.IsMatrix;
end;

procedure TSecurityUser.Execute;
begin
  Internal.Required(Self.FOnUser);

  FView.OnUser := Self.FOnUser;
  FView.OnResult := Self.FOnResult;

  FView.Show;
end;

end.
