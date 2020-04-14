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

; Tornar em um instalador silencioso
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
	; Também deve ser configurado uma senha, que é feito com as intruções seguintes
	; Alterar somente o valor de VALUE_OF_PASSWORD
	ExecWait '"msiexec" /i "$INSTDIR\tight_vnc.msi"  REBOOT=ReallySuppress  /qn\
			SET_USEVNCAUTHENTICATION=1\
			VALUE_OF_USEVNCAUTHENTICATION=1\
			SET_PASSWORD=1\
			VALUE_OF_PASSWORD=XXXXXXXX'
  
SectionEnd

Section "Install EXEs" SEC02
	
	ExecWait "$INSTDIR\acrobat.exe /sAll"
	ExecWait "$INSTDIR\cpu_z.exe /VERYSILENT"
	ExecWait "$INSTDIR\defraggler.exe /S"
	ExecWait "$INSTDIR\gimp.exe /VERYSILENT /SUPPRESSMSGBOXES"
	ExecWait "$INSTDIR\heavy_load.exe /VERYSILENT" 
	ExecWait "$INSTDIR\notepad_pp.exe /S"
	ExecWait "$INSTDIR\windir.exe /S"
	ExecWait "$INSTDIR\winrar.exe /S"
SectionEnd
