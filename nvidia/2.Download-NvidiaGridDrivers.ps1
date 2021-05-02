# Reference: https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/install-nvidia-driver.html#nvidia-gaming-driver
# Notes: Required s3.getobject, s3.list-objects api calls


$Bucket = "nvidia-gaming"
$KeyPrefix = "windows/latest"
$LocalPath = "C:\Users\Administrator\Desktop\NVIDIA"

#Download drivers
$Objects = Get-S3Object -BucketName $Bucket -KeyPrefix $KeyPrefix -Region us-east-1
foreach ($Object in $Objects) {
   $LocalFileName = $Object.Key
   if ($LocalFileName -ne '' -and $Object.Size -ne 0) {
       $LocalFilePath = Join-Path $LocalPath $LocalFileName
       Copy-S3Object -BucketName $Bucket -Key $Object.Key -LocalFile $LocalFilePath -Region us-east-1
   }
}

# Extract archives
foreach ($Object in $Objects) {
   $LocalFileName = $Object.Key
   if ($LocalFileName -ne '' -and $Object.Size -ne 0) {
       $LocalFilePath = Join-Path $LocalPath $LocalFileName
       $LocalFileDir = Join-Path $LocalPath $KeyPrefix
       Expand-Archive -Path $LocalFilePath -DestinationPath $LocalFileDir
   }
} 
