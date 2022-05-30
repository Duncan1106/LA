## Verzeichnisse
  # Verzeichnis in der die IST_RUECK_VOM...Datei von der Abholung liegt
  $Directory = ".\Versand\FTP\"## Verzeichnis muss fuer die eigenen Beduerfnisse angepasst werden
  # verzeichnis, fuer LISSA
  $RLDir =".\RL\Einnahmen\" ## Verzeichnis muss fuer die eigenen Beduerfnisse angepasst werden
  # Name und Pfad der GUI
  $gui = $args[1]

## Dateien
  # tatsaechliche Datei, es ist von auszugehen, dass immer nur eine Datei in dem Verzeichnis vorliegt
  $textfile = Get-ChildItem -Path $Directory
  # kuerzen des dateinames auf Format yyyymmddhhmmss(kompletter Zeitstempel)

## Verarbeitung
  $shorted=$textfile.Name.Substring(16,6)
  # erhalte das Jahr fuer die Einsortierung in die dafuer vorhandene Ordnerstruktur
  $year = $shorted.Substring(0,4)
  # selbes wie bei Jahr nur fuer Monat
  $month = $shorted.Substring(4,2)
  # Verzeihnis, in das die alten Rechenlaeufe kommen
  ## Verzeichnis muss fuer die eigenen Beduerfnisse angepasst werden und am Ende $year/$month passend zu Ihren Anforderungen angefuegt werden
  $historyDir = ".\history\$year\$month\" 

## Ausfuehrung
  # Archivierung der tatsaechlichen Rechenlaufsdatei
  Copy-Item $Directory\$textfile $historyDir
  # kopieren des Rechenlaufes in den fuer LISSA verstaendliche Dateinamen
  Copy-Item $Directory\$textfile $RLDir\IST_RUECK_LA02_V.txt

## Optionale Loeschung der Ursprungsdatei
  $deleteoption = $args[0]
  if ($deleteoption -cmatch "true") {
      Remove-Item -Path $Directory\$textfile -Force
      Write-Host "deleted the original File"
  }
  else {
      Write-Host "kept the original File, needs to be deleted, before executing this script another time"
  }
## Zurueck zum Hauptmenue
    write-host "Versand And History Script executed!"
    powershell.exe -ExecutionPolicy Unrestricted -command $gui
exit
