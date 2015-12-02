
Partial Class ViewPostsByCategory
    Inherits System.Web.UI.Page

    'Used to populate the list view with the appropriate posts based on the selected category.
    Protected Sub DropDownListCategories_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListCategories.SelectedIndexChanged
        ObjectDataSourcePostsByCategory.Select()
    End Sub

    'Unselects the currently selected record from the list view.
    Public Sub CloseDetailsOnClick()
        ListViewPosts.SelectedIndex = -1
    End Sub

    'After the item is removed, prevents the next item from being selected in the list view.
    Protected Sub ListViewPosts_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles ListViewPosts.ItemDeleted
        ListViewPosts.SelectedIndex = -1
    End Sub

    Protected Sub ObjectDataSourcePostsByCategory_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSourcePostsByCategory.Inserted
        e.AffectedRows = CType(e.ReturnValue, Integer)
        If e.Exception IsNot Nothing Then
            lblError.Text = "There was a database error." & e.Exception.Message
            e.ExceptionHandled = True
        End If
    End Sub

    Protected Sub ObjectDataSourcePostsByCategory_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSourcePostsByCategory.Updated
        e.AffectedRows = CType(e.ReturnValue, Integer)
        If e.Exception IsNot Nothing Then
            lblError.Text = "There was a database error." & e.Exception.Message
            e.ExceptionHandled = True
        ElseIf e.AffectedRows = 0 Then
            lblError.Text = "The row was not updated. Another user may have already updated this post."
        End If
    End Sub

    Protected Sub ObjectDataSourcePostsByCategory_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSourcePostsByCategory.Deleted
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