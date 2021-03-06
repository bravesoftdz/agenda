object frmPesquisaResponsavel: TfrmPesquisaResponsavel
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  Caption = 'Pesquisa de Respons'#225'veis'
  ClientHeight = 457
  ClientWidth = 788
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grbxDados: TcxGroupBox
    Left = 0
    Top = 70
    Align = alClient
    Caption = 'Dados'
    TabOrder = 1
    Height = 336
    Width = 788
    object cxGrid1: TcxGrid
      Left = 2
      Top = 18
      Width = 784
      Height = 316
      Align = alClient
      TabOrder = 0
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = cxGrid1DBTableView1CellDblClick
        DataController.DataSource = dsPesquisa
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Inactive = cxStyle1
        object cxGrid1DBTableView1nome: TcxGridDBColumn
          Caption = 'Nome'
          DataBinding.FieldName = 'nome'
          Width = 226
        end
        object cxGrid1DBTableView1sobrenome: TcxGridDBColumn
          Caption = 'Sobrenome'
          DataBinding.FieldName = 'sobrenome'
          Width = 352
        end
        object cxGrid1DBTableView1CPF: TcxGridDBColumn
          Caption = 'CPF'
          DataBinding.FieldName = 'cpf'
          Width = 90
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
  end
  object grbxFiltro: TcxGroupBox
    Left = 0
    Top = 0
    Align = alTop
    Caption = 'Filtros'
    TabOrder = 0
    Height = 70
    Width = 788
    object edtConteudo: TcxTextEdit
      Left = 169
      Top = 38
      TabOrder = 3
      OnKeyUp = edtConteudoKeyUp
      Width = 361
    end
    object lblCampo: TcxLabel
      Left = 16
      Top = 18
      Caption = 'Campo'
    end
    object lblConteudo: TcxLabel
      Left = 169
      Top = 18
      Caption = 'Conte'#250'do'
    end
    object cmbCampo: TcxComboBox
      Left = 16
      Top = 38
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Nome'
        'Sobrenome'
        'CPF')
      Properties.OnChange = cmbCampoPropertiesChange
      TabOrder = 0
      Text = 'Nome'
      Width = 129
    end
  end
  object grbxRodape: TcxGroupBox
    Left = 0
    Top = 406
    Align = alBottom
    TabOrder = 2
    Height = 51
    Width = 788
    object btnOK: TcxButton
      Left = 622
      Top = 17
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancelar: TcxButton
      Left = 703
      Top = 17
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object fdqPesquisa: TFDQuery
    IndexFieldNames = 'nome'
    Connection = DM.FDConnection
    SQL.Strings = (
      'SELECT * FROM  responsavel'
      'where escola_id = :escola_id ')
    Left = 692
    Top = 240
    ParamData = <
      item
        Name = 'ESCOLA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object dsPesquisa: TDataSource
    DataSet = fdqPesquisa
    Left = 692
    Top = 288
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 688
    Top = 336
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = clHighlight
      TextColor = clHighlightText
    end
  end
end
