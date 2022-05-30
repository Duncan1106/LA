## Verzeichnis in dem die ganzen alten Dateien liegen 
    $Directory = ".\history"
    # Name und Pfad der GUI
    $gui = $args[1]

## User-Input um das Jahr herauszufinden, fuer das das Verzeichnis erstellt werden soll
    $year = [String]$args[0]
    $dYear= (Get-Date).AddMonths(-1).ToString("yyyy")
    $dyear2 = [int]$dYear + 1 
    write-Host $year

##Benutzer Eingaben Ueberpruefung
    # Ueberpruefen, ob das angegebene Jahr kleiner als oder gleich dem aktuellen Jahr ist
    if ($year -lt $dYear) {
        write-Host "please enter a year that is in the future or the present, the past years should allready exist"
        powershell.exe -ExecutionPolicy Unrestricted -command $gui
    }
    ## Ueberpruefen, ob das angebenen Jahr ein valides Jahr ist, heisst gleich 4 Zeichen lang ist
    if($year.Length -cne 4) {
        write-Host "please enter a valid year which is not $year, example is: $dyear, $dyear2, ..."
        powershell.exe -ExecutionPolicy Unrestricted -command $gui
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
        powershell.exe -ExecutionPolicy Unrestricted -command $gui
        write-host "History Script executed!"
    }
exit
