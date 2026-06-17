param(
  [int]$Start = 183,
  [int]$Count = 101
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$cssPath = Join-Path $repoRoot "frontend\src\index.css"
$css = Get-Content -Path $cssPath -Raw

$upgrades = @(
  @{ Title = "safer container clipping"; Css = ".container, .container-fluid { min-width: 0; }" },
  @{ Title = "balanced row overflow"; Css = ".row { min-width: 0; }" },
  @{ Title = "stable column wrapping"; Css = "[class*='col'] { min-width: 0; }" },
  @{ Title = "clean card action spacing"; Css = ".card .btn-toolbar { gap: 0.35rem; }" },
  @{ Title = "quiet empty cards"; Css = ".card:empty { display: none; }" },
  @{ Title = "dashboard stat numerals"; Css = ".dashboard-card .display-6, .dashboard-card .h3 { font-variant-numeric: tabular-nums; }" },
  @{ Title = "complaint id readability"; Css = ".complaint-id, [data-complaint-id] { font-variant-numeric: tabular-nums; letter-spacing: 0; }" },
  @{ Title = "tracking code wrapping"; Css = ".tracking-code, [data-tracking-code] { overflow-wrap: anywhere; }" },
  @{ Title = "timeline item anchoring"; Css = ".timeline-item { position: relative; }" },
  @{ Title = "timeline text wrapping"; Css = ".timeline-item, .timeline-content { overflow-wrap: anywhere; }" },
  @{ Title = "status chip alignment"; Css = ".status-badge, .priority-badge { display: inline-flex; align-items: center; gap: 0.25rem; }" },
  @{ Title = "status chip no shrink"; Css = ".status-badge, .priority-badge { flex-shrink: 0; }" },
  @{ Title = "admin action wrap"; Css = ".admin-actions, .table-actions { display: flex; flex-wrap: wrap; gap: 0.35rem; }" },
  @{ Title = "officer action wrap"; Css = ".officer-actions { display: flex; flex-wrap: wrap; gap: 0.35rem; }" },
  @{ Title = "profile field wrapping"; Css = ".profile-field, .profile-value { overflow-wrap: anywhere; }" },
  @{ Title = "contact line wrapping"; Css = ".contact-info, .contact-link { overflow-wrap: anywhere; }" },
  @{ Title = "service tile stability"; Css = ".service-card { min-height: 100%; }" },
  @{ Title = "service icon sizing"; Css = ".service-card svg { flex-shrink: 0; }" },
  @{ Title = "hero action rhythm"; Css = ".hero-actions { display: flex; flex-wrap: wrap; gap: 0.75rem; }" },
  @{ Title = "hero text balance"; Css = ".hero-section h1, .hero-title { text-wrap: balance; }" },
  @{ Title = "section title balance"; Css = ".section-title, section h2 { text-wrap: balance; }" },
  @{ Title = "lead copy measure"; Css = ".lead { max-width: 68ch; }" },
  @{ Title = "paragraph measure"; Css = "p { text-wrap: pretty; }" },
  @{ Title = "ordered list rhythm"; Css = "ol > li + li { margin-top: 0.35rem; }" },
  @{ Title = "unordered list rhythm"; Css = "ul > li + li { margin-top: 0.25rem; }" },
  @{ Title = "nested list spacing"; Css = "li > ul, li > ol { margin-top: 0.25rem; }" },
  @{ Title = "definition term rhythm"; Css = "dt + dd { margin-top: 0.15rem; }" },
  @{ Title = "muted text contrast"; Css = ".text-muted { color: #64748b !important; }" },
  @{ Title = "secondary text contrast"; Css = ".text-secondary { color: #475569 !important; }" },
  @{ Title = "small text readability"; Css = "small, .small { line-height: 1.45; }" },
  @{ Title = "strong text weight"; Css = "strong, b { font-weight: 700; }" },
  @{ Title = "link underline offset"; Css = "a { text-underline-offset: 0.18em; }" },
  @{ Title = "hover link clarity"; Css = "a:hover { text-decoration-thickness: 0.08em; }" },
  @{ Title = "button disabled opacity"; Css = ".btn:disabled, .btn.disabled { opacity: 0.68; }" },
  @{ Title = "button text wrapping"; Css = ".btn { white-space: normal; }" },
  @{ Title = "icon button square"; Css = ".btn-icon { width: 40px; height: 40px; padding: 0; display: inline-grid; place-items: center; }" },
  @{ Title = "small icon button square"; Css = ".btn-icon.btn-sm { width: 34px; height: 34px; }" },
  @{ Title = "large icon button square"; Css = ".btn-icon.btn-lg { width: 46px; height: 46px; }" },
  @{ Title = "link button alignment"; Css = ".btn-link { display: inline-flex; align-items: center; gap: 0.25rem; }" },
  @{ Title = "outline button contrast"; Css = ".btn-outline-secondary { color: #334155; border-color: #94a3b8; }" },
  @{ Title = "primary button shadow restraint"; Css = ".btn-primary { box-shadow: none; }" },
  @{ Title = "danger button contrast"; Css = ".btn-danger { color: #ffffff; }" },
  @{ Title = "warning button contrast"; Css = ".btn-warning { color: #1f2937; }" },
  @{ Title = "success button contrast"; Css = ".btn-success { color: #ffffff; }" },
  @{ Title = "input placeholder contrast"; Css = ".form-control::placeholder { color: #64748b; opacity: 1; }" },
  @{ Title = "textarea resize safety"; Css = "textarea.form-control { resize: vertical; min-height: 112px; }" },
  @{ Title = "select min width"; Css = ".form-select { min-width: 0; }" },
  @{ Title = "input numeric rhythm"; Css = ".form-control { font-variant-numeric: normal; }" },
  @{ Title = "invalid field focus"; Css = ".form-control.is-invalid:focus, .form-select.is-invalid:focus { box-shadow: 0 0 0 0.2rem rgba(220, 38, 38, 0.2); }" },
  @{ Title = "valid field focus"; Css = ".form-control.is-valid:focus, .form-select.is-valid:focus { box-shadow: 0 0 0 0.2rem rgba(22, 163, 74, 0.2); }" },
  @{ Title = "form section spacing"; Css = ".form-section + .form-section { margin-top: 1.25rem; }" },
  @{ Title = "filter bar spacing"; Css = ".filter-bar { display: flex; flex-wrap: wrap; gap: 0.75rem; align-items: end; }" },
  @{ Title = "filter item sizing"; Css = ".filter-bar > * { min-width: min(220px, 100%); }" },
  @{ Title = "search field rhythm"; Css = ".search-field { min-width: min(280px, 100%); }" },
  @{ Title = "table header stickiness"; Css = ".table-sticky thead th { position: sticky; top: 0; z-index: 2; }" },
  @{ Title = "table hover readability"; Css = ".table-hover tbody tr:hover > * { background-color: #f8fafc; }" },
  @{ Title = "table compact buttons"; Css = ".table .btn-sm { white-space: nowrap; }" },
  @{ Title = "responsive table border"; Css = ".table-responsive { border-radius: 6px; }" },
  @{ Title = "responsive table scroll"; Css = ".table-responsive { scrollbar-gutter: stable; }" },
  @{ Title = "card grid alignment"; Css = ".card-grid { align-items: stretch; }" },
  @{ Title = "card body flex"; Css = ".card-body.d-flex { min-height: 0; }" },
  @{ Title = "card action footer"; Css = ".card-actions { display: flex; flex-wrap: wrap; gap: 0.5rem; margin-top: auto; }" },
  @{ Title = "metric card numerals"; Css = ".metric-value { font-variant-numeric: tabular-nums; }" },
  @{ Title = "metric label wrapping"; Css = ".metric-label { overflow-wrap: anywhere; }" },
  @{ Title = "chart container sizing"; Css = ".chart-container { min-width: 0; width: 100%; }" },
  @{ Title = "chart tooltip wrapping"; Css = ".recharts-tooltip-wrapper { max-width: min(320px, calc(100vw - 2rem)); }" },
  @{ Title = "chart legend wrapping"; Css = ".recharts-legend-wrapper { overflow-wrap: anywhere; }" },
  @{ Title = "navbar brand wrapping"; Css = ".navbar-brand { white-space: normal; line-height: 1.2; }" },
  @{ Title = "navbar collapse gap"; Css = ".navbar-collapse { gap: 0.5rem; }" },
  @{ Title = "navbar nav gap"; Css = ".navbar-nav { gap: 0.15rem; }" },
  @{ Title = "dropdown item wrapping"; Css = ".dropdown-item { white-space: normal; }" },
  @{ Title = "modal footer wrap"; Css = ".modal-footer { flex-wrap: wrap; gap: 0.5rem; }" },
  @{ Title = "modal header gap"; Css = ".modal-header { gap: 0.75rem; }" },
  @{ Title = "modal close no shrink"; Css = ".modal-header .btn-close { flex-shrink: 0; }" },
  @{ Title = "alert icon no shrink"; Css = ".alert svg { flex-shrink: 0; }" },
  @{ Title = "alert flex gap"; Css = ".alert.d-flex { gap: 0.75rem; }" },
  @{ Title = "toast header gap"; Css = ".toast-header { gap: 0.5rem; }" },
  @{ Title = "toast body line height"; Css = ".toast-body { line-height: 1.45; }" },
  @{ Title = "pagination wrapping"; Css = ".pagination { flex-wrap: wrap; gap: 0.25rem; }" },
  @{ Title = "pagination min target"; Css = ".page-link { min-width: 38px; min-height: 38px; display: inline-flex; align-items: center; justify-content: center; }" },
  @{ Title = "breadcrumb wrapping"; Css = ".breadcrumb { row-gap: 0.25rem; }" },
  @{ Title = "badge whitespace"; Css = ".badge { white-space: normal; text-align: inherit; }" },
  @{ Title = "badge numeric rhythm"; Css = ".badge { font-variant-numeric: tabular-nums; }" },
  @{ Title = "progress minimum height"; Css = ".progress { min-height: 0.75rem; }" },
  @{ Title = "accordion title wrapping"; Css = ".accordion-button { overflow-wrap: anywhere; }" },
  @{ Title = "tabs wrapping"; Css = ".nav-tabs { flex-wrap: wrap; }" },
  @{ Title = "pills wrapping"; Css = ".nav-pills { flex-wrap: wrap; }" },
  @{ Title = "list group action target"; Css = ".list-group-item-action { min-height: 44px; }" },
  @{ Title = "avatar no shrink"; Css = ".avatar, .user-avatar { flex-shrink: 0; }" },
  @{ Title = "uploaded image preview"; Css = ".image-preview img { max-height: 280px; object-fit: contain; }" },
  @{ Title = "attachment link wrapping"; Css = ".attachment-link { overflow-wrap: anywhere; }" },
  @{ Title = "map container ratio"; Css = ".map-container { aspect-ratio: 16 / 9; min-height: 240px; }" },
  @{ Title = "empty state spacing"; Css = ".empty-state { padding-block: clamp(2rem, 6vw, 4rem); }" },
  @{ Title = "empty state copy measure"; Css = ".empty-state p { max-width: 56ch; margin-inline: auto; }" },
  @{ Title = "loading state centering"; Css = ".loading-state { min-height: 220px; display: grid; place-items: center; }" },
  @{ Title = "error state wrapping"; Css = ".error-state { overflow-wrap: anywhere; }" },
  @{ Title = "mobile navbar spacing"; Css = "@media (max-width: 991.98px) { .navbar-nav { padding-block: 0.5rem; } }" },
  @{ Title = "mobile hero actions"; Css = "@media (max-width: 575.98px) { .hero-actions .btn { width: 100%; } }" },
  @{ Title = "mobile card actions"; Css = "@media (max-width: 575.98px) { .card-actions .btn { flex: 1 1 100%; } }" },
  @{ Title = "mobile filter fields"; Css = "@media (max-width: 575.98px) { .filter-bar > * { width: 100%; } }" },
  @{ Title = "print hide controls"; Css = "@media print { .btn, .navbar, .modal, .toast { display: none !important; } }" }
)

if ($Count -gt $upgrades.Count) {
  throw "Requested $Count upgrades, but only $($upgrades.Count) are defined."
}

Push-Location $repoRoot
try {
  for ($i = 0; $i -lt $Count; $i++) {
    $number = $Start + $i
    $marker = "mini-upgrade-$("{0:D3}" -f $number):"
    $upgrade = $upgrades[$i]

    if ((Get-Content -Path $cssPath -Raw).Contains($marker)) {
      Write-Host "Skipping existing $marker $($upgrade.Title)"
      continue
    }

    $block = @"


/* $marker $($upgrade.Title) */
$($upgrade.Css)
"@

    Add-Content -Path $cssPath -Value $block -Encoding utf8

    git add .
    if ($LASTEXITCODE -ne 0) { throw "git add failed for mini-upgrade-$number" }

    git commit -m "mini upgrade $("{0:D3}" -f $number): $($upgrade.Title)"
    if ($LASTEXITCODE -ne 0) { throw "git commit failed for mini-upgrade-$number" }

    git push origin main
    if ($LASTEXITCODE -ne 0) { throw "git push failed for mini-upgrade-$number" }
  }
}
finally {
  Pop-Location
}
