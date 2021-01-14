unit uElongation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Menus;

type
  TfmElongation = class(TForm)
    GroupBox1: TGroupBox;
    lbl1: TLabel;
    lbl4: TLabel;
    lbl2: TLabel;
    lbl7: TLabel;
    lbl6: TLabel;
    lbl5: TLabel;
    lbl3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit11: TEdit;
    Edit6: TEdit;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit27: TEdit;
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ComboBox3: TComboBox;
    PopupMenu1: TPopupMenu;
    Menu_AddRow: TMenuItem;
    Menu_DeleteRow: TMenuItem;
    SaveDialog1: TSaveDialog;
    procedure FormActivate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Menu_AddRowClick(Sender: TObject);
    procedure Menu_DeleteRowClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox3CloseUp(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmElongation: TfmElongation;

implementation

uses
  uMain;

{$R *.dfm}

procedure TfmElongation.FormActivate(Sender: TObject);
begin
  with StringGrid1 do
  begin
    Cells[0, 1] := '1.';
    Cells[0, 2] := '2.';
    Cells[0, 3] := '3.';
    Cells[0, 4] := '4.';
    Cells[0, 5] := '5.';

    Cells[0, 0] := 'TENDON';
    Cells[1, 0] := 'Length(m)';
    Cells[2, 0] := 'Strands no.';
    Cells[3, 0] := 'Stress End No.';
    Cells[4, 0] := 'End Factor-Front';
    Cells[5, 0] := 'End Factor-Rebar';
    Cells[6, 0] := 'Y1';
    Cells[7, 0] := 'X1';
    Cells[8, 0] := 'Y2';
    Cells[9, 0] := 'X2';
    Cells[10, 0] := 'Y3';
    Cells[11, 0] := 'X3';
    Cells[12, 0] := 'Y4';
    Cells[13, 0] := 'X4';
    Cells[14, 0] := 'Y5';
    Cells[15, 0] := 'X5';
    Cells[16, 0] := 'Y6';
    Cells[17, 0] := 'X6';
    Cells[18, 0] := 'Y7';
    Cells[19, 0] := 'X7';
    Cells[20, 0] := 'Y8';
    Cells[21, 0] := 'X8';
    Cells[22, 0] := 'Y9';
    Cells[23, 0] := 'X9';
    Cells[24, 0] := 'Y10';
    Cells[25, 0] := 'X10';
    Cells[26, 0] := 'Y11';
    Cells[27, 0] := 'X11';
    Cells[28, 0] := 'Y12';
    Cells[29, 0] := 'X12';
    Cells[30, 0] := 'Y13';
    Cells[31, 0] := 'X13';
    Cells[32, 0] := 'Y14';
    Cells[33, 0] := 'X14';
    Cells[34, 0] := 'Y15';
    Cells[35, 0] := 'Angular Deviation';
    Cells[36, 0] := 'P(l)/P(o)';
    Cells[37, 0] := 'd1';
    Cells[38, 0] := 'd2';
    Cells[39, 0] := 'Elongation';
  end;
end;

procedure TfmElongation.Button4Click(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to StringGrid1.RowCount - 1 do
    StringGrid1.Rows[i].Clear;
end;

procedure TfmElongation.Button3Click(Sender: TObject);
var
  row: Integer;
  Msg: string;
begin
  if (StringGrid1.Cells[1, 1] = '') or (StringGrid1.Cells[39, 1] = '') then
    MessageBox(Handle, Pchar('Warning ：' + #13 + #13 + 'Please input the necessary parameters and Calculate first!'), 'Check Result:', MB_OK + MB_ICONASTERISK)
  else
  begin
    for row := 1 to StringGrid1.RowCount - 1 do
    begin
      if (StringGrid1.Cells[1, row] <> '') and (StringGrid1.Cells[39, row] <> '') then
        Msg := Msg + 'Tendon No. ' + IntToStr(row) + '  =  ' + FormatFloat('0.00', (StrToFloat(StringGrid1.Cells[39, row]) / StrToFloat(StringGrid1.Cells[1, row]))) + '  mm' + #13 + #13;
    end;
    MessageBox(Handle, Pchar('Elongation Per Meter Tendon ：' + #13 + #13 + Msg), 'Check Result:', MB_OK + MB_ICONASTERISK);
  end;
end;

procedure TfmElongation.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
  org: TPoint;
begin
  with Sender as TStringGrid do
    if (ACol = 3) and (ARow >= FixedRows) then //在第3列显示一个ComboBox
    begin
      perform(WM_CANCELMODE, 0, 0);
      R := CellRect(ACol, ARow);
      org := Self.ScreenToClient(ClientToScreen(R.topleft));
      with ComboBox3 do
      begin
        setbounds(org.X - 0, org.Y - 0, R.right - R.left, height);
        itemindex := Items.IndexOf(Cells[ACol, ARow]);
        Show;
        BringTofront;
        SetFocus;
        DroppedDown := true;
      end;
    end;
end;

procedure TfmElongation.ComboBox3Change(Sender: TObject);
begin
  with Sender as TComboBox do
  begin
    hide;
    if itemindex >= 0 then
      with StringGrid1 do
        Cells[col, row] := Items[itemindex];
  end;
end;

procedure TfmElongation.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
  0:
  begin
    Edit2.Text := '98.7';
    Edit4.Text := '137.78';
    Edit22.Text := '0.775';
    Edit23.Text := '183.7';
    Edit27.Text := '1860';
  end;
  1:
  begin
    Edit2.Text := '100.0';
    Edit4.Text := '139.50';
    Edit22.Text := '0.785';
    Edit23.Text := '186';
    Edit27.Text := '1860';
  end;
  2:
  begin
    Edit2.Text := '139.0';
    Edit4.Text := '194.25';
    Edit22.Text := '1.102';
    Edit23.Text := '260.7';
    Edit27.Text := '1860';
  end;
  3:
  begin
    Edit2.Text := '150.0';
    Edit4.Text := '198.75';
    Edit22.Text := '1.180';
    Edit23.Text := '265';
    Edit27.Text := '1770';
  end;
  end;

end;

procedure TfmElongation.Menu_AddRowClick(Sender: TObject);
begin
  StringGrid1.RowCount := StringGrid1.RowCount + 1;
end;

procedure TfmElongation.Menu_DeleteRowClick(Sender: TObject);
begin
  StringGrid1.RowCount := StringGrid1.RowCount - 1;
end;

procedure TfmElongation.Button1Click(Sender: TObject);
var
  Stressing_End, E: integer;
  u, k, Po, Pl, P1, P2, Length, Angular_Deviation, d1, d2, Elongation_d, A: Double;
  i, Row, Col: Integer;
  j: Double;
begin
  Stressing_End := 2;
  Angular_Deviation := 0;
  A := StrToFloat(Edit2.Text);
  E := StrToInt(Edit1.Text);
  u := StrToFloat(Edit6.Text);
  k := StrToFloat(Edit3.Text);
  Po := StrToFloat(Edit4.Text);

  for Row := 1 to StringGrid1.RowCount - 1 do
  begin
    if StringGrid1.Cells[6, 1] = '' then
    begin
      MessageBox(Handle, PChar('Please key in the necessary parameters first!'), 'Notice', MB_OK + MB_ICONASTERISK);
      Exit;
    end
    else if StringGrid1.Cells[6, Row] = '' then
    begin
      MessageBox(Handle, PChar('Total [ ' + IntToStr(Row - 1) + ' ] row tendon profile calculated!'), 'Notice', MB_OK + MB_ICONASTERISK);
      Exit;
    end
    else
    begin
      for i := 4 to 17 do
        if StringGrid1.Cells[2 * i, Row] <> '' then
        begin
          Angular_Deviation := 0;

          for Col := i downto 4 do
          begin
            j := 4 * Abs(StrToInt(StringGrid1.Cells[2 * Col, Row]) - StrToInt(StringGrid1.Cells[2 * Col - 2, Row])) / StrToInt(StringGrid1.Cells[2 * Col - 1, Row]);
            Angular_Deviation := j + Angular_Deviation;
          end;
        end
        else

      Stressing_End := StrToInt(StringGrid1.Cells[3, Row]);
      Length := StrToFloat(StringGrid1.Cells[1, Row]);
      Pl := Po * Exp(-(u * Angular_Deviation + k * Length));
      P1 := 0.5 * (Po + Pl);
      P2 := 0.5 * (Po - Pl);
      d1 := (P1 * Length * 1000) / (A * E);
      d2 := (P2 * Length / 2 * 1000) / (A * E);

      if Stressing_End = 1 then
        Elongation_d := d1
      else
        Elongation_d := d1 + d2;

      StringGrid1.Cells[35, Row] := FormatFloat('0.00', Angular_Deviation);
      StringGrid1.Cells[36, Row] := FormatFloat('0.00', (Pl / Po));
      StringGrid1.Cells[37, Row] := FormatFloat('0.00', (d1));
      StringGrid1.Cells[38, Row] := FormatFloat('0.00', (d2));
      StringGrid1.Cells[39, Row] := FormatFloat('0.00', (Elongation_d));
      StringGrid1.Col := 39;
    end;
  end;
end;

procedure TfmElongation.Button2Click(Sender: TObject);
var
  i: integer;
  F: TextFile; //TextFile 和 Text 是一样的
  FileName: string;
begin
  SaveDialog1.Filter := 'Elongation Calculation Report (.rtp)|*.rpt';
  SaveDialog1.Title := 'Save report';
  SaveDialog1.DefaultExt := '.rpt';

  i := 0;
  if SaveDialog1.Execute then
  begin
    FileName := SaveDialog1.FileName; //create data file

    AssignFile(F, FileName);
    Rewrite(F); //会覆盖已存在的文件
    Writeln(F, 'ELONGATION CALCULATION REPORT'); //先单独写入此段字符
    Writeln(F, DateTimeToStr(Now)); //先单独写入此段字符
    Writeln(F, 'Project Name: ' + Self.Edit11.Text);
    Writeln(F, 'Coeff. of Friction (u): ' + Self.Edit6.Text);
    Writeln(F, 'Strand Size (d): ' + Self.ComboBox1.Text);
    Writeln(F, 'Stress Force (Po): ' + Self.Edit4.Text + 'KN');
    Writeln(F, 'Strand Area (A): ' + Self.Edit2.Text + 'mm2');
    Writeln(F, 'Elasticity Mod (E): ' + Self.Edit1.Text + 'KN/mm2');
    Writeln(F, 'Wobble Factor (k): ' + Self.Edit3.Text);

    with StringGrid1 do
    begin
      Writeln(F, Cells[0, i] + #9 + Cells[1, i] + #9 + Cells[2, i] + #9 + Cells[3, i] + #9 + Cells[4, i] + #9 + Cells[5, i] + #9 + Cells[6, i] + #9 + Cells[7, i] + #9 + Cells[8, i] + #9 + Cells[9, i] + #9 + Cells[10, i] + #9 + Cells[11, i] + #9 + Cells[12, i] + #9 + Cells[13, i] + #9 + Cells[14, i] + #9 + Cells[15, i] + #9 + Cells[16, i] + #9 + Cells[17, i] + #9 + Cells[18, i] + #9 + Cells[19, i] + #9 + Cells[20, i] + #9 + Cells[21, i] + #9 + Cells[22, i] + #9 + Cells[23, i] + #9 + Cells[24, i] + #9 + Cells
        [25, i] + #9 + Cells[26, i] + #9 + Cells[27, i] + #9 + Cells[28, i] + #9 + Cells[29, i] + #9 + Cells[30, i] + #9 + Cells[31, i] + #9 + Cells[32, i] + #9 + Cells[33, i] + #9 + Cells[34, i] + #9 + Cells[35, i] + #9 + Cells[36, i] + #9 + Cells[37, i] + #9 + Cells[38, i] + #9 + Cells[39, i]);

      for i := 1 to RowCount - 1 do
      begin
        if Cells[1, i] <> '' then
        begin
          Writeln(F, Cells[0, i] + #9 + #9 + Cells[1, i] + #9 + Cells[2, i] + #9 + #9 + Cells[3, i] + #9 + #9 + Cells[4, i] + #9 + #9 + Cells[5, i] + #9 + #9 + Cells[6, i] + #9 + Cells[7, i] + #9 + Cells[8, i] + #9 + Cells[9, i] + #9 + Cells[10, i] + #9 + Cells[11, i] + #9 + Cells[12, i] + #9 + Cells[13, i] + #9 + Cells[14, i] + #9 + Cells[15, i] + #9 + Cells[16, i] + #9 + Cells[17, i] + #9 + Cells[18, i] + #9 + Cells[19, i] + #9 + Cells[20, i] + #9 + Cells[21, i] + #9 + Cells[22, i] + #9 + Cells[23, i] +
            #9 + Cells[24, i] + #9 + Cells[25, i] + #9 + Cells[26, i] + #9 + Cells[27, i] + #9 + Cells[28, i] + #9 + Cells[29, i] + #9 + Cells[30, i] + #9 + Cells[31, i] + #9 + Cells[32, i] + #9 + Cells[33, i] + #9 + Cells[34, i] + #9 + Cells[35, i] + #9 + #9 + Cells[36, i] + #9 + Cells[37, i] + #9 + Cells[38, i] + #9 + Cells[39, i]);
        end;
      end;
    end;

    CloseFile(F);
  end
  else
    Abort;

end;


////////////////////////////////Action List End////////////////////////////////
//StringGrid默认单击选择表格，双击输入，以下代码功能：鼠标移动选择表格，单击输入数据
{procedure TMainform.StringGrid1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
ACol, ARow :integer;
begin
(Sender as TStringGrid).MouseToCell(X, Y, ACol, ARow);
if (ACol>0) and (ACol<(Sender as TStringGrid).ColCount) and (ARow>0) and (ARow<(Sender as TStringGrid).RowCount) then
begin
(Sender as TStringGrid).Col:=ACol;
(Sender as TStringGrid).Row:=ARow;
(Sender as TStringGrid).SetFocus;
end;
end;}


procedure TfmElongation.ComboBox3CloseUp(Sender: TObject);
begin
  ComboBox3.Hide;
end;

procedure TfmElongation.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  MaxWidth,MaxHeight: integer;
begin
  //按内容自动调整表格宽度
  MaxWidth := StringGrid1.Canvas.TextWidth(StringGrid1.Cells[ACol, ARow]);
  if MaxWidth > StringGrid1.ColWidths[ACol] then
    StringGrid1.ColWidths[ACol] := MaxWidth + 5;
  //按内容自动调整表格高度
  MaxHeight := StringGrid1.Canvas.TextHeight(StringGrid1.Cells[ACol, ARow]);
  if MaxHeight > StringGrid1.RowHeights[ARow] then
    StringGrid1.RowHeights[ARow] := MaxHeight + 4;
end;

procedure TfmElongation.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  fmElongation := nil;
end;

end.
