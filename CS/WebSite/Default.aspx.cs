using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxTreeList;
using DevExpress.Web.ASPxEditors;

namespace WebApplication1
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void tree_CustomCallback(object sender, TreeListCustomCallbackEventArgs e)
        {
            UpdateNodes(tree.Nodes);
            tree.DataBind();
        }

        private void UpdateNodes(TreeListNodeCollection nodes)
        {
            foreach (TreeListNode node in nodes)
            {
                UpdateNode(node);
                if (node.HasChildren) UpdateNodes(node.ChildNodes);
            }
        }

        private void UpdateNode(TreeListNode node)
        {
            bool isModified = false;
            foreach (TreeListColumn col in tree.Columns)
            {
                if (col is TreeListDataColumn)
                {
                    TreeListDataColumn dc = (TreeListDataColumn)col;
                    ASPxTextBox tb = (ASPxTextBox)tree.FindDataCellTemplateControl(node.Key, dc, "editor");
                    if (!tb.Text.Equals(node.GetValue(dc.FieldName)))
                        isModified = true;
                    SqlDataSource1.UpdateParameters[dc.FieldName].DefaultValue = tb.Text;
                }
            }
            SqlDataSource1.UpdateParameters[tree.KeyFieldName].DefaultValue = node.Key;
            if (isModified)
            {
                SqlDataSource1.Update();
            }
        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            tree.DataBind();
        }
    }
}
