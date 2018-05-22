Unit TwitchChat;

{$mode objfpc}{$H+}

interface

uses
  { System }
  Classes,
  { Indy }
  IdIRC, IdContext,
  { Twitch }
  TwitchUtils;

type
  TTwitchChat = class
  type
    TOnMessageEvent = procedure (const AMessage: String) of object;
    TMessageEventList = specialize TSynchronisedEventList<String>;
  protected
    FName: String;
    FOAuth: String;
    FIRCClient: TIdIRC;
    FSynchronised: Boolean;
    procedure PrefixChannel (var AChannel: String);
  protected
    FMessageEventList: TMessageEventList;
    procedure SetOnMessage (AOnMessageEvent : TOnMessageEvent);
    procedure OnMessageEvent (ASender: TIdContext; const ANickname, AHost, ATarget, AMessage: String);
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
    //If true, events will be fired by TThread.Synchronize instead of TThread.Queue.
    //This can be needed or useful on some systems or environments.
    property Synchronised: Boolean read FSynchronised write FSynchronised;
  public
    property OnMessage: TOnMessageEvent write SetOnMessage;
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
  
  FMessageEventList := TMessageEventList.Create;

  FIRCClient.OnPrivateMessage := @OnMessageEvent;
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

  FMessageEventList.Free;

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

procedure TTwitchChat.SetOnMessage (AOnMessageEvent: TOnMessageEvent);
begin
  FMessageEventList.Call := AOnMessageEvent;
end;

procedure TTwitchChat.OnMessageEvent (ASender: TIdContext; const ANickname, AHost, ATarget, AMessage: String);
begin
  FMessageEventList.AddObject(ANickname + ': ' +  AMessage);

  if Synchronised then
    TThread.Synchronize(nil, @FMessageEventList.CallNext)
  else
    TThread.Queue(nil, @FMessageEventList.CallNext);
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
  FIRCClient.IOHandler.ReadTimeout := 100; //If not set, a disconnect will result in an endless WaitFor.
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
