# PowerShell script to load environment variables from .env file

# Check if .env file exists
if (Test-Path ".env") {
    Write-Host "Loading environment variables from .env file..." -ForegroundColor Green
    
    # Read .env file and set environment variables
    Get-Content ".env" | ForEach-Object {
        if ($_ -match "^([^#].+?)=(.+)$") {
            $name = $matches[1].Trim()
            $value = $matches[2].Trim()
            
            # Remove quotes if present
            $value = $value -replace '^"(.*)"$', '$1'
            
            # Set environment variable
            [Environment]::SetEnvironmentVariable($name, $value, "Process")
            Write-Host "Set $name" -ForegroundColor Yellow
        }
    }
    
    Write-Host "Environment variables loaded successfully!" -ForegroundColor Green
} else {
    Write-Host "Error: .env file not found!" -ForegroundColor Red
    Write-Host "Please create a .env file based on .env.example" -ForegroundColor Yellow
}

# Display current ANTHROPIC_API_KEY (masked for security)
$apiKey = [Environment]::GetEnvironmentVariable("ANTHROPIC_API_KEY", "Process")
if ($apiKey) {
    $maskedKey = $apiKey.Substring(0, [Math]::Min(10, $apiKey.Length)) + "..."
    Write-Host "ANTHROPIC_API_KEY: $maskedKey" -ForegroundColor Cyan
} else {
    Write-Host "ANTHROPIC_API_KEY: Not set" -ForegroundColor Red
}