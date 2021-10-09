unit CF.StringUtils;

interface

function FormatString(_Text: string; _Values: array of string): String;

implementation

uses
  System.Classes,
  System.SysUtils;

function FormatString(_Text: string; _Values: array of string): String;
var
  LFormatStringParams: array of TVarRec;
  LString: UnicodeString;
  LstrIndex: Integer;
begin
  if Length(_Values) = 0 then
    Exit('');

  SetLength(LFormatStringParams, Length(_Values));

  for LstrIndex := 0 to Pred(Length(_Values)) do
  begin
    LString := _Values[LstrIndex];
    LFormatStringParams[LstrIndex].VType := vtUnicodeString;
    LFormatStringParams[LstrIndex].VUnicodeString := Pointer(LString);
  end;

  Result:= Format(_Text, LFormatStringParams);
end;

end.
