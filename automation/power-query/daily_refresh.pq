let
    SourceRevenue = Excel.Workbook(File.Contents("C:\\Data\\revenue_daily.xlsx"), null, true),
    RevenueSheet = SourceRevenue{[Item="Revenue",Kind="Sheet"]}[Data],
    RevenuePromoted = Table.PromoteHeaders(RevenueSheet, [PromoteAllScalars=true]),
    RevenueTyped = Table.TransformColumnTypes(RevenuePromoted, {
        {"Date", type date},
        {"Region", type text},
        {"Segment", type text},
        {"Revenue", type number},
        {"TargetRevenue", type number}
    }),

    SourceCosts = Excel.Workbook(File.Contents("C:\\Data\\cost_daily.xlsx"), null, true),
    CostSheet = SourceCosts{[Item="Costs",Kind="Sheet"]}[Data],
    CostPromoted = Table.PromoteHeaders(CostSheet, [PromoteAllScalars=true]),
    CostTyped = Table.TransformColumnTypes(CostPromoted, {
        {"Date", type date},
        {"Region", type text},
        {"OperatingExpense", type number}
    }),

    Joined = Table.NestedJoin(RevenueTyped, {"Date", "Region"}, CostTyped, {"Date", "Region"}, "Cost", JoinKind.LeftOuter),
    Expanded = Table.ExpandTableColumn(Joined, "Cost", {"OperatingExpense"}, {"OperatingExpense"}),
    AddOpexRatio = Table.AddColumn(Expanded, "OpexRatio", each [OperatingExpense] / [Revenue], Percentage.Type),
    AddRefreshDate = Table.AddColumn(AddOpexRatio, "RefreshDate", each DateTime.LocalNow(), type datetime)
in
    AddRefreshDate
