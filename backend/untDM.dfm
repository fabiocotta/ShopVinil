object DM: TDM
  Encoding = esUtf8
  QueuedRequest = False
  Height = 251
  Width = 341
  object conn: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\f_cot\Documents\GitHub\ShopVinil\backend\db\VI' +
        'NIL.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    ConnectedStoredUsage = []
    LoginPrompt = False
    Left = 32
    Top = 32
  end
  object ServerEvents: TRESTDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        NeedAuthorization = True
        Params = <>
        DataMode = dmRAW
        Name = 'dweventVinil'
        EventName = 'vinil'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEventByType = ServerEventsEventsdweventVinilReplyEventByType
      end>
    Left = 96
    Top = 32
  end
end