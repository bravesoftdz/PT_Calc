unit RFT_Calc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Calcular, Math;

type
  TfmRFT_Calc = class(TForm)
    GroupBox3: TGroupBox;
    Label20: TLabel;
    ComboBox7: TComboBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    GroupBox4: TGroupBox;
    Label19: TLabel;
    ComboBox8: TComboBox;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    GroupBox5: TGroupBox;
    Label18: TLabel;
    Label27: TLabel;
    ComboBox9: TComboBox;
    ComboBox10: TComboBox;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    GroupBox6: TGroupBox;
    Edit17: TEdit;
    Edit16: TEdit;
    Edit26: TEdit;
    procedure LabeledEdit1Change(Sender: TObject);
    procedure ComboBox7Change(Sender: TObject);
    procedure LabeledEdit2Change(Sender: TObject);
    procedure LabeledEdit4Change(Sender: TObject);
    procedure LabeledEdit5Change(Sender: TObject);
    procedure LabeledEdit8Change(Sender: TObject);
    procedure ComboBox9Change(Sender: TObject);
    procedure ComboBox10Change(Sender: TObject);
    procedure Edit17Change(Sender: TObject);
    procedure Edit16Change(Sender: TObject);
    procedure Edit17Enter(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRFT_Calc: TfmRFT_Calc;

implementation

uses
  PublicUnit;

{$R *.dfm}

procedure TfmRFT_Calc.ComboBox10Change(Sender: TObject);
begin
  if TComboBox(Sender).Text <> '' then
    LabeledEdit10.Text := FloatToStr(StrToFloat(LabeledEdit8.Text) * MeshAreaCalc(StrToFloat(ComboBox10.Text)));
end;

procedure TfmRFT_Calc.ComboBox7Change(Sender: TObject);
begin
  try
    LabeledEdit3.Text := FormatFloat('0.0', (StrtoFloat(LabeledEdit4.Text) * RebarAreaCalc(StrToFloat(ComboBox7.Text))));
  except
    on e: Exception do
      LabeledEdit3.Text := e.Message;
  end;
end;

procedure TfmRFT_Calc.ComboBox9Change(Sender: TObject);
begin
  if ComboBox9.Text <> '' then
    LabeledEdit9.Text := FloatToStr(StrToFloat(LabeledEdit8.Text) * MeshAreaCalc(StrToFloat(ComboBox9.Text)))
end;

procedure TfmRFT_Calc.Edit16Change(Sender: TObject);
begin
  begin
    try
      Edit26.Text := FloatToStr(CalcularExpression(PChar(Edit16.Text)))//计算主要公式引用，CalcularExpression.
    except
      on e: Exception do
        Edit26.Text := e.Message;
    end;
  end;
end;

procedure TfmRFT_Calc.Edit17Change(Sender: TObject);
begin
  try
    Edit16.Text := FloatToStr(CalcularExpression(PChar(Edit17.Text)))//计算主要公式引用，CalcularExpression.
  except
    on e: Exception do
      Edit16.Text := e.Message;
  end;
end;

procedure TfmRFT_Calc.Edit17Enter(Sender: TObject);
begin
  if TEdit(Sender).Text = 'INPUT FORMULA HERE' then
    Edit17.Clear;
end;

procedure TfmRFT_Calc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  fmRFT_Calc := nil;
end;

procedure TfmRFT_Calc.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    perform(WM_NEXTDLGCTL, 0, 0);//相当于按一下Tab键
end;

procedure TfmRFT_Calc.LabeledEdit1Change(Sender: TObject);
begin
  try
    LabeledEdit4.Text := FloatToStr((StrToFloat(LabeledEdit1.Text) * 1000 / StrtoFloat(LabeledEdit2.Text))); //Ceil(X)取得大于等于X的最小的整数
    LabeledEdit3.Text := FormatFloat('0.0', (StrtoFloat(LabeledEdit4.Text) * RebarAreaCalc(StrToFloat(ComboBox7.Text))));
    LabeledEdit8.Text := LabeledEdit1.Text;
  except
    on e: Exception do
      LabeledEdit3.Text := e.Message;
  end;
end;

procedure TfmRFT_Calc.LabeledEdit2Change(Sender: TObject);
begin
  try
    LabeledEdit4.Text := FloatToStr((StrToFloat(LabeledEdit1.Text) * 1000 / StrtoFloat(LabeledEdit2.Text))); //Ceil(X)取得大于等于X的最小的整数
    LabeledEdit3.Text := FormatFloat('0.0', (StrtoFloat(LabeledEdit4.Text) * RebarAreaCalc(StrToFloat(ComboBox7.Text))));
  except
    on e: Exception do
      LabeledEdit3.Text := e.Message;
  end;
end;

procedure TfmRFT_Calc.LabeledEdit4Change(Sender: TObject);
begin
  try
    LabeledEdit3.Text := FormatFloat('0.0', (StrtoFloat(LabeledEdit4.Text) * RebarAreaCalc(StrToFloat(ComboBox7.Text))));
  except
    on e: Exception do
      LabeledEdit3.Text := e.Message;
  end;
end;

procedure TfmRFT_Calc.LabeledEdit5Change(Sender: TObject);
begin
  try
    //Ceil 返回不小于value的下一个整数,需要uses math;
    LabeledEdit6.Text := FloatToStr(Ceil(StrToFloat(LabeledEdit5.Text) * StrToFloat(LabeledEdit7.Text) / RebarAreaCalc(StrToFloat(ComboBox8.Text))));
  except
    on e: Exception do
      LabeledEdit6.Text := e.Message;
  end;
end;

procedure TfmRFT_Calc.LabeledEdit8Change(Sender: TObject);
begin
  try
    LabeledEdit9.Text := FloatToStr(StrToFloat(LabeledEdit8.Text) * MeshAreaCalc(StrToFloat(ComboBox9.Text)));
    LabeledEdit10.Text := FloatToStr(StrToFloat(LabeledEdit8.Text) * MeshAreaCalc(StrToFloat(ComboBox10.Text)));
  except
    on e: Exception do
    begin
      LabeledEdit10.Text := e.Message;
      LabeledEdit9.Text := e.Message;
    end;
  end;
end;

end.
