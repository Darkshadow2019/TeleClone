# TeleClone By D@rkshadow
Set-ExecutionPolicy Bypass -Scope Process -Force;
[Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8
$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding

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
    $form.Text = "Administrator Authorization Required"
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
    $titleLabel.Text = "ADMINISTRATOR ACCESS REQUIRED"
    $titleLabel.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 14, [System.Drawing.FontStyle]::Bold)
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
        # $imageUrl = "https://raw.githubusercontent.com/PowerShell/PowerShell/master/assets/ps_black_128.png"
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
                           "APP Name : TELE CLONE" + [Environment]::NewLine +  
                           "Version : 1.0.0.1" + [Environment]::NewLine +
                           "Programming Language : PowerShell Script Language" + [Environment]::NewLine +
                           "Developer : D@rkshadow Myanmar" + [Environment]::NewLine + [Environment]::NewLine +
                           "By clicking 'YES', you acknowledge that you are an authorized Administrator and understand the risks of elevated access."
    $descriptionLabel.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 9, [System.Drawing.FontStyle]::Regular)
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
    
    # Your main application logic goes here
    Write-Host "Running with Administrator privileges" -ForegroundColor Green
    Write-Host "Performing system operations..." -ForegroundColor Yellow
    
    # Example operations
    $operations = @(
        "Initializing system components",
        "Validating security context",
        "Accessing protected resources", 
        "Applying configuration changes",
        "Updating system settings",
        "Finalizing operations"
    )
    
    foreach ($operation in $operations) {
        Write-Host "Operation: $operation" -ForegroundColor Cyan
        Start-Sleep -Milliseconds 500
    }
    
    Write-Host "Main application operations completed successfully" -ForegroundColor Green
    
    # Show completion message
    [System.Windows.Forms.MessageBox]::Show(
        "All system operations completed successfully.",
        "Application Completed",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Information
    )
}

# Alternative: Using Start-Job for true background processing
function Start-MainOperationsBackground {
    Write-Host "Starting background operations..." -ForegroundColor Green
    
    # Create a background job
    $jobScript = {
        $operations = @(
            "Initializing system components",
            "Validating security context",
            "Accessing protected resources", 
            "Applying configuration changes", 
            "Updating system settings",
            "Finalizing operations"
        )
        
        foreach ($operation in $operations) {
            Write-Output "Operation: $operation"
            Start-Sleep -Milliseconds 500
        }
        
        Write-Output "Background operations completed successfully"
        return "SUCCESS"
    }
    
    # Start the job
    $job = Start-Job -ScriptBlock $jobScript
    
    # Wait for job completion and get results
    $job | Wait-Job | Out-Null
    $results = $job | Receive-Job
    
    # Display results
    foreach ($result in $results) {
        Write-Host $result -ForegroundColor Cyan
    }
    
    # Clean up
    $job | Remove-Job
    
    Write-Host "All background operations finished" -ForegroundColor Green
}

# Main execution
Write-Host "Admin Acceptance Form Launcher" -ForegroundColor Cyan
Write-Host "==============================" -ForegroundColor Cyan

$accepted = Show-AdminAcceptanceForm

if ($accepted) {
    Write-Host "Application continues with elevated privileges" -ForegroundColor Green
    
    # You can add more operations here that run after form acceptance
    Write-Host "Preparing additional system tasks..." -ForegroundColor Yellow
    Start-Sleep -Seconds 1
    Write-Host "Additional tasks completed" -ForegroundColor Green
    
} else {
    Write-Host "Application terminated by user" -ForegroundColor Yellow
}

Write-Host "Script execution finished" -ForegroundColor Gray
