# Excel Executive Dashboard — Implementation Structure

This package is a ready-to-implement structure for building a VP-level Excel dashboard with refresh automation.

## Folder Map
- `00-governance/` — ownership, RACI, refresh SLAs, data contracts.
- `01-data/` — source inventory and Power Query landing tables.
- `02-model/` — star-schema design, DAX-like KPI definitions, mapping rules.
- `03-kpis/` — KPI catalog and threshold rules.
- `04-dashboard/` — sheet-by-sheet layout specs and interaction patterns.
- `05-automation/` — VBA orchestration, logging, and deployment checklist.
- `06-release/` — test cases, sign-off template, and release notes.

## Workbook Tabs (target)
1. `Control_Panel`
2. `Data_Staging`
3. `Model_Calcs`
4. `Exec_Summary`
5. `Revenue_Performance`
6. `Cost_Productivity`
7. `Risk_Alerts`
8. `Drillthrough_Detail`
9. `Refresh_Log`

## Naming Conventions
- Tables: `tbl_<domain>_<entity>` (e.g., `tbl_finance_revenue`)
- Queries: `q_<source>_<purpose>`
- Named ranges: `nr_<purpose>`
- VBA modules: `mod<Capability>`


## Test Guide
- See `automation/testing-with-sample-data.md` for step-by-step validation with sample files.
