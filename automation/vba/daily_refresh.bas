Attribute VB_Name = "modRefreshOrchestrator"
Option Explicit

Public Sub RunDailyRefresh()
    Dim startedAt As Date
    startedAt = Now

    On Error GoTo RefreshFail
    Call LogRefreshEvent("START", "Daily refresh started")

    Application.ScreenUpdating = False
    Application.DisplayAlerts = False

    ThisWorkbook.RefreshAll
    Call WaitForQueries(600)
    Call ValidateKPICompleteness
    Call StampRefreshStatus("SUCCESS", startedAt, Now)
    Call LogRefreshEvent("SUCCESS", "Daily refresh completed")

CleanExit:
    Application.DisplayAlerts = True
    Application.ScreenUpdating = True
    Exit Sub

RefreshFail:
    Call StampRefreshStatus("FAIL", startedAt, Now)
    Call LogRefreshEvent("FAIL", Err.Number & ": " & Err.Description)
    Call NotifyOpsTeam(Err.Description)
    Resume CleanExit
End Sub

Private Sub WaitForQueries(ByVal timeoutSeconds As Long)
    Dim t As Single
    t = Timer
    Do While IsAnyQueryRefreshing()
        DoEvents
        If Timer - t > timeoutSeconds Then
            Err.Raise vbObjectError + 1001, "WaitForQueries", "Refresh timeout exceeded"
        End If
    Loop
End Sub

Private Function IsAnyQueryRefreshing() As Boolean
    Dim cn As WorkbookConnection
    For Each cn In ThisWorkbook.Connections
        On Error Resume Next
        If cn.OLEDBConnection.Refreshing Then
            IsAnyQueryRefreshing = True
            Exit Function
        End If
        On Error GoTo 0
    Next cn
    IsAnyQueryRefreshing = False
End Function

Private Sub ValidateKPICompleteness()
    Dim ws As Worksheet
    Set ws = ThisWorkbook.Worksheets("Model_Calcs")

    If ws.Range("B2").Value = "" Then
        Err.Raise vbObjectError + 1002, "ValidateKPICompleteness", "Revenue KPI missing"
    End If
End Sub

Private Sub StampRefreshStatus(ByVal status As String, ByVal startedAt As Date, ByVal endedAt As Date)
    Dim ws As Worksheet
    Set ws = ThisWorkbook.Worksheets("Control_Panel")

    ws.Range("B2").Value = status
    ws.Range("B3").Value = startedAt
    ws.Range("B4").Value = endedAt
    ws.Range("B5").Value = DateDiff("s", startedAt, endedAt)
End Sub

Private Sub LogRefreshEvent(ByVal eventType As String, ByVal message As String)
    Dim ws As Worksheet, nextRow As Long
    Set ws = ThisWorkbook.Worksheets("Refresh_Log")

    nextRow = ws.Cells(ws.Rows.Count, 1).End(xlUp).Row + 1
    ws.Cells(nextRow, 1).Value = Now
    ws.Cells(nextRow, 2).Value = eventType
    ws.Cells(nextRow, 3).Value = message
End Sub

Private Sub NotifyOpsTeam(ByVal details As String)
    ' Placeholder: integrate Outlook/Teams webhook if approved.
    Debug.Print "ALERT: " & details
End Sub
