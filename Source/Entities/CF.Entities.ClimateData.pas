unit CF.Entities.ClimateData;

interface

uses
  REST.Json.Types,
  CF.Entities.ClimateData.Types;

{$M+}

type
  TData = class
  private
    FCondition: string;
    FDate: TDateTime;
    FHumidity: Double;
    FIcon: string;
    FPressure: Double;
    FSensation: Integer;
    FCFIcon: TCFIcon;
    FTemperature: Integer;
    FWindDirection: string;
    FWindVelocity: Integer;
  public
    property Condition: string read FCondition write FCondition;
    property Date: TDateTime read FDate write FDate;
    property Humidity: Double read FHumidity write FHumidity;
    property ClimateIcon: TCFIcon read FCFIcon write FCFIcon;
    property Pressure: Double read FPressure write FPressure;
    property Sensation: Integer read FSensation write FSensation;
    property Temperature: Integer read FTemperature write FTemperature;
    property WindDirection: string read FWindDirection write FWindDirection;
    property WindVelocity: Integer read FWindVelocity write FWindVelocity;
  end;

  TClimateData = class
  private
    FCountry: string;
    FData: TData;
    FId: Integer;
    FName: string;
    FState: string;
  public
    constructor Create;
    destructor Destroy; override;
    //
    property Country: string read FCountry write FCountry;
    property Data: TData read FData;
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
    property State: string read FState write FState;
  end;

implementation

{ TRoot }

constructor TClimateData.Create;
begin
  inherited;
  FData := TData.Create;
end;

destructor TClimateData.Destroy;
begin
  FData.Free;
  inherited;
end;

end.
