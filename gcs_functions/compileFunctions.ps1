$compileClientFileName = "gcs_compile_client.sqf"
$compileServerFileName = "gcs_compile_server.sqf"
$compileCfgClassHppName = "functions.hpp"
$fileToScanForExtension = "sqf"
$projectPrefix = "GCS"
$currentPath = $PSScriptRoot
$environment = Read-Host -Prompt "Please, select an environment ('dev' or 'prod')"

if ((Test-Path -Path $compileCfgClassHppName) -eq $true) { Remove-Item -Path $compileCfgClassHppName -Force }
if ((Test-Path -Path $compileClientFileName) -eq $true) { Remove-Item -Path $compileClientFileName -Force }
if ((Test-Path -Path $compileServerFileName) -eq $true) { Remove-Item -Path $compileServerFileName -Force }

$files = Get-ChildItem -Path $currentPath -Recurse -Filter "*.$fileToScanForExtension"
if ($files.Count -gt 0)
{
    New-Item -Path $PSScriptRoot -Name $compileClientFileName -ItemType File -Force
    New-Item -Path $PSScriptRoot -Name $compileServerFileName -ItemType File -Force
    New-Item -Path $PSScriptRoot -Name $compileCfgClassHppName -ItemType File -Force
    if ($environment -eq 'dev')
    {
        Write-Host ("Found {0} .{1} files. Will now analyse those files in order to populate our compile files." -f $files.Count, $fileToScanForExtension) -ForegroundColor Yellow

        Write-Host "Adding the compiled files..."
    
        "/*`n Compiling the client funtions.`n This file has been generated automatically.`n*/`n" | Add-Content -Path ($currentPath + "\" + $compileClientFileName)
        "/*`n Compiling the server funtions.`n This file has been generated automatically.`n*/`n" | Add-Content -Path ($currentPath + "\" + $compileServerFileName)

        foreach ($file in $files)
        {
            Write-Host ("Processing {0}..." -f $file.FullName) -ForegroundColor Gray

            $fileContent = Get-Content -ReadCount 0 -Path $file.FullName
            $isClient = $fileContent | Where { $_ -like '*Public: Y*' }
            $isServer = $fileContent | Where { $_ -like '*Public: N*' }

            $lineContent = '{0}_fnc{1} = compile preprocessFileLineNumbers "gcs_functions{2}";' -f $projectPrefix, $file.FullName.Replace($currentPath,"").Replace("\","_").Replace(".$fileToScanForExtension","").Replace("_fnc",""), $file.FullName.Replace($currentPath,"")

            if ($isClient -ne $null -and $isServer -ne $null)
            {
                Write-Host ("ERROR: The file: {0} has both the 'Public' parameter set to Y and N." -f $file.FullName)
            }
            elseif ($isClient -ne $null)
            {
                $lineContent | Add-Content -Path ($currentPath + "\" + $compileClientFileName)
            }
            else
            {
                $lineContent | Add-Content -Path ($currentPath + "\" + $compileServerFileName)
            }

        
            Write-Host ("Processing done." -f $file.FullName) -ForegroundColor Gray
        }

         Write-Host ("All {0} files has been processed successfully." -f $files.Count) -ForegroundColor Green
     }
     else
     {

        Write-Host ("Found {0} .{1} files. Will now analyse those files in order to populate our CfgFunctions class." -f $files.Count, $fileToScanForExtension) -ForegroundColor Yellow

        Write-Host "Adding the functions classes..."

        "/*`n Compiling the mission funtions.`n This file has been generated automatically.`n*/`n" | Add-Content -Path ($currentPath + "\" + $compileCfgClassHppName)
        "class CfgFunctions`n{`n    class $projectPrefix`n    {" | Add-Content -Path ($currentPath + "\" + $compileCfgClassHppName)

        $currentFolder = ""
        foreach ($file in $files)
        {
            Write-Host ("Processing: {0}..." -f $file.FullName) -ForegroundColor Gray
            if (([string]::IsNullOrEmpty($currentFolder) -eq $true) -or ($currentFolder -ne $file.Directory.FullName.Replace($currentPath,"").Substring(1, $file.Directory.FullName.Replace($currentPath,"").Length-1)))
            {
                # If it's not the first class, adds an enclosure statement for the previous class
                if ([string]::IsNullOrEmpty($currentFolder) -eq $false)
                {
                    "        };`n" | Add-Content -Path ($currentPath + "\" + $compileCfgClassHppName)
                }
                $currentFolder = $file.Directory.FullName.Replace($currentPath,"")
                $currentFolder = $currentFolder.Substring(1, $currentFolder.Length-1) # Removes the first "\"

                "        // $($currentFolder.Replace("\","_")) functions class`n        class $projectPrefix_$($currentFolder.Replace("\","_"))`n        {" | Add-Content -Path ($currentPath + "\" + $compileCfgClassHppName)

                Write-Host ("Processing new folder (functions category): {0}..." -f $currentFolder) -ForegroundColor White
            }

            $fileContent = Get-Content -ReadCount 0 -Path $file.FullName
            $functionComment = @()
            $tabs = "            "
            if ($fileContent[0] -eq "/`*")
            {
                for ($i=0;$i -lt $fileContent.Count;$i++)
                {
                    $functionComment += $tabs + $fileContent[$i]
                    if ($fileContent[$i] -like " `*/")
                    {

                        break;
                    }
                }
            }

            $functionComment | Add-Content -Path ($currentPath + "\" + $compileCfgClassHppName)
            "            class $($currentFolder.Replace("\","_"))_$($file.BaseName.Replace('fnc_',''))`n            {`n                file = ""gcs_functions\$($file.FullName.Replace($currentPath+'\',''))"";`n            };`n" | Add-Content -Path ($currentPath + "\" + $compileCfgClassHppName)

        
            Write-Host ("Processing done." -f $file.FullName) -ForegroundColor Gray
        }

        "        };`n    };`n};" | Add-Content -Path ($currentPath + "\" + $compileCfgClassHppName) # CfgFunctions enclosure bracket
     
	 
        Write-Host ("All {0} files has been processed successfully." -f $files.Count) -ForegroundColor Green
	 }
}
else
{
    Write-Host ("ERROR: No file where found in the following directory: {0}" -f $PSScriptRoot) -ForegroundColor Red
}

Pause