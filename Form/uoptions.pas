unit uOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, MPHexEditor,
  ValEdit, MPHexEditorEx, IniFiles;

type
  TdlgOptions = class(TForm)
    FontDialog1: TFontDialog;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    cbColors: TComboBox;
    cbFore: TColorBox;
    cbBack: TColorBox;
    GroupBox2: TGroupBox;
    ValueListEditor1: TValueListEditor;
    btnFont: TButton;
    Label1: TLabel;
    Bevel1: TBevel;
    Hexer: TMPHexEditorEx;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PageControl1: TPageControl;
    tsHexEditer: TTabSheet;
    TabSheet1: TTabSheet;
    CheckBox8: TCheckBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Edit1: TEdit;
    Edit4: TEdit;
    Edit7: TEdit;
    Edit10: TEdit;
    Edit13: TEdit;
    Edit2: TEdit;
    Edit5: TEdit;
    Edit8: TEdit;
    Edit11: TEdit;
    Edit3: TEdit;
    Edit6: TEdit;
    Edit9: TEdit;
    Edit12: TEdit;
    GroupBox10: TGroupBox;
    Label30: TLabel;
    Label17: TLabel;
    Label32: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Edit_R: TEdit;
    Edit_Y_dis: TEdit;
    Edit_dis: TEdit;
    CheckBox2: TCheckBox;
    Edit_Y_dis2: TEdit;
    Edit_a1: TEdit;
    Edit_b1: TEdit;
    Edit_c1: TEdit;
    Edit_a2: TEdit;
    Edit_b2: TEdit;
    Edit_c2: TEdit;
    TabSheet2: TTabSheet;
    TrackBar1: TTrackBar;
    Label18: TLabel;
    ComboBox1: TComboBox;
    Label19: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure cbColorsSelect(Sender: TObject);
    procedure cbForeSelect(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure FontDialog1Apply(Sender: TObject; Wnd: HWND);
    procedure ValueListEditor1Validate(Sender: TObject; ACol,
      ARow: Integer; const KeyName, KeyValue: String);
    procedure ValueListEditor1KeyPress(Sender: TObject; var Key: Char);
    procedure ValueListEditor1StringsChange(Sender: TObject);
    procedure HexerQueryPublicProperty(Sender: TObject;
      const PropertyName: String; var IsPublic: Boolean);
    procedure CheckBox2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure SetProperties;
  end;

var
  dlgOptions: TdlgOptions;

function EditEditorOptions(var Options: string): Boolean;

implementation

uses
  uTendonProfile, PublicUnit, uMain;

function EditEditorOptions(var Options: string): Boolean;
begin
  with TDlgOptions.Create(Application) do
  try
    Hexer.PropertiesAsString := Options;
    SetProperties;
    Result := ShowModal = mrOK;
    if Result
    then
      Options := Hexer.PropertiesAsString;
  finally
    Free;
  end;
end;

const
  // value list strings
  STR_VL_NOSIZECHG = 'Fixed file size';
  STR_VL_SWAPNIBBLES = 'Swap halfbytes (nibbles)';
  STR_VL_SHOWGRID = 'Show grid';
  STR_VL_OLEDND = 'OLE drag and drop';
  STR_VL_CREATEBACKUP = 'Create backups';
  STR_VL_BACKUPEXT = 'Backup file extension';
  STR_VL_CLIPHEX = 'Clipboard text data has Hex format';
  STR_VL_FLUSHCLIP = 'Preserve clipboard contents on close';
  STR_VL_FOREIGNCLIP = 'Support foreign clipboard formats';
  STR_VL_ZOOMONWHEEL = 'Use mouse wheel for zooming';
  STR_VL_MASKCHAR = 'Substitute whiteSpaces by';
  STR_VL_MAXUNDO = 'Max. size of Undo buffer (Byte)';
  STR_VL_HEXLOWER = 'Hex numbers in lower case';
  STR_VL_GUTTER3D = 'Gutter has 3D border';
  STR_VL_RULER = 'Show ruler';
  STR_VL_AUTOBYTESPERROW = 'Automatic row size';

  STR_BOOL: array[Boolean] of string = (
    'No', 'Yes'
  );
{$R *.dfm}

procedure TdlgOptions.FormCreate(Sender: TObject);
var
  LIntLoop: Integer;
  LStrData: string;
  LrecBook:TMPHBookmark;
begin

  LStrData := '';
  for LIntLoop := 0 to 255
  do
    LStrData := LStrData + Char(LIntLoop);

  Hexer.AsText := LStrData;

  Hexer.Seek(0,soFromBeginning);

  LrecBook.mPosition := 2;
  LrecBook.mInCharField := True;
  Hexer.Bookmark[4] := LrecBook;
  Hexer.ByteChanged[1] := True;

  ComboBox1.Items.AddStrings(SearchLanguagePack);
  ComboBox1.Text := FIni.ReadString('Language','Language','');
end;

procedure TdlgOptions.cbColorsSelect(Sender: TObject);
begin
  Label2.Enabled := True;
  Label3.Enabled := True;
  cbFore.Enabled := True;
  cbBack.Enabled := True;
  with cbColors do
    case ItemIndex of
      0://Offset
      begin
        cbFore.Selected := Hexer.Colors.Offset;
        cbBack.Selected := Hexer.Colors.OffsetBackGround;
      end;
      1://Current Offset
      begin
        cbFore.Selected := Hexer.Colors.CurrentOffset;
        cbBack.Selected := Hexer.Colors.CurrentOffsetBackGround;
      end;
      2://Characters
      begin
        cbFore.Selected := Hexer.Font.Color;
        cbBack.Selected := Hexer.Colors.Background;
      end;
      3://Even Column
      begin
        cbFore.Selected := Hexer.Colors.EvenColumn;
        cbBack.Selected := Hexer.Colors.Background;
      end;
      4://Odd Column
      begin
        cbFore.Selected := Hexer.Colors.OddColumn;
        cbBack.Selected := Hexer.Colors.Background;
      end;
      5://Modified
      begin
        cbFore.Selected := Hexer.Colors.ChangedText;
        cbBack.Selected := Hexer.Colors.ChangedBackground;
      end;
      6://Grid
      begin
        cbFore.Selected := Hexer.Colors.Grid;
        cbBack.Selected := Hexer.Colors.Background;
      end;
      7:
      begin
        cbBack.Selected := Hexer.Colors.ActiveFieldBackground;
        cbFore.Enabled := False;
        Label2.Enabled := False;
      end;
    else
      Label2.Enabled := False;
      Label3.Enabled := False;
      cbFore.Enabled := False;
      cbBack.Enabled := False;
    end;
end;

procedure TdlgOptions.cbForeSelect(Sender: TObject);
begin
  with cbColors
  do
    case ItemIndex of
      0://Offset
      begin
        Hexer.Colors.Offset := cbFore.Selected;
        Hexer.Colors.OffsetBackGround := cbBack.Selected;
      end;
      1://Current Offset
      begin
        Hexer.Colors.CurrentOffset := cbFore.Selected;
        Hexer.Colors.CurrentOffsetBackGround := cbBack.Selected;
      end;
      2://Characters
      begin
        Hexer.Font.Color := cbFore.Selected;
        Hexer.Colors.Background := cbBack.Selected;
      end;
      3://Even Column
      begin
        Hexer.Colors.EvenColumn := cbFore.Selected;
        Hexer.Colors.Background := cbBack.Selected;
      end;
      4://Odd Column
      begin
        Hexer.Colors.OddColumn := cbFore.Selected;
        Hexer.Colors.Background := cbBack.Selected;
      end;
      5://Modified
      begin
        Hexer.Colors.ChangedText := cbFore.Selected;
        Hexer.Colors.ChangedBackground := cbBack.Selected;
      end;
      6://Grid
      begin
        Hexer.Colors.Grid := cbFore.Selected;
        Hexer.Colors.Background := cbBack.Selected;
      end;
      7: Hexer.Colors.ActiveFieldBackground := cbBack.Selected;
    end;
end;

procedure TdlgOptions.btnFontClick(Sender: TObject);
var
  LfntTemp: TFont;
begin
  LfntTemp := TFont.Create;
  try
    LfntTemp.Assign(Hexer.Font);
    with FontDialog1 do
    begin
      Device := fdScreen;
      Options := Options+[fdApplyButton];
      Font.Assign(LfntTemp);
      if Execute
      then
        Hexer.Font.Assign(Font)
      else
        Hexer.Font.Assign(LfntTemp);
    end;
  finally
    LfntTemp.Free;
  end;
end;

procedure TdlgOptions.FontDialog1Apply(Sender: TObject; Wnd: HWND);
begin
  Hexer.Font.Assign(FontDialog1.Font);
end;

procedure TdlgOptions.SetProperties;

  procedure AddBool(const Key: string; const Value: Boolean);
  var
    LIntRow: Integer;
  begin
    with ValueListEditor1 do
    begin
      LIntRow := Strings.Add(Key+'='+STR_BOOL[Value]);
      with ItemProps[LIntRow] do
      begin
        EditStyle := esPickList;
        PickList.Text := STR_BOOL[False]+#13#10+STR_BOOL[True];
        ReadOnly := True;
      end;
    end;
  end;

  procedure AddString(const Key, Value: string);
  begin
    ValueListEditor1.Strings.Add(Key+'='+Value)
  end;

begin
  cbColors.ItemIndex := 0;
  cbColorsSelect(cbColors);
  with Hexer do
  begin
    AddBool(STR_VL_NOSIZECHG, NoSizeChange);
    AddBool(STR_VL_SWAPNIBBLES, SwapNibbles);
    AddBool(STR_VL_SHOWGRID, DrawGridLines);
    AddBool(STR_VL_OLEDND, OleDragDrop);
    AddBool(STR_VL_CREATEBACKUP, CreateBackup);
    AddString(STR_VL_BACKUPEXT, BackupExtension);
    AddBool(STR_VL_CLIPHEX, ClipboardAsHexText);
    AddBool(STR_VL_FLUSHCLIP, FlushClipboardAtShutDown);
    AddBool(STR_VL_FOREIGNCLIP, SupportsOtherClipFormats);
    AddBool(STR_VL_ZOOMONWHEEL, ZoomOnWheel);
    AddString(STR_VL_MASKCHAR, MaskChar);
    AddString(STR_VL_MAXUNDO, IntToStr(MaxUndo));
    AddBool(STR_VL_HEXLOWER, HexLowerCase);
    AddBool(STR_VL_GUTTER3D, DrawGutter3D);
    AddBool(STR_VL_RULER, ShowRuler);
    AddBool(STR_VL_AUTOBYTESPERROW, AutoBytesPerRow);
  end;
  Hexer.AllowInsertMode := False;
  Hexer.ReadOnlyView := True;
  Hexer.ByteChanged[1] := True;
end;

procedure TdlgOptions.TrackBar1Change(Sender: TObject);
begin
  fmMain.AlphaBlend := True;
  fmMain.AlphaBlendValue := TrackBar1.Position;
end;

procedure TdlgOptions.ValueListEditor1Validate(Sender: TObject; ACol,
  ARow: Integer; const KeyName, KeyValue: String);
begin
  with Hexer
  do
  case ARow of
    1: NoSizeChange := KeyValue = STR_BOOL[True];
    2: SwapNibbles := KeyValue = STR_BOOL[True];
    3: DrawGridLines := KeyValue = STR_BOOL[True];
    4: OleDragDrop := KeyValue = STR_BOOL[True];
    5: CreateBackup := KeyValue = STR_BOOL[True];
    6: BackupExtension := KeyValue;
    7: ClipboardAsHexText := KeyValue = STR_BOOL[True];
    8: FlushClipboardAtShutDown := KeyValue = STR_BOOL[True];
    9: SupportsOtherClipFormats := KeyValue = STR_BOOL[True];
    10: ZoomOnWheel := KeyValue = STR_BOOL[True];
    11: MaskChar := (KeyValue+#0)[1];
    12: MaxUndo := StrToInt('0'+KeyValue);
    13: HexLowerCase := KeyValue = STR_BOOL[True];
    14: DrawGutter3D := KeyValue = STR_BOOL[True];
    15: ShowRuler := KeyValue = STR_BOOL[True];
    16: AutoBytesPerRow := KeyValue = STR_BOOL[True];
  end;
end;

procedure TdlgOptions.ValueListEditor1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13
  then
    with ValueListEditor1
    do
      ValueListEditor1Validate(ValueListEditor1, Col, Row, Keys[Row],Values[Keys[Row]]);
end;

procedure TdlgOptions.ValueListEditor1StringsChange(Sender: TObject);
begin
  with ValueListEditor1
  do
    if Values[Keys[Row]] <> ''
    then
      ValueListEditor1Validate(ValueListEditor1, Col, Row, Keys[Row],Values[Keys[Row]]);

end;

procedure TdlgOptions.HexerQueryPublicProperty(Sender: TObject;
  const PropertyName: String; var IsPublic: Boolean);
const
  // properties not to get/set
  NO_PROPS = ';ReadOnlyView;AllowInsertMode;CaretKind;InsertMode;';
begin
  IsPublic := Pos(';'+LowerCase(PropertyName)+';', LowerCase(NO_PROPS)) = 0;
end;

procedure TdlgOptions.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked then
  begin
    Edit_R.Enabled := True;
    Edit_dis.Enabled := True;
    Edit_Y_dis.Enabled := True;
    Edit_Y_dis2.Enabled := True;
    Edit_a1.Enabled := True;
    Edit_b1.Enabled := True;
    Edit_c1.Enabled := True;
    Edit_a2.Enabled := True;
    Edit_b2.Enabled := True;
    Edit_c2.Enabled := True;
  end
  else
  begin
    Edit_R.Enabled := False;
    Edit_dis.Enabled := False;
    Edit_Y_dis.Enabled := False;
    Edit_Y_dis2.Enabled := False;
    Edit_a1.Enabled := False;
    Edit_b1.Enabled := False;
    Edit_c1.Enabled := False;
    Edit_a2.Enabled := False;
    Edit_b2.Enabled := False;
    Edit_c2.Enabled := False;
  end;
end;

procedure TdlgOptions.RadioButton1Click(Sender: TObject);
var
  temp : string;
begin
  Edit13.Text := '2500';
  Edit1.Text := '2730';
  Edit2.Text := '3080';
  Edit3.Text := '4130';
  Edit4.Text := '4480';
  Edit5.Text := '5530';
  Edit6.Text := '6580';
  Edit7.Text := '7280';
  Edit8.Text := '7630';
  Edit9.Text := '7980';
  Edit10.Text := '8330';
  Edit11.Text := '9030';
  Edit12.Text := '11130';



  case uTendonProfile.fmTendonProfile.ComboBox6.ItemIndex of
    0:
      begin
        Edit_R.Text := Edit13.Text;
      end;
    1:
      begin
        Edit_R.Text := Edit1.Text;
      end;
    2:
      begin
        Edit_R.Text := Edit2.Text;
      end;
    3:
      begin
        Edit_R.Text := Edit3.Text;
      end;
    4:
      begin
        Edit_R.Text := Edit4.Text;
      end;
    5:
      begin
        Edit_R.Text := Edit5.Text;
      end;
    6:
      begin
        Edit_R.Text := Edit6.Text;
      end;
    7:
      begin
        Edit_R.Text := Edit7.Text;
      end;
    8:
      begin
        Edit_R.Text := Edit8.Text;
      end;
    9:
      begin
        Edit_R.Text := Edit9.Text;
      end;
    10:
      begin
        Edit_R.Text := Edit10.Text;
      end;
    11:
      begin
        Edit_R.Text := Edit11.Text;
      end;
    12:
      begin
        Edit_R.Text := Edit12.Text;
      end;
  end;

  temp := fmTendonProfile.Edit_X.Text;
  fmTendonProfile.Edit_X.Text := '1000';
  fmTendonProfile.Edit_X.Text := temp;
end;

procedure TdlgOptions.RadioButton2Click(Sender: TObject);
var
  temp : string;
begin
  Edit13.Text := '5000';
  Edit1.Text := '3200';
  Edit2.Text := '3200';
  Edit3.Text := '3200';
  Edit4.Text := '4200';
  Edit5.Text := '4200';
  Edit6.Text := '5300';
  Edit7.Text := '5700';
  Edit8.Text := '6700';
  Edit9.Text := '6700';
  Edit10.Text := '6700';
  Edit11.Text := '9030';
  Edit12.Text := '11130';

  case fmTendonProfile.ComboBox6.ItemIndex of
    0:
      begin
        Edit_R.Text := Edit13.Text;
      end;
    1:
      begin
        Edit_R.Text := Edit1.Text;
      end;
    2:
      begin
        Edit_R.Text := Edit2.Text;
      end;
    3:
      begin
        Edit_R.Text := Edit3.Text;
      end;
    4:
      begin
        Edit_R.Text := Edit4.Text;
      end;
    5:
      begin
        Edit_R.Text := Edit5.Text;
      end;
    6:
      begin
        Edit_R.Text := Edit6.Text;
      end;
    7:
      begin
        Edit_R.Text := Edit7.Text;
      end;
    8:
      begin
        Edit_R.Text := Edit8.Text;
      end;
    9:
      begin
        Edit_R.Text := Edit9.Text;
      end;
    10:
      begin
        Edit_R.Text := Edit10.Text;
      end;
    11:
      begin
        Edit_R.Text := Edit11.Text;
      end;
    12:
      begin
        Edit_R.Text := Edit12.Text;
      end;
  end;

  temp := fmTendonProfile.Edit_X.Text;
  fmTendonProfile.Edit_X.Text := '1000';
  fmTendonProfile.Edit_X.Text := temp;
end;
end.
