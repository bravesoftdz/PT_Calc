unit uHexEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, MPHexEditor, MPHexEditorEx;

type
  TfmHexEditor = class(TForm)
    MPHexEditorEx2: TMPHexEditorEx;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmHexEditor: TfmHexEditor;

implementation


  
{$R *.dfm}

procedure TfmHexEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  fmRAPT_Crack := nil;
end;

end.
