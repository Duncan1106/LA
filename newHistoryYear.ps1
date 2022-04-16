$Directory = "./LA\history"

$year = Read-Host -Prompt 'Input the year to create a new history directory for this year'

$dYear= (Get-Date).AddMonths(-1).ToString("yyyy")

if ($year -le $dYear) {
    echo "please enter a year that is in the future, the present and the past years allready exist"
    pause
    exit
}

if($year.Length -cgt 4) {
    echo "please enter a valid year with is not $year, example is: 2021, 2022, ..."
    pause
    exit

}



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
