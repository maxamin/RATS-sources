object AudioCapture: TAudioCapture
  Left = 246
  Top = 126
  AutoScroll = False
  Caption = 'AudioCapture'
  ClientHeight = 442
  ClientWidth = 626
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 217
    Top = 0
    Width = 5
    Height = 425
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 425
    Width = 626
    Height = 17
    Panels = <>
    SimplePanel = True
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 217
    Height = 425
    Align = alLeft
    Caption = 'Settings'
    TabOrder = 1
    DesignSize = (
      217
      425)
    object ListView1: TListView
      Left = 8
      Top = 24
      Width = 201
      Height = 169
      Anchors = [akLeft, akTop, akRight]
      Columns = <
        item
          Caption = 'Sample Rate'
          Width = 100
        end
        item
          Caption = 'Channels'
          Width = 70
        end>
      HideSelection = False
      Items.Data = {
        5A0100000A00000000000000FFFFFFFFFFFFFFFF010000000000000005343830
        30300653746572656F00000000FFFFFFFFFFFFFFFF0100000000000000053438
        303030044D6F6E6F00000000FFFFFFFFFFFFFFFF010000000000000005343431
        30300653746572656F00000000FFFFFFFFFFFFFFFF0100000000000000053434
        313030044D6F6E6F00000000FFFFFFFFFFFFFFFF010000000000000005323231
        30300653746572656F00000000FFFFFFFFFFFFFFFF0100000000000000053232
        313030044D6F6E6F00000000FFFFFFFFFFFFFFFF010000000000000005313130
        35300653746572656F00000000FFFFFFFFFFFFFFFF0100000000000000053131
        303530044D6F6E6F00000000FFFFFFFFFFFFFFFF010000000000000004383030
        300653746572656F00000000FFFFFFFFFFFFFFFF010000000000000004383030
        30044D6F6E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ReadOnly = True
      RowSelect = True
      SmallImages = ImageList1
      TabOrder = 0
      ViewStyle = vsReport
      OnCustomDrawItem = ListView1CustomDrawItem
      OnCustomDrawSubItem = ListView1CustomDrawSubItem
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 208
      Width = 193
      Height = 17
      Caption = 'Automatically play received streams'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object CheckBox2: TCheckBox
      Left = 8
      Top = 232
      Width = 169
      Height = 17
      Caption = 'Save received streams'
      Checked = True
      State = cbChecked
      TabOrder = 2
      Visible = False
    end
    object BitBtn2: TBitBtn
      Left = 8
      Top = 264
      Width = 65
      Height = 25
      Caption = 'Start'
      TabOrder = 3
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 80
      Top = 264
      Width = 65
      Height = 25
      Caption = 'Stop'
      Enabled = False
      TabOrder = 4
      OnClick = BitBtn3Click
    end
  end
  object ListView2: TListView
    Left = 222
    Top = 0
    Width = 404
    Height = 425
    Align = alClient
    Columns = <
      item
        Caption = 'No'
      end
      item
        Caption = 'Size'
        Width = 80
      end
      item
        AutoSize = True
        Caption = 'Received'
      end>
    HideSelection = False
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    PopupMenu = PopupMenu1
    SmallImages = ImageList1
    TabOrder = 2
    ViewStyle = vsReport
    OnCustomDrawItem = ListView2CustomDrawItem
    OnCustomDrawSubItem = ListView2CustomDrawSubItem
    OnDeletion = ListView2Deletion
  end
  object ImageList1: TImageList
    Left = 528
    Top = 96
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000048B5
      620048B5620048B5620048B5620048B5620048B5620048B5620048B5620048B5
      620048B562000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000048B5620030DB
      950030DB950030DB950030DB950030DB950030DB950030DB950030DB950030DB
      950030DB950048B5620000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006464B8006464B800000000000000000000000000000000006464B8006464
      B800000000000000000000000000000000000000000048B5620011CE810011CE
      810011CE810011CE810011CE810011CE810011CE810011CE810011CE810011CE
      810011CE810011CE810048B56200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006464
      B8009898EE009898EE006464B80000000000000000006464B8009898EE009898
      EE006464B8000000000000000000000000000000000048B5620000C8760000C8
      760000C8760000C87600C4FFE40000C8760000C8760000C8760000C8760000C8
      760000C8760000C8760048B56200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000818181002A2A2A002A2A2A007E7E7E00000000000000
      0000000000000000000000000000000000000000000000000000000000006464
      B8006060E3006060E3009C9CF1006464B8006464B8009C9CF1006060E3006060
      E3006464B8000000000000000000000000000000000048B5620001C8760001C8
      760001C8760001C87600CCFFE800CCFFE80001C8760001C8760001C8760001C8
      760001C8760001C8760048B56200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000878787005F5F5F00828282007D7D7D00565656007E7E7E000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006464B8006666E8006666E800A1A1F300A1A1F3006666E8006666E8006464
      B800000000000000000000000000000000000000000048B5620003C9770003C9
      770003C9770003C97700D5FFEC00D5FFEC00D5FFEC0003C9770003C9770003C9
      770003C9770003C9770048B56200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003E3E3E008888880061616100555555007D7D7D002A2A2A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006464B8006D6DED006D6DED006D6DED006D6DED006464B8000000
      0000000000000000000000000000000000000000000048B5620007CA780007CA
      780007CA780007CA7800DFFFF000DFFFF000DFFFF000DFFFF00007CA780007CA
      780007CA780007CA780048B56200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000424242008A8A8A00666666005C5C5C00818181002C2C2C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006464B8007373F3007373F3007373F3007373F3006464B8000000
      0000000000000000000000000000000000000000000048B562000BCC7A000BCC
      7A000BCC7A000BCC7A00E9FFF500E9FFF500E9FFF500E9FFF5000BCC7A000BCC
      7A000BCC7A000BCC7A0048B56200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008E8E8E00696969008A8A8A008686860062626200838383000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006464B800B0B0FB007979F8007979F8007979F8007979F800B0B0FB006464
      B800000000000000000000000000000000000000000048B5620010CE7D0010CE
      7D0010CE7D0010CE7D00F2FFF900F2FFF900F2FFF90010CE7D0010CE7D0010CE
      7D0010CE7D0010CE7D0048B56200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008E8E8E00434343004141410089898900000000000000
      0000000000000000000000000000000000000000000000000000000000006464
      B800B3B3FD007E7EFC007E7EFC006464B8006464B8007E7EFC007E7EFC00B3B3
      FD006464B8000000000000000000000000000000000048B5620016D1800016D1
      800016D1800016D18000FAFFFD00FAFFFD0016D1800016D1800016D1800016D1
      800016D1800016D1800048B56200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006464
      B8008181FF008181FF006464B80000000000000000006464B8008181FF008181
      FF006464B8000000000000000000000000000000000048B562001DD383001DD3
      83001DD383001DD38300FFFFFF001DD383001DD383001DD383001DD383001DD3
      83001DD383001DD3830048B56200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006464B8006464B800000000000000000000000000000000006464B8006464
      B800000000000000000000000000000000000000000048B5620045DC980054DF
      A10024D6860024D6860024D6860024D6860024D6860024D6860024D6860024D6
      860054DFA10045DC980048B56200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000048B56200A6EF
      CE00A8EFCF00A8EFCF00A8EFCF00A8EFCF00A8EFCF00A8EFCF00A8EFCF00A8EF
      CF00A6EFCE0048B5620000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000048B5
      620048B5620048B5620048B5620048B5620048B5620048B5620048B5620048B5
      620048B562000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFFE0070000
      FFFFFFFFC0030000FFFFF3CF80010000FFFFE18780010000FC3FE00780010000
      F81FF00F80010000F81FF81F80010000F81FF81F80010000F81FF00F80010000
      FC3FE00780010000FFFFE18780010000FFFFF3CF80010000FFFFFFFFC0030000
      FFFFFFFFE0070000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object PopupMenu1: TPopupMenu
    Images = ImageList1
    Left = 352
    Top = 160
    object Clear1: TMenuItem
      Caption = 'Clear'
      ImageIndex = 1
      OnClick = Clear1Click
    end
    object DeleteSelected1: TMenuItem
      Caption = 'Delete Selected'
      ImageIndex = 1
      OnClick = DeleteSelected1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Play1: TMenuItem
      Caption = 'Play Selected'
      ImageIndex = 2
      OnClick = Play1Click
    end
  end
  object Timer1: TTimer
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 240
    Top = 240
  end
end
