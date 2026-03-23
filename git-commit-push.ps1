# סקריפט לקומיט ופוש - אתר ללימוד בינה מלאכותית AI
# שימוש: .\git-commit-push.ps1
# או עם הודעה: .\git-commit-push.ps1 "ההודעה שלך"

$msg = $args[0]
if (-not $msg) {
    $msg = "עדכון אתר - " + (Get-Date -Format "yyyy-MM-dd HH:mm")
}

Set-Location $PSScriptRoot
git add -A
git status
$confirm = Read-Host "לבצע קומיט עם ההודעה:`n  $msg`nהמשך? (y/n)"
if ($confirm -eq "y" -or $confirm -eq "Y") {
    git commit -m $msg
    git push
    Write-Host "בוצע." -ForegroundColor Green
} else {
    Write-Host "בוטל." -ForegroundColor Yellow
}
