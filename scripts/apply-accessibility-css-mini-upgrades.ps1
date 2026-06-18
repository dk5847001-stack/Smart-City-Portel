param(
  [int]$Start = 284,
  [int]$Count = 101
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$cssPath = Join-Path $repoRoot "frontend\src\index.css"

$upgrades = @(
  @{ Title = "focus ring visibility"; Css = ":focus-visible { outline: 3px solid rgba(37, 99, 235, 0.55); outline-offset: 3px; }" },
  @{ Title = "skip link layering"; Css = ".skip-link { position: absolute; left: 1rem; top: 1rem; z-index: 1100; transform: translateY(-150%); }" },
  @{ Title = "skip link focus reveal"; Css = ".skip-link:focus-visible { transform: translateY(0); }" },
  @{ Title = "main focus scroll margin"; Css = "main:focus { outline: none; } main:focus-visible { scroll-margin-top: 5rem; }" },
  @{ Title = "target scroll offset"; Css = ":target { scroll-margin-top: 5rem; }" },
  @{ Title = "form label weight"; Css = ".form-label { font-weight: 600; }" },
  @{ Title = "required mark spacing"; Css = ".required-mark { margin-left: 0.15rem; color: #b91c1c; }" },
  @{ Title = "help text measure"; Css = ".form-text { max-width: 72ch; }" },
  @{ Title = "help text contrast"; Css = ".form-text { color: #475569; }" },
  @{ Title = "error text contrast"; Css = ".invalid-feedback { color: #b91c1c; font-weight: 600; }" },
  @{ Title = "valid text contrast"; Css = ".valid-feedback { color: #15803d; font-weight: 600; }" },
  @{ Title = "input text color"; Css = ".form-control, .form-select { color: #111827; }" },
  @{ Title = "input border contrast"; Css = ".form-control, .form-select { border-color: #94a3b8; }" },
  @{ Title = "input focus border"; Css = ".form-control:focus, .form-select:focus { border-color: #2563eb; }" },
  @{ Title = "checkbox target size"; Css = ".form-check-input { width: 1.1em; height: 1.1em; }" },
  @{ Title = "checkbox label spacing"; Css = ".form-check-label { padding-left: 0.15rem; }" },
  @{ Title = "radio group rhythm"; Css = ".form-check + .form-check { margin-top: 0.25rem; }" },
  @{ Title = "fieldset rhythm"; Css = "fieldset { min-width: 0; }" },
  @{ Title = "legend sizing"; Css = "legend { font-size: 1rem; font-weight: 700; }" },
  @{ Title = "file input cursor"; Css = "input[type='file'] { cursor: pointer; }" },
  @{ Title = "file button contrast"; Css = ".form-control::file-selector-button { color: #111827; }" },
  @{ Title = "date input tabular"; Css = "input[type='date'], input[type='time'] { font-variant-numeric: tabular-nums; }" },
  @{ Title = "number input tabular"; Css = "input[type='number'] { font-variant-numeric: tabular-nums; }" },
  @{ Title = "readonly field clarity"; Css = ".form-control[readonly] { background-color: #f8fafc; color: #334155; }" },
  @{ Title = "disabled field clarity"; Css = ".form-control:disabled, .form-select:disabled { color: #64748b; background-color: #f1f5f9; }" },
  @{ Title = "button tap target"; Css = ".btn { min-height: 40px; }" },
  @{ Title = "button inline rhythm"; Css = ".btn { display: inline-flex; align-items: center; justify-content: center; gap: 0.4rem; }" },
  @{ Title = "button focus shadow"; Css = ".btn:focus-visible { box-shadow: 0 0 0 0.2rem rgba(37, 99, 235, 0.25); }" },
  @{ Title = "button text balance"; Css = ".btn { text-wrap: balance; }" },
  @{ Title = "close button focus"; Css = ".btn-close:focus-visible { box-shadow: 0 0 0 0.2rem rgba(37, 99, 235, 0.25); }" },
  @{ Title = "nav link focus"; Css = ".nav-link:focus-visible { box-shadow: inset 0 0 0 2px rgba(37, 99, 235, 0.45); }" },
  @{ Title = "dropdown focus state"; Css = ".dropdown-item:focus-visible { outline: 2px solid rgba(37, 99, 235, 0.55); outline-offset: -2px; }" },
  @{ Title = "navbar toggler target"; Css = ".navbar-toggler { min-width: 44px; min-height: 44px; }" },
  @{ Title = "navbar toggler focus"; Css = ".navbar-toggler:focus-visible { box-shadow: 0 0 0 0.2rem rgba(255, 255, 255, 0.28); }" },
  @{ Title = "link focus clarity"; Css = "a:focus-visible { border-radius: 4px; }" },
  @{ Title = "external link wrapping"; Css = "a[href^='http'] { overflow-wrap: anywhere; }" },
  @{ Title = "long code wrapping"; Css = "code, kbd, samp { overflow-wrap: anywhere; }" },
  @{ Title = "pre scroll safety"; Css = "pre { max-width: 100%; overflow-x: auto; }" },
  @{ Title = "kbd readability"; Css = "kbd { font-size: 0.85em; }" },
  @{ Title = "table caption contrast"; Css = ".table caption { color: #475569; }" },
  @{ Title = "table cell vertical align"; Css = ".table td, .table th { vertical-align: middle; }" },
  @{ Title = "table header weight"; Css = ".table thead th { font-weight: 700; }" },
  @{ Title = "table numeric rhythm"; Css = ".table .numeric, .table [data-numeric] { font-variant-numeric: tabular-nums; }" },
  @{ Title = "table empty cell clarity"; Css = ".table td:empty::after { content: '-'; color: #94a3b8; }" },
  @{ Title = "status text wrapping"; Css = ".status-text { overflow-wrap: anywhere; }" },
  @{ Title = "priority text wrapping"; Css = ".priority-text { overflow-wrap: anywhere; }" },
  @{ Title = "complaint title balance"; Css = ".complaint-title { text-wrap: balance; }" },
  @{ Title = "complaint description measure"; Css = ".complaint-description { max-width: 78ch; }" },
  @{ Title = "complaint meta gap"; Css = ".complaint-meta { display: flex; flex-wrap: wrap; gap: 0.5rem 0.75rem; }" },
  @{ Title = "complaint meta no shrink"; Css = ".complaint-meta > * { min-width: 0; }" },
  @{ Title = "timeline date tabular"; Css = ".timeline-date { font-variant-numeric: tabular-nums; }" },
  @{ Title = "timeline marker stability"; Css = ".timeline-marker { flex: 0 0 auto; }" },
  @{ Title = "dashboard heading balance"; Css = ".dashboard-heading { text-wrap: balance; }" },
  @{ Title = "dashboard toolbar wrap"; Css = ".dashboard-toolbar { display: flex; flex-wrap: wrap; gap: 0.5rem; }" },
  @{ Title = "dashboard toolbar alignment"; Css = ".dashboard-toolbar { align-items: center; justify-content: space-between; }" },
  @{ Title = "stats grid stable columns"; Css = ".stats-grid { grid-template-columns: repeat(auto-fit, minmax(min(180px, 100%), 1fr)); }" },
  @{ Title = "stat card label measure"; Css = ".stat-card .text-muted { max-width: 24ch; }" },
  @{ Title = "stat card icon no shrink"; Css = ".stat-card svg { flex-shrink: 0; }" },
  @{ Title = "chart empty state"; Css = ".chart-empty { min-height: 220px; display: grid; place-items: center; color: #64748b; }" },
  @{ Title = "chart label contrast"; Css = ".recharts-text { fill: #334155; }" },
  @{ Title = "chart axis contrast"; Css = ".recharts-cartesian-axis-line, .recharts-cartesian-axis-tick-line { stroke: #94a3b8; }" },
  @{ Title = "chart grid subtle"; Css = ".recharts-cartesian-grid line { stroke: #e2e8f0; }" },
  @{ Title = "modal body scroll"; Css = ".modal-body { max-height: min(70vh, 720px); overflow-y: auto; }" },
  @{ Title = "modal title balance"; Css = ".modal-title { text-wrap: balance; }" },
  @{ Title = "modal footer buttons"; Css = ".modal-footer .btn { flex: 0 1 auto; }" },
  @{ Title = "toast max width"; Css = ".toast { max-width: min(420px, calc(100vw - 2rem)); }" },
  @{ Title = "toast text wrapping"; Css = ".toast { overflow-wrap: anywhere; }" },
  @{ Title = "alert text measure"; Css = ".alert { max-width: 100%; }" },
  @{ Title = "alert heading balance"; Css = ".alert-heading { text-wrap: balance; }" },
  @{ Title = "badge line height"; Css = ".badge { line-height: 1.25; }" },
  @{ Title = "badge tap target"; Css = "button.badge, a.badge { min-height: 32px; display: inline-flex; align-items: center; }" },
  @{ Title = "pagination disabled clarity"; Css = ".page-item.disabled .page-link { color: #64748b; }" },
  @{ Title = "pagination active contrast"; Css = ".page-item.active .page-link { color: #ffffff; }" },
  @{ Title = "breadcrumb link wrap"; Css = ".breadcrumb-item a { overflow-wrap: anywhere; }" },
  @{ Title = "list group wrapping"; Css = ".list-group-item { overflow-wrap: anywhere; }" },
  @{ Title = "accordion focus clarity"; Css = ".accordion-button:focus-visible { box-shadow: inset 0 0 0 2px rgba(37, 99, 235, 0.45); }" },
  @{ Title = "accordion icon no shrink"; Css = ".accordion-button::after { flex-shrink: 0; }" },
  @{ Title = "card focus within"; Css = ".card:focus-within { border-color: rgba(37, 99, 235, 0.45); }" },
  @{ Title = "card title balance"; Css = ".card-title { text-wrap: balance; }" },
  @{ Title = "card text measure"; Css = ".card-text { max-width: 72ch; }" },
  @{ Title = "card footer wrap"; Css = ".card-footer { display: flex; flex-wrap: wrap; gap: 0.5rem; }" },
  @{ Title = "image alt border"; Css = "img { max-width: 100%; }" },
  @{ Title = "figure caption contrast"; Css = "figcaption { color: #475569; font-size: 0.92rem; }" },
  @{ Title = "avatar image fit"; Css = ".avatar img, .user-avatar img { width: 100%; height: 100%; object-fit: cover; }" },
  @{ Title = "upload dropzone focus"; Css = ".upload-dropzone:focus-within { border-color: #2563eb; }" },
  @{ Title = "upload hint contrast"; Css = ".upload-hint { color: #475569; }" },
  @{ Title = "empty state title balance"; Css = ".empty-state h2, .empty-state h3 { text-wrap: balance; }" },
  @{ Title = "empty state action wrap"; Css = ".empty-state .btn-group, .empty-state .actions { flex-wrap: wrap; gap: 0.5rem; }" },
  @{ Title = "loading spinner label"; Css = ".spinner-border + span, .spinner-grow + span { margin-left: 0.5rem; }" },
  @{ Title = "skeleton motion reduce"; Css = "@media (prefers-reduced-motion: reduce) { .placeholder { animation: none !important; } }" },
  @{ Title = "reduced motion smooth scroll"; Css = "@media (prefers-reduced-motion: reduce) { html:focus-within { scroll-behavior: auto; } }" },
  @{ Title = "reduced motion transitions"; Css = "@media (prefers-reduced-motion: reduce) { *, *::before, *::after { transition-duration: 0.01ms !important; } }" },
  @{ Title = "coarse pointer nav links"; Css = "@media (pointer: coarse) { .nav-link { min-height: 44px; display: flex; align-items: center; } }" },
  @{ Title = "coarse pointer dropdowns"; Css = "@media (pointer: coarse) { .dropdown-item { min-height: 44px; display: flex; align-items: center; } }" },
  @{ Title = "mobile modal body"; Css = "@media (max-width: 575.98px) { .modal-body { max-height: 68vh; } }" },
  @{ Title = "mobile table captions"; Css = "@media (max-width: 575.98px) { .table caption { font-size: 0.9rem; } }" },
  @{ Title = "mobile filter buttons"; Css = "@media (max-width: 575.98px) { .filter-bar .btn { width: 100%; } }" },
  @{ Title = "mobile dashboard toolbar"; Css = "@media (max-width: 575.98px) { .dashboard-toolbar { align-items: stretch; } }" },
  @{ Title = "mobile dashboard buttons"; Css = "@media (max-width: 575.98px) { .dashboard-toolbar .btn { width: 100%; } }" },
  @{ Title = "tablet card grid"; Css = "@media (min-width: 576px) and (max-width: 991.98px) { .card-grid { gap: 1rem; } }" },
  @{ Title = "print form clarity"; Css = "@media print { .form-control, .form-select { border-color: #64748b !important; } }" },
  @{ Title = "print link underline"; Css = "@media print { a { text-decoration: underline; } }" },
  @{ Title = "forced colors focus"; Css = "@media (forced-colors: active) { :focus-visible { outline: 2px solid Highlight; } }" }
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
