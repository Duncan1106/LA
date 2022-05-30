## Functions behind the menu items
$ownPathAndName = & { $myInvocation.ScriptName }

Function VersandAndHistory {
    write-host "Do you want the original File deleted? y for deleting and n for keeping"
    $del = "false"
    $deleteoption = (Read-Host)
    if ($deleteoption -cmatch "y"){
        $del = "true"
        powershell.exe -ExecutionPolicy Unrestricted -Command ".\Versand2HistoryAndRL.ps1" "$del" "$ownPathAndName"
    }
    else {
        powershell.exe -ExecutionPolicy Unrestricted -Command ".\Versand2HistoryAndRL.ps1" "$del" "$ownPathAndName"
    }
}

Function NewHistoryDirectory {
    write-host "Please enter a year, for wich you want to create that folder"
    $year = (Read-Host "Input: ").ToUpper()
    powershell.exe -ExecutionPolicy Unrestricted -Command ".\newHistoryYear.ps1" "$year" "$ownPathAndName"
}

## visable Menu for user
Write-Host "~~~~~~~~~~~~~~~~~~ Menu Title ~~~~~~~~~~~~~~~~~~" -ForegroundColor Cyan
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