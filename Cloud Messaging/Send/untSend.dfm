object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Cloud Messaging - Send'
  ClientHeight = 313
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 21
    Width = 51
    Height = 13
    Caption = 'Mensagem'
  end
  object Label2: TLabel
    Left = 24
    Top = 72
    Width = 89
    Height = 13
    Caption = 'Response Content'
  end
  object edtMessage: TEdit
    Left = 24
    Top = 40
    Width = 329
    Height = 21
    TabOrder = 0
  end
  object memResponse: TMemo
    Left = 24
    Top = 91
    Width = 329
    Height = 182
    TabOrder = 1
  end
  object btnSendMessage: TButton
    Left = 376
    Top = 38
    Width = 105
    Height = 25
    Caption = 'Send Message'
    Default = True
    TabOrder = 2
    OnClick = btnSendMessageClick
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 440
    Top = 224
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 440
    Top = 168
  end
end
