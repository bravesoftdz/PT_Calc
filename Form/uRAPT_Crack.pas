unit uRAPT_Crack;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfmRAPT_Crack = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox7: TGroupBox;
    btn64bit_Opt1_Crack: TButton;
    btn64bit_Opt1_Recrack: TButton;
    btn64bit_Opt1_Uncrack: TButton;
    GroupBox2: TGroupBox;
    btn32bit_Opt2_Crack: TButton;
    btn32bit_Opt2_Uncrack: TButton;
    btn32bit_Opt2_Recrack: TButton;
    GroupBox8: TGroupBox;
    btn32bit_Opt1_Crack: TButton;
    btn32bit_Opt1_Uncrack: TButton;
    btn32bit_Opt1_Recrack: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRAPT_Crack: TfmRAPT_Crack;

implementation


  
{$R *.dfm}

procedure TfmRAPT_Crack.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  fmRAPT_Crack := nil;
end;

end.
