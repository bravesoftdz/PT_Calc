unit Concrete_Strength;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils;

type
  TForm_Concrete_Strength = class(TForm)
    Memo9: TMemo;
    GroupBox10: TGroupBox;
    Label3: TLabel;
    Label32: TLabel;
    Label35: TLabel;
    ComboBox12: TComboBox;
    Edit29: TEdit;
    Edit30: TEdit;
    procedure ComboBox12Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Concrete_Strength: TForm_Concrete_Strength;

implementation

{$R *.dfm}

procedure TForm_Concrete_Strength.ComboBox12Change(Sender: TObject);
begin
  Edit29.Text := MidStr(ComboBox12.Text,2,2);
  Edit30.Text := FloatToStr(StrToFloat(MidStr(ComboBox12.Text,2,2))/0.8);
end;

end.
