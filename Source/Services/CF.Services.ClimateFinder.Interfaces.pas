unit CF.Services.ClimateFinder.Interfaces;

interface

uses
  System.Json,
  System.SysUtils,
  CF.Entities.ClimateData,
  CF.Services.ClimateFinder.Types,
  CF.Connections.Rest.Interfaces;

  type
    IClimateFinder<T> = interface
    ['{E8EFC46C-7B05-426E-B00F-C60F5AB5DBBE}']
    function AddProvider(_Provider: IRestProvider<TClimateData>): IClimateFinder<T>;
    function Find: IClimateFinder<T>;
    function GetData: TClimateData;
    function OnAfterGetData(_AProc: TProc): IClimateFinder<T>;
    function WithConnector(_Connector: IRestConnector): IClimateFinder<T>;
    function WithLocation(_ALocation: TClimateLocation): IClimateFinder<T>;
    function Parent: T;
    end;

implementation

end.
