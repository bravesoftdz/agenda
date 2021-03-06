object SmMain: TSmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 432
  Width = 723
  object FDMySQLDriverLink: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Program Files\MySQL\MySQL Server 5.6\lib\libmysql.dll'
    Left = 224
    Top = 24
  end
  object FDWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 442
    Top = 24
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 336
    Top = 25
  end
  object fdqLogError: TFDQuery
    BeforePost = fdqLogErrorBeforePost
    Connection = ServerContainer.FDConnection
    SQL.Strings = (
      'select * from log_error l'
      'where l.log_error_id = :log_error_id')
    Left = 56
    Top = 288
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
    Left = 528
    Top = 24
  end
  object fdqProcessoAtualizacao: TFDQuery
    Connection = ServerContainer.FDConnection
    SQL.Strings = (
      'SELECT * FROM processo_atualizacao'
      '')
    Left = 264
    Top = 288
  end
  object fdqLogServerRequest: TFDQuery
    Connection = ServerContainer.FDConnection
    SQL.Strings = (
      'select * from log_server_request l'
      'where l.log_server_request_id = :log_server_request_id')
    Left = 144
    Top = 288
    ParamData = <
      item
        Name = 'LOG_SERVER_REQUEST_ID'
        DataType = ftString
        ParamType = ptInput
        Value = '3'
      end>
  end
  object fdqTurmaAluno: TFDQuery
    Connection = ServerContainer.FDConnection
    SQL.Strings = (
      'select '#10'ta.*'#10'from turma_aluno ta'#10
      'inner join turma t on (t.turma_id = ta.turma_id )'#13#10#10
      'where escola_id = :escola_id'#10)
    Left = 234
    Top = 96
    ParamData = <
      item
        Name = 'ESCOLA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
      end>
  end
  object fdqTurma: TFDQuery
    Connection = ServerContainer.FDConnection
    SQL.Strings = (
      'SELECT * FROM turma t'#13#10#10
      'where escola_id = :escola_id'
      'order by nome')
    Left = 130
    Top = 96
    ParamData = <
      item
        Name = 'ESCOLA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object fdqAluno: TFDQuery
    Connection = ServerContainer.FDConnection
    SQL.Strings = (
      
        'SELECT a.*, concat(coalesce(a.nome,'#39#39'),'#39' '#39', coalesce(a.sobrenome' +
        ','#39#39')) as nome_completo '
      'FROM aluno a'
      'where 1=1'#10' '#10
      'and escola_id = :escola_id'#10
      'and ativo = '#39'S'#39
      'order by nome_completo'#10)
    Left = 50
    Top = 98
    ParamData = <
      item
        Name = 'ESCOLA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object fdqResp: TFDQuery
    Connection = ServerContainer.FDConnection
    SQL.Strings = (
      'select * from responsavel r'
      
        'inner join responsavel_escola re on (r.responsavel_id = re.respo' +
        'nsavel_id)'
      'where re.ativo = '#39'S'#39)
    Left = 56
    Top = 176
  end
  object fdqRespAluno: TFDQuery
    Connection = ServerContainer.FDConnection
    SQL.Strings = (
      'select ra.*'
      'from responsavel_aluno ra'
      
        'inner join responsavel_escola re on (ra.responsavel_id = re.resp' +
        'onsavel_id)'
      'where re.ativo = '#39'S'#39
      ''
      '')
    Left = 232
    Top = 176
  end
  object fdqRespTelefone: TFDQuery
    Connection = ServerContainer.FDConnection
    SQL.Strings = (
      'select rt.*'
      'from responsavel_telefone rt'
      
        'inner join responsavel_escola re on (rt.responsavel_id = re.resp' +
        'onsavel_id)'
      'where re.ativo = '#39'S'#39
      ''
      '')
    Left = 328
    Top = 176
  end
  object fdqFuncionarios: TFDQuery
    Connection = ServerContainer.FDConnection
    SQL.Strings = (
      'select * from funcionario f'#13#10#10
      ''
      'where f.escola_id = :escola_id'
      ''
      'and ativo = '#39'S'#39)
    Left = 56
    Top = 232
    ParamData = <
      item
        Name = 'ESCOLA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object fdqFuncionario: TFDQuery
    Connection = ServerContainer.FDConnection
    SQL.Strings = (
      'select * from funcionario f'#13#10#10
      ''
      'where funcionario_id = :funcionario_id '
      ''
      'and f.escola_id = :escola_id'
      ''
      'and ativo = '#39'S'#39)
    Left = 144
    Top = 232
    ParamData = <
      item
        Name = 'FUNCIONARIO_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ESCOLA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object fdqRespEscola: TFDQuery
    Connection = ServerContainer.FDConnection
    SQL.Strings = (
      'select re.*'
      'from responsavel_escola re'
      'where re.ativo = '#39'S'#39)
    Left = 144
    Top = 176
  end
  object fdqConfiguracoes: TFDQuery
    BeforePost = fdqConfiguracoesBeforePost
    Connection = ServerContainer.FDConnection
    SQL.Strings = (
      'select * from configuracoes'
      'where :configuracoes_id = :configuracoes_id')
    Left = 56
    Top = 349
    ParamData = <
      item
        Name = 'CONFIGURACOES_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
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
    Left = 528
    Top = 152
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 528
    Top = 96
  end
  object fdqLogCloudMessaging: TFDQuery
    Connection = ServerContainer.FDConnection
    SQL.Strings = (
      'select * from log_cloud_messaging l'
      'where log_cloud_messaging_id= :log_cloud_messaging_id')
    Left = 528
    Top = 208
    ParamData = <
      item
        Name = 'LOG_CLOUD_MESSAGING_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object fdqDeviceUsuario: TFDQuery
    BeforePost = fdqConfiguracoesBeforePost
    Connection = ServerContainer.FDConnection
    SQL.Strings = (
      'select * from device_usuario'
      'where device_usuario_id = :device_usuario_id')
    Left = 530
    Top = 260
    ParamData = <
      item
        Name = 'DEVICE_USUARIO_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object fdqDevicesResp: TFDQuery
    Connection = ServerContainer.FDConnection
    SQL.Strings = (
      'select du.device_token '#13#10#10
      'from responsavel_aluno ra'#13#10#10
      
        'inner join device_usuario du on (du.responsavel_id = ra.responsa' +
        'vel_id)'#13#10#10
      
        'inner join responsavel r on (r.responsavel_id = ra.responsavel_i' +
        'd)'#13#10#10
      'where ra.aluno_id = :aluno_id'#13#10#10
      'and r.ativo = '#39'S'#39#13#10#10
      'and ra.responsavel_id <> :responsavel_id')
    Left = 530
    Top = 325
    ParamData = <
      item
        Name = 'ALUNO_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'RESPONSAVEL_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object fdqDevicesFunc: TFDQuery
    Connection = ServerContainer.FDConnection
    SQL.Strings = (
      ''
      'select du.device_token'
      'from funcionario f'
      
        'inner join device_usuario du on (du.funcionario_id = f.funcionar' +
        'io_id)'
      'inner join turma t on (t.funcionario_id = f.funcionario_id)'
      'where f.ativo = '#39'S'#39
      ''
      'and t.turma_id in ( select ta.turma_id'
      #9#9#9#9#9'from turma_aluno ta'
      #9#9#9#9#9'where ta.aluno_id = :aluno_id'
      '                  )'
      '                  '
      'and f.funcionario_id <> :funcionario_id  ')
    Left = 530
    Top = 381
    ParamData = <
      item
        Name = 'ALUNO_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FUNCIONARIO_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
