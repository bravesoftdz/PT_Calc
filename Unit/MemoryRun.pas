unit MemoryRun;

interface

uses Windows;

type
TImportItem = record
Name: String;
PProcVar: ^Pointer;
end;

TwordArr = array [0..0] of Word;
PwordArr = ^TwordArr;
TdwordArr = array [0..0] of DWORD;
PdwordArr = ^TdwordArr;

TImageImportDescriptor = packed record
OriginalFirstThunk: DWORD;
TimeDateStamp: DWORD;
ForwarderChain: DWORD;
Name: DWORD;
FirstThunk: DWORD;
end;
PImageImportDescriptor = ^TImageImportDescriptor;

TImageBaseRelocation = packed record
VirtualAddress: Cardinal;
SizeOfBlock: Cardinal;
end;
PImageBaseRelocation = ^TImageBaseRelocation;

TEXEEntryProc = function(hinstDLL: HMODULE; hPrevInstance: HMODULE; lpCmdLine: PChar; nCmdShow: Integer): Boolean; stdcall;

TStringArray = array of String;

TLibInfo = record
ImageBase: Pointer;
EXEProc: TEXEEntryProc;
LibsUsed: TStringArray;
end;

PLibInfo = ^TLibInfo;
PPointer = ^Pointer;
TSections = packed array [0..100000] of TImageSectionHeader;

const
IMPORTED_NAME_OFFSET = $00000002;
IMAGE_ORDINAL_FLAG32 = $80000000;
IMAGE_ORDINAL_MASK32 = $0000FFFF;
PROCESS_ATTACH = 1;

procedure MemoryRunExe(pExe: Pointer);
procedure MemoryRunExeName(HIns: LongWord; Field: Pchar; ResName: Pchar);
function PeLoader(Src: Pointer): Pointer;
function PeFree(Src: Pointer): Boolean;

procedure Add(Strings: TStringArray; Text: string);
function StrToInt(S: string): integer;
function Find(Strings: array of string; Text: string; var Index: integer): boolean;
function GetSectionProtection(ImageScn: cardinal): cardinal;

implementation

procedure MemoryRunExe(pExe: Pointer);
var pSrc: Pointer;
begin
pSrc:=PeLoader(pExe);
PeFree(pSrc);
end;

procedure MemoryRunExeName(HIns: LongWord; Field: Pchar; ResName: Pchar);
var pExe,pSrc: Pointer;
begin
pExe:=LockResource(LoadResource(HIns,FindResource(HIns,Field,ResName)));
pSrc:=PeLoader(pExe);
PeFree(pSrc);
end;

function PeLoader(Src: Pointer): Pointer;
var
ImageBase: Pointer;
ImageBaseDelta: Integer;
ImageNtHeaders: PImageNtHeaders;
PSections: ^TSections;
SectionLoop: Integer;
SectionBase: Pointer;
VirtualSectionSize: Cardinal;
RawSectionSize: Cardinal;
OldProtect: Cardinal;
NewLibInfo: TLibInfo;

function IsImportByOrdinal(ImportDescriptor: dword; HLib: THandle): boolean;
begin
Result := (ImportDescriptor and IMAGE_ORDINAL_FLAG32) <> 0;
end;

procedure ProcessRelocs(PRelocs:PImageBaseRelocation);
var
PReloc: PImageBaseRelocation;
RelocsSize: cardinal;
Reloc: PWord;
ModCount: cardinal;
RelocLoop: cardinal;
begin
PReloc := PRelocs;
RelocsSize := ImageNtHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].Size;
while cardinal(PReloc) - cardinal(PRelocs) < RelocsSize do
begin
ModCount := (PReloc.SizeOfBlock-Sizeof(PReloc^)) div 2;
Reloc := pointer(cardinal(PReloc)+sizeof(PReloc^));
for RelocLoop := 0 to ModCount - 1 do begin
if Reloc^ and $f000 <> 0 then Inc(pdword(cardinal(ImageBase) + PReloc.VirtualAddress + (Reloc^ and $0fff))^, ImageBaseDelta);
Inc(Reloc);
end;
PReloc := pointer(Reloc);
end;
end;

procedure ProcessImports(PImports: PImageImportDescriptor);
var
PImport: PImageImportDescriptor;
Import: LPDword;
PImportedName: pchar;
LibHandle: HModule;
ProcAddress: pointer;
PLibName: pchar;
ImportLoop: integer;
begin
PImport := PImports;
while PImport.Name<>0 do
begin
PLibName := pchar(cardinal(PImport.Name) + cardinal(ImageBase));
if not Find(NewLibInfo.LibsUsed, PLibName, ImportLoop) then
begin
LibHandle := LoadLibrary(PLibName);
Add(NewLibInfo.LibsUsed, PLibName);
end else begin
LibHandle := cardinal(NewLibInfo.LibsUsed[ImportLoop]);
end;

if PImport.TimeDateStamp = 0 then
Import := LPDword(pImport.FirstThunk+cardinal(ImageBase))
else
Import := LPDword(pImport.OriginalFirstThunk + cardinal(ImageBase));

while Import^ <> 0 do
begin
if IsImportByOrdinal(Import^, LibHandle) then
ProcAddress := GetProcAddress(LibHandle, pchar(Import^ and $ffff))
else begin
PImportedName := pchar(Import^ + cardinal(ImageBase) + IMPORTED_NAME_OFFSET);
ProcAddress := GetProcAddress(LibHandle, PImportedName);
end;
PPointer(Import)^ := ProcAddress;
Inc(Import);
end;
Inc(PImport);
end;
end;

begin
ImageNtHeaders := pointer(int64(cardinal(Src)) + PImageDosHeader(Src)._lfanew);
ImageBase := VirtualAlloc(nil, ImageNtHeaders.OptionalHeader.SizeOfImage, MEM_RESERVE, PAGE_NOACCESS);
ImageBaseDelta := cardinal(ImageBase) - ImageNtHeaders.OptionalHeader.ImageBase;
SectionBase := VirtualAlloc(ImageBase, ImageNtHeaders.OptionalHeader.SizeOfHeaders, MEM_COMMIT, PAGE_READWRITE);
Move(Src^, SectionBase^, ImageNtHeaders.OptionalHeader.SizeOfHeaders);
VirtualProtect(SectionBase, ImageNtHeaders.OptionalHeader.SizeOfHeaders, PAGE_READONLY, OldProtect);
PSections := pointer(pchar(@(ImageNtHeaders.OptionalHeader)) + ImageNtHeaders.FileHeader.SizeOfOptionalHeader);

for SectionLoop := 0 to ImageNtHeaders.FileHeader.NumberOfSections - 1 do
begin
VirtualSectionSize := PSections[SectionLoop].Misc.VirtualSize;
RawSectionSize := PSections[SectionLoop].SizeOfRawData;

if VirtualSectionSize < RawSectionSize then
begin
VirtualSectionSize := VirtualSectionSize xor RawSectionSize;
RawSectionSize := VirtualSectionSize xor RawSectionSize;
VirtualSectionSize := VirtualSectionSize xor RawSectionSize;
end;

SectionBase := VirtualAlloc(PSections[SectionLoop].VirtualAddress + pchar(ImageBase), VirtualSectionSize, MEM_COMMIT, PAGE_READWRITE);
FillChar(SectionBase^, VirtualSectionSize, 0);
Move((pchar(src) + PSections[SectionLoop].PointerToRawData)^, SectionBase^, RawSectionSize);
end;

NewLibInfo.ExeProc := TEXEEntryProc(ImageNtHeaders.OptionalHeader.AddressOfEntryPoint + cardinal(ImageBase));
NewLibInfo.ImageBase := ImageBase;
SetLength(NewLibInfo.LibsUsed, 0);

if ImageNtHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress <> 0 then ProcessRelocs(pointer(ImageNtHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress + cardinal(ImageBase)));

if ImageNtHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress <> 0 then ProcessImports(pointer(ImageNtHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress + cardinal(ImageBase)));

for SectionLoop := 0 to ImageNtHeaders.FileHeader.NumberOfSections - 1 do
VirtualProtect(PSections[SectionLoop].VirtualAddress + pchar(ImageBase), PSections[SectionLoop].Misc.VirtualSize, GetSectionProtection(PSections[SectionLoop].Characteristics), OldProtect);

if @NewLibInfo.ExeProc <> nil then
begin
if not NewLibInfo.ExeProc(cardinal(ImageBase), DLL_PROCESS_ATTACH, nil,0) then
begin
NewLibInfo.ExeProc := nil;
PeFree(NewLibInfo.ImageBase);
end;
end;

Result:=NewLibInfo.ImageBase;
end;

function PeFree(Src: Pointer): Boolean;
begin
try
VirtualFree(Src, 0, MEM_RELEASE);
finally
Result:= True;
end;
end;

function StrToInt(S: string): integer;
begin
Val(S, Result, Result);
end;

procedure Add(Strings: TStringArray; Text: string);
begin
SetLength(Strings, Length(Strings) + 1);
Strings[Length(Strings)-1] := Text;
end;

function Find(Strings: array of string; Text: string; var Index: integer): boolean;
var StringLoop: integer;
begin
Result := False;
for StringLoop := 0 to Length(Strings) - 1 do
begin
if lstrcmpi(pchar(Strings[StringLoop]), pchar(Text)) = 0 then
begin
Index := StringLoop;
Result := True;
end;
end;
end;

function GetSectionProtection(ImageScn: cardinal): cardinal;
begin
Result := 0;
if (ImageScn and IMAGE_SCN_MEM_NOT_CACHED) <> 0 then Result := Result or PAGE_NOCACHE;

if (ImageScn and IMAGE_SCN_MEM_EXECUTE) <> 0 then begin

if (ImageScn and IMAGE_SCN_MEM_READ)<> 0 then  begin

if (ImageScn and IMAGE_SCN_MEM_WRITE)<> 0 then Result := Result or PAGE_EXECUTE_READWRITE  else Result := Result or PAGE_EXECUTE_READ;

end else if (ImageScn and IMAGE_SCN_MEM_WRITE) <> 0 then
Result := Result or PAGE_EXECUTE_WRITECOPY else Result := Result or PAGE_EXECUTE;

end else if (ImageScn and IMAGE_SCN_MEM_READ)<> 0 then  begin

if (ImageScn and IMAGE_SCN_MEM_WRITE) <> 0 then
Result := Result or PAGE_READWRITE else Result := Result or PAGE_READONLY;

end else if (ImageScn and IMAGE_SCN_MEM_WRITE) <> 0 then
Result := Result or PAGE_WRITECOPY else Result := Result or PAGE_NOACCESS;

end;

end.
