## Verzeichnisse
# Verzeichnis in der die IST_RUECK_VOM...Datei von der Abholung liegt
$Directory = "C:\Users\dunca\Desktop\LA\Versand\FTP\"
# verzeichnis, f�r LISSA
$RLDir = "C:\Users\dunca\Desktop\LA\RL\Einnahmen"

## Dateien
# tats�chliche Datei, es ist von auszugehen, dass immer nur eine Datei in dem Verzeichnis vorliegt
$textfile = Get-ChildItem -Path $Directory
# k�rzen des dateinames auf Format yyyymmddhhmmss(kompletter Zeitstempel)

## Verarbeitung
$shorter=$textfile.Name.Substring(14,14)
# erhalte das Jahr f�r die Einsortierung in die daf�r vorhandene Ordnerstruktur
$year = $shorter.Substring(0,4)
# selbes wie bei Jahr nur f�r Monat
$month = $shorter.Substring(4,2)
# Verzeihnis, in das die alten Rechenl�ufe kommen
$historyDir = "C:\Users\dunca\Desktop\LA\history\$year\$month\"

## Ausf�hrung
# Archivierung der tats�chlichen Rechenlaufsdatei
Copy-Item $Directory\$textfile $historyDir
# kopieren des Rechenlaufes in den f�r LISSA verst�ndliche Dateinamen
Copy-Item $Directory\$textfile $RLDir\IST_RUECK_LA02_V.txt