Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell -NoProfile -ExecutionPolicy Bypass -File ""scripts\wrapper.ps1""", 0, False
