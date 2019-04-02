Unicode true
!define MUI_UI "./modern.exe"
!include Sections.nsh
!include MUI2.nsh
!include x64.nsh
!include "Registry.nsh"
!insertmacro MUI_LANGUAGE English

!define AppName "LoLUtil"
!define AppVersion "1.0.3.0"
!define AppDev "Shen440"
!define COMPANY "Shen440"
!define PRODUCT "lolutil"


RequestExecutionLevel admin
Name "${AppName}"
ICON "images\Icon.ico"
OutFile "${AppName}${AppVersion}.exe"
SetOverwrite on



BrandingText "by Shen440"
VIProductVersion "${AppVersion}"
VIAddVersionKey /LANG=${LANG_ENGLISH} ProductName "${AppName}"
VIAddVersionKey /LANG=${LANG_ENGLISH} ProductVersion "${AppName}"
VIAddVersionKey /LANG=${LANG_ENGLISH} FileVersion "${AppVersion}"
VIAddVersionKey /LANG=${LANG_ENGLISH} FileDescription "Программа для смены серверов и языков игры LoL"



; handle variables
Var form_1
Var lblRegion
Var lblLng

Var DropListRegion
Var DropListLng
Var Font1
Var Font2
Var Lng
Var Reg
;Var Bitmap
Var BitmapRegion
Var BitmapLocate
Var BitmapHeader
Var BitmapRegionImage
Var BitmapLocateImage
Var BitmapHeaderImage
;var groupboxes
Var GroupBoxHeader
Var GroupBoxSwichter
Var GroupBoxDIR
Var GroupBoxStatus
;var directory
Var DirRequestTxt
Var DirRequestBtn
;VarLabals
Var lblDir
Var lblStatus
Var lblStatusChanged
;Var buttons
Var btnLngApp
Var btnKill
Var btnSave

;Var temp
Var Status
Var TextBoxStatus
Var TextBoxStatusT
Var Disabled1
; dialog create function
Function form_1_Create

  ; custom font definitions
  CreateFont $Font1 "Courier New" "12" "700"
  CreateFont $Font2 "Courier New" "9.75" "400"

  ; === form_1 (type: Dialog) ===
  nsDialogs::Create 1018
  Pop $form_1
  ${If} $form_1 == error
    Abort
  ${EndIf}
  !insertmacro MUI_HEADER_TEXT "Dialog title..." "Dialog subtitle..."

;Bitmap begin
  ; === Bitmap Header  ===
 ${NSD_CreateBitmap} 11.85u 7.38u 170.48u 33.23u ""
  Pop $BitmapHeader
  File "/oname=$PLUGINSDIR\header.bmp" "images\header.bmp"
  ${NSD_SetImage} $BitmapHeader "$PLUGINSDIR\header.bmp" $BitmapHeaderImage

  ; === Bitmap locate ===259, 54
  ${NSD_CreateBitmap} 17.77u 148.31u 17.11u 16u ""
  Pop $BitmapLocate
  File "/oname=$PLUGINSDIR\locate.bmp" "C:\Users\Shen\Pictures\locate.bmp"
  ${NSD_SetImage} $BitmapLocate "$PLUGINSDIR\locate.bmp" $BitmapLocateImage

  ${NSD_CreateBitmap} 18.43u 114.46u 16.46u 13.54u ""
  Pop $BitmapRegion
  File "/oname=$PLUGINSDIR\google_map_satellite.bmp" "C:\Users\Shen\Pictures\google_map_satellite.bmp"
  ${NSD_SetImage} $BitmapRegion "$PLUGINSDIR\google_map_satellite.bmp" $BitmapRegionImage

;Bitmap End

;Group labels
  ; === lblDir ===
  ${NSD_CreateLabel} 17.77u 72.62u 65.82u 20.31u "League of Legends Directory"
  Pop $lblDir

  ; === lblStatus  ===
  ${NSD_CreateLabel} 100.71u 78.77u 65.82u 14.15u "Not Found"
  Pop $lblStatus
  SetCtlColors $lblStatus 0xFF0000 0xF0F0F0
  ; === Label1 (type: Label) ===

;Group labelsEnd

;== GroupBox begin

  ; === GroupBoxHeader (type: GroupBox) ===
  ${NSD_CreateGroupBox} 7.9u 1.23u 178.38u 43.08u ""
  Pop $GroupBoxHeader

 ; === GroupBoxSwichter
  ${NSD_CreateGroupBox} 7.9u 108.31u 178.38u 99.69u ""
  Pop $GroupBoxSwichter
  ;${NSD_OnChange} $GroupBoxSwichter checkLoL

  ; === GroupBoxDIR (type: GroupBox) ===
  ${NSD_CreateGroupBox} 7.9u 67.69u 178.38u 43.08u ""
  Pop $GroupBoxDIR

; === GroupBoxStatus ===
  ${NSD_CreateGroupBox} 7.9u 44.31u 178.38u 24.62u ""
  Pop $GroupBoxStatus

;== GroupBoxEnd


;===Directory
  ; === DirRequest1_Txt (type: Text) ===
  ${NSD_CreateText} 18.43u 94.77u 135.59u 12.31u "$DirRequestTxt"
  Pop $DirRequestTxt

  ; === DirRequest1_Btn (type: Button) ===
  ${NSD_CreateButton} 155.34u 94.77u 19.75u 12.31u "..."
  Pop $DirRequestBtn
  ${NSD_OnClick} $DirRequestBtn DirRequestClick

;===DirectoryEnd

  ; === TextBox1 (type: Text) ===
  ${NSD_CreateLabel} 63.19u 52.92u 65.82u 12.31u "$Status"
  Pop $TextBoxStatus
    SendMessage $TextBoxStatus ${WM_SETFONT}  $Font2 0



  ; === btnLngApp (type: Button) ===
  ${NSD_CreateButton} 17.77u 12.92u 27.65u 14.15u "ENG"
  Pop $btnLngApp
  EnableWindow $btnLngApp 0
  ; === btnKill (type: Button) ===
  ${NSD_CreateButton} 121.11u 187.69u 45.42u 17.23u "Kill LOL"
  Pop $btnKill
  ${NSD_OnClick} $btnKill onClickKILL


  ; === lblRegion (type: Label) ===
  ${NSD_CreateLabel} 38.84u 114.46u 56.61u 13.54u "Region"
  Pop $lblRegion
  SendMessage $lblRegion ${WM_SETFONT} $Font1 0

  ; === lblLng (type: Label) ===
  ${NSD_CreateLabel} 38.84u 148.31u 67.14u 16u "Language"
  Pop $lblLng
  SendMessage $lblLng ${WM_SETFONT} $Font1 0

  ; === btnSave (type: Button) ===
${NSD_CreateButton} 18.43u 187.69u 45.42u 17.23u "Save"
  Pop $btnSave
  ${NSD_OnClick} $btnSave onClickSave
   EnableWindow $btnSave 1

  ; === DropListRegion (type: DropList) ===
  ${NSD_CreateDropList} 18.43u 131.69u 156.66u 14.77u "Russia"

  Pop $DropListRegion
  SendMessage $DropListRegion ${WM_SETFONT} $Font2 0
  ${NSD_CB_AddString} $DropListRegion "Brazil"
  ${NSD_CB_AddString} $DropListRegion "EU Nordic and East"
  ${NSD_CB_AddString} $DropListRegion "EU West"
  ${NSD_CB_AddString} $DropListRegion "Japan"
  ${NSD_CB_AddString} $DropListRegion "Latin America North"
  ${NSD_CB_AddString} $DropListRegion "Latin America South"
  ${NSD_CB_AddString} $DropListRegion "North America"
  ${NSD_CB_AddString} $DropListRegion "Oceania"
  ${NSD_CB_AddString} $DropListRegion "Russia"
  ${NSD_CB_AddString} $DropListRegion "Turkey"
  ${NSD_CB_SelectString} $DropListRegion "Russia"
  ${NSD_OnChange} $DropListRegion DropListRegion.onchange

  ; === DropListLng (type: DropList) ===
${NSD_CreateDropList} 18.43u 168u 156.66u 14.77u "Русский (Russia)"
  Pop $DropListLng
  SendMessage $DropListLng ${WM_SETFONT} $Font2 0
  ${NSD_CB_AddString} $DropListLng "Czech (Czechia)"
  ${NSD_CB_AddString} $DropListLng "German (Germany)"
  ${NSD_CB_AddString} $DropListLng "Greek (Greece)"
  ${NSD_CB_AddString} $DropListLng "English (Australia)"
  ${NSD_CB_AddString} $DropListLng "Русский (Russia)"
  ${NSD_CB_AddString} $DropListLng "English (United States)"
  ${NSD_CB_AddString} $DropListLng "English (United Kingdom)"
  ${NSD_CB_AddString} $DropListLng "Italian (Italy)"
  ${NSD_CB_AddString} $DropListLng "Spanish (Argentina)"
  ${NSD_CB_AddString} $DropListLng "Spanish (Spanish)"
  ${NSD_CB_AddString} $DropListLng "Spanish (Mexico)"
  ${NSD_CB_AddString} $DropListLng "French (Franch)"
  ${NSD_CB_AddString} $DropListLng "Hungarian (Hungary)"
  ${NSD_CB_AddString} $DropListLng "Japanese (Japan)"
  ${NSD_CB_AddString} $DropListLng "Korean (South Korea)"
  ${NSD_CB_AddString} $DropListLng "Polish (Poland)"
  ${NSD_CB_AddString} $DropListLng "Portuguese (Brazil)"
  ${NSD_CB_AddString} $DropListLng "Romanian (Romania)"
  ${NSD_CB_AddString} $DropListLng "Turkish (Turkey)"
  ${NSD_CB_SelectString} $DropListLng "Русский (Russia)"
  ${NSD_OnChange} $DropListLng DropListLng.onchange

FunctionEnd

; dialog show function
Function form_1_Show
  Call form_1_Create
  nsDialogs::Show
FunctionEnd


; =========================================================
; dialog script ends
; =========================================================


Function onClickSave

Call lblStatusChanged
Call RegionCheck
Call LngCheck
Call Writeini

FunctionEnd



Function DirRequestClick

  Pop $R0
  ${If} $R0 == $DirRequestBtn
    ${NSD_GetText} $DirRequestTxt $R0


    nsDialogs::SelectFolderDialog /NOUNLOAD "" "$R0"
    Pop $R0
    ${If} "$R0" != "error"
      ${NSD_SetText} $DirRequestTxt "$R0"
    ${EndIf}
  ${EndIf}
  SendMessage $Disabled1 ${WM_SETTEXT} 0 "1"
    IfFileExists "$R0\LeagueClient.exe" +3
    MessageBox MB_OK "Wrong Dir"
    abort

FunctionEnd





Function onClickKILL
FunctionEnd

Function lblStatusChanged
  SendMessage $TextBoxStatus ${WM_SETTEXT} 0 "STR: SAVED"
FunctionEnd

Function LngCheck
${If} $Lng == 0
StrCpy $Lng "cs_CZ"
${Else}
    ${If} $Lng == 1
  StrCpy $Lng "de_DE"
 ${Else}
      ${If} $Lng == 2
  StrCpy $Lng "el_GR"
 ${Else}
      ${If} $Lng == 3
  StrCpy $Lng "en_AUE"
   ${Else}
      ${If} $Lng == 4
  StrCpy $Lng "ru_RU"
   ${Else}
      ${If} $Lng == 5
  StrCpy $Lng "en_US"
   ${Else}
      ${If} $Lng == 6
  StrCpy $Lng "en_GB"
   ${Else}
      ${If} $Lng == 7
  StrCpy $Lng "it_IT"
   ${Else}
      ${If} $Lng == 8
  StrCpy $Lng "es_AR"
   ${Else}
      ${If} $Lng == 9
  StrCpy $Lng "es_ES"
   ${Else}
      ${If} $Lng == 10
  StrCpy $Lng "es_MX"
   ${Else}
      ${If} $Lng == 11
  StrCpy $Lng "fr_FR"
   ${Else}
      ${If} $Lng == 12
  StrCpy $Lng "hu_HU"
   ${Else}
      ${If} $Lng == 13
  StrCpy $Lng "ja_JP"
   ${Else}
      ${If} $Lng == 14
  StrCpy $Lng "ko_KR"
   ${Else}
      ${If} $Lng == 15
  StrCpy $Lng "pl_PL"
   ${Else}
      ${If} $Lng == 16
  StrCpy $Lng "pt_BR"
   ${Else}
      ${If} $Lng == 17
  StrCpy $Lng "ro_RO"
   ${Else}
      ${If} $Lng == 18
  StrCpy $Lng "tr_TR"
 ${EndIf}
  ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}

FunctionEnd



Function RegionCheck
 ${If} $Reg == 0
StrCpy $Reg "BR"
    ${Else}
${If} $Reg == 1
  StrCpy $Reg "EUNE"
 ${Else}
      ${If} $Reg == 2
  StrCpy $Reg "EUW"
 ${Else}
      ${If} $Reg == 3
  StrCpy $Reg "JP"
   ${Else}
      ${If} $Reg == 4
  StrCpy $Reg "LA1"
   ${Else}
      ${If} $Reg == 5
  StrCpy $Reg "LA2"
   ${Else}
      ${If} $Reg == 6
  StrCpy $Reg "NA"
   ${Else}
      ${If} $Reg == 7
  StrCpy $Reg "OC1"
   ${Else}
      ${If} $Reg == 8
  StrCpy $Reg "RU"
   ${Else}
      ${If} $Reg == 9
  StrCpy $Reg "es_ES"
   ${Else}
      ${If} $Reg == 10
  StrCpy $Reg "TR"

 ${EndIf}
  ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
 ${EndIf}
FunctionEnd

Function DropListLng.onchange
  Pop $DropListLng
   SendMessage $DropListLng ${CB_GETCURSEL} 0 0 $Lng
FunctionEnd

Function DropListRegion.onchange
  Pop $DropListRegion
    SendMessage $DropListRegion ${CB_GETCURSEL} 0 0 $Reg
FunctionEnd



Function Writeini
${if} ${RunningX64}
SetRegView 64
WriteRegStr HKLM "Software\WOW6432Node\Riot Games, Inc\League of Legends" "Location" "$R0"
${Else}
SetRegView 32
WriteRegStr HKLM "Software\Riot Games, Inc\League of Legends" "Location"  "$R0"
${Endif}

CreateDirectory "$R0\Config"
FileOpen $0 "$R0\Config\LeagueClientSettings.yaml" w
FileWrite $0 "install:$\r$\n"
FileWrite $0 "    globals:$\r$\n"
FileWrite $0 '        locale: "$Lng"$\r$\n'
FileWrite $0 '        region: "$Reg"$\r$\n'
FileWrite $0 "    last-valid-login-splash:$\r$\n"
FileWrite $0 '        theme: "seasonstart2019-c"$\r$\n'
FileWrite $0 '        version: "1.46"$\r$\n'
FileWrite $0 "    licensesAgreedTo:$\r$\n"
FileWrite $0 "        4F039B7708ED4333FA6715B86A2FE534: null$\r$\n"
FileWrite $0 "        669805AFB549049B0BC076CAE84983F7: null$\r$\n"
FileWrite $0 "        C316223E0402D00F535E0E41CAD27ECE: null$\r$\n"
FileWrite $0 "    npe-splash:$\r$\n"
FileWrite $0 "        enableNewPlayerSplash: true$\r$\n"
FileWrite $0 "    patcher:$\r$\n"
FileClose $0


FunctionEnd



  Page custom form_1_Show






Section main

SectionEnd

Function .onInit
InitPluginsDir
StrCpy $Reg "RU"
StrCpy $Lng "ru_RU"
   ;Get the skin file to use
   File /oname=$PLUGINSDIR\Amakrits.vsf "Styles\OnyxBlue.vsf"
   ;Load the skin using the LoadVCLStyleA function
   NSISVCLStyles::LoadVCLStyle $PLUGINSDIR\Amakrits.vsf

Call FindDirReg
!if "" != ""
  ; we're testing the uninstaller, so the installer only writes it and exits
  WriteUninstaller "%UNINSTALLER_FILENAME%"
  Quit
!endif

FunctionEnd



Function un.onInit
	InitPluginsDir
FunctionEnd

Function FindDirReg
${if} ${RunningX64}
SetRegView 64
ReadRegStr $R0 HKLM "Software\WOW6432Node\Riot Games, Inc\League of Legends" "Location"
${Else}
SetRegView 32
ReadRegStr $R0 HKLM "Software\Riot Games, Inc\League of Legends" "Location"
${Endif}
StrCpy $DirRequestTxt $R0
FunctionEnd
