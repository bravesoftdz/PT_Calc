unit uHexEditor;

interface

uses
  Windows, Forms, SysUtils, Classes, 
  Messages, ExtCtrls, Menus, ActnList, Buttons, ComCtrls,
  Dialogs, IniFiles, Controls, MPHexEditor;


// strings
const
  STR_SAVECHANGES = 'Save changes to %s?';
  STR_CAPTION = 'Post-Tension Calculation Program [%s]';
  STR_NOT_FOUND = 'No match found.';
  STR_NUM_REPLACED = '%d replacemets.';
  STR_INP_BPR = 'Change Bytes per row (0=AUTO)';
  STR_INP_BPC = 'Change Bytes per column';
  STR_INP_BPU = 'Change Bytes per unit';
  STR_INP_BPB = 'Change Bytes per block';

  // status bar
  STR_SB_POS  = 'Pos: %s';
  STR_SB_SEL  = 'Sel: %s-%s';
  STR_SB_SIZE = 'Size: %s';
  STR_SB_MOD : array[Boolean] of Char = (' ','*');
  STR_SB_RO : array[Boolean] of Char = (' ','R');
  STR_SB_INS : array[Boolean] of string = ('OVW','INS');

  // menu
  STR_MENU_EDIT_UNDO = 'Undo: %s';
  STR_MENU_EDIT_CONVERT_DATA = 'Convert Data...';
  STR_MENU_EDIT_CONVERT_SEL = 'Convert Selection...';
  STR_MENU_VIEW_BPR = 'Bytes Per Row: %d';
  STR_MENU_VIEW_BPR_AUTO = 'Bytes Per Row: AUTO (%d)';
  STR_MENU_VIEW_BPC = 'Bytes Per Column: %d';
  STR_MENU_VIEW_BPU = 'Bytes Per Unit: %d';
  STR_MENU_VIEW_BPB = 'Bytes Per Block: %d';

  // queries
  STR_QT_OFFSETPREFIX = 'Change Offset Format';
  STR_Q_OFFSETPREFIX = '[r|c|Units%][-|Width!]<Base>:[Prefix]|[Suffix]';

  STR_QT_GOTO = 'Goto';
  STR_Q_GOTO = '[-|+|!]<Amount>';

  // ini
  STR_INI_BOOKMARKS = 'Bookmarks';
  STR_INI_EDITOR    = 'Editor';

  // err->BytesPerUnit (Replace)
  STR_ERR_BPU_FINDTEXT = 'Size of data to search for must be a multiple '+
    'of Bytes per unit';
  STR_ERR_BPU_REPLACETEXT = 'Size of replacement data must be a multiple '+
    'of Bytes per unit';


  function CheckChanges: Boolean;
  // save/restore bookmarks
  procedure LoadBookmarks;
  procedure SaveBookmarks;
  // do save file
  function SaveFile(const ForceNewName: Boolean): Boolean;
  procedure UpdateStatusBar;

implementation

uses
  uMain, uHex_Editor;


function CheckChanges: Boolean;
begin
  with fmHexEditor.MPHexEditorEx1 do
  begin
    if Modified
    then
      case MessageDlg(Format(STR_SAVECHANGES,[FileName]), mtConfirmation, [mbYes, mbNo, mbCancel],0) of
        mrNo: Result := True;
        mrYes: Result := SaveFile(False);
      else
        Result := False;
      end
    else
      Result := True;
  end;
end;

function SaveFile(const ForceNewName: Boolean): Boolean;
begin
  Result := True;
  with fmHexEditor.MPHexEditorEx1 do
  try
    if (not Modified) or (not HasFile) or (ReadOnlyFile) or ForceNewName then
    begin
      with fmMain.SaveDialog1
      do
        if Execute
        then
          SaveToFile(FileName)
        else
          Result := False;
    end
    else
      Save;
  except
    on E: Exception do
    begin
      fmMain.StatusBar1.Panels[7].Text := '-';
      fmHexEditor.MPHexEditorEx1.Modified := True;  // saving failed, so modified again
      Result := False;
      Application.ShowException(E);
    end;
  end;
end;

procedure SaveBookmarks;
begin
  with fmHexEditor.MPHexEditorEx1
  do
    if HasFile then
    begin
      if BookmarksAsString = ''
      then
        FIni.DeleteKey(STR_INI_BOOKMARKS, FileName)
      else
        FIni.WriteString(STR_INI_BOOKMARKS, FileName, BookmarksAsString)
    end;
end;

procedure LoadBookmarks;
begin
  with fmHexEditor.MPHexEditorEx1
  do
    if HasFile
    then
      BookMarksAsString := FIni.ReadString(STR_INI_BOOKMARKS, FileName, '')
end;

procedure UpdateStatusBar;
var
  LEnumTrans: TMPHTranslationKind;
begin
  with fmHexEditor.MPHexEditorEx1 do
  begin
    // set form caption to show filename
    fmMain.Caption := Format(STR_CAPTION,[FileName]);

    // set statusbar
    with fmMain.StatusBar1 do
    begin
      // Position
      Panels[0].Text := Format(STR_SB_POS,[Trim(GetAnyOffsetString(GetCursorPos))]);
      // size
      Panels[1].Text := Format(STR_SB_SIZE,[Trim(GetAnyOffsetString(DataSize))]);
      // selection
      if SelCount > 0
      then
        Panels[2].Text := Format(STR_SB_SEL,[Trim(GetAnyOffsetString(Min(SelStart, SelEnd))),
          Trim(GetAnyOffsetString(Max(SelStart, SelEnd)))])
      else
        Panels[2].Text := '';
      // changed
      Panels[3].Text := STR_SB_MOD[Modified];
      // readonly
      Panels[4].Text := STR_SB_RO[ReadOnlyFile];
      // ovw/ins
      Panels[5].Text := STR_SB_INS[InsertMode];
      // translation / unicode
      if not UnicodeChars then
        Panels[6].Text := MPHTranslationDescShort[Translation]
      else
      begin
        if UnicodeBigEndian then
          Panels[6].Text := MPH_UC_BE_S
        else
          Panels[6].Text := MPH_UC_S
      end;
    end;

    // update actions - file
    fmMain.acFileSave.Enabled := HasFile and Modified and not (ReadOnlyView or ReadOnlyFile);
    fmMain.acFileSaveAs.Enabled := (not ReadOnlyView) and (DataSize > 0);

    fmMain.acFilePrint.Enabled := DataSize > 0;

    // - edit
    with fmMain.acEditUndo do
    begin
      Enabled := CanUndo;
      Caption := Format(STR_MENU_EDIT_UNDO,[UndoDescription]);
    end;
    fmMain.acEditRedo.Enabled := CanRedo;

    fmMain.acEditCut.Enabled := CanCut;
    fmMain.acEditCopy.Enabled := CanCopy;
    fmMain.acEditPaste.Enabled := CanPaste;

    fmMain.acEditInsertNibble.Enabled := not ReadOnlyView;
    fmMain.acEditDeleteNibble.Enabled := (DataSize > 0) and (not ReadOnlyView);
    fmMain.acEditSelectAll.Enabled := DataSize > 0;

    fmMain.acEditFind.Enabled := DataSize > 0;
    fmMain.acEditFindNext.Enabled := (DataSize > 0) and (fmMain.FFindRec.StrData <> '');
    fmMain.acEditReplace.Enabled := (DataSize > 0) and (not ReadOnlyView);

    with fmMain.acEditConvert do
    begin
      Enabled := (DataSize > 0) and (not ReadOnlyView);
      if SelCount > 0
      then
        Caption := STR_MENU_EDIT_CONVERT_SEL
      else
        Caption := STR_MENU_EDIT_CONVERT_DATA
    end;

    // - view
    // dynamic translation actions
    for LEnumTrans := Low(TMPHTranslationKind) to High(TMPHTranslationKind)
    do
      with fmMain.FTranslationActions[LEnumTrans]
      do
        Checked := Integer(Translation) = Tag;

    fmMain.acViewOffsetHex.Checked := OffsetFormat = MPHOffsetHex;
    fmMain.acViewOffsetDec.Checked := OffsetFormat = MPHOffsetDec;
    fmMain.acViewOffsetOct.Checked := OffsetFormat = MPHOffsetOct;

    if AutoBytesPerRow then
      fmMain.acViewBytesPerRow.Caption := Format(STR_MENU_VIEW_BPR_AUTO,[BytesPerRow])
    else
      fmMain.acViewBytesPerRow.Caption := Format(STR_MENU_VIEW_BPR,[BytesPerRow]);
    fmMain.acViewBytesPerColumn.Caption := Format(STR_MENU_VIEW_BPC,[BytesPerColumn]);
    fmMain.acViewBytesPerUnit.Caption := Format(STR_MENU_VIEW_BPU,[BytesPerUnit]);
    fmMain.acViewBytesPerBlock.Caption := Format(STR_MENU_VIEW_BPB,[BytesPerBlock]);
    fmMain.acViewBytesPerUnit.Enabled := not UnicodeChars;
    fmMain.mnTranslation.Enabled := not UnicodeChars;

    fmMain.acViewReadOnlyView.Checked := ReadOnlyView;

    fmMain.acViewUnicode.Checked := UnicodeChars;
    if not fmMain.acViewUnicode.Checked then
      fmMain.acViewUnicode.Enabled := ((BytesPerRow mod 2) = 0) and
      ((BytesPerColumn mod 2) = 0)
    else
      fmMain.acViewUnicode.Enabled := True;
    fmMain.acViewUnicodeBE.Checked := UnicodeBigEndian;
    fmMain.acViewUnicodeBE.Enabled := UnicodeChars;
  end;
end;




end.
