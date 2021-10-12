unit CF.Connections.Rest.Connector;

interface
uses
  System.SysUtils,
  System.JSON,
  CF.Connections.Rest.Interfaces,
  CF.Utils.StringHelper;

type
  TRestConnector = class(TInterfacedObject, IRestConnector)
  protected
    FResponseJson : TJsonValue;
    FParamValues: TArray<string>;
    FAfterGet: TProc;
    FURLBase: string;
  protected
    procedure DoAfterGet;
    procedure ValidateURLBase(_URLBase: string);
    procedure ValidateParamValues(_ParamValues: array of string);
  public
    function ExecuteGet: IRestConnector; Virtual; Abstract;
    function GetFullURL: string;
    function GetResponseJson: TJsonValue;
    function OnAfterGet(_AProc: TProc): IRestConnector;
    function WithParamValues(_ParamValues: array of string): IRestConnector;
    function WithURLBase(_URLBase: string): IRestConnector;
  end;

implementation

{ TConnectorRest }

procedure TRestConnector.DoAfterGet;
begin
  if Assigned(FAfterGet) then
    FAfterGet();
end;

function TRestConnector.GetFullURL: string;
begin
  Result := FURLBase.FormatValues(FParamValues)
end;

function TRestConnector.GetResponseJson: TJsonValue;
begin
  Result := FResponseJson;
end;

function TRestConnector.OnAfterGet(_AProc: TProc): IRestConnector;
begin
  FAfterGet:= _AProc;
  Result := Self;
end;

procedure TRestConnector.ValidateParamValues(_ParamValues: array of string);
begin
  if Length(_ParamValues) = 0 then
    raise Exception.Create('Empty Parameter Values is not allowed!');
end;

procedure TRestConnector.ValidateURLBase(_URLBase: string);
begin
  if Trim(_URLBase) = '' then
    raise Exception.Create('Empty URL is not allowed!');
end;

function TRestConnector.WithParamValues(_ParamValues: array of string): IRestConnector;
var
  I: Integer;
begin
  SetLength(FParamValues, Length(_ParamValues));
  for I := 0 to Pred(Length(_ParamValues)) do
    FParamValues[I] := _ParamValues[I];
  Result := Self;
end;

function TRestConnector.WithURLBase(_URLBase: string): IRestConnector;
begin
  ValidateURLBase(_URLBase);
  FURLBase := _URLBase;
  Result := Self;
end;

end.
