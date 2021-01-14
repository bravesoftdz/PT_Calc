unit uRAPTConverter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, MPHexEditor, MPHexEditorEx, StrUtils;

type
  TfmRAPTConvert = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    MPHexEditorEx1: TMPHexEditorEx;
    Edit2: TEdit;
    Edit3: TEdit;
    ComboBox1: TComboBox;
    Label1: TLabel;
    ComboBox2: TComboBox;
    Label2: TLabel;
    ComboBox3: TComboBox;
    Label3: TLabel;
    ComboBox4: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRAPTConvert: TfmRAPTConvert;

implementation

uses
  uMain;
  
{$IFNDEF DELPHI6UP}
const
  clMoneyGreen = TColor($C0DCC0);
  clSkyBlue = TColor($F0CAA6);
  clCream = TColor($F0FBFF);
{$ENDIF}

{$R *.dfm}

procedure TfmRAPTConvert.Button1Click(Sender: TObject);
begin
  with fmMain.OpenDialog1 do
  begin
    Filter := 'RAPT file (.rpf)|*.rpf';
    FileName := 'Frame.rpf';
    Title := 'Open RAPT file';
    DefaultExt := '.rpf';
    if Execute then
      MPHexEditorEx1.LoadFromFile(FileName);
  end;
end;

procedure TfmRAPTConvert.FormCreate(Sender: TObject);
begin
  // make sure that MYGRID is not defined in mphexeditor.pas
  Assert(MPHexEditorEx1 is TCustomGrid);
end;


function SaveFile(const ForceNewName: Boolean): Boolean;
begin
  Result := True;
  with fmRAPTConvert.MPHexEditorEx1 do
  try
    if (not Modified) or (not HasFile) or (ReadOnlyFile) or ForceNewName then
    begin
      with fmMain.SaveDialog1
      do
      begin
        Filter := 'RAPT file (.rpf)|*.rpf';
        FileName := 'Frame.rpf';
        Title := 'Open RAPT file';
        DefaultExt := '.rpf';
        if Execute
        then
          SaveToFile(FileName)
        else
          Result := False;
      end;  
    end
    else;
//      Save;
  except
    on E: Exception do
    begin
      fmRAPTConvert.MPHexEditorEx1.Modified := True;  // saving failed, so modified again
      Result := False;
      Application.ShowException(E);
    end;
  end;
end;


procedure TfmRAPTConvert.Button2Click(Sender: TObject);
begin
  SaveFile(True);
end;


procedure TfmRAPTConvert.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  fmRAPTConvert := nil;
end;

procedure TfmRAPTConvert.Button3Click(Sender: TObject);
var
  i : Integer;
  a : string;
begin
  i := StrToInt(ComboBox1.Text + ComboBox2.Text+ ComboBox3.Text + ComboBox4.Text);

  a := IntToHex(i,8);
  Edit2.Text := MidStr(a,7,2) + MidStr(a,5,2);
  Edit3.Text := MidStr(a,3,2) + MidStr(a,1,2);

end;

end.
