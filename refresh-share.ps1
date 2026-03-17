$ErrorActionPreference = 'Stop'

$workspace = 'C:\Users\USER\.openclaw\workspace'
$sourceApp = Join-Path $workspace 'apps\personal-ledger'
$shareApp = Join-Path $workspace 'apps\personal-ledger-share'

New-Item -ItemType Directory -Force -Path $shareApp | Out-Null

# 1) 同步页面结构和数据
Copy-Item (Join-Path $sourceApp 'index.html') (Join-Path $shareApp 'index.html') -Force
Copy-Item (Join-Path $sourceApp 'ledger-data.js') (Join-Path $shareApp 'ledger-data.js') -Force

# 2) 自动提交并推送到 GitHub（如果有变更）
Push-Location $shareApp
try {
  git add . | Out-Null
  $status = git status --porcelain
  if ($status) {
    $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    git commit -m "Auto refresh ledger share $stamp" | Out-Null
    git push origin main | Out-Null
    Write-Output 'ledger share refresh done + pushed'
  } else {
    Write-Output 'ledger share refresh done (no changes)'
  }
  Write-Output $shareApp
}
finally {
  Pop-Location
}
