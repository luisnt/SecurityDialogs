unit Security.Matrix;

interface

uses
  System.SysUtils, System.Classes, Vcl.ExtCtrls, System.UITypes, Vcl.StdCtrls, Vcl.Forms

    , Security.Matrix.Interfaces
    , Security.Matrix.View, System.StrUtils
    ;

type
  TPermissionNotifyEvent = Security.Matrix.Interfaces.TMatrixNotifyEvent;
  TResultNotifyEvent     = Security.Matrix.Interfaces.TResultNotifyEvent;
  TSecurityMatrixView    = Security.Matrix.View.TSecurityMatrixView;

  TSecurityMatrix = class(TComponent)
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  strict private
    FView: TSecurityMatrixView;

    FOnMatrix: TMatrixNotifyEvent;
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

    procedure setNameMatrix(Value: String);
    function getNameMatrix: String;

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
    function View: iMatrixView;

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
    property NameMatrix: String read getNameMatrix write setNameMatrix;
    property Email     : String read getEmail write setEmail;
    property Active    : Boolean read getActive write setActive;
    property Password  : String read getPassword write setPassword;
    property MatrixID  : Integer read getMatrixID write setMatrixID;
    property IsMatrix  : Boolean read getIsMatrix write setIsMatrix;

    { Published declarations - Events }
    property OnMatrix: TMatrixNotifyEvent read FOnMatrix write FOnMatrix;
    property OnResult: TResultNotifyEvent read FOnResult write FOnResult;
  end;

implementation

uses
  Security.Internal;

{ TSecurityManage }

constructor TSecurityMatrix.Create(AOwner: TComponent);
begin
  FView := TSecurityMatrixView.Create(Screen.FocusedForm);
  inherited;
end;

destructor TSecurityMatrix.Destroy;
begin
  FreeAndNil(FView);
  inherited;
end;

procedure TSecurityMatrix.SetComputerIP(const Value: string);
begin
  FView.LabelIPComputerValue.Caption := Value;
end;

function TSecurityMatrix.getComputerIP: string;
begin
  Result := FView.LabelIPComputerValue.Caption;
end;

procedure TSecurityMatrix.SetServerIP(const Value: string);
begin
  FView.LabelIPServerValue.Caption := Value;
end;

function TSecurityMatrix.getServerIP: string;
begin
  Result := FView.LabelIPServerValue.Caption;
end;

procedure TSecurityMatrix.SetSigla(const Value: string);
begin
  FView.PanelTitleLabelSigla.Caption := Value;
end;

function TSecurityMatrix.getSigla: string;
begin
  Result := FView.PanelTitleLabelSigla.Caption;
end;

procedure TSecurityMatrix.setUpdatedIn(const Value: string);
begin
  FView.PanelTitleAppInfoUpdatedValue.Caption := Value;
end;

function TSecurityMatrix.getUpdatedIn: string;
begin
  Result := FView.PanelTitleAppInfoUpdatedValue.Caption;
end;

procedure TSecurityMatrix.SetVersion(const Value: string);
begin
  FView.PanelTitleAppInfoVersionValue.Caption := Value;
end;

function TSecurityMatrix.getVersion: string;
begin
  Result := FView.PanelTitleAppInfoVersionValue.Caption;
end;

function TSecurityMatrix.getLogo: TImage;
begin
  Result := FView.ImageLogo;
end;

function TSecurityMatrix.View: iMatrixView;
begin
  Result := FView;
end;

procedure TSecurityMatrix.setID(Value: Int64);
begin
  FView.ID := Value;
end;

function TSecurityMatrix.getID: Int64;
begin
  Result := FView.ID;
end;

procedure TSecurityMatrix.setNameMatrix(Value: String);
begin
  FView.NameMatrix := Value;
end;

function TSecurityMatrix.getNameMatrix: String;
begin
  Result := FView.NameMatrix;
end;

procedure TSecurityMatrix.setEmail(Value: String);
begin
  FView.Email := Value;
end;

function TSecurityMatrix.getEmail: String;
begin
  Result := FView.Email;
end;

procedure TSecurityMatrix.setActive(Value: Boolean);
begin
  FView.Active := Value;
end;

function TSecurityMatrix.getActive: Boolean;
begin
  Result := FView.Active;
end;

procedure TSecurityMatrix.setPassword(Value: String);
begin
  FView.Password := Value;
end;

function TSecurityMatrix.getPassword: String;
begin
  Result := FView.Password;
end;

procedure TSecurityMatrix.setUpdatedAt(const Value: TDateTime);
begin
  FView.UpdatedAt := Value;
end;

function TSecurityMatrix.getUpdatedAt: TDateTime;
begin
  Result := FView.UpdatedAt;
end;

procedure TSecurityMatrix.setMatrixID(Value: Integer);
begin
  FView.MatrixID := Value;
end;

function TSecurityMatrix.getMatrixID: Integer;
begin
  Result := FView.MatrixID;
end;

procedure TSecurityMatrix.setIsMatrix(Value: Boolean);
begin
  FView.IsMatrix := Value;
end;

function TSecurityMatrix.getIsMatrix: Boolean;
begin
  Result := FView.IsMatrix;
end;

procedure TSecurityMatrix.Execute;
begin
  Internal.Required(Self.FOnMatrix);

  FView.OnMatrix := Self.FOnMatrix;
  FView.OnResult := Self.FOnResult;

  FView.Show;
end;

end.
