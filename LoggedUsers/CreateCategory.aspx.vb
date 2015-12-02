
Partial Class LoggedUsers_CreateCategory
    Inherits System.Web.UI.Page

    Protected Sub ObjectDataSourceCategories_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSourceCategories.Inserted
        e.AffectedRows = CType(e.ReturnValue, Integer)
        If e.Exception IsNot Nothing Then
            lblError.Text = "There was a database error." & e.Exception.Message
            e.ExceptionHandled = True
        End If
        Session.Remove("UserId")
    End Sub

    Protected Sub ObjectDataSourceCategories_Inserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceMethodEventArgs) Handles ObjectDataSourceCategories.Inserting
        Session.Add("UserId", User.Identity.Name)
    End Sub
End Class
