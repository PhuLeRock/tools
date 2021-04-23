function install-Notepadpp(){
	$install=".\store\npp.6.8.6.Installer.exe"
	Start-Process -FilePath $install -ArgumentList '/InstallDirectoryPath:"C:\Program Files (x86)"','/S' -Wait -Verb RunAs
	Write-Host “Notepad++ has been installed.” -ForegroundColor Green
}

install-Notepadpp