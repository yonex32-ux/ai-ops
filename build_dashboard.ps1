<#
.SYNOPSIS
  activity_log.csv と effect_log.csv を読み込み、AI社員 監視ダッシュボード(HTML)を生成する。

.DESCRIPTION
  dashboard_template.html のプレースホルダにデータを埋め込み、
  ai_monitor_dashboard.html を出力する。依存ライブラリなしで、生成したHTMLは
  ダブルクリックで開ける。

.EXAMPLE
  .\build_dashboard.ps1
  .\build_dashboard.ps1 -Open   # 生成後に既定ブラウザで開く
#>
param(
    [switch]$Open
)

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$activityCsv = Join-Path $scriptDir "activity_log.csv"
$effectCsv   = Join-Path $scriptDir "effect_log.csv"
$template    = Join-Path $scriptDir "dashboard_template.html"
$outPath     = Join-Path $scriptDir "ai_monitor_dashboard.html"

if (-not (Test-Path $template)) { throw "dashboard_template.html が見つかりません" }

function Read-CsvSafe($path) {
    if (Test-Path $path) { return @(Import-Csv -Path $path) }
    return @()
}

$activities = Read-CsvSafe $activityCsv
$effects    = Read-CsvSafe $effectCsv

# 1件でも配列としてシリアライズされるように -AsArray を使う(PS7+)。
# PS5.1 互換のため、件数で分岐する。
function To-JsonArray($rows) {
    if ($rows.Count -eq 0) { return "[]" }
    $json = $rows | ConvertTo-Json -Depth 5
    if ($rows.Count -eq 1) { $json = "[$json]" }  # 単一要素はオブジェクトになるため配列化
    return $json
}

$activitiesJson = To-JsonArray $activities
$effectsJson    = To-JsonArray $effects
$generated      = Get-Date -Format "yyyy-MM-dd HH:mm"

$html = Get-Content -Path $template -Raw -Encoding UTF8
$html = $html.Replace("/*__ACTIVITIES__*/[]", $activitiesJson)
$html = $html.Replace("/*__EFFECTS__*/[]", $effectsJson)
$html = $html.Replace("__GENERATED__", $generated)

# BOMなしUTF-8で書き出す
[System.IO.File]::WriteAllText($outPath, $html, (New-Object System.Text.UTF8Encoding($false)))

Write-Output "ダッシュボードを生成しました: $outPath"
Write-Output "稼働イベント: $($activities.Count) 件 / 効果ログ: $($effects.Count) 件"

if ($Open) {
    Start-Process $outPath
}
