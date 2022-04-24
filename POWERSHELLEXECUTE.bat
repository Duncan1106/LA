## Batch File um die Powershell Scripte in eingescghränkten Umgebungen uneingeschränkt ausführen zu können
@echo off
echo " Druecke 1 fuer Versand2History%RL, 2 fuer newHistoryYear Verzeichnis"
echo " und 3 um das Programm zu beenden""
:0
CHOICE /N /C 123 /M "Waehle [1], [2] oder [3]"

IF %ERRORLEVEL% == 1 GOTO 1
IF %ERRORLEVEL% == 2 GOTO 2
IF %ERRORLEVEL% == 3 GOTO 3

:1
echo "Ausfüren des Versand2History&RL Scriptes"
PowerShell.exe -ExecutionPolicy Unrestricted -command "./versand2historyAndRL.ps1" ## Verzeichnis muss angepaast werden
GOTO end
pause
exit

:2
echo "Ausfüren des newHistoryYear Scriptes"
PowerShell.exe -ExecutionPolicy Unrestricted -command "./newHistoryYear.ps1" ## Verzeichnis muss angepasst werden
GOTO end


:3
exit

:end
CHOICE /N /C YN /M "Programm beenden? [Y] zum beenden [N] zur Auswahl zurück."
IF %ERRORLEVEL% == 1 GOTO 3
IF %ERRORLEVEL% == 2 GOTO 0
