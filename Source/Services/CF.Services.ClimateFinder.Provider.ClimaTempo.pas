unit CF.Services.ClimateFinder.Provider.ClimaTempo;

interface

uses
  CF.Connections.Rest.Interfaces,
  cf.Entities.ClimateData,
  CF.Services.ClimateFinder.Types,
  CF.Connections.Rest.Provider;

type
  //http://apiadvisor.climatempo.com.br/api/v1/weather/locale/4529/current?token=0037758ec0a554d1f47b83583a420e14
  TClimateFinderProviderClimaTempo = class(TRestProvider<TClimateData>)
  public
    class function New: IRestProvider<TClimateData>;
    constructor Create;
    //
    function GetURLBase: String; override;
  end;

implementation

uses
  System.SysUtils,
  CF.Services.ClimateFinder.Adapter.ClimaTempo;

{ TClimateFinderProviderClimaTempo }

constructor TClimateFinderProviderClimaTempo.Create;
begin
  inherited;
  WithAdapter(TClimateFinderAdapterClimaTempo.New);
end;

function TClimateFinderProviderClimaTempo.GetURLBase: String;
begin
  Result := 'http://apiadvisor.climatempo.com.br/api/v1/weather/locale/%s/current?token=' + FToken
end;

class function TClimateFinderProviderClimaTempo.New: IRestProvider<TClimateData>;
begin
  Result := Self.Create;
end;

end.
