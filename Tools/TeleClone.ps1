Set-ExecutionPolicy Bypass -Scope Process -Force;
$source = "$env:APPDATA\Telegram Desktop\Telegram.exe"
$desktop = [Environment]::GetFolderPath("Desktop")
$appData = [Environment]::GetFolderPath("ApplicationData")
$mainFolder = "$appData\TeleClone"

if (Test-Path $source) {
    New-Item -ItemType Directory -Path $mainFolder -Force | Out-Null
    1..5 | ForEach-Object {
        $folderNumber = "{0:D2}" -f $_  # 01, 02, 03, 04, 05
        $folderName = "TeleClone$folderNumber"
        $folder = "$mainFolder\$folderName"
        
        New-Item -ItemType Directory -Path $folder -Force | Out-Null
        Copy-Item $source "$folder\Telegram.exe" -Force
        $portableFile = "$folder\portable"
        New-Item -ItemType File -Path $portableFile -Force | Out-Null
        
        Write-Host "Created: $folderName" -ForegroundColor Green
    }
    $shell = New-Object -ComObject WScript.Shell
    1..5 | ForEach-Object {
        $folderNumber = "{0:D2}" -f $_  # 01, 02, 03, 04, 05
        $folderName = "TeleClone$folderNumber"
        $exePath = "$mainFolder\$folderName\Telegram.exe"
        $shortcutPath = "$desktop\$folderName.lnk"
        
        $shortcut = $shell.CreateShortcut($shortcutPath)
        $shortcut.TargetPath = $exePath
        $shortcut.WorkingDirectory = "$mainFolder\$folderName"
        $shortcut.Description = "Telegram Clone $folderNumber"
        $shortcut.Save()
        Write-Host "Shortcut: $folderName" -ForegroundColor Cyan
    }
    $mainShortcut = $shell.CreateShortcut("$desktop\TelClone.lnk")
    $mainShortcut.TargetPath = $mainFolder
    $mainShortcut.Description = "Open Telegram Clones Folder"
    $mainShortcut.Save()
    Write-Host "Shortcut: Telegram Clones Folder" -ForegroundColor Cyan
    
    Write-Host "`nCOMPLETED!" -ForegroundColor Green
    Write-Host "Folders created: TeleClone01 to TeleClone05" -ForegroundColor White
    Write-Host "Shortcuts created: 6 total (5 clones + 1 folder)" -ForegroundColor White
    Write-Host "Location: $mainFolder" -ForegroundColor White
    Start-Process "explorer.exe" -ArgumentList $mainFolder
} else {
    Write-Host "Telegram not found at: $source" -ForegroundColor Red
    Write-Host "Please make sure Telegram Desktop is installed" -ForegroundColor Yellow
}







