!include MUI2.nsh
!include LogicLib.nsh
!include x64.nsh

Outfile "emacs-darkmode-${OUT_VERSION}-installer.exe"


SetCompressor /solid lzma

Var StartMenuFolder


!define MUI_WELCOMEPAGE_TITLE "Emacs"
!define MUI_WELCOMEPAGE_TITLE_3LINES
!define MUI_WELCOMEPAGE_TEXT "Vince's Emacs for Windows, with dark mode! (version ${OUT_VERSION})"

!define MUI_WELCOMEFINISHPAGE_BITMAP "${OUT_VERSION}\share\emacs\${EMACS_VERSION}\etc\images\splash.bmp"
!define MUI_ICON "${OUT_VERSION}\share\emacs\${EMACS_VERSION}\etc\images\icons\hicolor\scalable\apps\emacs.ico"
!define MUI_UNICON "${OUT_VERSION}\share\emacs\${EMACS_VERSION}\etc\images\icons\hicolor\scalable\apps\emacs.ico"

!insertmacro MUI_PAGE_WELCOME


!define MUI_LICENSEPAGE_TEXT_TOP "The GNU General Public License"
!insertmacro MUI_PAGE_LICENSE "${OUT_VERSION}\share\emacs\${EMACS_VERSION}\lisp\COPYING"

!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"
Name Emacs-${OUT_VERSION}

function .onInit
    StrCpy $INSTDIR "$PROGRAMFILES64\Emacs"
functionend


Section

  SetOutPath $INSTDIR

  File /r ${OUT_VERSION}

  # define uninstaller name
  WriteUninstaller $INSTDIR\Uninstall.exe

  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  ;Create shortcuts
  CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
  CreateShortcut "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk" "$INSTDIR\Uninstall.exe"

  !insertmacro MUI_STARTMENU_WRITE_END
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Emacs.lnk" "$INSTDIR\${OUT_VERSION}\bin\runemacs.exe"
SectionEnd


# create a section to define what the uninstaller does.
# the section will always be named "Uninstall"
Section "Uninstall"

  # Always delete uninstaller first
  Delete "$INSTDIR\Uninstall.exe"

  # now delete installed directory
  RMDir /r "$INSTDIR"
  RMDir "$INSTDIR"

  !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuFolder

  Delete "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk"
  RMDir "$SMPROGRAMS\$StartMenuFolder"
SectionEnd
