unit CF.Connections.Rest.Interfaces;

interface

uses
  System.JSON,
  System.SysUtils;

type
  IRestConnector = interface
    ['{DFB79FE2-8FD0-4840-94E6-F5B32FA61F76}']
    function ExecuteGet: IRestConnector;
    function GetFullURL: string;
    function GetResponseJson: TJsonValue;
    function OnAfterGet(_AProc: TProc): IRestConnector;
    function WithParamValues(_ParamValues: array of string): IRestConnector;
    function WithURLBase(_URLBase: string): IRestConnector;
  end;

type
  IRestAdapter<T> = interface
    ['{D2A3751C-3A54-48D8-9F5B-8E1CF4701F21}']
    function FromJson(_ResponseJson: TJSONValue): T;
  end;

type
  IRestProvider<T> = interface
  ['{178E7186-E0AB-4381-A6D4-E971A8BA2FBF}']
    function GetURLBase: String;
    function WithAdapter(_Adapter: IRestAdapter<T>): IRestProvider<T>;
    function WithToken(_Token: string): IRestProvider<T>;
    function FromJson(_JSonValue: TJsonValue): T;
  end;

implementation

end.
