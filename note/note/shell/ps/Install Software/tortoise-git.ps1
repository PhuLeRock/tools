function install-tortoise-git(){
	$install = ".\store\TortoiseGit-1.8.16.0-x64.msi"
	Start-Process $install /qn -Wait
	Write-Host “Tortoise git has been installed.” -ForegroundColor Green
}

install-tortoise-git