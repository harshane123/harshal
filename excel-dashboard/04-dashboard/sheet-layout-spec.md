# Dashboard Layout Specification

## Exec_Summary (single-page VP view)
- Header: date stamp, refresh status, last successful run.
- Row 1 KPI cards: Revenue, Margin, Opex Ratio, Pipeline Coverage, Churn.
- Row 2: Trend combo chart (Revenue vs Target) + 13-month sparkline strip.
- Row 3: Risk heatmap by region/business unit.
- Right panel: Top 5 exceptions and owner/action due date.

## Interactions
- Global filters: Date range, Region, Segment, Product Line.
- Drill actions: KPI card click -> detailed sheet.
- Bookmark buttons: `Quarter View`, `Monthly View`, `YTD`.

## Accessibility
- Minimum 12pt body font.
- Contrast ratio > 4.5:1.
- Use icon + text for status (no color-only signaling).
