<# : LMDM_DATA_Decompress.bat
:: By luigim1
:: Select the folder and the file to decompress

@echo off
title LM2 DATAZlib Decompressor v0.1
echo WARNING: It can only go up to three folders.
echo Loading....
::Select specific folder
set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion
echo You chose !folder!
pause

for /f "delims=" %%I in ('powershell -noprofile "iex (${%~f0} | out-string)"') do (
    echo You chose %%~I
    pause
    offzip.exe -a -1 "%%~I" "!folder!" 0
)
echo DONE!
echo LM2 DATAZlib Decompressor v0.1
echo By: luigim1
pause

goto :EOF

::

: end Batch portion / begin PowerShell hybrid chimera #>

Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.OpenFileDialog
$f.InitialDirectory = pwd
$f.Filter = "LM2 zlib Compressed Data File (*.data)|*.data|Output (*.dat)|*.data*" 
$f.ShowHelp = $true									#for some reason, setting it to false causes the entire thing to hang
$f.Multiselect = $false									#offzip cant handle two files, so its disabled
[void]$f.ShowDialog()
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }
