unit CF.Services.ClimateFinder.Adapter.ResourceLoader;

interface
uses
  System.Classes,
  System.Types,
  CF.Services.ClimateFinder.Adapter.ResourceLoader.Interfaces,
  CF.Services.ClimateFinder.Adapter.ResourceLoader.Types;

type
  TCustomResourceLoader = class(TInterfacedObject, IResourceLoader)
  protected
    FHandle: NativeUInt;
  public
    constructor Create;
    class function New: IResourceLoader;
    //
    function GetStreamByName(_AResourceName: string): TResourceStream; virtual;
    function GetStreamByResource(AResource: TCFResource): TResourceStream; virtual;
    function WithHandle(_AHandle: NativeUInt): IResourceLoader;
  end;

implementation

uses
  Winapi.Windows,
  System.TypInfo;

{ TCustomResourceLoader }

constructor TCustomResourceLoader.Create;
begin
  inherited;
  WithHandle(FindClassHInstance(Self.ClassType));
end;

function TCustomResourceLoader.GetStreamByName(_AResourceName: string): TResourceStream;
begin
  Result := TResourceStream.Create(FHandle,'cfiSun' {_AResourceName}, RT_RCDATA);
end;

function TCustomResourceLoader.GetStreamByResource(AResource: TCFResource): TResourceStream;
begin
  Result := GetStreambyName(GetEnumName( TypeInfo(TCFResource), Integer(AResource)));
end;

class function TCustomResourceLoader.New: IResourceLoader;
begin
  Result := Self.Create;
end;

function TCustomResourceLoader.WithHandle(_AHandle: NativeUInt): IResourceLoader;
begin
  FHandle := _AHandle
end;

end.
