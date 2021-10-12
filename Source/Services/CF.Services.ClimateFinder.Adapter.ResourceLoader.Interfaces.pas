unit CF.Services.ClimateFinder.Adapter.ResourceLoader.Interfaces;

interface

uses
  System.Classes,
  CF.Services.ClimateFinder.Adapter.ResourceLoader.Types;

type IResourceLoader = interface
  ['{A3A4FE88-E7D2-46D6-8382-4389B9F525C0}']
  function GetStreamByName(AResourceName: string): TResourceStream;
  function GetStreamByResource(AResource: TCFResource): TResourceStream;
  function WithHandle(AHandle: NativeUInt): IResourceLoader;
end;

type IClimateFinderResourceLoader = interface
  ['{F392FFB8-D144-47AE-8E76-FFB6F5CE2D03}']
  function GetStream: TResourceStream;
end;

implementation

end.
