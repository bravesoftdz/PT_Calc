unit uCAD2Excel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfmCAD2Excel = class(TForm)
    GroupBox7: TGroupBox;
    Label31: TLabel;
    Label33: TLabel;
    Label26: TLabel;
    Edit19: TEdit;
    ComboBox11: TComboBox;
    Button1: TButton;
    Edit20: TEdit;
    GroupBox8: TGroupBox;
    Memo5: TMemo;
    Memo6: TMemo;
    Memo7: TMemo;
    Memo8: TMemo;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCAD2Excel: TfmCAD2Excel;

implementation

uses
  uMain;

{$R *.dfm}

procedure TfmCAD2Excel.Button1Click(Sender: TObject);
var
  F: TextFile; //TextFile 和 Text 是一样的
  FileName: string;
begin
  SaveDialog1.Filter := 'AutoLISP Application Source (.lsp)|*.lsp';
  SaveDialog1.Title := 'Save';
  SaveDialog1.DefaultExt := '.lsp';

  if SaveDialog1.Execute then
  begin
    FileName := SaveDialog1.FileName; //create data file
    AssignFile(F, FileName);
    Rewrite(F); //会覆盖已存在的文件

    if ComboBox11.ItemIndex = 0 then
      Writeln(F, '' + Memo5.Text) //By layer .lsp
    else if ComboBox11.ItemIndex = 1 then
      Writeln(F, '' + Memo6.Text) //By select .lsp option1
    else if ComboBox11.ItemIndex = 2 then
      Writeln(F, '' + Memo7.Text); //By layer .lsp option2

    CloseFile(F);
  end
  else
    Abort;

end;

procedure TfmCAD2Excel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  fmCAD2Excel := nil;
end;

end.
