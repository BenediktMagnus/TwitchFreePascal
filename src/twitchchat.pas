Unit TwitchChat;

{$mode objfpc}{$H+}

interface

uses
  { Indy }
  IdIRC;

type
  TTwitchChat = class
  protected
    FName: String;
    FOAuth: String;
    FIRCClient: TIdIRC;
  protected
    procedure PrefixChannel (var AChannel: String);
  public
    constructor Create; virtual; overload;
    constructor Create (const AName, AOAuth: String); virtual; overload;
    destructor Destroy; override;
    procedure Connect; overload;
    procedure Connect (const AName, AOAuth: String); overload;
    procedure Disconnect;
    procedure Join (AChannel: String);
    procedure Say (AChannel: String; const AMessage: String);
  public
    property Name: String read FName write FName;
    property OAuth: String read FOAuth write FOAuth;
  end;

implementation

const
  TwitchIRCServerHost = 'irc.chat.twitch.tv';
  TwitchIRCServerPort = 6667;

//////////////////////////
//Constructor/Destructor//
//////////////////////////

constructor TTwitchChat.Create;
begin
  inherited;

  FIRCClient := TIdIRC.Create;
end;

constructor TTwitchChat.Create (const AName, AOAuth: String);
begin
  FName := AName;
  FOAuth := AOAuth;

  Create;
end;

destructor TTwitchChat.Destroy;
begin
  FIRCClient.Free;

  inherited;
end;

/////////////////////
//Private/Protected//
/////////////////////

procedure TTwitchChat.PrefixChannel (var AChannel: String);
begin
  if AChannel[1] <> '#' then
    AChannel := '#' + AChannel;
end;

//////////
//Public//
//////////

procedure TTwitchChat.Connect (const AName, AOAuth: String);
begin
  FName := AName;
  FOAuth := AOAuth;

  Connect;
end;

procedure TTwitchChat.Connect;
begin
  FIRCClient.Host := TwitchIRCServerHost;
  FIRCClient.Port := TwitchIRCServerPort;
  FIRCClient.Nickname := FName;
  FIRCClient.Password := FOAuth;

  FIRCClient.Connect;
end;

procedure TTwitchChat.Disconnect;
begin
  FIRCClient.Disconnect;
end;

procedure TTwitchChat.Join (AChannel: String);
begin
  PrefixChannel(AChannel);

  FIRCClient.Join(AChannel);
end;

procedure TTwitchChat.Say (AChannel: String; const AMessage: String);
begin
  PrefixChannel(AChannel);

  FIRCClient.Say(AChannel, AMessage);
end;

end.
