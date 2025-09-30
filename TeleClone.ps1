# Telegram_Quick_Setup By D@rkshadow
# One-click setup for 5 folders (TeleClone01-05) + shortcuts

$source = "$env:APPDATA\Telegram Desktop\Telegram.exe"
$desktop = [Environment]::GetFolderPath("Desktop")
$mainFolder = "$desktop\TeleClone"

if (Test-Path $source) {
    # Create main folder
    New-Item -ItemType Directory -Path $mainFolder -Force | Out-Null
    
    # Create 5 subfolders (TeleClone01 to TeleClone05) and copy files
    1..5 | ForEach-Object {
        $folderNumber = "{0:D2}" -f $_  # 01, 02, 03, 04, 05
        $folderName = "TeleClone$folderNumber"
        $folder = "$mainFolder\$folderName"
        
        New-Item -ItemType Directory -Path $folder -Force | Out-Null
        Copy-Item $source "$folder\Telegram.exe" -Force
        Write-Host "✅ Created: $folderName" -ForegroundColor Green
    }
    
    # Create shortcuts for each TeleClone
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
        Write-Host "🔗 Shortcut: $folderName" -ForegroundColor Cyan
    }
    
    # Main folder shortcut
    $mainShortcut = $shell.CreateShortcut("$desktop\TelClone.lnk")
    $mainShortcut.TargetPath = $mainFolder
    $mainShortcut.Description = "Open Telegram Clones Folder"
    $mainShortcut.Save()
    Write-Host "🔗 Shortcut: Telegram Clones Folder" -ForegroundColor Cyan
    
    Write-Host "`n🎉 COMPLETED!" -ForegroundColor Green
    Write-Host "📁 Folders created: TeleClone01 to TeleClone05" -ForegroundColor White
    Write-Host "🔗 Shortcuts created: 6 total (5 clones + 1 folder)" -ForegroundColor White
    Write-Host "📍 Location: $mainFolder" -ForegroundColor White
    
    # Open the folder
    Start-Process "explorer.exe" -ArgumentList $mainFolder
} else {
    Write-Host "❌ Telegram not found at: $source" -ForegroundColor Red
    Write-Host "   Please make sure Telegram Desktop is installed" -ForegroundColor Yellow
}
