param(
    [Parameter(Mandatory = $true)]
    [string]$Date,

    [Parameter(Mandatory = $true)]
    [string]$TaskType,

    [Parameter(Mandatory = $true)]
    [string]$TaskName,

    [Parameter(Mandatory = $true)]
    [int]$EstimatedManualMinutes,

    [Parameter(Mandatory = $true)]
    [int]$ActualMinutes,

    [Parameter(Mandatory = $true)]
    [ValidateRange(1, 5)]
    [int]$QualityScore,

    [Parameter(Mandatory = $true)]
    [string]$MistakePrevented,

    [Parameter(Mandatory = $true)]
    [string]$Workflow,

    [Parameter(Mandatory = $true)]
    [string]$PluginsUsed,

    [string]$Notes = ""
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$csvPath = Join-Path $scriptDir "effect_log.csv"

$minutesSaved = $EstimatedManualMinutes - $ActualMinutes

$mistakePreventedNormalized = switch ($MistakePrevented.ToLower()) {
    "true" { $true; break }
    "false" { $false; break }
    "1" { $true; break }
    "0" { $false; break }
    default { throw "MistakePrevented must be one of: true, false, 1, 0" }
}

$row = [pscustomobject]@{
    date = $Date
    task_type = $TaskType
    task_name = $TaskName
    estimated_manual_minutes = $EstimatedManualMinutes
    actual_minutes = $ActualMinutes
    minutes_saved = $minutesSaved
    quality_score = $QualityScore
    mistake_prevented = $mistakePreventedNormalized
    workflow = $Workflow
    plugins_used = $PluginsUsed
    notes = $Notes
}

$row | Export-Csv -Path $csvPath -Append -NoTypeInformation -Encoding UTF8

Write-Output "Recorded: $TaskName"
Write-Output "Minutes saved: $minutesSaved"
