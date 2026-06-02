# vkim Windows Terminal profile setup
# Run once after extraction to add vkim as a Windows Terminal profile.
# Usage: Right-click -> Run with PowerShell
#        OR: powershell -ExecutionPolicy Bypass -File setup-windows-terminal.ps1

$ErrorActionPreference = "Stop"
$root     = Split-Path $PSCommandPath -Parent
$vkimExe  = Join-Path $root "vkim.exe"

if (-not (Test-Path $vkimExe)) {
  Write-Error "vkim.exe not found at $vkimExe. Run this script from the extracted vkim folder."
  exit 1
}

$fragDir  = "$env:LOCALAPPDATA\Microsoft\Windows Terminal\Fragments\vkim"
$fragFile = "$fragDir\vkim.json"

New-Item -ItemType Directory -Force -Path $fragDir | Out-Null

$fragment = [ordered]@{
  profiles = @(
    [ordered]@{
      name              = "vkim"
      commandline       = $vkimExe
      startingDirectory = "%USERPROFILE%"
      font              = [ordered]@{ face = "CaskaydiaCove Nerd Font Mono" }
    }
  )
} | ConvertTo-Json -Depth 5

Set-Content -Path $fragFile -Value $fragment -Encoding UTF8

Write-Host "Done! Restart Windows Terminal to see the 'vkim' profile."
Write-Host "Profile written to: $fragFile"
