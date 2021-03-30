Attribute VB_Name = "Module1"
Sub stock_loop()
    On Error Resume Next
'Define Variables
    Dim ws_count As Integer
    Dim i As Integer
    Dim j As Long
    Dim k As Integer
    Dim l As Integer
    Dim m As Integer
    Dim total_vol As Double
    Dim open_price As Double
    Dim close_price As Double
    k = 2
    ws_count = ActiveWorkbook.Worksheets.Count
    
'loops through sheets
    For i = 1 To ws_count
    
'Labels for columns
        ActiveWorkbook.Worksheets(i).Cells(1, 9).Value = "Ticker"
        ActiveWorkbook.Worksheets(i).Cells(1, 10).Value = "Total Stock Volume"
        ActiveWorkbook.Worksheets(i).Cells(1, 11).Value = "Yearly Change"
        ActiveWorkbook.Worksheets(i).Cells(1, 12).Value = "Percent Change"
        ActiveWorkbook.Worksheets(i).Cells(1, 16).Value = "Ticker"
        ActiveWorkbook.Worksheets(i).Cells(1, 17).Value = "Value"
        ActiveWorkbook.Worksheets(i).Cells(2, 15).Value = "Greatest % Increase"
        ActiveWorkbook.Worksheets(i).Cells(3, 15).Value = "Greatest % Decrease"
        ActiveWorkbook.Worksheets(i).Cells(4, 15).Value = "Greatest Total Volume"
'set volume to 0 to sum over a range
        total_vol = 0
'loop over sheet
        For j = 2 To ActiveWorkbook.Worksheets(i).Cells.SpecialCells(xlCellTypeLastCell).Row
            If ActiveWorkbook.Worksheets(i).Cells(j, 1).Value <> ActiveWorkbook.Worksheets(i).Cells(j + 1, 1).Value Then

'loops through to find difference and % change in stocks
                close_price = ActiveWorkbook.Worksheets(i).Cells(j, 6).Value
                ActiveWorkbook.Worksheets(i).Cells(k, 11).Value = close_price - open_price
                ActiveWorkbook.Worksheets(i).Cells(k, 12).Value = (close_price - open_price) / open_price
                open_price = 0
                close_price = 0

'loops through to sum vol columns for each Ticker
                ActiveWorkbook.Worksheets(i).Cells(k, 9).Value = ActiveWorkbook.Worksheets(i).Cells(j, 1).Value
                total_vol = total_vol + ActiveWorkbook.Worksheets(i).Cells(j, 7).Value
                ActiveWorkbook.Worksheets(i).Cells(k, 10).Value = total_vol
                k = k + 1
                total_vol = 0
            ElseIf ActiveWorkbook.Worksheets(i).Cells(j - 1, 1).Value <> ActiveWorkbook.Worksheets(i).Cells(j, 1).Value Then

'loops for difference and % change in stocks
                open_price = ActiveWorkbook.Worksheets(i).Cells(j, 3).Value

'loops through to sum vol columns for each Ticker
                total_vol = total_vol + ActiveWorkbook.Worksheets(i).Cells(j, 7).Value
            Else
                total_vol = total_vol + ActiveWorkbook.Worksheets(i).Cells(j, 7).Value
            End If
        Next j
        
'Positive green and Negative Red
        For l = 2 To ActiveWorkbook.Worksheets(i).Range("K1").CurrentRegion.Rows.Count
            ActiveWorkbook.Worksheets(i).Cells(l, 12).Style = "Percent"
            If ActiveWorkbook.Worksheets(i).Cells(l, 11).Value > 0 Then
                With ActiveWorkbook.Worksheets(i).Cells(l, 11).Interior
                    .ColorIndex = 4
                    .TintAndShade = 0.6
                End With
            Else
                With ActiveWorkbook.Worksheets(i).Cells(l, 11).Interior
                    .ColorIndex = 3
                    .TintAndShade = 0.6
                End With
            End If
        Next l
                
'Find Max % inc, % dec, and total volume
    ActiveWorkbook.Worksheets(i).Cells(2, 17).Value = WorksheetFunction.Max(Worksheets(i).Range("L2:L" & ActiveWorkbook.Worksheets(i).Range("K1").CurrentRegion.Rows.Count))
    ActiveWorkbook.Worksheets(i).Cells(3, 17).Value = WorksheetFunction.Min(Worksheets(i).Range("L2:L" & ActiveWorkbook.Worksheets(i).Range("K1").CurrentRegion.Rows.Count))
    ActiveWorkbook.Worksheets(i).Cells(4, 17).Value = WorksheetFunction.Max(Worksheets(i).Range("J2:J" & ActiveWorkbook.Worksheets(i).Range("K1").CurrentRegion.Rows.Count))

'make data into Percent values
    ActiveWorkbook.Worksheets(i).Cells(2, 17).Style = "Percent"
    ActiveWorkbook.Worksheets(i).Cells(3, 17).Style = "Percent"
    
'Max and Min tickers
        For m = 2 To ActiveWorkbook.Worksheets(i).Range("K1").CurrentRegion.Rows.Count
            If ActiveWorkbook.Worksheets(i).Cells(m, 12).Value = ActiveWorkbook.Worksheets(i).Cells(2, 17).Value Then
                ActiveWorkbook.Worksheets(i).Cells(2, 16).Value = ActiveWorkbook.Worksheets(i).Cells(m, 9).Value
            ElseIf ActiveWorkbook.Worksheets(i).Cells(m, 12).Value = ActiveWorkbook.Worksheets(i).Cells(3, 17).Value Then
                ActiveWorkbook.Worksheets(i).Cells(3, 16).Value = ActiveWorkbook.Worksheets(i).Cells(m, 9).Value
            ElseIf ActiveWorkbook.Worksheets(i).Cells(m, 10).Value = ActiveWorkbook.Worksheets(i).Cells(4, 17).Value Then
                ActiveWorkbook.Worksheets(i).Cells(4, 16).Value = ActiveWorkbook.Worksheets(i).Cells(m, 9).Value
            End If
        Next m
'k = 2 so loop can start on new sheet
        k = 2
    Next i
End Sub
