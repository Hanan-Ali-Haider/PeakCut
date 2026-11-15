# PeakCut Launcher
# Starts the server in background and opens the web UI
# Press Ctrl+C or close this window to stop the server completely

$ffmpegPath = "D:\Bullshit\ffmpeg-master-latest-win64-gpl-shared\bin"
$projectPath = "D:\Bullshit\PeakCut-main"
$pythonPath = "C:\Users\NS COMPUTER\AppData\Local\Python\pythoncore-3.15-64\python.exe"

# Add ffmpeg to PATH for this session
$env:PATH += ";$ffmpegPath"

# Kill any existing PeakCut server
Stop-Process -Name "python" -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1

# Start server in background (hidden window)
$process = Start-Process -FilePath $pythonPath -ArgumentList "-m studio.server" -WorkingDirectory $projectPath -WindowStyle Hidden -PassThru

Write-Host "PeakCut server starting (PID: $($process.Id))..."
Write-Host "Press Ctrl+C or close this window to stop the server."

# Wait for server to be ready
$ready = $false
for ($i = 0; $i -lt 30; $i++) {
    try {
        $response = Invoke-WebRequest -Uri "http://127.0.0.1:8765" -Method GET -TimeoutSec 2 -ErrorAction Stop
        if ($response.StatusCode -eq 200) {
            $ready = $true
            break
        }
    } catch {}
    Start-Sleep -Seconds 1
}

if ($ready) {
    Write-Host "Server ready! Opening browser..."
    Start-Process "http://127.0.0.1:8765"
} else {
    Write-Error "Server failed to start within 30 seconds"
    Stop-Process -Id $process.Id -Force -ErrorAction SilentlyContinue
    exit 1
}

# Cleanup function - kills server and any child processes
function Stop-PeakCutServer {
    Write-Host "`nStopping PeakCut server..."
    Stop-Process -Id $process.Id -Force -ErrorAction SilentlyContinue
    # Also kill any child processes
    Get-CimInstance Win32_Process -Filter "ParentProcessId = $($process.Id)" | ForEach-Object {
        Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
    }
}

# Handle Ctrl+C (works in interactive console)
try {
    [System.Console]::CancelKeyPress.Add({
        Stop-PeakCutServer
        exit 0
    })
} catch {}

# Handle window close / script exit
$global:cleanupRegistered = $true
Register-EngineEvent -SourceIdentifier PowerShell.Exiting -Action {
    if ($global:cleanupRegistered) { Stop-PeakCutServer }
} | Out-Null

# Keep script alive so server keeps running
try {
    $process.WaitForExit()
} catch {
    Stop-PeakCutServer
}