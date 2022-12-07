Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports DevExpress.Web.ASPxTreeList
Imports DevExpress.Web

Namespace WebApplication1
	Partial Public Class _Default
		Inherits System.Web.UI.Page
		Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

		End Sub


		Protected Sub tree_CustomCallback(ByVal sender As Object, ByVal e As TreeListCustomCallbackEventArgs)
			UpdateNodes(tree.Nodes)
			tree.DataBind()
		End Sub

		Private Sub UpdateNodes(ByVal nodes As TreeListNodeCollection)
			For Each node As TreeListNode In nodes
				UpdateNode(node)
				If node.HasChildren Then
					UpdateNodes(node.ChildNodes)
				End If
			Next node
		End Sub

		Private Sub UpdateNode(ByVal node As TreeListNode)
			Dim isModified As Boolean = False
			For Each col As TreeListColumn In tree.Columns
				If TypeOf col Is TreeListDataColumn Then
					Dim dc As TreeListDataColumn = CType(col, TreeListDataColumn)
					Dim tb As ASPxTextBox = CType(tree.FindDataCellTemplateControl(node.Key, dc, "editor"), ASPxTextBox)
					If (Not tb.Text.Equals(node.GetValue(dc.FieldName))) Then
						isModified = True
					End If
					SqlDataSource1.UpdateParameters(dc.FieldName).DefaultValue = tb.Text
				End If
			Next col
			SqlDataSource1.UpdateParameters(tree.KeyFieldName).DefaultValue = node.Key
			If isModified Then
				SqlDataSource1.Update()
			End If
		End Sub

		Protected Sub ASPxButton2_Click(ByVal sender As Object, ByVal e As EventArgs)
			tree.DataBind()
		End Sub
	End Class
End Namespace
