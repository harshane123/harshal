# SharePoint Page Composition

## Page: Executive Performance Cockpit
- Hero web part: status strip with last refresh, quality score.
- Section A: KPI tiles (5 primary KPIs).
- Section B: Performance trends (embedded BI visual).
- Section C: Risk + exceptions list (automated list feed).
- Section D: Action tracker (Planner/Tasks integration).

## Components
- `spfx-kpi-tile`
- `spfx-trend-panel`
- `spfx-risk-grid`
- `spfx-refresh-badge`

## Non-functional
- Page load under 3 seconds for cached users.
- WCAG 2.1 AA accessibility.
