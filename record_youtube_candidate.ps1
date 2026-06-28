param(
    [Parameter(Mandatory = $true)]
    [string]$Date,

    [Parameter(Mandatory = $true)]
    [string]$Topic,

    [Parameter(Mandatory = $true)]
    [string]$VideoTitle,

    [Parameter(Mandatory = $true)]
    [string]$Url,

    [Parameter(Mandatory = $true)]
    [string]$WhyWatch,

    [string]$Status = "queued",

    [string]$NotebookTarget = "",

    [string]$Notes = ""
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$csvPath = Join-Path $scriptDir "youtube_learning_queue.csv"

$row = [pscustomobject]@{
    date = $Date
    topic = $Topic
    video_title = $VideoTitle
    url = $Url
    why_watch = $WhyWatch
    status = $Status
    notebook_target = $NotebookTarget
    notes = $Notes
}

if (-not (Test-Path $csvPath)) {
    $row | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
}
else {
    $csvLine = $row | ConvertTo-Csv -NoTypeInformation | Select-Object -Skip 1
    Add-Content -Path $csvPath -Value $csvLine -Encoding UTF8
}

Write-Output "Queued: $VideoTitle"
