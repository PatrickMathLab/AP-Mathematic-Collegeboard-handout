$ErrorActionPreference = 'Stop'
$backupRoot = $PSScriptRoot
$manifest = Get-Content -LiteralPath (Join-Path $backupRoot 'BACKUP-SNAPSHOT.json') -Raw | ConvertFrom-Json
$archive = Join-Path $backupRoot 'project-before-html-format.zip'
$destination = Join-Path $backupRoot 'restored-project'
if ((Test-Path -LiteralPath $archive) -or (Test-Path -LiteralPath $destination)) { throw 'Restore output already exists; choose a clean download folder.' }
foreach ($part in $manifest.github_parts) {
    $partPath = Join-Path $backupRoot $part.path
    if (-not (Test-Path -LiteralPath $partPath)) { throw "Missing backup part: $($part.path)" }
    if ((Get-FileHash -LiteralPath $partPath -Algorithm SHA256).Hash.ToLower() -ne $part.sha256) { throw "Backup part checksum mismatch: $($part.path)" }
}
$outputStream = [IO.File]::Create($archive)
try {
    foreach ($part in ($manifest.github_parts | Sort-Object index)) {
        $inputStream = [IO.File]::OpenRead((Join-Path $backupRoot $part.path))
        try { $inputStream.CopyTo($outputStream) } finally { $inputStream.Dispose() }
    }
} finally { $outputStream.Dispose() }
if ((Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash.ToLower() -ne $manifest.archive_sha256) { throw 'Complete archive checksum mismatch.' }
Expand-Archive -LiteralPath $archive -DestinationPath $destination
foreach ($file in $manifest.files) {
    $filePath = Join-Path (Join-Path $destination 'AP-Calculus-AB-BC') $file.path
    if ((Get-FileHash -LiteralPath $filePath -Algorithm SHA256).Hash.ToLower() -ne $file.sha256) { throw "Restored file checksum mismatch: $($file.path)" }
}
Write-Host "Restored and verified $($manifest.file_count) project files in $destination"
