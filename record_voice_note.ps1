param(
    [Parameter(Mandatory = $true)]
    [string]$Date,

    [Parameter(Mandatory = $true)]
    [string]$Source,

    [string]$DurationMin = "",

    [string]$Topic = "",

    [string]$TranscriptLocation = "",

    [string]$ContextSummary = "",

    [string]$JudgmentSignal = "",

    [string]$RoutedTo = "",

    [string]$Status = "received",

    [string]$Notes = ""
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$csvPath = Join-Path $scriptDir "voice_inbox_queue.csv"

$row = [pscustomobject]@{
    date = $Date
    source = $Source
    duration_min = $DurationMin
    topic = $Topic
    transcript_location = $TranscriptLocation
    context_summary = $ContextSummary
    judgment_signal = $JudgmentSignal
    routed_to = $RoutedTo
    status = $Status
    notes = $Notes
}

if (-not (Test-Path $csvPath)) {
    $row | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
}
else {
    $csvLine = $row | ConvertTo-Csv -NoTypeInformation | Select-Object -Skip 1
    Add-Content -Path $csvPath -Value $csvLine -Encoding UTF8
}

Write-Output "Voice note logged: $Date / $Source ($Status)"
