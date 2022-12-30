## ====================== ##
##   @Author Duncan1106   ##
## ====================== ##

Write-Output "====================================" -ForegroundColor Green
Write-Output "====== LA-Automation Skripts =======" -ForegroundColor Green
Write-Output "====================================" -ForegroundColor Green
Write-Output "========== by Duncan1106 ===========" -ForegroundColor Green
Write-Output "====================================" -ForegroundColor Green

# Error catching
$ErrorActionPreference = "Stop"

Function VersandAndHistory {
    # Define variables
    $deleteoption = $null
    $Directory = ".\Versand\FTP\"
    $RLDir = ".\RL\Einnahmen\"
    $textfile = Get-ChildItem -Path $Directory
    $shorted = $textfile.Name.Substring(14,6)
    $year = $shorted.Substring(0,4)
    $month = $shorted.Substring(4,2)
    $historyDir = ".\history\$year\$month\"

    # Prompt user to delete original file
    Write-Output "`nSoll die Originaldatei geloescht werden? Y zum Loeschen, N zum Behalten"
    $deleteoption = (Read-Host)

    # Try block to handle errors
    Try {
        # Archivierung der tatsaechlichen Rechenlaufsdatei
        Copy-Item $Directory\$textfile $historyDir
        # kopieren des Rechenlaufes in den fuer LISSA verstaendliche Dateinamen
        Copy-Item $Directory\$textfile $RLDir\IST_RUECK_LA02_V.txt

        # Optionally delete original file
        if ($deleteoption -cmatch "y" -or $deleteoption -cmatch "Y") {
            Remove-Item -Path $Directory\$textfile -Force
            Write-Output "Erfolgreiche Loeschung der Originaldatei"
        }
        else {
            Write-Output "Die Originaldatei wurde NICHT geloescht. Vor der naechsten Ausfuehrung dieses Skriptes bitte loeschen"
        }
        Write-Output "Versand und Archivierungs Skript ausgefuehrt!"
    }
    Catch {
        Write-Output "`n"
        Write-Output $_.Exception.Message -ForegroundColor Red
        Write-Output $_.ScriptStackTrace
        Write-Output "`n"
    }
}

Function NewHistoryDirectory {

    ## Verzeichnis in dem die ganzen alten Dateien liegen
    $Directory = ".\history"

    ## Wenn die Benutzereingabe korrekt war, erstellen des Jahresverzeichnisses, mit den Monaten als Unterordner, von 01 bis 12 durchnummeriert
    Try {
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
            Write-Output "Archivierungsstrukturskript ausgefuehrt!"
        }
    Catch {
            Write-Output "`n"
            Write-Output $_.Exception.Message -ForegroundColor Red
            Write-Output $_.ScriptStackTrace
    }
}

function Main {
    $flag = $false
    while ($true) {
        Write-Output "`n================== LA Skript ==================" -ForegroundColor Cyan
        Write-Output "1: 1 um das Versand und Archivierungs Skript auszufuehren"
        Write-Output "2: 2 um das Archivierungsstrukturskript auszufuehren"
        Write-Output "q: q um das Skript zu beenden."

        $user_input = (Read-Host "Bitte waehle: ").ToUpper()

        switch ($user_input)
        {
            '1' { VersandAndHistory }
            '2' {
                $validYear = $false
                $promptCount = 0
                $year = 0
                while (!$validYear -and $promptCount -lt 3)
                {
                    $year = (Read-Host "Please enter a year: ")
                    $dYear = $currentYear = (Get-Date).Year

                    # Check if the entered year is not in the past
                    if ($year -lt $dYear)
                    {
                        Write-Output "Please enter a year that is not in the past."
                    }
                    # Check if the entered year is a 4-digit year
                    elseif ($year.Length -cne 4)
                    {
                        Write-Output "Please enter a valid year, not $year, for example: $dyear, $($dyear + 1), ..."
                    }
                    else
                    {
                        $validYear = $true
                    }
                    $promptCount++
                }
                if ($validYear)
                {
                    NewHistoryDirectory $year
                }
                else
                {
                    Write-Output "You have exceeded the maximum number of attempts to enter a valid year."
                }
            }
            'q' {
                Write-Output "Das Skript wurde beendet" -BackgroundColor Red -ForegroundColor White
                $flag = $true
                break
            }
            Default {
                Write-Output "`nDeine Wahl $user_input, ist nicht gueltig. Bitte starte das Skript neu." -BackgroundColor Red -ForegroundColor White
                break
            }

        }
        if ($flag) {
            break;
        }
    }
}

Main