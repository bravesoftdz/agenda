object SmMain: TSmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 429
  Width = 636
  object fdqAlunos: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM aluno ')
    Left = 40
    Top = 96
  end
  object FDMySQLDriverLink: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Program Files\MySQL\MySQL Server 5.6\lib\libmysql.dll'
    Left = 136
    Top = 32
  end
  object FDWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 226
    Top = 32
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 136
    Top = 97
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=agendadb'
      'User_Name=admin'
      'Password=senhabdagenda'
      'Server=agendadb.cfmlnopzuyrp.sa-east-1.rds.amazonaws.com'
      'DriverID=MySQL')
    LoginPrompt = False
    AfterConnect = FDConnectionAfterConnect
    Left = 42
    Top = 32
  end
  object FDConnectionLocal: TFDConnection
    Params.Strings = (
      'Database=agenda'
      'User_Name=root'
      'Password=admin'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 42
    Top = 152
  end
  object fdqLogError: TFDQuery
    BeforePost = fdqLogErrorBeforePost
    Connection = FDConnection
    SQL.Strings = (
      'select * from log_error l'
      'where l.log_error_id = :log_error_id')
    Left = 40
    Top = 216
    ParamData = <
      item
        Name = 'LOG_ERROR_ID'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object ApplicationEvents: TApplicationEvents
    OnException = ApplicationEventsException
    Left = 136
    Top = 152
  end
  object fdqProcessoAtualizacao: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM processo_atualizacao'
      'where ((escola_id = :escola_id) or (escola_id = 0))'
      '')
    Left = 48
    Top = 304
    ParamData = <
      item
        Name = 'ESCOLA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM periodo_tipo;')
    Left = 152
    Top = 304
  end
end
