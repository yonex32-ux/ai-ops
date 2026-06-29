param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("返信担当", "仕分け担当", "会議担当", "立ち上げ担当", "申請担当")]
    [string]$Employee,

    [Parameter(Mandatory = $true)]
    [ValidateSet("reply-triage", "file-intake", "meeting-prep-followup", "new-project-kickoff", "budget-outsourcing-draft")]
    [string]$Workflow,

    [Parameter(Mandatory = $true)]
    [ValidateSet("稼働中", "確認待ち", "待機", "完了")]
    [string]$Status,

    [Parameter(Mandatory = $true)]
    [string]$Task,

    [string]$Detail = "",

    # 既定では現在時刻を使う。再現用に明示指定も可能。
    [string]$Timestamp = (Get-Date -Format "yyyy-MM-dd HH:mm")
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$csvPath = Join-Path $scriptDir "activity_log.csv"

$row = [pscustomobject]@{
    timestamp = $Timestamp
    employee  = $Employee
    workflow  = $Workflow
    status    = $Status
    task      = $Task
    detail    = $Detail
}

if (-not (Test-Path $csvPath)) {
    $row | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
}
else {
    $row | Export-Csv -Path $csvPath -Append -NoTypeInformation -Encoding UTF8
}

Write-Output "稼働イベントを記録しました: [$Employee] $Status - $Task"
Write-Output "ダッシュボードを更新するには .\build_dashboard.ps1 を実行してください。"
