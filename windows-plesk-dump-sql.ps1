# Configurações
$BackupDir = "C:\backup_bancos"
$MySQLUser = "admin"
$MySQLPassword = "<YOUR-PASSWORD-SQL-PLESK>"
$MySQLPort = 3306
$MySQLPath = "C:\Program Files (x86)\Plesk\MySQL\bin"
$FilePath = "lista.txt"
$WaitSeconds = 10

# Criar diretório de backup, se não existir
if (-Not (Test-Path -Path $BackupDir)) {
    New-Item -ItemType Directory -Path $BackupDir | Out-Null
}

# Verificar se o arquivo de bancos existe
if (-Not (Test-Path -Path $FilePath)) {
    Write-Host "ERRO: O arquivo $FilePath nao foi encontrado!" -ForegroundColor Red
    Pause
    Exit
}

# Ler cada linha do arquivo e executar o mysqldump
Get-Content $FilePath | ForEach-Object {
    $DbName = $_.Trim()

    # Verificar se o nome do banco não está vazio
    if ($DbName -ne "") {
        Write-Host "Exportando banco de dados: $DbName"

        # Construir o comando mysqldump
        $DumpCommand = """$MySQLPath\mysqldump"" -u$MySQLUser -p`"$MySQLPassword`" -P$MySQLPort $DbName > `"$BackupDir\$DbName.sql`""

        # Executar o comando
        cmd.exe /c $DumpCommand

        # Verificar o código de saída
        if ($LASTEXITCODE -ne 0) {
            Write-Host "ERRO ao exportar o banco de dados: $DbName" -ForegroundColor Red
        } else {
            Write-Host "Sucesso ao exportar o banco: $DbName" -ForegroundColor Green
        }

        # Aguardar antes de continuar
        Write-Host "Aguardando $WaitSeconds segundos antes de continuar..."
        Start-Sleep -Seconds $WaitSeconds
    }
}

Write-Host "Exportação concluída. Backups salvos em $BackupDir." -ForegroundColor Green
Pause
