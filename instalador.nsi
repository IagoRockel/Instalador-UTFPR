!include LogicLib.nsh
!include x64.nsh

; Nome do instalador
Name "Pacote de Softwares UTFPR - Reitoria"

; Nome do arquivo 
OutFile "utfpr_install.exe"

; Build Unicode installer
Unicode True

; Pasta para extrair os instaladores de terceiros (AppData\Local\Temp\UTFPR)
InstallDir $TEMP\UTFPR

; Tornar em um instalador silecioso
SilentInstall silent

; Função chamada na inicialização do instalador
Function .onInit
	
	; Configura onde extrair os arquivos
	SetOutPath $INSTDIR

	; Verifica a arquitetura do sistema e extrai os arquivos correspondentes
	${If} ${RunningX64}
		File ".\x64\*"
	${Else}
		File ".\x86\*"
	${EndIF}

	; Extrai os arquivos que não possuem versão x64
	File ".\common\*"

FunctionEnd

Section "Install MSIs" SEC01

	ExecWait '"msiexec" /i "$INSTDIR\7zip.msi"  /qn'
	ExecWait '"msiexec" /i "$INSTDIR\chrome.msi"  /qn'
	ExecWait '"msiexec" /i "$INSTDIR\firefox.msi"  /qn'
	ExecWait '"msiexec" /i "$INSTDIR\libre_office.msi"  /qn'
	; ownCloud reinicia a máquina por padrão, portanto é necessário impedi-lo
	ExecWait '"msiexec" /i "$INSTDIR\owncloud.msi"  REBOOT=ReallySuppress  /qn'
	; TightVNC tem a possibilidade de solicitar um reboot, logo também é suprimido
	ExecWait '"msiexec" /i "$INSTDIR\tight_vnc.msi"  REBOOT=ReallySuppress  /qn'
  
SectionEnd

Section "Install EXEs" SEC02
	
	ExecWait "$INSTDIR\acrobat.exe /s"
	ExecWait "$INSTDIR\cpu_z.exe /s"
	ExecWait "$INSTDIR\defraggler.exe /s"
	ExecWait "$INSTDIR\gimp.exe /s"
	ExecWait "$INSTDIR\heavy_load.exe /s"
	ExecWait "$INSTDIR\notepad_pp.exe /s"
	ExecWait "$INSTDIR\windir.exe /s"
	ExecWait "$INSTDIR\winrar.exe /s"
SectionEnd
