
# LA Optimizations Scripts

some scripts and script ideas for automations




## Features

- Simple GUI in PowerShell
    - "Versand und Archivierungsscript"  
    - "Achrivierungsordnerstrukturgeneratorscript"
    - quit option

- "Versand und Archivierungsscript"
    - user prompt for deletion of original file
    - file gets copied to specifiedd loactions and gets renamed accordingly
    - archive original file to year/month structure

- "Archivierungsordnerstrukturgeneratorscript"
    - user promt to get the year to create the year/month structure
    - checks if the year user inputed is in the future or the current year
## Change Following according to your needs

```bash
    line 17: $Directory = ".\Versand\FTP\"

    line 18: $RLDir =".\RL\Einnahmen\"
    
    line 23: $historyDir = ".\history\$year\$month\" 

    line 57: $Directory = ".\history"
```
    
## Optimizations

try and catch errors for easy user debug and StackTree output if error accoured

## Badges
![GitHub language count](https://img.shields.io/github/languages/count/Duncan1106/LA?color=lime&label=languages&logo=gray)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/Duncan1106/LA)
![GitHub Repo stars](https://img.shields.io/github/stars/Duncan1106/LA?style=plastic)

## Security

[![PSScriptAnalyzer](https://github.com/Duncan1106/LA/actions/workflows/powershell.yml/badge.svg)](https://github.com/Duncan1106/LA/actions/workflows/powershell.yml)
[![Codacy Security Scan](https://github.com/Duncan1106/LA/actions/workflows/codacy.yml/badge.svg)](https://github.com/Duncan1106/LA/actions/workflows/codacy.yml)
