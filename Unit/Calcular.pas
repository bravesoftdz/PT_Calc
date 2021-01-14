unit Calcular;

interface

uses
  SysUtils, dialogs;

type
  TYSF = set of char;

  TCalWithoutKH = class
  private
    FSuXuestr: string;
    FindYSFPosition: integer;
    procedure InitFindYSF;
    function FindNextYSF(var YSFChar: char; var LeftValue: double): boolean;
    function CalTwo(x, y: double; c: char): double;
  public
    function GetValue: double;
    constructor Create(SuXueStr: string); overload;
  end;

////////TCalcular类用于计算任何形式的加减乘除字串表达式的运算
  TCalcular = class
  private
    FStr: string;
    function RightNPos(s: string; c: char; n: integer): integer;
    function GetStrWithKH(s: string; var index: integer; var len: integer): string;
    function ReplaceStr(SubStr: string; RepPos, Replen: integer; Str: string): string;
    function GetCharNum(c: char; s: string): integer;
  public
    function GetValue: double;
    constructor Create(SuXueStr: string); overload;
  end;

function CalcularNoKH(expression: string): double;
function CalcularExpression(expression: string): double; //输出函数，主要就用它了

implementation

function CalcularExpression(expression: string): double;
var
  ca: TCalcular;
begin
  ca := TCalcular.Create(expression);
  result := ca.GetValue;
  ca.Free;
end;
//////////////////类TCalcular现实部分//////////////////////////////////////////////////

function TCalcular.GetValue: double;
var
  str: string;
  ii, ll: integer;
begin
  str := self.GetStrWithKH(Fstr, ii, ll);
  //showmessage(inttostr(ll));
  while str <> '' do
  begin
    //if (str[1]='(')and(str[length(str)]=')') then
    str := copy(str, 2, length(str) - 2);
    str := floattostr(CalcularNoKH(str));
    Fstr := ReplaceStr(str, ii, ll, Fstr);
    //showmessage(Fstr);
    str := self.GetStrWithKH(Fstr, ii, ll);
  end;
  //showmessage(fstr);
  result := CalcularNoKH(Fstr);
  //showmessage(floattostr(result));
end;


//替换子串函数，而不管要替换的两者是否相等
function TCalcular.ReplaceStr(SubStr: string; RepPos, Replen: integer; Str: string): string;
begin
//showmessage('Strlength='+inttostr(length(str))+': replen+reppos='+inttostr(reppos+replen));
  if reppos > 1 then
  begin
    result := copy(str, 1, Reppos - 1) + substr + copy(str, reppos + replen, length(str) - replen - reppos + 1);
  end
  else
    result := substr + copy(str, length(substr) + 1, length(str) - replen);
end;


//返回字符c出现的次数
function TCalcular.GetCharNum(c: char; s: string): integer;
var
  i: integer;
begin
  result := 0;
  for i := 1 to length(s) do
    if s[i] = c then
      result := result + 1;
end;


//返回字符c从右第n次出现的位置,如果n大于出现的次数将返回－1,如果没找到将返回0
function TCalcular.RightNPos(s: string; c: char; n: integer): integer;
var
  i, p: integer;
begin
  result := 0;
  p := 0;
  if n > getcharnum(c, s) then
  begin
    result := -1;
    exit;
  end;
  for i := length(s) downto 1 do
  begin
    if s[i] = c then
    begin
      p := p + 1;
     //showmessage(inttostr(p));
      if p = n then
      begin
        result := I;
        break;
      end;
    end;
  end;
end;


//返回字串最里面括号（包括括号）内内容,从左优先原则
function TCalcular.GetStrWithKH(s: string; var index: integer; var len: integer): string;
var
  L, R, i: integer;
begin
  result := '';
  if pos('(', s) > 0 then
  begin
    i := 1;
    L := rightNpos(s, '(', i);
    R := pos(')', s);
    while L > R do
    begin
      i := i + 1;
      L := rightnpos(s, '(', i);
    end;
    index := L;
    len := R - L + 1;
    result := copy(s, L, r - L + 1);
  end;
end;

constructor TCalcular.Create(SuXueStr: string);
begin
  Fstr := SuXueStr;
end;


/////////////////CalCularNoKH函数实现部分///////////////////////////////////////////////////
function CalcularNoKH(expression: string): double;
var
  ca: TCalwithoutKH;
begin
  ca := TCalwithoutKH.Create(expression);
  result := ca.GetValue;
  ca.Free;
end;


///////////////////类TCalWithoutKH实现部分///////////////////////////////////////////
procedure TCalWithoutKH.InitFindYSF;
begin
  FindYSFPosition := 0;
end;

function TCalWithoutKH.FindNextYSF(var YSFChar: char; var LeftValue: double): boolean;
var
  i: integer;
  YSF: TYSF;
  s: string;
begin
  YSF := ['+', '-', '*', '/'];
  result := false;
  for i := FindYSFPosition + 1 to length(FSuXueStr) do
    if FSuXueStr[i] in YSF then
    begin
      YSFChar := FSuXueStr[i];
      s := copy(FSuXueStr, FindYSFPosition + 1, i - FindYSFPosition - 1);
      FindYSFPosition := i;
      result := true;
      break;
    end;
  if not result then
    s := copy(FSuXueStr, FindYSFPosition + 1, length(FSuXueStr) - FindYSFPosition);
  leftvalue := strtofloat(s);
end;

function isCC(c: char): boolean;
var
  CCYSF: TYSF;
begin
  CCYSF := ['*', '/'];
  result := false;
  if c in CCYSF then
    result := true;
end;

function TCalWithoutKH.GetValue: double;
var
  A, B, C: double;
  c1, c2, c3: char;
  finded: boolean;
begin
  result := 0;
  A := 0;
  B := 0;
  C := 0;
  finded := false;
  self.InitFindYSF;
  if not self.FindNextYSF(c1, A) then //如果只有一个数
  begin
    result := A;
    exit;
  end;
  if not self.FindNextYSF(c2, B) then //如果有二个数
  begin
    result := caltwo(A, B, c1);
    exit;
  end;
  repeat
    finded := self.FindNextYSF(c3, C);
    if iscc(c1) then
    begin
      A := caltwo(A, B, c1);
      B := C;
      c1 := c2;
      c2 := c3;
    end
    else if iscc(c2) then
    begin
      B := caltwo(B, C, c2);
      c2 := c3;
    end
    else
    begin
      A := caltwo(A, B, c1);
      B := C;
      c1 := c2;
      c2 := c3;
    end;
  until not finded;
  result := caltwo(A, B, c1);
end;

function TCalWithoutKH.CalTwo(x, y: double; c: char): double;
begin
  if c = '+' then
    result := x + y
  else if c = '-' then
    result := x - y
  else if c = '*' then
    result := x * y
  else if c = '/' then
    result := x / y;
end;

constructor TCalWithoutKH.Create(SuXueStr: string);
begin
  fsuxuestr := suxuestr;
end;

end.
