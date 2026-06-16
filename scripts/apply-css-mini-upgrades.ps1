param(
  [int]$Start = 82,
  [int]$Count = 101
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$cssPath = Join-Path $repoRoot "frontend\src\index.css"

$upgrades = @(
  @{ Title = "steadier small buttons"; Css = ".btn-sm { min-height: 34px; }" },
  @{ Title = "steadier large buttons"; Css = ".btn-lg { min-height: 46px; }" },
  @{ Title = "clear button icon rhythm"; Css = ".btn svg { flex-shrink: 0; vertical-align: -0.125em; }" },
  @{ Title = "balanced icon links"; Css = ".nav-link svg { flex-shrink: 0; vertical-align: -0.125em; }" },
  @{ Title = "predictable card imagery"; Css = ".card-img-top { aspect-ratio: 16 / 9; object-fit: cover; }" },
  @{ Title = "stable avatar sizing"; Css = ".avatar, .user-avatar { aspect-ratio: 1; object-fit: cover; }" },
  @{ Title = "safer modal scrolling"; Css = ".modal-body { overscroll-behavior: contain; }" },
  @{ Title = "readable modal titles"; Css = ".modal-title { overflow-wrap: anywhere; }" },
  @{ Title = "clean dropdown spacing"; Css = ".dropdown-menu { padding-block: 0.4rem; }" },
  @{ Title = "strong dropdown focus"; Css = ".dropdown-item:focus-visible { outline: 2px solid #2563eb; outline-offset: -2px; }" },
  @{ Title = "stable navbar toggler"; Css = ".navbar-toggler { min-width: 44px; min-height: 44px; }" },
  @{ Title = "clear navbar toggler focus"; Css = ".navbar-toggler:focus-visible { outline: 2px solid #2563eb; outline-offset: 3px; }" },
  @{ Title = "resilient form help text"; Css = ".form-text { overflow-wrap: anywhere; }" },
  @{ Title = "compact invalid feedback"; Css = ".invalid-feedback { line-height: 1.35; }" },
  @{ Title = "compact valid feedback"; Css = ".valid-feedback { line-height: 1.35; }" },
  @{ Title = "file input readability"; Css = ".form-control[type='file'] { min-height: 44px; }" },
  @{ Title = "range input touch target"; Css = ".form-range { min-height: 32px; }" },
  @{ Title = "checkbox alignment"; Css = ".form-check-input { flex-shrink: 0; }" },
  @{ Title = "checkbox label wrapping"; Css = ".form-check-label { overflow-wrap: anywhere; }" },
  @{ Title = "radio label wrapping"; Css = ".form-check { min-height: 1.5rem; }" },
  @{ Title = "table cell wrapping"; Css = ".table td, .table th { overflow-wrap: anywhere; }" },
  @{ Title = "table action spacing"; Css = ".table .btn + .btn { margin-left: 0.35rem; }" },
  @{ Title = "caption contrast"; Css = ".table caption { color: #475569; }" },
  @{ Title = "list group focus"; Css = ".list-group-item:focus-visible { outline: 2px solid #2563eb; outline-offset: -2px; }" },
  @{ Title = "list group word wrapping"; Css = ".list-group-item { overflow-wrap: anywhere; }" },
  @{ Title = "breadcrumb separators"; Css = ".breadcrumb-item + .breadcrumb-item::before { color: #64748b; }" },
  @{ Title = "breadcrumb active contrast"; Css = ".breadcrumb-item.active { color: #475569; }" },
  @{ Title = "pagination focus ring"; Css = ".page-link:focus-visible { outline: 2px solid #2563eb; outline-offset: 2px; }" },
  @{ Title = "pagination disabled contrast"; Css = ".page-item.disabled .page-link { color: #64748b; }" },
  @{ Title = "badge vertical rhythm"; Css = ".badge { line-height: 1.2; }" },
  @{ Title = "badge icon spacing"; Css = ".badge svg { margin-right: 0.25rem; vertical-align: -0.125em; }" },
  @{ Title = "alert link contrast"; Css = ".alert a { font-weight: 600; }" },
  @{ Title = "alert paragraph rhythm"; Css = ".alert p:last-child { margin-bottom: 0; }" },
  @{ Title = "toast text wrapping"; Css = ".toast { overflow-wrap: anywhere; }" },
  @{ Title = "toast close target"; Css = ".toast .btn-close { min-width: 32px; min-height: 32px; }" },
  @{ Title = "spinner alignment"; Css = ".spinner-border, .spinner-grow { vertical-align: -0.125em; }" },
  @{ Title = "progress label contrast"; Css = ".progress-bar { color: #ffffff; font-weight: 600; }" },
  @{ Title = "accordion focus"; Css = ".accordion-button:focus-visible { outline: 2px solid #2563eb; outline-offset: -2px; }" },
  @{ Title = "accordion body wrapping"; Css = ".accordion-body { overflow-wrap: anywhere; }" },
  @{ Title = "tab focus visibility"; Css = ".nav-tabs .nav-link:focus-visible { outline: 2px solid #2563eb; outline-offset: 2px; }" },
  @{ Title = "pills focus visibility"; Css = ".nav-pills .nav-link:focus-visible { outline: 2px solid #2563eb; outline-offset: 2px; }" },
  @{ Title = "card title wrapping"; Css = ".card-title { overflow-wrap: anywhere; }" },
  @{ Title = "card subtitle contrast"; Css = ".card-subtitle { color: #64748b; }" },
  @{ Title = "card footer rhythm"; Css = ".card-footer > :last-child { margin-bottom: 0; }" },
  @{ Title = "card header rhythm"; Css = ".card-header > :last-child { margin-bottom: 0; }" },
  @{ Title = "description list spacing"; Css = "dt { color: #334155; } dd { margin-bottom: 0.75rem; }" },
  @{ Title = "code token readability"; Css = "code { color: #0f172a; background: #f1f5f9; border-radius: 4px; padding: 0.1rem 0.25rem; }" },
  @{ Title = "pre block scrolling"; Css = "pre { overflow-x: auto; border-radius: 6px; }" },
  @{ Title = "kbd contrast"; Css = "kbd { background: #0f172a; border-radius: 4px; }" },
  @{ Title = "mark readability"; Css = "mark { padding-inline: 0.2em; }" },
  @{ Title = "blockquote clarity"; Css = "blockquote { border-left: 4px solid #cbd5e1; padding-left: 1rem; color: #334155; }" },
  @{ Title = "horizontal rule spacing"; Css = "hr { opacity: 1; border-color: #e2e8f0; }" },
  @{ Title = "figure caption contrast"; Css = ".figure-caption { color: #64748b; }" },
  @{ Title = "image loading background"; Css = "img { background-color: transparent; }" },
  @{ Title = "svg overflow safety"; Css = "svg { overflow: visible; }" },
  @{ Title = "map frame stability"; Css = "iframe { max-width: 100%; border: 0; }" },
  @{ Title = "video fit safety"; Css = "video { max-width: 100%; height: auto; }" },
  @{ Title = "canvas fit safety"; Css = "canvas { max-width: 100%; }" },
  @{ Title = "main landmark spacing"; Css = "main { min-width: 0; }" },
  @{ Title = "section anchor offset"; Css = "section[id] { scroll-margin-top: 88px; }" },
  @{ Title = "article text wrapping"; Css = "article { overflow-wrap: anywhere; }" },
  @{ Title = "aside text wrapping"; Css = "aside { overflow-wrap: anywhere; }" },
  @{ Title = "footer link target"; Css = "footer a { min-height: 32px; display: inline-flex; align-items: center; }" },
  @{ Title = "header z-index guard"; Css = "header, .navbar { z-index: 1030; }" },
  @{ Title = "skip link layer"; Css = ".skip-link { z-index: 1100; }" },
  @{ Title = "focus ring consistency"; Css = "a:focus-visible { outline: 2px solid #2563eb; outline-offset: 3px; }" },
  @{ Title = "button group wrapping"; Css = ".btn-group.flex-wrap { row-gap: 0.35rem; }" },
  @{ Title = "input group wrapping"; Css = ".input-group { min-width: 0; }" },
  @{ Title = "input group text wrapping"; Css = ".input-group-text { overflow-wrap: anywhere; }" },
  @{ Title = "form floating label safety"; Css = ".form-floating > label { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }" },
  @{ Title = "select option contrast"; Css = "select option { color: #0f172a; background: #ffffff; }" },
  @{ Title = "disabled field cursor"; Css = ".form-control:disabled, .form-select:disabled { cursor: not-allowed; }" },
  @{ Title = "readonly field contrast"; Css = ".form-control[readonly] { background-color: #f8fafc; }" },
  @{ Title = "required label hint"; Css = "label.required::after { content: ' *'; color: #dc2626; }" },
  @{ Title = "meter dimensions"; Css = "meter { width: 100%; min-height: 0.75rem; }" },
  @{ Title = "output token wrapping"; Css = "output { overflow-wrap: anywhere; }" },
  @{ Title = "details panel spacing"; Css = "details { border-radius: 6px; } details > summary { cursor: pointer; }" },
  @{ Title = "summary focus ring"; Css = "summary:focus-visible { outline: 2px solid #2563eb; outline-offset: 3px; }" },
  @{ Title = "dialog viewport safety"; Css = "dialog { max-width: min(720px, calc(100vw - 2rem)); }" },
  @{ Title = "popover viewport safety"; Css = "[popover] { max-width: min(420px, calc(100vw - 2rem)); }" },
  @{ Title = "search cancel affordance"; Css = "input[type='search'] { -webkit-appearance: textfield; }" },
  @{ Title = "number input alignment"; Css = "input[type='number'] { font-variant-numeric: tabular-nums; }" },
  @{ Title = "date input sizing"; Css = "input[type='date'], input[type='time'], input[type='datetime-local'] { min-height: 44px; }" },
  @{ Title = "color input sizing"; Css = "input[type='color'] { min-width: 44px; min-height: 44px; padding: 0.25rem; }" },
  @{ Title = "password field readability"; Css = "input[type='password'] { letter-spacing: 0.02em; }" },
  @{ Title = "tel field numeric rhythm"; Css = "input[type='tel'] { font-variant-numeric: tabular-nums; }" },
  @{ Title = "email field wrapping"; Css = "input[type='email'] { overflow-wrap: anywhere; }" },
  @{ Title = "url field wrapping"; Css = "input[type='url'] { overflow-wrap: anywhere; }" },
  @{ Title = "mobile form spacing"; Css = "@media (max-width: 575.98px) { .form-label { margin-bottom: 0.35rem; } }" },
  @{ Title = "mobile table font"; Css = "@media (max-width: 575.98px) { .table { font-size: 0.92rem; } }" },
  @{ Title = "mobile button full width utility"; Css = "@media (max-width: 575.98px) { .btn-mobile-block { width: 100%; } }" },
  @{ Title = "tablet modal margins"; Css = "@media (min-width: 576px) and (max-width: 991.98px) { .modal-dialog { margin-inline: 1.5rem; } }" },
  @{ Title = "desktop dense tables"; Css = "@media (min-width: 992px) { .table.table-sm td, .table.table-sm th { padding-block: 0.55rem; } }" },
  @{ Title = "wide chart breathing room"; Css = "@media (min-width: 1400px) { .recharts-wrapper { margin-inline: auto; } }" },
  @{ Title = "print link clarity"; Css = "@media print { a[href]::after { content: ''; } }" },
  @{ Title = "print badge clarity"; Css = "@media print { .badge { border: 1px solid #475569; color: #0f172a !important; } }" },
  @{ Title = "print table borders"; Css = "@media print { .table td, .table th { border-color: #94a3b8 !important; } }" },
  @{ Title = "dark preference neutral base"; Css = "@media (prefers-color-scheme: dark) { :root { color-scheme: light; } }" },
  @{ Title = "forced colors link clarity"; Css = "@media (forced-colors: active) { a { text-decoration: underline; } }" },
  @{ Title = "reduced motion carousel"; Css = "@media (prefers-reduced-motion: reduce) { .carousel-item { transition: none !important; } }" },
  @{ Title = "high contrast buttons"; Css = "@media (prefers-contrast: more) { .btn-outline-primary { border-width: 2px; } }" },
  @{ Title = "coarse pointer close buttons"; Css = "@media (pointer: coarse) { .btn-close { min-width: 44px; min-height: 44px; } }" },
  @{ Title = "safe bottom inset"; Css = "body { padding-bottom: env(safe-area-inset-bottom); }" },
  @{ Title = "stable app root"; Css = "#root { min-height: 100vh; }" }
)

if ($Count -gt $upgrades.Count) {
  throw "Requested $Count upgrades, but only $($upgrades.Count) are defined."
}

for ($i = 0; $i -lt $Count; $i++) {
  $number = $Start + $i
  $upgrade = $upgrades[$i]
  $block = @"


/* mini-upgrade-$("{0:D2}" -f $number): $($upgrade.Title) */
$($upgrade.Css)
"@

  Add-Content -Path $cssPath -Value $block -Encoding utf8

  Push-Location $repoRoot
  git add .
  if ($LASTEXITCODE -ne 0) { throw "git add failed for mini-upgrade-$number" }

  git commit -m "mini upgrade $("{0:D3}" -f $number): $($upgrade.Title)"
  if ($LASTEXITCODE -ne 0) { throw "git commit failed for mini-upgrade-$number" }

  git push origin main
  if ($LASTEXITCODE -ne 0) { throw "git push failed for mini-upgrade-$number" }
  Pop-Location
}
