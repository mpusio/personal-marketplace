#Requires -Version 5.1
$ErrorActionPreference = 'SilentlyContinue'
trap { exit 0 }

try {
    Add-Type -AssemblyName System.Windows.Forms -ErrorAction Stop
    Add-Type -AssemblyName System.Drawing -ErrorAction Stop

    # Read JSON from stdin (Claude Code hook input)
    $inputLines = @()
    while ($line = [Console]::In.ReadLine()) {
        if ($null -eq $line) { break }
        $inputLines += $line
    }

    if ($inputLines.Count -eq 0) { exit 0 }

    $hookData = ($inputLines -join "`n") | ConvertFrom-Json -ErrorAction Stop

    # Get notification type and message from hook input
    $notificationType = $hookData.notification_type
    $hookMessage = $hookData.message

    # Configure notification based on type
    $title = "Claude Code"
    $message = ""
    $iconType = [System.Windows.Forms.ToolTipIcon]::Info

    switch ($notificationType) {
        "permission_prompt" {
            $title = "Claude Code - Wymagana zgoda"
            if ($hookMessage) {
                $message = $hookMessage
            } else {
                $message = "Claude czeka na Twoja zgode"
            }
            $iconType = [System.Windows.Forms.ToolTipIcon]::Warning
            [System.Media.SystemSounds]::Exclamation.Play()
        }
        "idle_prompt" {
            $title = "Claude Code - Oczekuje"
            if ($hookMessage) {
                $message = $hookMessage
            } else {
                $message = "Claude czeka na Twoja odpowiedz"
            }
            $iconType = [System.Windows.Forms.ToolTipIcon]::Info
            [System.Media.SystemSounds]::Asterisk.Play()
        }
        "auth_success" {
            $title = "Claude Code - Uwierzytelnienie"
            $message = "Logowanie zakonczone pomyslnie"
            $iconType = [System.Windows.Forms.ToolTipIcon]::Info
        }
        default { exit 0 }
    }

    if ([string]::IsNullOrWhiteSpace($message)) { exit 0 }

    # Create balloon notification
    $notifyIcon = New-Object System.Windows.Forms.NotifyIcon
    $notifyIcon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon("$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe")
    $notifyIcon.Visible = $true
    $notifyIcon.BalloonTipTitle = $title
    $notifyIcon.BalloonTipText = $message
    $notifyIcon.BalloonTipIcon = $iconType

    $notifyIcon.ShowBalloonTip(5000)
    Start-Sleep -Milliseconds 3000

    $notifyIcon.Visible = $false
    $notifyIcon.Dispose()

} catch {
    exit 0
}

exit 0
