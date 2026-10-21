# Keeps the PC and display awake until you close this window or press Ctrl+C
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Power {
    [DllImport("kernel32.dll")]
    public static extern uint SetThreadExecutionState(uint esFlags);
}
"@

# ES_CONTINUOUS | ES_SYSTEM_REQUIRED | ES_DISPLAY_REQUIRED
$flags = 0x80000000 -bor 0x00000001 -bor 0x00000002

Write-Host "Keeping laptop awake. Press Ctrl+C or close this window to stop."
try {
    while ($true) {
        [Power]::SetThreadExecutionState($flags) | Out-Null
        Start-Sleep -Seconds 60
    }
}
finally {
    [Power]::SetThreadExecutionState(0x80000000) | Out-Null  # back to normal
    Write-Host "Normal sleep settings restored."
}
