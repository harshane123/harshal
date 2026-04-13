# Web UI Dashboard Architecture (Confluence + SharePoint)

## Objective
Translate the Excel dashboard into a governed web architecture for enterprise collaboration and distribution.

## Delivery Surfaces
- Confluence: narrative insight pages, KPI commentary, governance docs.
- SharePoint: operational dashboard page, embedded Power BI/Excel web parts, document center.

## Core Layers
1. Data Layer: enterprise DB/APIs, governed semantic model.
2. Service Layer: refresh APIs, alert service, metadata endpoints.
3. Presentation Layer: SharePoint dashboard + Confluence insight hubs.
4. Security Layer: Azure AD groups, row-level access, audit logs.
