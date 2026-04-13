# Security and Access Model

## Groups
- `EXEC_DASHBOARD_VP`
- `EXEC_DASHBOARD_DIRECTORS`
- `EXEC_DASHBOARD_ANALYSTS`
- `EXEC_DASHBOARD_AUDIT`

## Rules
- VP: full summary + drillthrough.
- Directors: scoped drillthrough by org unit.
- Analysts: authoring + diagnostics.
- Audit: read-only with immutable logs.

## Controls
- SSO via Azure AD.
- Row-level security for org hierarchy.
- Access review every quarter.
