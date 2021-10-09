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
   TClimateFinder<T> = class(TInterfacedObject, IClimateFinder<T>)
   private
     FParent : T;
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
     constructor Create(_AParent: T);
     destructor Destroy; override;
     //
     class function New(_AParent: T): IClimateFinder<T>;
     //
     function AddProvider(_Provider: IRestProvider<TClimateData>): IClimateFinder<T>;
     function Find: IClimateFinder<T>;
     function GetData: TClimateData;
     function OnAfterGetData(_AProc: TProc): IClimateFinder<T>;
     function WithConnector(_Connector: IRestConnector): IClimateFinder<T>;
     function WithLocation(_ALocation: TClimateLocation): IClimateFinder<T>;
     function Parent: T;
   end;

implementation

procedure TClimateFinder<T>.ConfigureConnection;
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

constructor TClimateFinder<T>.Create(_AParent: T);
begin
  FClimateProviders := TList<IRestProvider<TClimateData>>.Create;
  FCurrClimateProvider := nil;
  FParent := _AParent;
end;

destructor TClimateFinder<T>.Destroy;
begin
  FClimateProviders.Free;
end;

procedure TClimateFinder<T>.DoAfterGetData;
begin
  if Assigned(FAfterGetData) then
    FAfterGetData();
end;

function TClimateFinder<T>.Find: IClimateFinder<T>;
begin
  ConfigureConnection;
  FConnector.ExecuteGet;
  Result := Self;
end;

function TClimateFinder<T>.GetData: TClimateData;
begin
  Result:= FCurrClimateProvider.FromJson(FConnector.GetResponseJson);
end;

class function TClimateFinder<T>.New(_AParent: T): IClimateFinder<T>;
begin
  Result := Self.Create(_AParent);
end;

function TClimateFinder<T>.OnAfterGetData(_AProc: TProc): IClimateFinder<T>;
begin
  FAfterGetData := _AProc;
  Result := Self
end;

function TClimateFinder<T>.Parent: T;
begin
  Result := FParent;
end;

procedure TClimateFinder<T>.DoNewProvider(_Index: Integer);
begin
  if not Assigned(FCurrClimateProvider) then
    FCurrClimateProvider := FClimateProviders[_Index];
end;

function TClimateFinder<T>.WithConnector(_Connector: IRestConnector): IClimateFinder<T>;
begin
  FConnector := _Connector;
  Result := Self
end;

function TClimateFinder<T>.WithLocation(_ALocation: TClimateLocation): IClimateFinder<T>;
begin
  FLocation := _ALocation;
  Result := Self
end;

function TClimateFinder<T>.AddProvider(_Provider: IRestProvider<TClimateData>): IClimateFinder<T>;
begin
  DoNewProvider(FClimateProviders.Add(_Provider));
  Result := Self;
end;

end.
