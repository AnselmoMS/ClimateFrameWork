unit CF.Entities.ClimateData;

interface

uses
  REST.Json.Types;

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
    FTemperature: Integer;
    FWindDirection: string;
    FWindVelocity: Integer;
  published
    property Condition: string read FCondition write FCondition;
    property Date: TDateTime read FDate write FDate;
    property Humidity: Double read FHumidity write FHumidity;
    property Icon: string read FIcon write FIcon;
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
  published
    property Country: string read FCountry write FCountry;
    property Data: TData read FData;
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
    property State: string read FState write FState;
  public
    constructor Create;
    destructor Destroy; override;
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
