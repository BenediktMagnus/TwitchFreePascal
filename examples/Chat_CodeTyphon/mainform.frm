object FormMain: TFormMain
  Left = 309
  Height = 414
  Top = 250
  Width = 470
  Caption = 'Example CodeTyphon'
  ClientHeight = 414
  ClientWidth = 470
  OnClose = FormClose
  OnCreate = FormCreate
  LCLVersion = '6.4'
  object Button_Connect: TButton
    Left = 1
    Height = 32
    Top = 66
    Width = 116
    Caption = 'Connect'
    OnClick = Button_ConnectClick
    TabOrder = 0
  end
  object Memo_Text: TMemo
    Left = 1
    Height = 176
    Top = 192
    Width = 463
    Lines.Strings = (
      'Hello Twitch!'
    )
    TabOrder = 1
  end
  object Button_Send: TButton
    Left = 1
    Height = 33
    Top = 376
    Width = 116
    Caption = 'Send'
    OnClick = Button_SendClick
    TabOrder = 2
  end
  object Button_Disconnect: TButton
    Left = 348
    Height = 32
    Top = 376
    Width = 116
    Caption = 'Disconnect'
    OnClick = Button_DisconnectClick
    TabOrder = 3
  end
  object Edit_Name: TLabeledEdit
    Left = 1
    Height = 27
    Top = 32
    Width = 160
    EditLabel.AnchorSideLeft.Control = Edit_Name
    EditLabel.AnchorSideRight.Control = Edit_Name
    EditLabel.AnchorSideRight.Side = asrBottom
    EditLabel.AnchorSideBottom.Control = Edit_Name
    EditLabel.Left = 1
    EditLabel.Height = 17
    EditLabel.Top = 12
    EditLabel.Width = 160
    EditLabel.Caption = 'Twitch name:'
    EditLabel.ParentColor = False
    TabOrder = 4
  end
  object Edit_OAuth: TLabeledEdit
    Left = 176
    Height = 27
    Top = 32
    Width = 288
    EditLabel.AnchorSideLeft.Control = Edit_OAuth
    EditLabel.AnchorSideRight.Control = Edit_OAuth
    EditLabel.AnchorSideRight.Side = asrBottom
    EditLabel.AnchorSideBottom.Control = Edit_OAuth
    EditLabel.Left = 176
    EditLabel.Height = 17
    EditLabel.Top = 12
    EditLabel.Width = 288
    EditLabel.Caption = 'Twitch OAuth:'
    EditLabel.ParentColor = False
    TabOrder = 5
  end
  object Edit_Channel: TLabeledEdit
    Left = 1
    Height = 27
    Top = 136
    Width = 279
    EditLabel.AnchorSideLeft.Control = Edit_Channel
    EditLabel.AnchorSideRight.Control = Edit_Channel
    EditLabel.AnchorSideRight.Side = asrBottom
    EditLabel.AnchorSideBottom.Control = Edit_Channel
    EditLabel.Left = 1
    EditLabel.Height = 17
    EditLabel.Top = 116
    EditLabel.Width = 279
    EditLabel.Caption = 'Channel name:'
    EditLabel.ParentColor = False
    TabOrder = 6
  end
  object Label_Text: TLabel
    Left = 1
    Height = 17
    Top = 168
    Width = 33
    Caption = 'Text:'
    ParentColor = False
  end
end
