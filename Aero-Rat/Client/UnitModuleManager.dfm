object ModuleManager: TModuleManager
  Left = 488
  Top = 237
  Width = 518
  Height = 357
  Caption = 'ModuleManager'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ListView1: TListView
    Left = 0
    Top = 0
    Width = 502
    Height = 304
    Align = alClient
    Columns = <
      item
        Caption = 'Name'
        Width = 100
      end
      item
        Caption = 'Location'
        Width = 250
      end>
    HideSelection = False
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    PopupMenu = PopupMenu1
    SmallImages = ImageList1
    TabOrder = 0
    ViewStyle = vsReport
    OnCustomDrawItem = ListView1CustomDrawItem
    OnCustomDrawSubItem = ListView1CustomDrawSubItem
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 304
    Width = 502
    Height = 17
    Panels = <>
    SimplePanel = True
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 128
    Top = 168
  end
  object ImageList1: TImageList
    Left = 232
    Top = 104
    Bitmap = {
      494C010105000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006D6D
      6D006F6F6F00696969006A6A6A006D6D6D006F6F6F006D6D6D006C6C6C006767
      6700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006E6E6E007373
      7300A8A8A800A5A5A500AAAAAA00A1A1A100A3A3A300A7A7A700AAAAAA007979
      79006F6F6F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006F6F6F00D8D8
      D800D5D5D500CECECE00D6D6D600DCDCDC00D4D4D400D0D0D000DEDEDE00CECE
      CE006D6D6D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000068686800ABAB
      AB00A6A6A600AEAEAE00A7A7A700A5A5A500A9A9A900AAAAAA00A0A0A000ABAB
      AB00727272000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6B6B00E1E1
      E100D6D6D600DADADA00DCDCDC00D8D8D800E2E2E200DCDCDC00DBDBDB00DDDD
      DD00686868000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006E6E6E00A5A5
      A500B6B6B600ACACAC00B1B1B100B1B1B100A8A8A800AAAAAA00B4B4B400AAAA
      AA00767676000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006E6E6E00E1E1
      E100E0E0E000E6E6E600DDDDDD00E0E0E000E5E5E500E1E1E100E2E2E200E3E3
      E300666666000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000071717100B1B1
      B100BABABA00B4B4B400B3B3B300B6B6B600B8B8B800B3B3B300B5B5B500B5B5
      B5006F6F6F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005A5A
      5A0091919100949494005E5E5E006C6C6C006A6A6A00A5A5A500EBEBEB009D9D
      9D00676767000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000068686800BABABA006A6A
      6A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006A6A6A00F0F0F0006D6D
      6D00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C5C5C5006A6A6A0000000000000000000000000066666600E8E8E8007373
      7300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006D6D6D00F0F0F0006E6E6E006F6F6F006E6E6E00EFEFEF00E8E8E8007171
      7100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C4C4C400E9E9E900E7E7E700EEEEEE00E3E3E300EBEBEB006C6C6C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CACACA006F6F6F006C6C6C00707070006B6B6B00000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006F6F
      6F0062626200767676006F6F6F006C6C6C006969690075757500707070006161
      6100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000717171007878
      7800A6A6A600A4A4A4009F9F9F00A5A5A500A9A9A9009E9E9E00A0A0A0007F7F
      7F00727272000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006464B8006464B800000000000000000000000000000000006464B8006464
      B800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006A6A6A00D3D3
      D300D5D5D500D8D8D800D3D3D300D5D5D500D0D0D000D6D6D600D9D9D900D3D3
      D3006C6C6C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006464
      B8009898EE009898EE006464B80000000000000000006464B8009898EE009898
      EE006464B8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006F6F6F00ACAC
      AC00A9A9A900AFAFAF00A6A6A600ADADAD00AEAEAE00A7A7A700AAAAAA00AAAA
      AA00666666000000000000000000000000000000000000000000000000000000
      00000000000000000000818181002A2A2A002A2A2A007E7E7E00000000000000
      0000000000000000000000000000000000000000000000000000000000006464
      B8006060E3006060E3009C9CF1006464B8006464B8009C9CF1006060E3006060
      E3006464B8000000000000000000000000000000000000000000000000000000
      00000000000000000000A5C3A60071926F006586630095B39600000000000000
      000000000000000000000000000000000000000000000000000066666600DEDE
      DE00D6D6D600D2D2D200E2E2E200D7D7D700D7D7D700D7D7D700DEDEDE00DFDF
      DF006C6C6C000000000000000000000000000000000000000000000000000000
      000000000000878787005F5F5F00828282007D7D7D00565656007E7E7E000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006464B8006666E8006666E800A1A1F300A1A1F3006666E8006666E8006464
      B800000000000000000000000000000000000000000000000000000000000000
      000000000000ABC9AC00A3CBA1009DC99A00A0CC9D009DC59B009AB89B000000
      00000000000000000000000000000000000000000000000000006D6D6D00B2B2
      B200B3B3B300B1B1B100AFAFAF00B3B3B300B9B9B900ACACAC00B2B2B200ACAC
      AC006D6D6D000000000000000000000000000000000000000000000000000000
      0000000000003E3E3E008888880061616100555555007D7D7D002A2A2A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006464B8006D6DED006D6DED006D6DED006D6DED006464B8000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000081A27F00AEDAAB009DCE980093C48E00A2CE9F00698A67000000
      00000000000000000000000000000000000000000000000000006B6B6B00E3E3
      E300E1E1E100E4E4E400E2E2E200DFDFDF00E3E3E300E5E5E500DFDFDF00E5E5
      E5006E6E6E000000000000000000000000000000000000000000000000000000
      000000000000424242008A8A8A00666666005C5C5C00818181002C2C2C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006464B8007373F3007373F3007373F3007373F3006464B8000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000087A88500B5E1B2009FD09A0094C58F00A5D1A20071926F000000
      00000000000000000000000000000000000000000000000000006D6D6D00B5B5
      B50035353500B7B7B700B6B6B600B4B4B400B5B5B500BBBBBB002F2F2F00BABA
      BA006B6B6B000000000000000000000000000000000000000000000000000000
      0000000000008E8E8E00696969008A8A8A008686860062626200838383000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006464B800B0B0FB007979F8007979F8007979F8007979F800B0B0FB006464
      B800000000000000000000000000000000000000000000000000000000000000
      000000000000ACCAAD00ADD5AB00B8E4B500AFDBAC00A8D0A600A4C2A5000000
      000000000000000000000000000000000000000000000000000068686800A7A7
      A700E7E7E7009E9E9E006D6D6D006F6F6F00727272009B9B9B00EFEFEF009D9D
      9D00707070000000000000000000000000000000000000000000000000000000
      000000000000000000008E8E8E00434343004141410089898900000000000000
      0000000000000000000000000000000000000000000000000000000000006464
      B800B3B3FD007E7EFC007E7EFC006464B8006464B8007E7EFC007E7EFC00B3B3
      FD006464B8000000000000000000000000000000000000000000000000000000
      00000000000000000000AECCAF0088A9860087A88500ABC9AC00000000000000
      0000000000000000000000000000000000000000000000000000000000006666
      6600EEEEEE006C6C6C000000000000000000000000006C6C6C00EDEDED006B6B
      6B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006464
      B8008181FF008181FF006464B80000000000000000006464B8008181FF008181
      FF006464B8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006D6D
      6D00EDEDED006D6D6D000000000000000000000000006C6C6C00E8E8E8006F6F
      6F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006464B8006464B800000000000000000000000000000000006464B8006464
      B800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007171
      7100EDEDED00E6E6E6006A6A6A006F6F6F0069696900E9E9E900EAEAEA007070
      7000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B6B6B00E7E7E700FFFFFF00F5F5F500ECECEC00F0F0F000737373000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000071717100686868006E6E6E006E6E6E0063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000E00F000000000000
      C007000000000000C007000000000000C007000000000000C007000000000000
      C007000000000000C007000000000000C007000000000000E007000000000000
      FF8F000000000000FF8F000000000000F38F000000000000F00F000000000000
      F01F000000000000F83F000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFE00F
      FFFFFFFFFFFFC007FFFFF3CFFFFFC007FFFFE187FFFFC007FC3FE007FC3FC007
      F81FF00FF81FC007F81FF81FF81FC007F81FF81FF81FC007F81FF00FF81FC007
      FC3FE007FC3FE38FFFFFE187FFFFE38FFFFFF3CFFFFFE00FFFFFFFFFFFFFF01F
      FFFFFFFFFFFFF83FFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object PopupMenu1: TPopupMenu
    Images = ImageList1
    Left = 112
    Top = 256
    object Refresh1: TMenuItem
      Caption = 'Refresh'
      ImageIndex = 2
      OnClick = Refresh1Click
    end
    object UpdateSpeed1: TMenuItem
      Caption = 'Update Speed'
      Visible = False
      object High1: TMenuItem
        Caption = 'High'
        OnClick = High1Click
      end
      object Normal1: TMenuItem
        Caption = 'Normal'
        Checked = True
        OnClick = Normal1Click
      end
      object Low1: TMenuItem
        Caption = 'Low'
        OnClick = Low1Click
      end
      object Paused1: TMenuItem
        Caption = 'Paused'
        OnClick = Paused1Click
      end
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object LoadModule1: TMenuItem
      Caption = 'Load Module'
      OnClick = LoadModule1Click
    end
    object UnloadModule1: TMenuItem
      Caption = 'Unload Module'
      OnClick = UnloadModule1Click
    end
  end
end
