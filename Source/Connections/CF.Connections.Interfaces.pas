unit CF.Connections.Interfaces;

interface

uses
  System.JSON,
  System.SysUtils;

type
  IConnector = interface {Rest, DataBase, File i/o}
    ['{94C2072D-AE4D-43EE-8A34-F31E602D9643}']
  end;

implementation

end.
