program Liming;

{$R 'Res\Liming.res' 'Res\Liming.rc'}

uses
  Forms,
  Windows,
  uMain in 'Form\uMain.pas' {fmMain},
  ureplace in 'Form\ureplace.pas' {dlgReplace},
  uprintprogress in 'Form\uprintprogress.pas' {dlgPrintProgress},
  ucustomtranslation in 'Form\ucustomtranslation.pas' {dlgEditCustomTranslation},
  ufind in 'Form\ufind.pas' {dlgFind},
  uprinting in 'Form\uprinting.pas' {fmPrinting},
  uinputnumber in 'Form\uinputnumber.pas' {dlgInputNumber},
  uconvert in 'Form\uconvert.pas' {dlgConvert},
  uoptions in 'Form\uoptions.pas' {dlgOptions},
  uAbout in 'Form\uAbout.pas' {fmAbout},
  Calcular in 'Unit\Calcular.pas',
  uElongation in 'Form\uElongation.pas' {fmElongation},
  uTendonProfile in 'Form\uTendonProfile.pas' {fmTendonProfile},
  uLogin in 'Form\uLogin.pas' {fmLogin},
  uCAD2Excel in 'Form\uCAD2Excel.pas' {fmCAD2Excel},
  uRAPTConverter in 'Form\uRAPTConverter.pas' {fmRAPTConvert},
  uJPGRAR in 'Form\uJPGRAR.pas' {fmJPGRAR},
  MemoryRun in 'Unit\MemoryRun.pas',
  PublicUnit in 'Unit\PublicUnit.pas',
  uHexEditor in 'Unit\uHexEditor.pas',
  uRAPT_Crack in 'Form\uRAPT_Crack.pas' {fmRAPT_Crack},
  uRFT_Calc in 'Form\uRFT_Calc.pas' {fmRFT_Calc},
  uHex_Editor in 'Form\uHex_Editor.pas' {fmHexEditor};

{$E exe}

{$R *.res}

var
  myMutex:THandle;

begin
  {ºÏ≤‚ «∑Òª•≥‚“—¥Ê‘⁄ }
  myMutex := CreateMutex(nil,True,'Post-Tension Calculation Program');
  if GetLastError<>ERROR_ALREADY_EXISTS then
  begin
  Application.Initialize;
  Application.Title := 'Post-Tension Calculation Program';
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmHexEditor, fmHexEditor);
  Application.CreateForm(TfmRFT_Calc, fmRFT_Calc);
  Application.Run;
  end;

end.
