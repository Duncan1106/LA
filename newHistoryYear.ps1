## Verzeichnis in dem die ganzen alten Dateien liegen sollen
$Directory = "./LA\history"

## User-Input um das Jahr herauszufinden, für das das Verzeichnis erstellt werden soll
$year = Read-Host -Prompt 'Input the year to create a new history directory for this year'

##User-Input überprüfung
$dYear= (Get-Date).AddMonths(-1).ToString("yyyy")

# Überprüfen, ob das angegebene Jahr kleiner als oder glecih dem aktuellen Jahr ist
if ($year -le $dYear) {
    echo "please enter a year that is in the future, the present and the past years allready exist"
    pause
    exit
}

## Überprüfen, ob das angebenen Jahr ein valides Jahr ist, heißt gleich 4 Zeichen lang ist
if($year.Length -cne 4) {
    echo "please enter a valid year with is not $year, example is: 2021, 2022, ..."
    pause
    exit
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
}
