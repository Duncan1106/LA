## Batch File um die Powershell Scripte in eingescghränkten Umgebungen uneingeschränkt ausfüren zu können
@echo off
echo "Drücke 1 für automatisches Kopieren und umbenennen der Dateie, für die Erstellung "
echo "eines neues Jahresverzeichnisses , 2 und 3 um das Programm zu beenden""
CHOICE /N /C 123 /M "Wähle [1], [2] oder [3]"

IF %ERRORLEVEL% == 1 GOTO 1
IF %ERRORLEVEL% == 2 GOTO 2
IF %ERRORLEVEL% == 3 GOTO 3

:1
echo "Ausfüren des Versand2History&RL Scriptes"
PowerShell.exe -ExecutionPolicy Unrestricted -command "C:\Users\dunca\Desktop\versand2historyAndRL.ps1" ## Verzeichnis muss angepaast werden
pause
exit

:2
echo "Ausfüren des newHistoryYear Scriptes"
PowerShell.exe -ExecutionPolicy Unrestricted -command "C:\Users\dunca\Desktop\newHistoryYear.ps1" ## Verzeichnis muss angepasst werden
pause
exit

:3
exit
