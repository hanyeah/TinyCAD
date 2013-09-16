; Script generated by the HM NIS Edit Script Wizard.
; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "TinyCAD"
!define PRODUCT_VERSION "2.80.06"
!define PRODUCT_PUBLISHER "TinyCAD"
!define PRODUCT_WEB_SITE "http://tinycad.sourceforge.net"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\TinyCad.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI.nsh"

; For the DLL installer
!include "UpgradeDll.nsh"

; MUI (Modern User Interface) Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME

; License page
!insertmacro MUI_PAGE_LICENSE "licence.rtf"

; Directory page
!insertmacro MUI_PAGE_DIRECTORY

; Instfiles page
!insertmacro MUI_PAGE_INSTFILES

; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\TinyCad.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"
; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "Setup.exe"
InstallDir "$PROGRAMFILES32\TinyCAD"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""

Var DATA_DIR	;this will be used later to point to the user application data path where the libraries and example files are installed
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  SetShellVarContext current	;Note:  The typical user doesn't have write permission to the "All Users" area, so install TinyCAD on a per user basis
;  SetShellVarContext all

 StrCpy $DATA_DIR "$DOCUMENTS\TinyCAD"
  CreateDirectory "$INSTDIR"

; Download MDAC (if necessary)
  IfFileExists $SYSDIR\msjet40.dll skip_mdac_download
  MessageBox MB_OKCANCEL "TinyCAD did not find the Microsoft MDAC components including msjet40.dll, these will be downloaded and installed now from url$\nhttp://tinycad.sourceforge.net/installer/MDAC_TYP.EXE$\n$\nYou must be connected to the internet for this to work properly!$\n$\nNote that this is not recommended for Windows Vista/7/8 and newer systems.  In this case, hit Cancel.$\n$\n" IDCANCEL skip_mdac_download
  NSISdl::download /TIMEOUT=30000 http://tinycad.sourceforge.net/installer/MDAC_TYP.EXE $INSTDIR/mdac_typ.exe
  Pop $R0 ;Get the return value
  StrCmp $R0 "success" +3
    MessageBox MB_OK "Download failed: $R0.  Please try to install again or download and run MDAC_TYPE.exe from Microsoft directly."
    Quit
  ExecWait '"$INSTDIR/MDAC_TYP.EXE" /Q'

skip_mdac_download:
  MessageBox MB_OK "Libraries will be installed to$\n$DATA_DIR\libs$\n$\nExample files will be installed to $\n$DATA_DIR\examples"
  CreateDirectory "$DATA_DIR"
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File "..\src\Release\TinyCad.exe"
  CreateDirectory "$SMPROGRAMS\TinyCAD"
  CreateShortCut "$SMPROGRAMS\TinyCAD\TinyCAD.lnk" "$INSTDIR\TinyCad.exe"
  CreateShortCut "$DESKTOP\TinyCAD.lnk" "$INSTDIR\TinyCad.exe"
  ; 
  ;	Note:  These relative paths only work correctly if you are compiling the install script from the installer sub-directory!
  ; 
  File "..\src\png\libpng13.dll"
  File "..\src\png\zlib1.dll"
  File "..\src\libiconv\iconv.dll"
  File "..\src\SQLite\sqlite3.dll"
  File "..\src\msvc\redist\x86\msvcr71.dll"
  File "..\src\msvc\redist\x86\msvcr80.dll"
  File "..\src\msvc\redist\x86\msvcr90.dll"
  File "..\docs\TinyCAD.chm"
  File "..\docs\PDF Outputs\TinyCAD_Manual.pdf"
  File "..\installer\LGPL Version 2.1.txt"
  File "..\installer\LGPL Version 3.0.txt"

  CreateShortCut "$SMPROGRAMS\TinyCAD\Help.lnk" "$INSTDIR\TinyCAD.chm"

  SetOutPath "$DATA_DIR\library"
  File "..\libs\74TTL.TCLib"
  File "..\libs\AC connectors.TCLib"
  File "..\libs\Analog.TCLib"
  File "..\libs\Connectors.TCLib"
  File "..\libs\DISCRETE.TCLib"
  File "..\libs\IC-CMOS4000.TCLib"
  File "..\libs\IC-OPAMP.TCLib"
  File "..\libs\IC-VREG.TCLib"
  File "..\libs\Microcontroller.TCLib"
  File "..\libs\passive2.TCLib"
  File "..\libs\passive.TCLib"
  File "..\libs\semi.TCLib"
  File "..\libs\switches.TCLib"
  File "..\libs\valve.TCLib"
  File "..\libs\gen_semiconductor.TCLib"
  File "..\libs\gen_passive.TCLib"
  File "..\libs\gen_Mechanical.TCLib"
  File "..\libs\gen_Logic.TCLib"
  File "..\libs\Mechanical.TCLib"
  File "..\libs\gen_Electromechanical_switches.TCLib"
  File "..\libs\gen_Electromechanical_Relays.TCLib"
  File "..\libs\gen_Electromechanical.TCLib"
  File "..\libs\pm_Connectors.TCLib"
  File "..\libs\pm_Electromechanical.TCLib"
  File "..\libs\pm_Indicators.TCLib"
  File "..\libs\Power.TCLib"
  File "..\libs\cm_Connectors.TCLib"
  File "..\libs\sm_IC_Transceivers.TCLib"
  File "..\libs\Assemblies.TCLib"
  File "..\libs\symbols.TCLib"
  File "..\libs\th_Comparators.TCLib"
  File "..\libs\th_Connectors.TCLib"
  File "..\libs\th_Electromechanical.TCLib"
  File "..\libs\th_Headers.TCLib"
  File "..\libs\th_OpAmps.TCLib"
  File "..\libs\th_Passive.TCLib"
  File "..\libs\th_Semiconductors.TCLib"
  File "..\libs\th_Transceivers.TCLib"
  File "..\libs\th_uC.TCLib"
  File "..\libs\th_Vreg.TCLib"
  File "..\libs\gen_Power.TCLib"
  File "..\libs\Relay_v1.TCLib"

  SetOutPath "$DATA_DIR\examples"
  File "..\examples\AMP.DSN"
  File "..\examples\AtTiny LED Flasher.dsn"
  File "..\examples\CurrSens.dsn"
  File "..\examples\nanocomp6802.dsn"
  File "..\examples\WaterSensor.dsn"

; Install the MSVC components
;  !insertmacro UpgradeDLL "c:\Windows\System32\msvcrt40.dll" "$SYSDIR\msvcrt40.dll" "$SYSDIR"
;  !insertmacro UpgradeDLL "c:\Windows\System32\msvcirt.dll" "$SYSDIR\msvcirt.dll" "$SYSDIR"

; Install the DAO components
  ReadRegStr $R0 HKLM "Software\Microsoft\Windows\CurrentVersion" "CommonFilesDir"
  Strcmp $R0 "" create_dao36_common copy_dao36_common
create_dao36_common:
; If the common files setting didn't exist, create the directory
; Set the value and write it
	StrCpy $R0 "$PROGRAMFILES\Common Files"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion" "CommonFilesDir" $R0
copy_dao36_common:
  ; Create the entire directory path to the shared DAO directory
  CreateDirectory "$R0"
  CreateDirectory "$R0\Microsoft Shared"
  CreateDirectory "$R0\Microsoft Shared\DAO"
  StrCpy $R9 "$R0\Microsoft Shared\DAO"

  SetOutPath $R9
  File "dao\DAO2535.TLB"
  !insertmacro UpgradeDLL "dao\dao360.dll" "$R9\dao360.dll" "$R9"
  !insertmacro UpgradeDLL "dao\dao350.dll" "$R9\dao350.dll" "$R9"
SectionEnd

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\TinyCAD\TinyCAD Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\TinyCAD\TinyCAD Manual.lnk" "$INSTDIR\TinyCAD_Manual.pdf"
  CreateShortCut "$SMPROGRAMS\TinyCAD\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\TinyCad.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\TinyCad.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  SetShellVarContext current	;Note:  The usual user doesn't have write permission to the "All Users" area, so install TinyCAD on a per user basis
;  StrCpy $0 $APPDATA
;  SetShellVarContext all
;  StrCpy $1 $APPDATA
;  MessageBox MB_OK $0$\n$1

;  StrCpy $DATA_DIR "$APPDATA\TinyCAD"
  StrCpy $DATA_DIR "$DOCUMENTS\TinyCAD"

  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"

  Delete "$DATA_DIR\examples\VREG.DSN"
  Delete "$DATA_DIR\examples\VCA.DSN"
  Delete "$DATA_DIR\examples\nanocomp6802.dsn"
  Delete "$DATA_DIR\examples\KEYSW.DSN"
  Delete "$DATA_DIR\examples\INVERTER.DSN"
  Delete "$DATA_DIR\examples\face.dsn"
  Delete "$DATA_DIR\examples\AtTiny LED Flasher.dsn"
  Delete "$DATA_DIR\examples\AMP.DSN"
  Delete "$DATA_DIR\examples\CurSens.dsn"
  Delete "$DATA_DIR\examples\WaterSensor.dsn"

  Delete "$DATA_DIR\library\valve.mdb"
  Delete "$DATA_DIR\library\switches.mdb"
  Delete "$DATA_DIR\library\semi.mdb"
  Delete "$DATA_DIR\library\passive.mdb"
  Delete "$DATA_DIR\library\passive2.mdb"
  Delete "$DATA_DIR\library\Microcontroller.mdb"
  Delete "$DATA_DIR\library\IC-VREG.mdb"
  Delete "$DATA_DIR\library\IC-OPAMP.mdb"
  Delete "$DATA_DIR\library\IC-CMOS4000.mdb"
  Delete "$DATA_DIR\library\DISCRETE.mdb"
  Delete "$DATA_DIR\library\Connectors.mdb"
  Delete "$DATA_DIR\library\Analog.mdb"
  Delete "$DATA_DIR\library\AC connectors.mdb"
  Delete "$DATA_DIR\library\74TTL.mdb"
  Delete "$DATA_DIR\library\74TTL.TCLib"
  Delete "$DATA_DIR\library\AC connectors.TCLib"
  Delete "$DATA_DIR\library\Analog.TCLib"
  Delete "$DATA_DIR\library\Assemblies.TCLib"
  Delete "$DATA_DIR\library\cm_Connectors.TCLib"
  Delete "$DATA_DIR\library\Connectors.TCLib"
  Delete "$DATA_DIR\library\DISCRETE.TCLib"
  Delete "$DATA_DIR\library\gen_Electromechanical.TCLib"
  Delete "$DATA_DIR\library\gen_Electromechanical_Relays.TCLib"
  Delete "$DATA_DIR\library\gen_Electromechanical_switches.TCLib"
  Delete "$DATA_DIR\library\gen_Logic.TCLib"
  Delete "$DATA_DIR\library\gen_Mechanical.TCLib"
  Delete "$DATA_DIR\library\gen_passive.TCLib"
  Delete "$DATA_DIR\library\gen_Power.TCLib"
  Delete "$DATA_DIR\library\gen_semiconductor.TCLib"
  Delete "$DATA_DIR\library\IC-CMOS4000.TCLib"
  Delete "$DATA_DIR\library\IC-OPAMP.TCLib"
  Delete "$DATA_DIR\library\IC-VREG.TCLib"
  Delete "$DATA_DIR\library\Mechanical.TCLib"
  Delete "$DATA_DIR\library\Microcontroller.TCLib"
  Delete "$DATA_DIR\library\passive.TCLib"
  Delete "$DATA_DIR\library\passive2.TCLib"
  Delete "$DATA_DIR\library\pm_Connectors.TCLib"
  Delete "$DATA_DIR\library\pm_Electromechanical.TCLib"
  Delete "$DATA_DIR\library\pm_Indicators.TCLib"
  Delete "$DATA_DIR\library\Power.TCLib"
  Delete "$DATA_DIR\library\semi.TCLib"
  Delete "$DATA_DIR\library\sm_IC_Transceivers.TCLib"
  Delete "$DATA_DIR\library\switches.TCLib"
  Delete "$DATA_DIR\library\symbols.TCLib"
  Delete "$DATA_DIR\library\th_Comparators.TCLib"
  Delete "$DATA_DIR\library\th_Connectors.TCLib"
  Delete "$DATA_DIR\library\th_Electromechanical.TCLib"
  Delete "$DATA_DIR\library\th_Headers.TCLib"
  Delete "$DATA_DIR\library\th_OpAmps.TCLib"
  Delete "$DATA_DIR\library\th_Passive.TCLib"
  Delete "$DATA_DIR\library\th_Semiconductors.TCLib"
  Delete "$DATA_DIR\library\th_Transceivers.TCLib"
  Delete "$DATA_DIR\library\th_uC.TCLib"
  Delete "$DATA_DIR\library\th_Vreg.TCLib"
  Delete "$DATA_DIR\library\valve.TCLib"
  Delete "$DATA_DIR\library\Relay_v1.TCLib"
  Delete "$INSTDIR\TinyCAD.chm"

  Delete "$INSTDIR\zlib1.dll"
  Delete "$INSTDIR\libpng13.dll"
  Delete "$INSTDIR\iconv.dll"
  Delete "$INSTDIR\sqlite3.dll"
  Delete "$INSTDIR\msvcr71.dll"
  Delete "$INSTDIR\msvcr80.dll"
  Delete "$INSTDIR\msvcr90.dll"
  
  Delete "$INSTDIR\TinyCAD_Manual.pdf"
  Delete "$INSTDIR\TinyCad.exe"

  Delete "$SMPROGRAMS\TinyCAD\Uninstall.lnk"
  Delete "$SMPROGRAMS\TinyCAD\TinyCAD Website.lnk"
  Delete "$SMPROGRAMS\TinyCAD\Help.lnk"
  Delete "$DESKTOP\TinyCAD.lnk"
  Delete "$SMPROGRAMS\TinyCAD\TinyCAD.lnk"
  Delete "$INSTDIR\LGPL Version 2.1.txt"
  Delete "$INSTDIR\LGPL Version 3.0.txt"

  RMDir "$SMPROGRAMS\TinyCAD"
  RMDir "$DATA_DIR\library"
  RMDir "$DATA_DIR\examples"
  RMDir "$DATA_DIR"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd
