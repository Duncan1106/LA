## ====================== ##
##   @Author Duncan1106   ##
## ====================== ##

Write-Host "====================================" -ForegroundColor Green
Write-Host "====== LA-Automation Skripts =======" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host "========== by Duncan1106 ===========" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green

# Error catching
$ErrorActionPreference = "Stop"

Function VersandAndHistory {
    Write-Host " "
    write-host "Soll die Originaldatei geloescht werden? Y zum Loeschen, N zum Behalten"
    $deleteoption = (Read-Host)
    ## Verzeichnisse
    # Verzeichnis in der die IST_RUECK_VOM...Datei von der Abholung liegt
    $Directory = ".\Versand\FTP\"## Verzeichnis muss fuer die eigenen Beduerfnisse angepasst werden
    # verzeichnis, fuer LISSA
    $RLDir =".\RL\Einnahmen\" ## Verzeichnis muss fuer die eigenen Beduerfnisse angepasst werden
    
    ## Dateien
    #tatsaechliche Datei, es ist von auszugehen, dass immer nur eine Datei in dem Verzeichnis vorliegt
    $textfile = Get-ChildItem -Path $Directory
    
    # kuerzen des dateinames auf Format yyyymmddhhmmss(kompletter Zeitstempel)
    $shorted=$textfile.Name.Substring(16,6)
    # erhalte das Jahr fuer die Einsortierung in die dafuer vorhandene Ordnerstruktur
    $year = $shorted.Substring(0,4)
    # selbes wie bei Jahr nur fuer Monat
    $month = $shorted.Substring(4,2)
    # Verzeihnis, in das die alten Rechenlaeufe kommen
    ## Verzeichnis muss fuer die eigenen Beduerfnisse angepasst werden und am Ende $year/$month passend zu Ihren Anforderungen angefuegt werden
    $historyDir = ".\history\$year\$month\" 

    ## Ausfuehrung
    Try {
        # Archivierung der tatsaechlichen Rechenlaufsdatei
        Copy-Item $Directory\$textfile $historyDir
        # kopieren des Rechenlaufes in den fuer LISSA verstaendliche Dateinamen
        Copy-Item $Directory\$textfile $RLDir\IST_RUECK_LA02_V.txt

        ## Optionale Loeschung der Ursprungsdatei
        if ($deleteoption -cmatch "y") {
            Remove-Item -Path $Directory\$textfile -Force
            Write-Host "Erfolgreiche Löschung der Originaldatei"
        }
        else {
            Write-Host "Die Originaldatei wurde NICHT geloescht. Vor der naechsten Ausfuehrung dieses Skriptes bitte loeschen"
        }
        write-host "Versand und Archivierungs Skript ausgefuehrt!"
        }
    Catch {
        Write-Host ""
        Write-Host $_.Exception.Message -ForegroundColor Red
        Write-Host $_.ScriptStackTrace
        Write-Host ""
    }
}

Function NewHistoryDirectory {
    Write-Host " "
    ## User-Input um das Jahr herauszufinden, fuer das das Verzeichnis erstellt werden soll
    write-host "Bitte gib ein Jahr an, für das die Ordnerstruktur aufgebaut werden soll"
    $year = (Read-Host "Input: ").ToUpper()
    
    ## Verzeichnis in dem die ganzen alten Dateien liegen 
    $Directory = ".\history"

    $dYear= (Get-Date).AddMonths(-1).ToString("yyyy")
    $dyear2 = [int]$dYear + 1 

    ##Benutzer Eingaben Ueberpruefung
    # Ueberpruefen, ob das angegebene Jahr kleiner als oder gleich dem aktuellen Jahr ist
    if ($year -lt $dYear) {
        write-Host "Bitte gib ein Jahr ein, das in der Zukunft liegt, vergangene Jahre existieren schon"
    }
    ## Ueberpruefen, ob das angebenen Jahr ein valides Jahr ist, heisst gleich 4 Zeichen lang ist
    if($year.Length -cne 4) {
        write-Host "Bitte gib ein valides Jahr ein, nicht $year, zum Beispiel: $dyear, $dyear2, ..."
    }

    ## Wenn die Benutzereingabe korrekt war, erstellen des Jahresverzeichnisses, mit den Monaten als Unterordner, von 01 bis 12 durchnummeriert
    else {
        Try{
            New-Item -Path $Directory -Name $year -ItemType "directory"
            $subdir = "$Directory\$year"
            For ($i=1; $i -lt 13; $i++) {
                if($i -lt 10) {
                    $zero2nine = "0$i"
                    New-Item -Path $subdir -Name $zero2nine -ItemType "directory"
                }
                else{    
                    New-Item -Path $subdir -Name $i -ItemType "directory"
                }
            }
            write-host "Archivierungsstrukturskript ausgefuehrt!"
        }
        Catch {
            Write-Host ""
            Write-Host $_.Exception.Message -ForegroundColor Red
            Write-Host $_.ScriptStackTrace
            Write-Host ""
        }
    }
}

## GUI für den Benutzer
Write-Host "================== LA Skript ==================" -ForegroundColor Cyan
Write-Host "1: 1 um das Versand und Archivierungs Skript auszufuehren"
Write-Host "2: 2 um das Archivierungsstrukturskript auszufuehren"
Write-Host "Q: Q um das Skript zu beenden."

$input = (Read-Host "Bitte waehle: ").ToUpper()

switch ($input)
{
    '1' {VersandAndHistory}
    '2' {NewHistoryDirectory}
    'Q' {Write-Host "Das Skript wurde beednet" -BackgroundColor Red -ForegroundColor White}
    Default {Write-Host "Deine Wahl $input, ist nicht gueltig. Bitte starte das Skript neu." -BackgroundColor Red -ForegroundColor White}
}
pause
