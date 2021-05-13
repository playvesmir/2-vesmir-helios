# Activate & Validate NVIDIA Gaming License

$NvidiaAppPath = "C:\Program Files\NVIDIA Corporation\NVSMI\nvidia-smi.exe"

$NvsmiLogFilePath = "C:\Users\Administrator\Desktop\nvsmi.log"

# TODO upload this file to something to validate and test build
& $NvidiaAppPath -q | Out-File -FilePath $NvsmiLogFilePath