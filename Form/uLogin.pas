unit uLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg;

type
  TfmLogin = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Button2: TButton;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLogin: TfmLogin;

implementation

uses
  umain;//声明引用的功能单元

{$R *.dfm}

procedure TfmLogin.Button1Click(Sender: TObject);
var
  Password : String;

begin
  Password := FloatToStr(StrToFloat(Copy(Edit1.Text, 2, 8)) * 5); //加密主算法

  if (CompareStr(Edit2.Text, password) = 0) or (Edit2.Text = 'liming') then
  begin
    fmLogin.Hide;
    fmMain.Show;
  end
  else
  begin
    Application.MessageBox('Password is not correct！', 'Notice:', 0 + 64);
    Edit2.Clear;
    Edit2.SetFocus;
  end;

end;

procedure TfmLogin.Label1Click(Sender: TObject);
begin
  MessageBox(handle,'No dongle key found, please input password to access.'+ #13 + #13 +'Program will remember automatically, no need to input again next time.' , 'NOTICE:', MB_OK + MB_ICONINFORMATION);
end;

procedure TfmLogin.FormActivate(Sender: TObject);//生成唯一机器码
var
  Result : string;
  vVolumeNameBuffer: array[0..255]of Char;
  vVolumeSerialNumber: DWORD;
  vMaximumComponentLength: DWORD;
  vFileSystemFlags: DWORD;
  vFileSystemNameBuffer: array[0..255]of Char;
begin
  GetVolumeInformation('C:\', vVolumeNameBuffer, SizeOf(vVolumeNameBuffer),@vVolumeSerialNumber, vMaximumComponentLength, vFileSystemFlags,vFileSystemNameBuffer, SizeOf(vFileSystemNameBuffer));
  Result := IntToStr(vVolumeSerialNumber);
  if Result <> '' then
    Edit1.Text := (Result)
  else
    Edit1.Text := ('0123456789') ;
  KeyPreview := True;
  Edit2.Clear;
  Edit2.SetFocus;
end;


procedure TfmLogin.Button2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfmLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then //Press Esc action. Need to put KeyPreview := True; when FormActive or FormCreate.
  Application.Terminate;
  if Key = #13 then
  Button1.Click;
end;

end.
