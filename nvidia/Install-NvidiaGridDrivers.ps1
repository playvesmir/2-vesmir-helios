$KeyPrefix = "windows/latest/Windows"
$LocalPath = "C:\Users\Administrator\Desktop\NVIDIA"

# Install Drivers
$ArchiveFileDir = Join-Path $LocalPath $KeyPrefix
$Installer = Get-ChildItem -Path $ArchiveFileDir\* -Include *win10*.exe

Write-Host "Installing NVIDIA Drivers" -NoNewline
Start-Process -FilePath $Installer -ArgumentList '/s' -wait

# Change Registry
$RegPath = "HKLM:\SOFTWARE\NVIDIA Corporation\Global"
$RegKey = "vGamingMarketplace"
$RegVal = "2"

# TODO bug with existing key error
New-ItemProperty -Path $RegPath -Name $RegKey -Value $RegVal -PropertyType DWord
#Get-ItemProperty -Path $RegPath

# Download & Install Certification File
$CertFileURL = "https://nvidia-gaming.s3.amazonaws.com/GridSwCert-Archive/GridSwCertWindows_2021_10_2.cert"
$CertFilePath = "C:\Users\Administrator\Desktop\GridSwCert.txt"
$CertFileInstallPath = "C:\Users\Public\Documents"

Write-Host "Downloading CertFile" -NoNewline
(New-Object System.Net.WebClient).DownloadFile($CertFileURL, $CertFilePath)

Write-Host "Installing CertFile" -NoNewline
Copy-Item -Path $CertFilePath -Destination $CertFileInstallPath


# Code to remove downloaded files
# Remove-Item -Path $LocalPath -Recurse
# Remove-Item -Path $CertFilePath

Restart-Computer