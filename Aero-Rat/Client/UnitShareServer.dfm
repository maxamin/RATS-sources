object ShareServer: TShareServer
  Left = 537
  Top = 345
  Width = 331
  Height = 346
  Caption = 'ShareServer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    315
    310)
  PixelsPerInch = 96
  TextHeight = 13
  object ListView1: TListView
    Left = 8
    Top = 8
    Width = 297
    Height = 265
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        AutoSize = True
        Caption = 'Address'
      end
      item
        Caption = 'Port'
      end>
    HideSelection = False
    RowSelect = True
    PopupMenu = PopupMenu1
    SmallImages = ImageList1
    TabOrder = 0
    ViewStyle = vsReport
  end
  object Button2: TButton
    Left = 137
    Top = 280
    Width = 81
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button1: TButton
    Left = 225
    Top = 280
    Width = 81
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    TabOrder = 2
    OnClick = Button1Click
  end
  object ImageList1: TImageList
    Left = 600
    Top = 200
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000067907000588662004C7A5600628D6C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000759F7C0056885E0081BA8D008CCA9A0097D5A50076B486004D8358004E7A
      5600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006464B8006464B800000000000000000000000000000000006464B8006464
      B800000000000000000000000000000000000000000000000000000000006894
      700072A97C00A1E1AD0089CC95007CC0890071B8800084CB93009FE3AE006AA5
      7800537F5B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006464
      B8009898EE009898EE006464B80000000000000000006464B8009898EE009898
      EE006464B80000000000000000000000000000000000000000007BA6850077AE
      8100A0E3AC0074B980006FB27B0067AB740065AC740066AF770064B076009DE4
      AC00609B6E00527F5E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006464
      B8006060E3006060E3009C9CF1006464B8006464B8009C9CF1006060E3006060
      E3006464B8000000000000000000000000000000000000000000669A7200A3E2
      B00077BC83006FB37A0077B48200DAFFE400D8FFE4006EB07D0063AF750063AF
      7500A2E5B2004C845B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006464B8006666E8006666E800A1A1F300A1A1F3006666E8006666E8006464
      B800000000000000000000000000000000000000000086B0910094CCA10090D0
      9C007EBF880073AE7C006F9B7600E6FFEE00DEFFE80077AA84006DB07D0069B2
      7A0087CD980076B4860064917000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006464B8006D6DED006D6DED006D6DED006D6DED006464B8000000
      000000000000000000000000000000000000000000007FAC8B00A3DCAF0087C7
      930083C18D00DFFFE600EAFFEE00ECFFF100ECFFF200DFFFE900D6FFE6006DB3
      7E006CB57D0096D7A60051815D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006464B8007373F3007373F3007373F3007373F3006464B8000000
      000000000000000000000000000000000000000000007CA68700AFE5BA0095D2
      A00085BD8C00E1FFE700E9FFED00F1FFF400EDFFF400E6FFF000DAFFE60068AC
      770075BC84009CDAAA00507E5A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006464B800B0B0FB007979F8007979F8007979F8007979F800B0B0FB006464
      B800000000000000000000000000000000000000000095BB9F00AADCB400ABE2
      B3008DC594008CBD91008AAC8D00EAFFEE00E6FFEC00709B7A0079B585006FB3
      7E008CCE9A0088C1940067907000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006464
      B800B3B3FD007E7EFC007E7EFC006464B8006464B8007E7EFC007E7EFC00B3B3
      FD006464B800000000000000000000000000000000000000000097C19E00BFF2
      C6009DD5A40097CE9D0094C59900E3FFE900E1FFE9008DC4970075B783007CC0
      8900A4E1AF0060926A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006464
      B8008181FF008181FF006464B80000000000000000006464B8008181FF008181
      FF006464B800000000000000000000000000000000000000000095B69B00ACD7
      B200CEFFD3009AD1A00092C899008EC495008FC9990090CC9C008CCE9A00A3E2
      B00081B68B006B95720000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006464B8006464B800000000000000000000000000000000006464B8006464
      B8000000000000000000000000000000000000000000000000000000000090B1
      9600ADD8B300CDFDD300B4E9BD009FD6A9009BD4A700A5E0B300B2EDC00080B4
      8C006C9575000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009CBAA100A3CAAA00BCE8C400C6F7D100C1F4CE00A9DCB6007BAA890080A9
      8A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009AB9A40081A58D007CA38A008CB09800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFC3F00000000
      FFFFF00F00000000F3CFE00700000000E187C00300000000E007C00300000000
      F00F800100000000F81F800100000000F81F800100000000F00F800100000000
      E007C00300000000E187C00300000000F3CFE00700000000FFFFF00F00000000
      FFFFFC3F00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object PopupMenu1: TPopupMenu
    Images = ImageList1
    Left = 80
    Top = 72
    object Add1: TMenuItem
      Caption = 'Add'
      ImageIndex = 1
      OnClick = Add1Click
    end
    object Remove1: TMenuItem
      Caption = 'Remove'
      ImageIndex = 0
      OnClick = Remove1Click
    end
  end
end
