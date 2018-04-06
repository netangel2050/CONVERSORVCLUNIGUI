object frmmain: Tfrmmain
  Left = 0
  Top = 0
  Caption = 'Conversor VCL x UNIGUI'
  ClientHeight = 592
  ClientWidth = 777
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 777
    Height = 233
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 11
      Width = 37
      Height = 13
      Caption = 'Arquivo'
    end
    object Label2: TLabel
      Left = 16
      Top = 59
      Width = 50
      Height = 13
      Caption = 'Salvar Em '
    end
    object Label3: TLabel
      Left = 16
      Top = 107
      Width = 56
      Height = 13
      Caption = 'MainModule'
    end
    object Label4: TLabel
      Left = 143
      Top = 107
      Width = 23
      Height = 13
      Caption = 'Uses'
    end
    object Label5: TLabel
      Left = 16
      Top = 146
      Width = 32
      Height = 13
      Caption = 'Button'
    end
    object edArquivo: TEdit
      Left = 16
      Top = 28
      Width = 465
      Height = 21
      TabOrder = 0
      Text = 'C:\Projetos\DelphiXE6\wilton_unigui32\Balcao\'
    end
    object Button2: TButton
      Left = 487
      Top = 25
      Width = 18
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 511
      Top = 25
      Width = 62
      Height = 25
      Caption = 'Carregar'
      TabOrder = 2
      OnClick = Button3Click
    end
    object btnconverteDFM: TButton
      Left = 487
      Top = 80
      Width = 75
      Height = 25
      Caption = 'Converter'
      Enabled = False
      TabOrder = 3
      OnClick = btnconverteDFMClick
    end
    object edEndsalva: TEdit
      Left = 16
      Top = 80
      Width = 465
      Height = 21
      TabOrder = 4
      Text = 'C:\Projetos\DelphiXE6\wilton_unigui32\BalcaoWebWin\'
    end
    object edMainModule: TEdit
      Left = 16
      Top = 120
      Width = 121
      Height = 21
      TabOrder = 5
    end
    object edUses: TEdit
      Left = 143
      Top = 120
      Width = 594
      Height = 21
      Hint = 'Uses apos o implementation'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
    end
    object edButton: TEdit
      Left = 16
      Top = 159
      Width = 121
      Height = 21
      TabOrder = 7
    end
    object mUses: TMemo
      Left = 143
      Top = 147
      Width = 594
      Height = 80
      Hint = 'Uses inicio do .pas'
      ScrollBars = ssBoth
      TabOrder = 8
    end
    object mTemp: TMemo
      Left = 640
      Top = 8
      Width = 97
      Height = 56
      ScrollBars = ssBoth
      TabOrder = 9
      Visible = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 233
    Width = 777
    Height = 359
    Align = alClient
    TabOrder = 1
    object mOrigem: TMemo
      Left = 1
      Top = 1
      Width = 775
      Height = 143
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object mDestino: TMemo
      Left = 1
      Top = 144
      Width = 775
      Height = 125
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
    end
    object mObs: TMemo
      Left = 1
      Top = 269
      Width = 775
      Height = 89
      Align = alBottom
      ScrollBars = ssBoth
      TabOrder = 2
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.dfm'
    Filter = 'Arquivos DFM|*.dfm'
    Left = 704
    Top = 48
  end
end
