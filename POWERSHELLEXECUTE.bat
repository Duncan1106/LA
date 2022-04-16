## Batch File um die Powershell Scripte in eingescghränkten Umgebungen uneingeschränkt ausfüren zu können

echo "Drücke A für automatisches Kopieren und umbenennen der Dateie, für die Erstellung eines neues Jahresverzeichnisses , B und Q um das Programm zu beenden"
CHOICE /N /C:ABQ /M "Wähle A, B oder Q"%1

IF ERRORLEVEL ==1 GOTO A
IF ERRORLEVEL ==2 GOTO B
IF ERRORLEVEL ==3 GOTO Q

A:
echo "Ausfüren des Versand2History&RL Scriptes"
PowerShell.exe -ExecutionPolicy Unrestricted -command "C:\Users\dunca\Desktop\versand2historyandRL.ps1" ## Verzeichnis muss angepaast werden
pause
exit

B:
echo "Ausfüren des newHistoryYear Scriptes"
PowerShell.exe -ExecutionPolicy Unrestricted -command "C:\Users\dunca\Desktop\newHistoryYear.ps1" ## Verzeichnis muss angepasst werden
pause
exit

Q:
exit





