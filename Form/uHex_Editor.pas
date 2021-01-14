unit uHex_Editor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, MPHexEditor, MPHexEditorEx;

type
  TfmHexEditor = class(TForm)
    MPHexEditorEx1: TMPHexEditorEx;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmHexEditor: TfmHexEditor;

implementation

uses uMain, PublicUnit, uHexEditor;


  
{$R *.dfm}

procedure TfmHexEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  Action := caFree;
//  fmHexEditor := nil;
end;

procedure TfmHexEditor.FormCreate(Sender: TObject);
var
  LsrlData: TStrings;
begin
  // make sure that MYGRID is not defined in mphexeditor.pas
  Assert(fmHexEditor.MPHexEditorEx1 is TCustomGrid);


  //copy form loadprops,
  LsrlData := TStringList.Create;
  try
    FIni.ReadSectionValues(STR_INI_EDITOR, LsrlData);
    if LsrlData.Count > 1 then
    try
      fmHexEditor.MPHexEditorEx1.PropertiesAsString := LsrlData.Text;
    except
    end;
  finally
    LsrlData.Free;
  end;


end;

end.
