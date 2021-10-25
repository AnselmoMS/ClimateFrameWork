unit CF.Services.ClimateFinder;

interface
uses
  System.SysUtils,
  System.Generics.Collections,
  CF.Services.ClimateFinder.Interfaces,
  CF.Services.ClimateFinder.Types,
  CF.Entities.ClimateData,
  CF.Connections.Rest.Interfaces;

  type
   TClimateFinder = class(TInterfacedObject, IClimateFinder)
   private
     FConnector: IRestConnector;
     FAfterGetData: TProc;
     FLocation: TClimateLocation;
     FClimateProviders: TList<IRestProvider<TClimateData>>;
     FCurrClimateProvider: IRestProvider<TClimateData>;

     procedure DoAfterGetData;
   protected
     procedure ConfigureConnection;
     procedure DoNewProvider(_Index: Integer);
   public
     constructor Create;
     destructor Destroy; override;
     //
     class function New: IClimateFinder;
     //
     function AddProvider(_Provider: IRestProvider<TClimateData>): IClimateFinder;
     function Find: IClimateFinder;
     function GetData: TClimateData;
     function OnAfterGetData(_AProc: TProc): IClimateFinder;
     function WithConnector(_Connector: IRestConnector): IClimateFinder;
     function WithLocation(_ALocation: TClimateLocation): IClimateFinder;
   end;

implementation

procedure TClimateFinder.ConfigureConnection;
begin
  FConnector
    .WithURLBase(FCurrClimateProvider.GetURLBase)
    .WithParamValues([FLocation.ID.ToString])
    .OnAfterGet(
      Procedure
      begin
        DoAfterGetData;
      end);
end;

constructor TClimateFinder.Create;
begin
  FClimateProviders := TList<IRestProvider<TClimateData>>.Create;
  FCurrClimateProvider := nil;
end;

destructor TClimateFinder.Destroy;
begin
  FClimateProviders.Free;
end;

procedure TClimateFinder.DoAfterGetData;
begin
  if Assigned(FAfterGetData) then
    FAfterGetData();
end;

function TClimateFinder.Find: IClimateFinder;
begin
  ConfigureConnection;
  FConnector.ExecuteGet;
  Result := Self;
end;

function TClimateFinder.GetData: TClimateData;
begin
  Result:= FCurrClimateProvider.FromJson(FConnector.GetResponseJson);
end;

class function TClimateFinder.New: IClimateFinder;
begin
  Result := Self.Create;
end;

function TClimateFinder.OnAfterGetData(_AProc: TProc): IClimateFinder;
begin
  FAfterGetData := _AProc;
  Result := Self
end;

procedure TClimateFinder.DoNewProvider(_Index: Integer);
begin
  if not Assigned(FCurrClimateProvider) then
    FCurrClimateProvider := FClimateProviders[_Index];
end;

function TClimateFinder.WithConnector(_Connector: IRestConnector): IClimateFinder;
begin
  FConnector := _Connector;
  Result := Self
end;

function TClimateFinder.WithLocation(_ALocation: TClimateLocation): IClimateFinder;
begin
  FLocation := _ALocation;
  Result := Self
end;

function TClimateFinder.AddProvider(_Provider: IRestProvider<TClimateData>): IClimateFinder;
begin
  DoNewProvider(FClimateProviders.Add(_Provider));
  Result := Self;
end;

end.
