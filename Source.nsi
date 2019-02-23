; The name of the installer
RequestExecutionLevel user
Name "lolutil"a!define AppName "LoLUtil"
!define AppVersion "1.0.3.0"
!define AppDev "Shen440"
!define MUI_ICON "lolutilicon.ico"
!define COMPANY "Shen440"
!define PRODUCT "lolutil"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "Header.bmp"

RequestExecutionLevel user
Name "${AppName}"
Unicode true

; General Symbol Definitions

BrandingText "by Shen440"

VIProductVersion "${AppVersion}"
VIAddVersionKey /LANG=${LANG_ENGLISH} ProductName "${AppName}"
VIAddVersionKey /LANG=${LANG_ENGLISH} ProductVersion "${AppName}"
VIAddVersionKey /LANG=${LANG_ENGLISH} FileVersion "${AppVersion}"
VIAddVersionKey /LANG=${LANG_ENGLISH} FileDescription "Программа для смены серверов и языков игры LoL"


; The file to write
OutFile "${AppName}${AppVersion}"
SetOverwrite on

; MUI Symbol Definitions
!include Sections.nsh
!include MUI2.nsh
!insertmacro MUI_LANGUAGE English

===================================

; handle variables
Var form_1
Var lblRegion
Var lblLng
Var btnSave
Var DropListRegion
Var DropListLng
Var Font1
Var Font2
Var Lng
Var Reg

; dialog create function
Function form_1_Create

  ; custom font definitions
  CreateFont $Font1 "Microsoft Sans Serif" "14.25" "700"
  CreateFont $Font2 "Courier New" "12" "400"

  ; === form_1 (type: Dialog) ===
  nsDialogs::Create 1018
  Pop $form_1
  ${If} $form_1 == error
    Abort
  ${EndIf}
  !insertmacro MUI_HEADER_TEXT "Dialog title..." "Dialog subtitle..."

  ; === lblRegion (type: Label) ===
  ${NSD_CreateLabel} 26.33u 5.54u 119.8u 20.31u "Region"
  Pop $lblRegion
  SendMessage $lblRegion ${WM_SETFONT} $Font1 0

  ; === lblLng (type: Label) ===
   ${NSD_CreateLabel} 26.33u 43.69u 119.8u 20.31u "Language"
  Pop $lblLng
  SendMessage $lblLng ${WM_SETFONT} $Font1 0

  ; === btnSave (type: Button) ===
  ${NSD_CreateButton} 41.47u 95.38u 85.57u 25.85u "Save"
  Pop $btnSave
  ${NSD_OnClick} $btnSave onClickSave

  ; === DropListRegion (type: DropList) ===
  ${NSD_CreateDropList} 7.9u 25.85u 162.58u 16u "Russia"

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
  ${NSD_OnChange}  $DropListRegion DropListRegion.onchange

  ; === DropListLng (type: DropList) ===
  ${NSD_CreateDropList} 7.9u 65.85u 162.58u 16u "Русский (Russia)"
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
  ${NSD_OnChange}  $DropListLng DropListLng.onchange

FunctionEnd

; dialog show function
Function form_1_Show
  Call form_1_Create
  nsDialogs::Show
FunctionEnd

Function onClickSave
Call RegionCheck
Call LngCheck
MessageBox MB_OK "$Reg $Lng"
Call Writeini
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
; =========================================================
; dialog script ends here
; =========================================================




Function Writeini
CreateDirectory "$EXEDIR\Config"
FileOpen $0 "$EXEDIR\Config\LeagueClientSettings.yaml" w
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


; show the dialog

  Page custom form_1_Show



Function DropListLng.onchange
        Pop $DropListLng
        SendMessage $DropListLng ${CB_GETCURSEL} 0 0 $Lng

FunctionEnd

Function DropListRegion.onchange
        Pop $DropListRegion
        SendMessage $DropListRegion ${CB_GETCURSEL} 0 0 $Reg

FunctionEnd


Section main
SectionEnd

Function .onInit
	InitPluginsDir
   ;Get the skin file to use
   File /oname=$PLUGINSDIR\Amakrits.vsf "Styles\Glossy.vsf"
   ;Load the skin using the LoadVCLStyleA function
   NSISVCLStyles::LoadVCLStyle $PLUGINSDIR\Amakrits.vsf


!if "" != ""
  ; we're testing the uninstaller, so the installer only writes it and exits
  WriteUninstaller "%UNINSTALLER_FILENAME%"
  Quit
!endif
FunctionEnd

Function un.onInit
	InitPluginsDir
FunctionEnd
Unicode true
; General Symbol Definitions
!define COMPANY         "Shen440"
!define PRODUCT         "lolutil"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "C:\Users\Shen\Downloads\l7IOTWrBhZY.bmp"
BrandingText "by Shen440"
!define MUI_ICON "lolutilicon.ico"
VIProductVersion "${PRODUCT_VERSION}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "Lolutil"
VIAddVersionKey /LANG=${LANG_ENGLISH} "Comments" ""
VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "${PRODUCT_PUBLISHER}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalTrademarks" ""
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "Copyright (c) . All rights reserved"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" ""
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "1.02"
VIAddVersionKey /LANG=${LANG_ENGLISH} "RePackBuild" " by Shen"

; installer properties
XPStyle on

; The file to write
OutFile "lolutil.exe"
SetOverwrite on

; MUI Symbol Definitions
!include Sections.nsh
!include MUI2.nsh
!insertmacro MUI_LANGUAGE English



; handle variables
Var form_1
Var lblRegion
Var lblLng
Var btnSave
Var DropListRegion
Var DropListLng
Var Font1
Var Font2
Var Lng
Var Reg

; dialog create function
Function form_1_Create

  ; custom font definitions
  CreateFont $Font1 "Microsoft Sans Serif" "14.25" "700"
  CreateFont $Font2 "Courier New" "12" "400"

  ; === form_1 (type: Dialog) ===
  nsDialogs::Create 1018
  Pop $form_1
  ${If} $form_1 == error
    Abort
  ${EndIf}
  !insertmacro MUI_HEADER_TEXT "" "Dialog subtitle..."

  ; === lblRegion (type: Label) ===
  ${NSD_CreateLabel} 26.33u 5.54u 119.8u 20.31u "Region"
  Pop $lblRegion
  SendMessage $lblRegion ${WM_SETFONT} $Font1 0

  ; === lblLng (type: Label) ===
   ${NSD_CreateLabel} 26.33u 43.69u 119.8u 20.31u "Language"
  Pop $lblLng
  SendMessage $lblLng ${WM_SETFONT} $Font1 0

  ; === btnSave (type: Button) ===
  ${NSD_CreateButton} 41.47u 95.38u 85.57u 25.85u "Save"
  Pop $btnSave
  ${NSD_OnClick} $btnSave onClickSave

  ; === DropListRegion (type: DropList) ===
  ${NSD_CreateDropList} 7.9u 25.85u 162.58u 16u "Russia"

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
  ${NSD_OnChange}  $DropListRegion DropListRegion.onchange

  ; === DropListLng (type: DropList) ===
  ${NSD_CreateDropList} 7.9u 65.85u 162.58u 16u "Русский (Russia)"
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
  ${NSD_OnChange}  $DropListLng DropListLng.onchange

FunctionEnd

; dialog show function
Function form_1_Show
  Call form_1_Create
  nsDialogs::Show
FunctionEnd

Function onClickSave
Call RegionCheck
Call LngCheck
MessageBox MB_OK "$Reg $Lng"
Call Writeini
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
; =========================================================
; dialog script ends here
; =========================================================




Function Writeini
CreateDirectory "$EXEDIR\Config"
FileOpen $0 "$EXEDIR\Config\LeagueClientSettings.yaml" w
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


; show the dialog

  Page custom form_1_Show



Function DropListLng.onchange
        Pop $DropListLng
        SendMessage $DropListLng ${CB_GETCURSEL} 0 0 $Lng

FunctionEnd

Function DropListRegion.onchange
        Pop $DropListRegion
        SendMessage $DropListRegion ${CB_GETCURSEL} 0 0 $Reg

FunctionEnd


Section main
SectionEnd

Function .onInit
	InitPluginsDir
   ;Get the skin file to use
   File /oname=$PLUGINSDIR\Amakrits.vsf "C:\InstallBuilder\NSIS\App\NSISVCLStyles\Styles\Glossy.vsf"
   ;Load the skin using the LoadVCLStyleA function
   NSISVCLStyles::LoadVCLStyle $PLUGINSDIR\Amakrits.vsf


!if "" != ""
  ; we're testing the uninstaller, so the installer only writes it and exits
  WriteUninstaller "%UNINSTALLER_FILENAME%"
  Quit
!endif
FunctionEnd

Function un.onInit
	InitPluginsDir
FunctionEnd
