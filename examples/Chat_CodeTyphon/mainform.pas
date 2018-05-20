unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  IdIRC, TwitchChat;

type
  { TFormMain }
  TFormMain = class(TForm)
    ButtonJoin: TButton;
    Button_Connect: TButton;
    Button_Send: TButton;
    Button_Disconnect: TButton;
    Edit_Name: TLabeledEdit;
    Edit_OAuth: TLabeledEdit;
    Label_Text: TLabel;
    Edit_Channel: TLabeledEdit;
    Memo_Text: TMemo;
    procedure ButtonJoinClick(Sender: TObject);
    procedure Button_ConnectClick(Sender: TObject);
    procedure Button_DisconnectClick(Sender: TObject);
    procedure Button_SendClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    FTwitchChat: TTwitchChat;
  protected
    procedure OnMessage (const AMessage: String);
  public
  end;

var
  FormMain: TFormMain;

implementation

{$R *.frm}

{ TFormMain }

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FTwitchChat := TTwitchChat.Create;

  FTwitchChat.OnMessage := @OnMessage;
end;

procedure TFormMain.Button_ConnectClick(Sender: TObject);
begin
  FTwitchChat.Connect(Edit_Name.Text, Edit_OAuth.Text);
end;

procedure TFormMain.ButtonJoinClick(Sender: TObject);
begin
  FTwitchChat.Join(Edit_Channel.Text);
end;

procedure TFormMain.Button_SendClick(Sender: TObject);
begin
  FTwitchChat.Say(Edit_Channel.Text, Memo_Text.Lines.Text);
end;

procedure TFormMain.Button_DisconnectClick(Sender: TObject);
begin
  FTwitchChat.Disconnect;
end;

procedure TFormMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FTwitchChat.Free;
end;

procedure TFormMain.OnMessage (const AMessage: String);
begin
  Memo_Text.Lines.Text := AMessage;
end;

end.

