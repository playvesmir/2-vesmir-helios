Write-Host "Downloading AWS CLI" -NoNewline
$AWSCLIUrl = "https://awscli.amazonaws.com/AWSCLIV2.msi"
$AWSCLIFilePath = "C:\Users\Administrator\Desktop\AWSCLIV2.msi"

(New-Object System.Net.WebClient).DownloadFile($AWSCLIUrl, $AWSCLIFilePath)
# TODO generalize next line
start-process -filepath "C:\Windows\System32\msiexec.exe" -ArgumentList '/qn /i "C:\Users\Administrator\Desktop\AWSCLIV2.msi"' -Wait

Remove-Item -Path $AWSCLIFilePath
