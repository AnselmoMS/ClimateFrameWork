unit CF.Connections.Rest.Connector.RR4D;

interface

uses
  CF.Connections.Rest.Interfaces,
  CF.Connections.Rest.Connector,
  RESTRequest4D;

   type
   TConnectorRestRR4D = class(TRestConnector)
   private
    FResponse: IResponse;
    FRequest: IRequest;
   public
     constructor Create;
     //
     class function New: IRestConnector;
     //
     function ExecuteGet: IRestConnector; override;
   end;

implementation

uses
  System.SysUtils,
  System.Classes,
  Winapi.Windows,
  System.JSON;

{ TConnectorRestRR4D }

constructor TConnectorRestRR4D.Create;
begin
  FRequest := TRequest
                .New
                  .Accept('application/json');
end;

function TConnectorRestRR4D.ExecuteGet: IRestConnector;
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      FResponse := FRequest
                 .BaseURL(GetFullURL)
                 .Get;

      TThread.Synchronize(TThread.Current,
      procedure
      begin
        FResponseJson := FResponse.JSONValue;
        OutputDebugString(Pchar(FResponseJson.ToString));
        DoAfterGet;
      end)
    end).Start;

  Result := Self;
end;

class function TConnectorRestRR4D.New: IRestConnector;
begin
  Result := Self.Create
end;

end.
