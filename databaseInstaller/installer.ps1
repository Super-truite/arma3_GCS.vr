# Variables definitions
$mysqlConnStr = "Server={0};Uid={1};Pwd={2}"
$sqlQueriesFilesPath = ("{0}\queries\" -f (Get-Location).Path)
$sqlQueriesFiles = @()

# Loads the MySQL .NET Connector
try {
    [void][system.reflection.Assembly]::LoadWithPartialName("MySql.Data")
} catch {
    Write-Error -Message $_
	pause
	exit -99
}


$mysqlServerIp = Read-Host "MySQL Server ip (can be localhost)"
$mysqlUsername = Read-Host "MySQL username"
$mysqlPassword = Read-Host "MySQL password"


try {
    $mysqlConn = New-Object MySql.Data.MySqlClient.MySqlConnection(($mysqlConnStr -f ($mysqlServerIp, $mysqlUsername, $mysqlPassword)))
    $mysqlConn.Open()
    
    $cmd = New-Object MySql.Data.MySqlClient.MySqlCommand
    $cmd.Connection  = $mysqlConn
} catch {
    Write-Error $_
	pause
	exit 0
} finally {
    if ($mysqlConn -eq $null -or $mysqlConn.State -ne 'Open')
    {
        Write-Error "Unable to connect to the given MySQL server."
		pause
		exit 0
    }
}

if (-not (Test-Path -Path $sqlQueriesFilesPath))
{
    Write-Error ("Unable to retrieve the queries from the following directory: {0} does this directory exists?." -f $sqlQueriesFilesPath)
} else {
    $sqlQueriesFiles = Get-ChildItem -Path $sqlQueriesFilesPath -Force | Sort-Object -Property 'Fullname'
    if ($sqlQueriesFiles.Count -eq 0)
    {
        Write-Error ("Unable to retrieve the queries from the following directory: {0} does this directory has the multiple queries files in it?." -f $sqlQueriesFilesPath)
		pause
		exit -1
    }
}


foreach ($queryFile in $sqlQueriesFiles)
{
    try
    {
        $cmd.CommandText = Get-Content -ReadCount 0 -Path $queryFile.Fullname -Force
        [void]$cmd.ExecuteNonQuery()
    } catch {
        Write-Error ("An error has occurred with the following query: {0} - {1}" -f ($queryFile.Basename, $_))
		pause
		exit -2
    }
}


Write-Host -ForegroundColor Green "Database installed and configured successfully!"
pause;