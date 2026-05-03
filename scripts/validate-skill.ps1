Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
$skillPath = Join-Path $root "SKILL.md"

if (-not (Test-Path -LiteralPath $skillPath)) {
  throw "Missing SKILL.md"
}

$skill = Get-Content -Raw -LiteralPath $skillPath

$frontmatterMatch = [regex]::Match($skill, "(?s)^---\s*(.*?)\s*---")
if (-not $frontmatterMatch.Success) {
  throw "Missing YAML frontmatter"
}

$frontmatter = $frontmatterMatch.Groups[1].Value
$frontmatterLines = $frontmatter -split "\r?\n" | Where-Object { $_.Trim().Length -gt 0 }
if ($frontmatterLines.Count -ne 2) {
  throw "SKILL.md frontmatter must contain exactly name and description fields"
}

$expectedNameLine = "name: remotion-marketing-video"
if (($frontmatterLines[0]).Trim() -ne $expectedNameLine) {
  throw "Expected first frontmatter field: $expectedNameLine"
}

$nameMatch = [regex]::Match($frontmatter, "(?m)^name:\s*([a-z0-9](?:[a-z0-9-]{0,62}[a-z0-9])?)\s*$")
if (-not $nameMatch.Success) {
  throw "Skill name must use lowercase letters, numbers, and hyphens, and be <=64 characters"
}

if ($nameMatch.Groups[1].Value -match "--") {
  throw "Skill name must not contain consecutive hyphens"
}

$descriptionMatch = [regex]::Match($frontmatter, "(?ms)^description:\s*(.+?)(?:\r?\n[a-zA-Z0-9_-]+:|\z)")
if (-not $descriptionMatch.Success) {
  throw "Missing description in frontmatter"
}

$description = $descriptionMatch.Groups[1].Value.Trim()
if ($description.StartsWith('"') -and $description.EndsWith('"')) {
  $description = $description.Substring(1, $description.Length - 2)
}

if ([string]::IsNullOrWhiteSpace($description)) {
  throw "Description must be non-empty"
}

if ($description.Length -gt 1024) {
  throw "Description is too long ($($description.Length) chars). Keep it <=1024 for Agent Skills spec compatibility."
}

$wordCount = ([regex]::Matches($skill, "\b[\w'-]+\b")).Count
if ($wordCount -gt 2500) {
  throw "SKILL.md is too large ($wordCount words). Move details to references/."
}

$allSkillFiles = @(Get-ChildItem -LiteralPath $root -Recurse -Filter "SKILL.md" -File | Where-Object { $_.FullName -notmatch "\\.git\\" })
if ($allSkillFiles.Count -ne 1) {
  $list = ($allSkillFiles | ForEach-Object { $_.FullName }) -join [Environment]::NewLine
  throw "Expected exactly one SKILL.md at repository root. Found:$([Environment]::NewLine)$list"
}

if ((Resolve-Path -LiteralPath $allSkillFiles[0].FullName).Path -ne (Resolve-Path -LiteralPath $skillPath).Path) {
  throw "The only SKILL.md must be at repository root"
}

$badCharCodes = @(0x00E2, 0x00F0, 0x0178, 0x0153, 0x20AC)
$textFiles = Get-ChildItem -LiteralPath $root -Recurse -File |
  Where-Object { $_.FullName -notmatch "\\.git\\" -and $_.Extension.ToLowerInvariant() -in @(".md", ".ps1") }

foreach ($file in $textFiles) {
  $content = Get-Content -Raw -LiteralPath $file.FullName
  foreach ($charCode in $badCharCodes) {
    if ($content.Contains([char]$charCode)) {
      throw "Mojibake character found in $($file.FullName)"
    }
  }
  $placeholderMarker = "TO" + "DO"
  if ($content -match $placeholderMarker) {
    throw "Unfinished placeholder marker found in $($file.FullName)"
  }
}

$mediaExtensions = @(
  ".png", ".jpg", ".jpeg", ".gif", ".webp", ".svg",
  ".mp3", ".wav", ".aac", ".m4a", ".flac",
  ".mp4", ".mov", ".webm", ".mkv",
  ".ttf", ".otf", ".woff", ".woff2", ".riv", ".lottie"
)

$mediaFiles = @(
  Get-ChildItem -LiteralPath $root -Recurse -File |
    Where-Object { $_.FullName -notmatch "\\.git\\" -and $mediaExtensions -contains $_.Extension.ToLowerInvariant() }
)

if ($mediaFiles.Count -gt 0) {
  $list = ($mediaFiles | ForEach-Object { $_.FullName }) -join [Environment]::NewLine
  throw "Bundled media/assets are not allowed in this skill:$([Environment]::NewLine)$list"
}

$referenceMatches = [regex]::Matches($skill, "references/[A-Za-z0-9_.-]+\.md")
$missing = New-Object System.Collections.Generic.List[string]
foreach ($match in $referenceMatches) {
  $path = Join-Path $root ($match.Value -replace "/", [IO.Path]::DirectorySeparatorChar)
  if (-not (Test-Path -LiteralPath $path)) {
    $missing.Add($match.Value)
  }
}

if ($missing.Count -gt 0) {
  $missingList = [string]::Join(", ", $missing)
  throw "Missing referenced files: $missingList"
}

if (Test-Path -LiteralPath (Join-Path $root "assets")) {
  throw "assets/ directory is not allowed for this no-bundled-media skill"
}

Write-Host "Skill validation passed."
Write-Host "SKILL.md words: $wordCount"
Write-Host "Referenced files checked: $($referenceMatches.Count)"
