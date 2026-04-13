# Test Plan: Validate with Your Sample Excel Files

This guide shows how to test the delivered VBA (`automation/vba/daily_refresh.bas`) and Power Query (`automation/power-query/daily_refresh.pq`) logic using your own sample files.

## 1) Prerequisites
- Windows machine with Microsoft Excel (Microsoft 365 or Excel 2019+).
- Ability to enable macros in a trusted location.
- Two sample source files:
  - `revenue_daily.xlsx` with sheet name `Revenue`
  - `cost_daily.xlsx` with sheet name `Costs`

Expected columns in `Revenue`:
- `Date` (date)
- `Region` (text)
- `Segment` (text)
- `Revenue` (number)
- `TargetRevenue` (number)

Expected columns in `Costs`:
- `Date` (date)
- `Region` (text)
- `OperatingExpense` (number)

## 2) Place Sample Files
Option A (no query edits):
1. Create folder `C:\Data\`
2. Copy your files as:
   - `C:\Data\revenue_daily.xlsx`
   - `C:\Data\cost_daily.xlsx`

Option B (custom path):
1. Open Power Query editor.
2. Replace the paths in `File.Contents(...)` with your local paths.
3. Save and close.

## 3) Create Workbook Shell for Testing
1. Create a macro-enabled workbook: `ExecutiveDashboard_Test.xlsm`.
2. Create sheets with exact names:
   - `Control_Panel`
   - `Data_Staging`
   - `Model_Calcs`
   - `Exec_Summary`
   - `Revenue_Performance`
   - `Cost_Productivity`
   - `Risk_Alerts`
   - `Drillthrough_Detail`
   - `Refresh_Log`
3. In `Control_Panel`, set labels:
   - `A2: Status`
   - `A3: StartTime`
   - `A4: EndTime`
   - `A5: DurationSec`
4. In `Model_Calcs`, reserve `B2` as Revenue KPI check cell.
5. In `Refresh_Log`, add headers in row 1:
   - `A1: Timestamp`
   - `B1: EventType`
   - `C1: Message`

## 4) Import Power Query Logic
1. Data → Get Data → Launch Power Query Editor.
2. New Source → Blank Query.
3. Open Advanced Editor and paste content from `automation/power-query/daily_refresh.pq`.
4. Name query `q_daily_refresh`.
5. Close & Load To… → Table on `Data_Staging` sheet.

## 5) Import VBA Logic
1. Press `ALT+F11` to open VBA editor.
2. Insert → Module.
3. Paste content from `automation/vba/daily_refresh.bas`.
4. Save workbook as `.xlsm`.

## 6) Connect Validation Cell
The macro checks `Model_Calcs!B2` to ensure KPI presence.
- Set `Model_Calcs!B2` to a formula or linked value from the loaded table, e.g.:
  - `=SUM(Data_Staging!D:D)` (or your actual revenue column)
- Ensure it is non-empty after refresh.

## 7) Run Manual Refresh Test
1. In Excel, Developer → Macros → run `RunDailyRefresh`.
2. Verify outcomes:
   - `Control_Panel!B2` = `SUCCESS`
   - `Control_Panel!B3:B5` populated
   - New log row in `Refresh_Log`
   - `Data_Staging` table updated from sample files

## 8) Negative Tests (important)
### A. Missing Source File
- Temporarily rename one source file and run macro.
- Expected:
  - `Control_Panel!B2` = `FAIL`
  - `Refresh_Log` contains error detail

### B. Missing KPI Cell Value
- Clear `Model_Calcs!B2` and run macro.
- Expected:
  - Fail with `Revenue KPI missing`
  - Failure logged in `Refresh_Log`

### C. Schema Mismatch
- Rename a required column in source.
- Run refresh.
- Expected:
  - Query error and failure logged.

## 9) Daily Scheduler Smoke Test
1. Configure a Windows Task Scheduler task (see `automation/schedules/windows-task-scheduler.md`).
2. Set trigger 5 minutes in the future for test.
3. Confirm workbook opens, macro runs, and log is appended.

## 10) Go-Live Readiness Checklist
- [ ] Query paths parameterized or centrally managed
- [ ] Macro workbook in trusted location
- [ ] Failure notifications wired (Outlook/Teams)
- [ ] 3 consecutive successful scheduled runs
- [ ] KPI totals reconcile with source files
