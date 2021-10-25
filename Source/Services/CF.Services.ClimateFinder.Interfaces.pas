unit CF.Services.ClimateFinder.Interfaces;

interface

uses
  System.Json,
  System.SysUtils,
  CF.Services.ClimateFinder.Types,
  CF.Connections.Rest.Interfaces,
  CF.Entities.ClimateData;

  type
    IClimateFinder = interface
    ['{E8EFC46C-7B05-426E-B00F-C60F5AB5DBBE}']
    function AddProvider(_Provider: IRestProvider<TClimateData>): IClimateFinder;
    function Find: IClimateFinder;
    function GetData: TClimateData;
    function OnAfterGetData(_AProc: TProc): IClimateFinder;
    function WithConnector(_Connector: IRestConnector): IClimateFinder;
    function WithLocation(_ALocation: TClimateLocation): IClimateFinder;
    end;

implementation

end.
