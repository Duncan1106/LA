## ====================== ##
##   @Author Duncan1106   ##
## ====================== ##

Write-Host "===================================="
Write-Host "============ LA Skript ============="
Write-Host "===================================="
Write-Host "========== by Duncan1106 ==========="
Write-Host "===================================="

Function VersandAndHistory {
    Write-Host " "
    write-host "Do you want the original File deleted? y for deleting and n for keeping"
    $deleteoption = (Read-Host)
    ## Verzeichnisse
    # Verzeichnis in der die IST_RUECK_VOM...Datei von der Abholung liegt
    $Directory = ".\Versand\FTP\"## Verzeichnis muss fuer die eigenen Beduerfnisse angepasst werden
    # verzeichnis, fuer LISSA
    $RLDir =".\RL\Einnahmen\" ## Verzeichnis muss fuer die eigenen Beduerfnisse angepasst werden
    # Name und Pfad der GUI
    
    ## Dateien
    #tatsaechliche Datei, es ist von auszugehen, dass immer nur eine Datei in dem Verzeichnis vorliegt
    $textfile = Get-ChildItem -Path $Directory
    # kuerzen des dateinames auf Format yyyymmddhhmmss(kompletter Zeitstempel)

    ## Verarbeitung
    $shorted=$textfile.Name.Substring(14,6)
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
    if ($deleteoption -cmatch "y") {
        Remove-Item -Path $Directory\$textfile -Force
        Write-Host "deleted the original File"
    }
    else {
        Write-Host "kept the original File, needs to be deleted, before executing this script another time"
    }
    ## Zurueck zum Hauptmenue
    write-host "Versand And History Script executed!"
}

Function NewHistoryDirectory {
    Write-Host " "
    ## User-Input um das Jahr herauszufinden, fuer das das Verzeichnis erstellt werden soll
    write-host "Please enter a year, for wich you want to create that folder"
    $year = (Read-Host "Input: ").ToUpper()
    
    ## Verzeichnis in dem die ganzen alten Dateien liegen 
    $Directory = ".\history"

    $dYear= (Get-Date).AddMonths(-1).ToString("yyyy")
    $dyear2 = [int]$dYear + 1 

    ##Benutzer Eingaben Ueberpruefung
    # Ueberpruefen, ob das angegebene Jahr kleiner als oder gleich dem aktuellen Jahr ist
    if ($year -lt $dYear) {
        write-Host "please enter a year that is in the future or the present, the past years should allready exist"
    }
    ## Ueberpruefen, ob das angebenen Jahr ein valides Jahr ist, heisst gleich 4 Zeichen lang ist
    if($year.Length -cne 4) {
        write-Host "please enter a valid year which is not $year, example is: $dyear, $dyear2, ..."
    }

    ## Wenn die Usereingabe korrekt war, erstellen des Jahresverzeichnisses, mit den Monaten als Unterordner, von 01 bis 12 durchnummeriert
    else {
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
        write-host "History Script executed!"
    }
}

## visable Menu for user
Write-Host "================== Menu Title ==================" -ForegroundColor Cyan
Write-Host "1: Enter 1 to execute the versand and history script"
Write-Host "2: Enter 2 to execute the history folder creation script"
Write-Host "Q: Enter Q to quit."

$input = (Read-Host "Please make a selection").ToUpper()

switch ($input)
{
    '1' {VersandAndHistory}    ### Input the name of the function you want to execute when 1 is entered
    '2' {NewHistoryDirectory}    ### Input the name of the function you want to execute when 2 is entered
    'Q' {Write-Host "The script has been terminated" -BackgroundColor Red -ForegroundColor White}
    Default {Write-Host "Your selection = $input, is not valid. Please try again." -BackgroundColor Red -ForegroundColor White}
}
pause
