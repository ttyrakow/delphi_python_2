object FMainForm: TFMainForm
  Left = 0
  Top = 0
  Caption = 'Temperatura'
  ClientHeight = 1023
  ClientWidth = 1254
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -24
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 192
  DesignSize = (
    1254
    1023)
  TextHeight = 32
  object Label1: TLabel
    Left = 11
    Top = 96
    Width = 77
    Height = 32
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Miasto:'
  end
  object Label2: TLabel
    Left = 11
    Top = 176
    Width = 136
    Height = 32
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Typ wykresu:'
  end
  object img: TImage
    Left = 32
    Top = 384
    Width = 1185
    Height = 615
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Anchors = [akLeft, akTop, akRight, akBottom]
    Center = True
    Proportional = True
    Stretch = True
  end
  object otworzArkuszButton: TButton
    Left = 272
    Top = 11
    Width = 374
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Otw'#243'rz arkusz danych'
    TabOrder = 0
    OnClick = otworzArkuszButtonClick
  end
  object miastoCombo: TComboBox
    Left = 272
    Top = 93
    Width = 817
    Height = 40
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Style = csDropDownList
    TabOrder = 1
  end
  object miesiecznyCheck: TRadioButton
    Left = 272
    Top = 176
    Width = 545
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Zmiany temperatur w miesi'#261'cach roku'
    Checked = True
    TabOrder = 2
    TabStop = True
  end
  object rokCombo: TComboBox
    Left = 912
    Top = 173
    Width = 177
    Height = 40
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Style = csDropDownList
    TabOrder = 3
  end
  object rocznyCheck: TRadioButton
    Left = 272
    Top = 228
    Width = 545
    Height = 34
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Zmiany roczne temperatury w miesi'#261'cu'
    TabOrder = 4
  end
  object miesiacCombo: TComboBox
    Left = 912
    Top = 225
    Width = 177
    Height = 40
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Style = csDropDownList
    TabOrder = 5
  end
  object wykresButton: TButton
    Left = 272
    Top = 304
    Width = 374
    Height = 49
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Rysuj wykres'
    TabOrder = 6
    OnClick = wykresButtonClick
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.xlsx'
    Filter = 'Arkusze Excel (*.xlsx)|*.xlsx|Wszystkie pliki (*.*)|*.*'
    FilterIndex = 0
    InitialDir = '.'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Wybierz arkusz'
    Left = 792
    Top = 424
  end
  object eng: TPythonEngine
    AutoLoad = False
    DllName = 'python311.dll'
    DllPath = '.'
    APIVersion = 1013
    RegVersion = '3.11'
    UseLastKnownVersion = False
    OnBeforeLoad = engBeforeLoad
    Left = 1072
    Top = 472
  end
end
