## Verzeichnisse
# Verzeichnis in der die IST_RUECK_VOM...Datei von der Abholung liegt
$Directory = "C:\Users\dunca\Desktop\LA\Versand\FTP\"
# verzeichnis, für LISSA
$RLDir = "C:\Users\dunca\Desktop\LA\RL\Einnahmen"

## Dateien
# tatsächliche Datei, es ist von auszugehen, dass immer nur eine Datei in dem Verzeichnis vorliegt
$textfile = Get-ChildItem -Path $Directory
# kürzen des dateinames auf Format yyyymmddhhmmss(kompletter Zeitstempel)

## Verarbeitung
$shorter=$textfile.Name.Substring(14,14)
# erhalte das Jahr für die Einsortierung in die dafür vorhandene Ordnerstruktur
$year = $shorter.Substring(0,4)
# selbes wie bei Jahr nur für Monat
$month = $shorter.Substring(4,2)
# Verzeihnis, in das die alten Rechenläufe kommen
$historyDir = "C:\Users\dunca\Desktop\LA\history\$year\$month\"

## Ausführung
# Archivierung der tatsächlichen Rechenlaufsdatei
Copy-Item $Directory\$textfile $historyDir
# kopieren des Rechenlaufes in den für LISSA verständliche Dateinamen
Copy-Item $Directory\$textfile $RLDir\IST_RUECK_LA02_V.txt
