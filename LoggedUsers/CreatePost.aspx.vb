
Partial Class LoggedUsers_CreatePost
    Inherits System.Web.UI.Page

    'Removes the UserId from session and redirects to the users posts.
    Protected Sub ObjectDataSourceInsertPost_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSourceInsertPost.Inserted
        e.AffectedRows = CType(e.ReturnValue, Integer)
        If e.Exception IsNot Nothing Then
            lblError.Text = "There was a database error." & e.Exception.Message
            e.ExceptionHandled = True
        End If
        Session.Remove("UserId")
        Response.Redirect("~/LoggedUsers/ViewMyPosts.aspx")
    End Sub

    'Adds the current user to session state.
    Protected Sub ObjectDataSourceInsertPost_Inserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceMethodEventArgs) Handles ObjectDataSourceInsertPost.Inserting
        Session.Add("UserId", User.Identity.Name)
    End Sub
End Class
