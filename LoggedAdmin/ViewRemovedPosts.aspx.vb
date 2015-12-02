
Partial Class LoggedAdmin_ViewRemovedPosts
    Inherits System.Web.UI.Page

    'Unselects the currently selected record from the list view.
    Public Sub CloseDetailsOnClick()
        ListViewPosts.SelectedIndex = -1
    End Sub

    'After the item is removed, prevents the next item from being selected in the list view.
    Protected Sub ListViewPosts_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles ListViewPosts.ItemDeleted
        ListViewPosts.SelectedIndex = -1
    End Sub

    Protected Sub ObjectDataSourceRemovedPosts_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSourceRemovedPosts.Deleted
        e.AffectedRows = CType(e.ReturnValue, Integer)
        If e.Exception IsNot Nothing Then
            lblError.Text = "There was a database error." & e.Exception.Message
            e.ExceptionHandled = True
        ElseIf e.AffectedRows = 0 Then
            lblError.Text = "The row was not deleted. Another user may have already deleted this post."
        End If
    End Sub

    Public Sub AddToFavorites()
        Try
            FavoritesDataAccess.InsertFavorite(ListViewPosts.SelectedValue, User.Identity.Name)
            Session.Add("UserId", User.Identity.Name.ToString)
            Response.Redirect("~/LoggedUsers/ViewMyFavorites.aspx")
        Catch ex As Exception
            lblError.Text = "Unable to add this post to your favorites.\nYou may already have this post as a favorite."
        End Try
    End Sub
End Class
