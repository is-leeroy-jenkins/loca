#define MyAppName "Loca"
#ifndef MyAppVersion
  #define MyAppVersion "0.1.0"
#endif

[Setup]
AppId={{CA467224-64B7-4BAD-B9D3-D9252C67332B}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher=is-leeroy-jenkins
DefaultDirName={localappdata}\Programs\Loca
DefaultGroupName=Loca
OutputDir=..\dist-installer
OutputBaseFilename=Loca-Setup-{#MyAppVersion}
Compression=lzma2
SolidCompression=yes
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
PrivilegesRequired=lowest
WizardStyle=modern
UninstallDisplayName=Loca
UninstallDisplayIcon={app}\Loca.exe
CloseApplications=yes

[Files]
Source: "..\dist\Loca\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional shortcuts:"

[Icons]
Name: "{group}\Loca"; Filename: "{app}\Loca.exe"
Name: "{autodesktop}\Loca"; Filename: "{app}\Loca.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\Loca.exe"; Description: "Launch Loca"; Flags: nowait postinstall skipifsilent
