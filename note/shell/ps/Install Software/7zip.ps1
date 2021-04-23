function install-7zip(){
	$install=".\store\7z1512-x64.exe"
	Start-Process -FilePath $install -ArgumentList '/InstallDirectoryPath:"C:\Program Files (x86)"','/S' -Wait -Verb RunAs
	Write-Host “7zip has been installed.” -ForegroundColor Green
}

install-7zip