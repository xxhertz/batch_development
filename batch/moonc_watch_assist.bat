@echo off
goto main

:main
if exist output_dir.txt (
	set /p folder=<output_dir.txt
	setlocal enabledelayedexpansion
	echo !folder!
	endlocal
	choice /m "Use this folder"
	if ERRORLEVEL 2 (
		goto choose_folder
	)
	if ERRORLEVEL 1 (
		goto run
	)
) else (
	goto choose_folder
)

:run
setlocal enabledelayedexpansion
.\moonscript\moonc.exe -t !folder! -w src
endlocal
goto main

:choose_folder

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Build output folder',0,0).self.path""

for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion
echo !folder! 1>output_dir.txt
endlocal
goto main
