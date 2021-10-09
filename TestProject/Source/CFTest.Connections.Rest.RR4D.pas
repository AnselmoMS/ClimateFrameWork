unit CFTest.Connections.Rest.RR4D;

interface

uses
  DUnitX.TestFramework,
  CF.Connections.Connector.Rest.RR4D;

type
  [TestFixture]
  TCFTestConnectionsRestRR4D = class
  private
    FConnectorRestRR4D: TConnectorRestRR4D;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure ExecuteGet;
  end;

implementation
uses
  Delphi.Mocks;



procedure TCFTestConnectionsRestRR4D.ExecuteGet;
begin

end;

procedure TCFTestConnectionsRestRR4D.Setup;
  procedure AfterGet;
  begin

  end;
  const
  MOCK_URL = '';
begin
  FConnectorRestRR4D := TConnectorRestRR4D.Create;

  FConnectorRestRR4D
    .WithURLBase(MOCK_URL)
    .OnAfterGet(AfterGet)
end;

procedure TCFTestConnectionsRestRR4D.TearDown;
begin
end;


initialization
  TDUnitX.RegisterTestFixture(TCFTestConnectionsRestRR4D);

end.
