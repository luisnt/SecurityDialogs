unit Security.Permission.View;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, System.Variants, System.Classes, Vcl.Graphics, System.Hash, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
   Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg,

   PngSpeedButton, PngFunctions,

   Security.Permission.Interfaces
     ;

type
   TSecurityPermissionView = class(TForm, iPermissionView, iPermissionViewEvents)
      ShapeBodyRight: TShape;
      ShapeBodyLeft: TShape;
      ImageLogo: TImage;
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
      pl_Fundo: TPanel;
      LabelID: TLabel;
      LabelName: TLabel;
      LabelCan: TLabel;
      PanelName: TPanel;
      PanelImageName: TPanel;
      ImageName: TImage;
      PanelImageNameError: TPanel;
      ImageNameError: TImage;
      EditName: TEdit;
      PanelID: TPanel;
      PanelImageID: TPanel;
      ImageID: TImage;
      EditID: TEdit;
      EditCreatedAt: TEdit;
      PanelCan: TPanel;
      PanelImageCan: TPanel;
      ImageCan: TImage;
      PanelImageCanError: TPanel;
      ImageCanError: TImage;
      EditCan: TMaskEdit;
      Panel1: TPanel;
      LabelTableStatus: TLabel;
      PngSpeedButtonOk: TPngSpeedButton;
      PngSpeedButtonCancelar: TPngSpeedButton;
      ShapeToolbarTop: TShape;
      ShapeToolbarBottom: TShape;
      ShapePanelTitleBottom: TShape;
      procedure PngSpeedButtonCancelarClick(Sender: TObject);
      procedure PngSpeedButtonOkClick(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure FormActivate(Sender: TObject);
      procedure FormCreate(Sender: TObject);

      strict private
         FID               : Int64;
         FUpdatedAt        : TDateTime;
         FCan              : string;
         FNamePermission   : String;
         FChangedPermission: boolean;

         FOnPermission: TPermissionNotifyEvent;
         FOnResult    : TResultNotifyEvent;

         { Strict private declarations }
         function getID: Int64;
         procedure setID(const Value: Int64);

         function getUpdatedAt: TDateTime;
         procedure setUpdatedAt(const Value: TDateTime);

         function getCan: string;
         procedure setCan(const Value: string);

         function getNamePermission: string;
         procedure setNamePermission(const Value: string);

         procedure setOnPermission(const Value: TPermissionNotifyEvent);
         function getOnPermission: TPermissionNotifyEvent;

         procedure setOnResult(const Value: TResultNotifyEvent);
         function getOnResult: TResultNotifyEvent;
      private
         { Private declarations }
         procedure Validate;
         procedure doPermission;
         procedure doResult;
      public
         { Public declarations }
         function Events: iPermissionViewEvents;
      published
         { Published declarations }
         property ID            : Int64 read getID write setID;
         property UpdatedAt     : TDateTime read getUpdatedAt write setUpdatedAt;
         property Can           : string read getCan write setCan;
         property NamePermission: string read getNamePermission write setNamePermission;

         property OnPermission: TPermissionNotifyEvent read FOnPermission write FOnPermission;
         property OnResult    : TResultNotifyEvent read FOnResult write FOnResult;
   end;

var
   SecurityPermissionView: TSecurityPermissionView;

implementation

uses
   Security.Internal;

{$R *.dfm}


procedure TSecurityPermissionView.Validate;
var
   LEditCan : string;
   LEditName: string;
begin
   LEditCan  := Trim(EditCan.Text);
   LEditName := Trim(EditName.Text);

   // Validações
   Internal.Required(EditCan, LEditCan);
   Internal.Required(EditName, LEditName);

   Can            := LEditCan;
   NamePermission := LEditName;
end;

procedure TSecurityPermissionView.doPermission;
var
   LError: string;
begin
   SelectFirst;
   Validate;
   FChangedPermission := False;
   OnPermission(ID, Can, NamePermission, LError, FChangedPermission); // Atricuição da nova senha
   Internal.Die(LError);
   if FChangedPermission then
      Close;
end;

procedure TSecurityPermissionView.doResult;
begin
   try
      if not Assigned(FOnResult) then
         Exit;

      FOnResult(FChangedPermission);
   finally
      Application.NormalizeAllTopMosts;
      BringToFront;
   end;
end;

function TSecurityPermissionView.Events: iPermissionViewEvents;
begin
   Result := Self;
end;

procedure TSecurityPermissionView.FormActivate(Sender: TObject);
begin
   if ID = 0 then
   begin
      EditID.Clear;
      EditCreatedAt.Clear;
      EditCan.Clear;
      EditName.Clear;
   end;
   FChangedPermission := False;

   BringToFront;
   Application.NormalizeAllTopMosts;

   EditName.SetFocus;
end;

procedure TSecurityPermissionView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Application.RestoreTopMosts;
   doResult;
end;

procedure TSecurityPermissionView.FormCreate(Sender: TObject);
begin
   ID := 0;
end;

procedure TSecurityPermissionView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_RETURN:
         begin
            if ActiveControl = EditName then
               PngSpeedButtonOk.Click
            else
               SelectNext(ActiveControl, True, True);
            Key := VK_CANCEL;
         end;
   end;
end;

procedure TSecurityPermissionView.PngSpeedButtonCancelarClick(Sender: TObject);
begin
   FChangedPermission := False;
   Close;
end;

procedure TSecurityPermissionView.PngSpeedButtonOkClick(Sender: TObject);
begin
   doPermission;
end;

procedure TSecurityPermissionView.setID(const Value: Int64);
begin
   FID                      := Value;
   LabelTableStatus.Caption := IFThen(Value = 0, 'Criando', 'Editando');
end;

function TSecurityPermissionView.getID: Int64;
begin
   Result := FID;
end;

procedure TSecurityPermissionView.setUpdatedAt(const Value: TDateTime);
begin
   FUpdatedAt         := Value;
   EditCreatedAt.Text := IFThen(FUpdatedAt = 0, '', FormatDateTime('dd.mm.yyyy HH:mm', FUpdatedAt));
end;

function TSecurityPermissionView.getUpdatedAt: TDateTime;
begin
   Result := FUpdatedAt;
end;

procedure TSecurityPermissionView.setCan(const Value: string);
begin
   FCan         := Value;
   EditCan.Text := Value;
end;

function TSecurityPermissionView.getCan: string;
begin
   Result := FCan;
end;

procedure TSecurityPermissionView.setNamePermission(const Value: string);
begin
   FNamePermission := Value;
   EditName.Text   := Value;
end;

function TSecurityPermissionView.getNamePermission: string;
begin
   Result := FNamePermission;
end;

procedure TSecurityPermissionView.setOnPermission(const Value: Security.Permission.Interfaces.TPermissionNotifyEvent);
begin
   FOnPermission := Value;
end;

function TSecurityPermissionView.getOnPermission: Security.Permission.Interfaces.TPermissionNotifyEvent;
begin
   Result := FOnPermission;
end;

procedure TSecurityPermissionView.setOnResult(const Value: Security.Permission.Interfaces.TResultNotifyEvent);
begin
   FOnResult := Value;
end;

function TSecurityPermissionView.getOnResult: Security.Permission.Interfaces.TResultNotifyEvent;
begin
   Result := FOnResult;
end;

end.
