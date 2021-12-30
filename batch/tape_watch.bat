@REM non functional
@echo off
setlocal enabledelayedexpansion

if exist output_dir.txt (
	set /p folder=<"output_dir.txt"
	echo !folder!
	choice /m "Use this folder"
	if ERRORLEVEL 2 (
		goto :choose_folder
	)
	if ERRORLEVEL 1 (
		goto :main
	)
) else (
	goto :choose_folder
)

:choose_folder
set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Build output folder',0,0).self.path""

for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"
echo !folder! 1>output_dir.txt
goto :main

:main
set count=0
for %%i in (src/*) do @(
	cd src

	for /f %%a in ('"forfiles /m %%i /c "cmd /c echo @ftime" "') do @(
		set /a count+=1
		set modif_time=%%a
	)
	cd ..
	@REM https://stackoverflow.com/a/50401317
	for %%Z in (!count!) do @(
		if not "!old_times[%%Z]!" == "!modif_time!" @(
			if not "!old_times[%%Z]!" == "" (
				echo %%i saved

				if not exist moonout\ (
					mkdir moonout
				)
				.\moonscript\moonc.exe -t .\moonout .\src\%%i
				coffee tape -m "main" -o "final_build.lua" -d .\moonout\src .
			)
			set old_times[%%Z]=!modif_time!
		)
	)
)

goto :main
