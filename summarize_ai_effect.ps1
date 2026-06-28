$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$csvPath = Join-Path $scriptDir "effect_log.csv"

if (-not (Test-Path $csvPath)) {
    Write-Error "effect_log.csv not found"
    exit 1
}

$rows = @(Import-Csv -Path $csvPath)

if ($rows.Count -eq 0) {
    Write-Output "No effect data recorded yet."
    exit 0
}

$taskCount = $rows.Count
$estimatedTotal = ($rows | Measure-Object -Property estimated_manual_minutes -Sum).Sum
$actualTotal = ($rows | Measure-Object -Property actual_minutes -Sum).Sum
$savedTotal = ($rows | Measure-Object -Property minutes_saved -Sum).Sum
$avgSaved = [math]::Round(($savedTotal / $taskCount), 1)
$qualityImproved = @(($rows | Where-Object { [int]$_.quality_score -ge 4 })).Count
$mistakesPrevented = @(($rows | Where-Object { $_.mistake_prevented -eq "True" })).Count

$workflowSummary = $rows |
    Group-Object workflow |
    Sort-Object Count -Descending |
    Select-Object Name, Count

Write-Output "AI Effect Summary"
Write-Output "Tasks logged: $taskCount"
Write-Output "Estimated manual minutes: $estimatedTotal"
Write-Output "Actual minutes: $actualTotal"
Write-Output "Total minutes saved: $savedTotal"
Write-Output "Average minutes saved per task: $avgSaved"
Write-Output "Quality-improved tasks (score >= 4): $qualityImproved"
Write-Output "Mistake-prevented tasks: $mistakesPrevented"
Write-Output ""
Write-Output "Workflow frequency"
$workflowSummary | Format-Table -AutoSize
