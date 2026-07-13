# Cloudflare Worker & D1 Database Step-by-Step Auto Deployer for Windows
# Run this script in PowerShell to deploy your backend.

$ErrorActionPreference = "Stop"
Clear-Host

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "   Hua Lian High School Report System - Cloudflare Deploy" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""

# 1. Check Node.js
Write-Host "[1/6] Checking Node.js environment..." -ForegroundColor Yellow
try {
    $nodeVersion = node -v
    Write-Host "-> Node.js is installed: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: Node.js is not found!" -ForegroundColor Red
    Write-Host "Please download and install Node.js from:" -ForegroundColor Yellow
    Write-Host "Link: https://nodejs.org/" -ForegroundColor Blue
    Write-Host "After installation, reopen this PowerShell window and run again." -ForegroundColor Yellow
    Read-Host "Press Enter to exit..."
    exit 1
}

# 2. Check/Install Wrangler
Write-Host ""
Write-Host "[2/6] Checking Cloudflare Wrangler installation..." -ForegroundColor Yellow
try {
    & npx wrangler --version | Out-Null
    Write-Host "-> Wrangler is ready." -ForegroundColor Green
} catch {
    Write-Host "Installing wrangler globally..." -ForegroundColor Yellow
    npm install -g wrangler
    Write-Host "-> Wrangler installed successfully." -ForegroundColor Green
}

# 3. Cloudflare Login
Write-Host ""
Write-Host "[3/6] Authenticating with Cloudflare..." -ForegroundColor Yellow
Write-Host "Note: A browser window will open automatically. Please login and click 'Allow'." -ForegroundColor DarkGray
& npx wrangler login

# 4. Check or Create D1 Database
Write-Host ""
Write-Host "[4/6] Setting up D1 database..." -ForegroundColor Yellow

$dbName = "hualian-reports-db"
$dbId = ""

# Read wrangler.json
$wranglerJsonPath = Join-Path $PSScriptRoot "..\wrangler.json"
if (-not (Test-Path $wranglerJsonPath)) {
    Write-Host "Error: wrangler.json not found in project root!" -ForegroundColor Red
    Read-Host "Press Enter to exit..."
    exit 1
}

$wranglerConfig = Get-Content $wranglerJsonPath -Raw | ConvertFrom-Json
$currentDbId = $wranglerConfig.d1_databases[0].database_id

if ($currentDbId -eq "YOUR_D1_DATABASE_ID_HERE" -or [string]::IsNullOrEmpty($currentDbId)) {
    Write-Host "Creating new Cloudflare D1 database: $dbName..." -ForegroundColor Cyan
    $createOutput = & npx wrangler d1 create $dbName
    Write-Host $createOutput
    
    # Extract database_id
    if ($createOutput -match "database_id = `"([^`"]+)`"") {
        $dbId = $Matches[1]
    } elseif ($createOutput -match "database_id\s*:\s*'([^']+)'") {
        $dbId = $Matches[1]
    } elseif ($createOutput -match "database_id = '([^']+)'") {
        $dbId = $Matches[1]
    } else {
        Write-Host "Failed to parse database_id automatically." -ForegroundColor Yellow
        Write-Host "Please look at the console output above, copy the 'database_id', and paste it here." -ForegroundColor Yellow
        $dbId = Read-Host "Enter your Cloudflare D1 database_id"
    }
    
    if (-not [string]::IsNullOrEmpty($dbId)) {
        # Update wrangler.json
        $wranglerConfig.d1_databases[0].database_id = $dbId
        $wranglerConfig | ConvertTo-Json -Depth 10 | Out-File $wranglerJsonPath -Encoding utf8
        Write-Host "-> Updated wrangler.json with database_id: $dbId" -ForegroundColor Green
    }
} else {
    Write-Host "-> Database ID is already configured in wrangler.json: $currentDbId" -ForegroundColor Green
    $dbId = $currentDbId
}

# 5. Initialize/Update database schemas & seed data
Write-Host ""
Write-Host "[5/6] Syncing database schema and importing student comments..." -ForegroundColor Yellow

# Executing schema migration
Write-Host "-> Creating database tables..." -ForegroundColor Cyan
& npx wrangler d1 execute $dbName --file=migrations/0001_schema.sql --yes

# Executing seed
Write-Host "-> Importing student list and teacher accounts..." -ForegroundColor Cyan
& npx wrangler d1 execute $dbName --file=scripts/0002_seed.sql --yes

# Executing J2L comments import
Write-Host "-> Importing Word comments for all J2L subjects..." -ForegroundColor Cyan
& npx wrangler d1 execute $dbName --file=scripts/0003_import_comments.sql --yes

Write-Host "-> Database sync completed successfully!" -ForegroundColor Green

# 6. Deploy worker
Write-Host ""
Write-Host "[6/6] Deploying Cloudflare Worker API..." -ForegroundColor Yellow
$deployOutput = & npx wrangler deploy
Write-Host $deployOutput

Write-Host ""
Write-Host "========================================================" -ForegroundColor Green
Write-Host "🎉 Backend Worker deployed successfully to Cloudflare!" -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Please copy the deployed Worker URL from the output above, e.g.:" -ForegroundColor Yellow
Write-Host "https://hualian-reports-worker.<username>.workers.dev" -ForegroundColor Cyan
Write-Host ""
Write-Host "Paste it into the first lines of 'frontend/js/auth.js' to connect." -ForegroundColor Yellow
Write-Host ""
Read-Host "Press Enter to exit..."
