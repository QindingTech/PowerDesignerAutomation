'******************************************************************************
'* File:     pdm2excel.txt
'* Title:    pdm export to excel
'* Purpose:  To export the tables and columns to Excel
'* Model:    Physical Data Model
'* Objects:  Table, Column, View
'* Author:   WebClerk
'* Created:  2015-4-14
'* Version:  0.1
'* Usage: open powerdesinger and run ctrl+shift+x, run this script
'******************************************************************************
Option Explicit
   Dim rowsNum
   rowsNum = 0
'-----------------------------------------------------------------------------
' Main function
'-----------------------------------------------------------------------------
' Get the current active model
Dim Model
Set Model = ActiveModel
If (Model Is Nothing) Or (Not Model.IsKindOf(PdPDM.cls_Model)) Then
  MsgBox "The current model is not an PDM model."
Else
 ' Get the tables collection
 '创建EXCEL APP
 dim beginrow
 DIM EXCEL, SHEET
 set EXCEL = CREATEOBJECT("Excel.Application")
 EXCEL.workbooks.add(-4167)'添加工作表
 EXCEL.workbooks(1).sheets(1).name ="test"
 set sheet = EXCEL.workbooks(1).sheets("test")
 
 ShowProperties Model, SHEET
 EXCEL.visible = true
 '设置列宽和自动换行
 sheet.Columns(1).ColumnWidth = 20 
 sheet.Columns(2).ColumnWidth = 40 
 sheet.Columns(4).ColumnWidth = 20 
 sheet.Columns(5).ColumnWidth = 20 
 sheet.Columns(6).ColumnWidth = 15 
 sheet.Columns(1).WrapText =true
 sheet.Columns(2).WrapText =true
 sheet.Columns(4).WrapText =true
 End If
'-----------------------------------------------------------------------------
' Show properties of tables
'-----------------------------------------------------------------------------
Sub ShowProperties(mdl, sheet)
   ' Show tables of the current model/package
   rowsNum=0
   beginrow = rowsNum+1
   ' For each table
   output "begin"
   Dim tab
   For Each tab In mdl.tables
      ShowTable tab,sheet
   Next
   if mdl.tables.count > 0 then
        sheet.Range("A" & beginrow + 1 & ":A" & rowsNum).Rows.Group
   end if
   output "end"
End Sub
'-----------------------------------------------------------------------------
' Show table properties
'-----------------------------------------------------------------------------
Sub ShowTable(tab, sheet)
   If IsObject(tab) Then
     Dim rangFlag
     rowsNum = rowsNum + 1
      ' Show properties
      Output "================================"
      sheet.cells(rowsNum, 1) = "实体名"
      sheet.cells(rowsNum, 2) =tab.name
      sheet.cells(rowsNum, 3) = ""
      sheet.cells(rowsNum, 4) = "表名"
      sheet.cells(rowsNum, 5) = tab.code
      sheet.Range(sheet.cells(rowsNum, 5),sheet.cells(rowsNum, 6)).Merge
      rowsNum = rowsNum + 1
      sheet.cells(rowsNum, 1) = "属性名"
      sheet.cells(rowsNum, 2) = "说明"
      sheet.cells(rowsNum, 3) = ""
      sheet.cells(rowsNum, 4) = "字段中文名"
      sheet.cells(rowsNum, 5) = "字段名"
      sheet.cells(rowsNum, 6) = "字段类型"
      '设置边框
      sheet.Range(sheet.cells(rowsNum-1, 1),sheet.cells(rowsNum, 2)).Borders.LineStyle = "1"
      sheet.Range(sheet.cells(rowsNum-1, 4),sheet.cells(rowsNum, 6)).Borders.LineStyle = "1"
Dim col ' running column
Dim colsNum
colsNum = 0
      for each col in tab.columns
        rowsNum = rowsNum + 1
        colsNum = colsNum + 1
      sheet.cells(rowsNum, 1) = col.name
      sheet.cells(rowsNum, 2) = col.comment
        sheet.cells(rowsNum, 3) = ""
      sheet.cells(rowsNum, 4) = col.name
      sheet.cells(rowsNum, 5) = col.code
      sheet.cells(rowsNum, 6) = col.datatype
      next
      sheet.Range(sheet.cells(rowsNum-colsNum+1,1),sheet.cells(rowsNum,2)).Borders.LineStyle = "2"       
      sheet.Range(sheet.cells(rowsNum-colsNum+1,4),sheet.cells(rowsNum,6)).Borders.LineStyle = "2"
      rowsNum = rowsNum + 1
      
      Output "FullDescription: "       + tab.Name
   End If
End Sub