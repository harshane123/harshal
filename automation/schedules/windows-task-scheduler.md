# Windows Task Scheduler Setup

## Trigger
- Daily at 6:00 AM local server time.

## Action
- Launch `Excel.exe` with macro-enabled workbook path.
- Auto-run macro: `RunDailyRefresh` through Workbook Open event or startup script.

## Reliability
- Retry: every 10 minutes up to 3 times.
- Stop task if running > 45 minutes.
- Enable task history.

## Monitoring
- Persist logs to `Refresh_Log` sheet and optional CSV export.
- Alert on failure via Teams webhook/email.
