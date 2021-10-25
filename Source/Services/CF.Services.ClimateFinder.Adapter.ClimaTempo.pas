unit CF.Services.ClimateFinder.Adapter.ClimaTempo;

interface
uses
 System.Classes,
 System.JSON,
 CF.Entities.ClimateData,
 CF.Connections.Rest.Interfaces,
 CF.Entities.ClimateData.Types;

 const
   CLIMATEMPO_ICON_NAMES : array [TCFIcon] of String =
   (
    '1'  ,
    '1n' ,
    '2'  ,
    '2n' ,
    '2r' ,
    '2rn',
    '3'  ,
    '3n' ,
    '3TM',
    '4'  ,
    '4n' ,
    '4r' ,
    '4rn',
    '4t' ,
    '4tn',
    '5'  ,
    '5n' ,
    '6'  ,
    '6n' ,
    '7'  ,
    '7n' ,
    '8'  ,
    '8n' ,
    '9'  ,
    '9n' 
   );

 type
  TClimateFinderAdapterClimaTempo = class(TInterfacedObject, IRestAdapter<TClimateData>)
  private
    function GetClimateIcon(_AIcon: string): TCFIcon;
  public
    class function New: IRestAdapter<TClimateData>;
    //
    function FromJson(_ResponseJson: TJsonValue): TClimateData;
  end;


implementation

uses
  System.SysUtils,
  REST.Json,
  Winapi.Windows,
  System.RegularExpressions;

{ TClimateResponseAdapterClimaTempo }

function GetDateTime(var _AJSONDatetimeValue: string): TDateTime;
begin
  var fs:= FormatSettings.Invariant;
  fs.DateSeparator := '-';
  fs.ShortDateFormat := 'yyyy-mm-dd';
  Result := StrtoDateTime(_AJSONDatetimeValue, fs);
end;

function ReplaceDateTimeToIso8061(_AJSONValue: TJsonValue; _APath: String): TJSONValue;
begin
  var LExtractedDateTime: String := _AJSONValue.P[_APath].Value.Replace('"', '');
  var datahora: TDateTime := GetDateTime(LExtractedDateTime);

  var datahoraIso8061 := FormatDateTime('yyyy-mm-dd"T"HH:MM:SS"Z"', datahora);
  var LNewResponseString := TRegEx.Replace(_AJSONValue.ToJSON, '\d{4}\-\d{2}\-\d{2}\s\d{2}\:\d{2}\:\d{2}', datahoraIso8061);

  var LNewResponse:= TJSONObject.ParseJSONValue(LNewResponseString);
  Result := LNewResponse;
end;

function TClimateFinderAdapterClimaTempo.GetClimateIcon(_AIcon: string): TCFIcon;
var
  ico: TCFIcon;
begin
  for ico := Low(TCFIcon) to High(TCFIcon) do
    if CLIMATEMPO_ICON_NAMES[ico] = _AIcon then
      Exit(ico);
end;

class function TClimateFinderAdapterClimaTempo.New: IRestAdapter<TClimateData>;
begin
  Result := Self.Create;
end;

function TClimateFinderAdapterClimaTempo.FromJson(_ResponseJson: TJsonValue): TClimateData;
var
 LResult: TClimateData;
begin
  {$REGION 'Exemplo de retorno'}
(*
{
    "id": 4529,
    "name": "Itabaiana",
    "state": "SE",
    "country": "BR  ",
    "data": {
        "temperature": 31,
        "wind_direction": "ESE",
        "wind_velocity": 24,
        "humidity": 53.8,
        "condition": "Poucas nuvens",
        "pressure": 990.3,
        "icon": "2",
        "sensation": 33,
        "date": "2021-09-07 16:45:34"
    }
}
*)
{$ENDREGION}

  var LNewResponse := ReplaceDateTimeToIso8061(_ResponseJson, 'data.date');
  OutputDebugString(PChar(LNewResponse.ToJSON));
  LResult := TJson.JsonToObject<TClimateData>(LNewResponse.ToJSON);
  LResult.Data.ClimateIcon := GetClimateIcon(_ResponseJson.GetValue<String>('data.icon'));

//  First chance exception... Exception class EDateTimeException with message 'Invalid date string: 2021-09-19 07:59:46'
//  LResult := TJson.JsonToObject<TClimateData>(_ResponseJson.ToJSON, [joDateFormatISO8601, joDateIsUTC]);
  Result := LResult;
end;

end.
