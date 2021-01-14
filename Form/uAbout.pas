unit uAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ShellAPI, jpeg;

type
  TfmAbout = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Shape1: TShape;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAbout: TfmAbout;

implementation

uses
  uMain, PublicUnit;

{$R *.dfm}

procedure TfmAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  fmAbout := nil;
end;

procedure TfmAbout.Label4Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', CO_URL, nil, nil, SW_Hide);
end;

end.
