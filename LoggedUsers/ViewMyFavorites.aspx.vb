
Partial Class LoggedUsers_ViewMyFavorites
    Inherits System.Web.UI.Page

    'Passes the currently logged in user to the select command of the object data source.
    Protected Sub ObjectDataSourceViewFavorites_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSourceViewFavorites.Selecting
        e.InputParameters("userId") = User.Identity.Name
    End Sub

    'Unselects the currently selected record from the list view.
    Public Sub CloseDetailsOnClick()
        ListViewFavorites.SelectedIndex = -1
    End Sub

    Protected Sub ObjectDataSourceViewFavorites_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSourceViewFavorites.Deleted
        e.AffectedRows = CType(e.ReturnValue, Integer)
        If e.Exception IsNot Nothing Then
            lblError.Text = "There was a database error." & e.Exception.Message
            e.ExceptionHandled = True
        ElseIf e.AffectedRows = 0 Then
            lblError.Text = "The row was not deleted. Another user may have already deleted this post."
        End If
        ListViewFavorites.SelectedIndex = -1
    End Sub
End Class
