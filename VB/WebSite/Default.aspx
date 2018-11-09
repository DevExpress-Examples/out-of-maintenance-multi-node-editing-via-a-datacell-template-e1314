<%@ Page Language="vb" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="WebApplication1._Default" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v13.1, Version=13.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dxwtl" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	<title>Multi-Node Editing via a DataCell template</title>
</head>
<body>
	<form id="form1" runat="server">
	<div>
		<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString %>"
			DeleteCommand="DELETE FROM [Employees] WHERE [EmployeeID] = @EmployeeID" InsertCommand="INSERT INTO [Employees] ([LastName], [FirstName], [Title], [ReportsTo]) VALUES (@LastName, @FirstName, @Title, @ReportsTo)"
			SelectCommand="SELECT [EmployeeID], [LastName], [FirstName], [Title], [ReportsTo] FROM [Employees]"
			UpdateCommand="UPDATE [Employees] SET [LastName] = @LastName, [FirstName] = @FirstName, [Title] = @Title WHERE [EmployeeID] = @EmployeeID">
			<DeleteParameters>
				<asp:Parameter Name="EmployeeID" Type="Int32" />
			</DeleteParameters>
			<UpdateParameters>
				<asp:Parameter Name="LastName" Type="String" />
				<asp:Parameter Name="FirstName" Type="String" />
				<asp:Parameter Name="Title" Type="String" />
				<asp:Parameter Name="EmployeeID" Type="Int32" />
			</UpdateParameters>
			<InsertParameters>
				<asp:Parameter Name="LastName" Type="String" />
				<asp:Parameter Name="FirstName" Type="String" />
				<asp:Parameter Name="Title" Type="String" />
				<asp:Parameter Name="ReportsTo" Type="Int32" />
			</InsertParameters>
		</asp:SqlDataSource>
		<dxwtl:ASPxTreeList ID="tree" runat="server" AutoGenerateColumns="False" ClientInstanceName="tree"
			DataSourceID="SqlDataSource1" KeyFieldName="EmployeeID" ParentFieldName="ReportsTo"
			OnCustomCallback="tree_CustomCallback">
			<SettingsBehavior AutoExpandAllNodes="True" />
			<Templates>
				<DataCell>
					<dxe:ASPxTextBox ID="editor" runat="server" Text='<%#Container.Value%>' AutoResizeWithContainer="True"
						Width="100%">
					</dxe:ASPxTextBox>
				</DataCell>
			</Templates>
			<Columns>
				<dxwtl:TreeListTextColumn FieldName="Title" VisibleIndex="0">
				</dxwtl:TreeListTextColumn>
				<dxwtl:TreeListTextColumn FieldName="LastName" VisibleIndex="1">
				</dxwtl:TreeListTextColumn>
				<dxwtl:TreeListTextColumn FieldName="FirstName" VisibleIndex="2">
				</dxwtl:TreeListTextColumn>
			</Columns>
		</dxwtl:ASPxTreeList>
		<table>
			<tr>
				<td style="width: 50%">
					<dxe:ASPxButton ID="ASPxButton1" runat="server" Text="Update" AutoPostBack="false">
						<ClientSideEvents Click="function(s, e) {
	 tree.PerformCustomCallback('update');
}" />
					</dxe:ASPxButton>
				</td>
				<td style="width: 50%">
					<dxe:ASPxButton ID="ASPxButton2" runat="server" Text="Cancel" OnClick="ASPxButton2_Click" />
				</td>
			</tr>
		</table>
	</div>
	</form>
</body>
</html>
