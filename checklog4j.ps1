$fileList= @()
$driveList=@()

#Get all mounted disk
Get-PSDrive | Select-Object -ExpandProperty Name | Select-String -Pattern '^[a-z]$' | ForEach-Object { $driveList += $_}
foreach ($drive in $driveList){ Write-Output "Found Drive Letter $drive"}

 
# Check all files names and pipe all directories to list
foreach ($drive in $driveList) {
    Write-Output "Scanning Disk $drive"
    Get-ChildItem -Path $drive`:\ "*log4j*" -Recurse -Force -ErrorAction SilentlyContinue | Where {$_.extension -like ".jar"} | select-object FullName | ForEach-Object { $fileList += $_}
}

# Print to screen results
foreach ($file in $fileList){ Write-Output $file} 