unit CF.Utils.StringHelper;

interface

uses
  System.Classes,
  System.SysUtils;

type
  TCFSystemStringHelper = record helper for string
  end;

  TCFStringHelper = record helper for string
  public
    function FormatValues(_Values: array of string): String;
  end;

implementation

function TCFStringHelper.FormatValues(_Values: array of string): String;
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

  Result:= System.SysUtils.Format(Self, LFormatStringParams);
end;

end.
