# Define the source and output directories
$srcDir = "C:\Intune\src"
$outDir = "C:\Intune\out"
$intuneWinAppUtilPath = "C:\Intune\Tool\IntuneWinAppUtil.exe"

# Initialize the list of files
$files = @()

# Check for EXE or MSI files in the src directory and add them to the list
foreach ($file in Get-ChildItem -Path $srcDir) {
    if ($file.Extension -eq ".exe" -or $file.Extension -eq ".msi") {
        $files += $file.Name
    }
}

# If no EXE or MSI file is found, print an error message
if ($files.Count -eq 0) {
    Write-Host "No EXE or MSI file found in the src directory."
} elseif ($files.Count -eq 1) {
    # If only one file is found, assign it without prompting
    $selectedFile = $files
    Write-Host "Selected file: $selectedFile"
} else {
    # Print the list of files with numbers starting from 1
    Write-Host "Select a file:"
    for ($i = 0; $i -lt $files.Count; $i++) {
        Write-Host "$($i + 1). $($files[$i])"
    }
    
    # Prompt user to select a file
    $selectedIndex = Read-Host "Enter the number of the file you want to select"
    
    # Subtract 1 from the prompted number after storing it
    $selectedIndex = $selectedIndex - 1
    
    # Assign the selected file to a variable
    $selectedFile = $files[$selectedIndex]
    
    Write-Host "Selected file: $selectedFile"
}

# Run the IntuneWinAppUtil.exe with the parameters
$command = "$intuneWinAppUtilPath -s $selectedFile -c $srcDir -o $outDir"
Write-host $command
Invoke-Expression $command
