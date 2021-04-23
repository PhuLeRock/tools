Set-ExecutionPolicy	-Scope	Process -ExecutionPolicy	Unrestricted
## Define the target URL ##
## $dotNetFxUrl = "https://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe"
$dotNetFxUrl = "http://10.128.240.158:7000/Software/dotNetFx40_Full_x86_x64.exe"
$packageName = "NDP46-KB3045557-x86-x64-AllOS-ENU.exe"
$downloadPath = Join-Path -path $env:TEMP  $packageName
Write-Host "Download to " $downloadPath -ForegroundColor Cyan

If (!(test-path $downloadPath))
{
    Try
    {
        ## Instantiate a WebClient Object from the .Net classes ##
        $request = New-Object System.Net.Webclient
    
        Write-Host "Downloading File ... " -ForegroundColor Cyan

        ## Make the Get request and pipe output to the destination file ##
        $request.DownloadFile($dotNetFxUrl, $downloadPath)
 
        ### Send a success message to the console. Uncomment this for testing ##
        Write-Host("Download Finished!!!") -ForegroundColor Cyan
 
    }
 
    Catch [System.Net.WebException], [System.IO.IOException] {
        ## If there's an error send a message to the console ##

        Write-Host $_.Exception.GetType().FullName -ForegroundColor Red
        Write-Host $_.Exception.Message  -ForegroundColor Red
        Write-Host $_.Exception.InnerException  -ForegroundColor Red
        ## Exit gracefully ##
        Exit
    }
}
else
{
    Write-Host "Already exist " $packageName -ForegroundColor Cyan
}

$process = (Start-Process -FilePath $downloadPath -ArgumentList "/q /norestart" -Wait -Verb RunAs -PassThru)

if ($process.ExitCode -eq 0)
{
    
    Write-Host -Fore Cyan "Install " $packageName " completed !!!"
}
else 
{
    if ($process.ExitCode -eq 3010)
    {
        Write-Host -Fore Cyan "Install " $packageName " operation is successful. Changes will not be effective until the system is rebooted."
    }
    else
    {
        Write-Host -Fore Red "Errorcode: " $process.ExitCode
    }
}

