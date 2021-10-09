unit CFTest.Connections;

interface

uses
  DUnitX.TestFramework,
  CF.Connections.Rest.Connector;

type
  [TestFixture]
  TCFTestConnections = class
  public
   var
   FConnectorRest: TRestConnector;

    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestDoAfterGet;
    [Test]
    procedure TestGetResponseJson;
    [Test]
    procedure TestOnAfterGet;
    [Test]
    [TestCase('Case Full URL .com.br', 'www.anselmomota.com.br')]
    procedure ValidWithURLBase(_URLBase: string);
    [Test]
    [TestCase('Case Empty URL', '')]
    procedure InValidWithURLBase(_URLBase: string);
  end;

implementation

uses
  System.SysUtils;

procedure TCFTestConnections.InValidWithURLBase(_URLBase: string);
begin
  Assert.WillRaise(
   procedure
   begin
     FConnectorRest.WithURLBase(_URLBase)
   end)
end;

procedure TCFTestConnections.Setup;
begin
  FConnectorRest:= TRestConnector.Create;
end;

procedure TCFTestConnections.TearDown;
begin
  FConnectorRest:= nil;
end;

procedure TCFTestConnections.TestDoAfterGet;
begin
  Assert.WillRaise(procedure
                   begin
                     FConnectorRest.ExecuteGet
                   end,
                   EAbstractError)
end;

procedure TCFTestConnections.TestGetResponseJson;
begin
  Assert.IsNull(FConnectorRest.GetResponseJson)
end;

procedure TCFTestConnections.TestOnAfterGet;
begin
  Assert.AreSame(FConnectorRest,
                 FConnectorRest.OnAfterGet(
                   procedure
                   begin
                   end
                    )
                 )
end;

procedure TCFTestConnections.ValidWithURLBase(_URLBase: string);
begin
  Assert.WillNotRaise(
   procedure
   begin
     FConnectorRest.WithURLBase(_URLBase)
   end)
end;

initialization
  TDUnitX.RegisterTestFixture(TCFTestConnections);

end.
