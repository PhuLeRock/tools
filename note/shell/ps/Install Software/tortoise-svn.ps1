function install-tortoise-svn(){
	$install = ".\store\TortoiseSVN-1.9.2.26806-x64.msi"
	Start-Process $install /qn -Wait;
	Write-Host “Tortoise svn has been installed.” -ForegroundColor Green
}

install-tortoise-svn