# Activate & Validate NVIDIA Gaming License

$NvidiaAppPath = "C:\Program Files\NVIDIA Corporation\NVSMI\nvidia-smi.exe"

$NvsmiLogFilePath = "C:\Users\Administrator\Desktop\nvsmi.log"

# TODO upload this file to something to validate and test build
& $NvidiaAppPath -q | Out-File -FilePath $NvsmiLogFilePath

# Change Registry
$RegPath = "HKLM:\SOFTWARE\NVIDIA Corporation\Global\GridLicensing"
$RegKey = "FeatureType"
$RegVal = "0"

# TODO bug with existing key error
New-ItemProperty -Path $RegPath -Name $RegKey -Value $RegVal -PropertyType DWord

# Change Registry
$RegPath = "HKLM:\SOFTWARE\NVIDIA Corporation\Global\GridLicensing"
$RegKey = "IgnoreSP"
$RegVal = "1"

# TODO bug with existing key error
New-ItemProperty -Path $RegPath -Name $RegKey -Value $RegVal -PropertyType DWord

# Optimizing GPU
Write-Host "Optimize GPU"

# Disable autoboost
& $NvidiaAppPath --auto-boost-default=0 | Out-File -FilePath $NvsmiLogFilePath -Append

# Set GPU to max freq on G4 instances
# TODO optimize for each GPU
& $NvidiaAppPath -ac "5001,1590" | Out-File -FilePath $NvsmiLogFilePath -Append
