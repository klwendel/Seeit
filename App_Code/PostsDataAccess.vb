Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports System.ComponentModel

<DataObject(True)>
Public Class PostsDataAccess
    Inherits DatabaseConnections

    <DataObjectMethod(DataObjectMethodType.Select)>
    Public Shared Function GetAllPosts() As List(Of Post)
        Dim conn As SqlConnection = GetSeeItDatabaseConnection()
        Dim posts As New List(Of Post)
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_GetAllPosts"
            command.CommandType = CommandType.StoredProcedure
            Dim reader As SqlDataReader = command.ExecuteReader()
            Dim post As Post
            If reader.HasRows Then
                Do While reader.Read
                    post = New Post
                    post.PostId = CInt(reader("PostId"))
                    post.Description = reader("Description").ToString
                    post.Details = reader("Details").ToString
                    post.DateCreated = CDate(reader("DateCreated"))
                    post.UserId = reader("UserId").ToString
                    post.CategoryId = CInt(reader("CategoryId"))
                    post.Removed = CBool(reader("Removed"))
                    posts.Add(post)
                    post = Nothing
                Loop
            End If
            reader.Close()
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
        Return posts
    End Function

    <DataObjectMethod(DataObjectMethodType.Select)>
    Public Shared Function GetRemovedPosts() As List(Of Post)
        Dim conn As SqlConnection = GetSeeItDatabaseConnection()
        Dim posts As New List(Of Post)
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_GetRemovedPosts"
            command.CommandType = CommandType.StoredProcedure
            Dim reader As SqlDataReader = command.ExecuteReader()
            Dim post As Post
            If reader.HasRows Then
                Do While reader.Read
                    post = New Post
                    post.PostId = CInt(reader("PostId"))
                    post.Description = reader("Description").ToString
                    post.Details = reader("Details").ToString
                    post.DateCreated = CDate(reader("DateCreated"))
                    post.UserId = reader("UserId").ToString
                    post.CategoryId = CInt(reader("CategoryId"))
                    post.Removed = CBool(reader("Removed"))
                    posts.Add(post)
                    post = Nothing
                Loop
            End If
            reader.Close()
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
        Return posts
    End Function

    <DataObjectMethod(DataObjectMethodType.Select)>
    Public Shared Function GetPostsByCategory(ByRef categoryId As Integer) As List(Of Post)
        Dim conn As SqlConnection = GetSeeItDatabaseConnection()
        Dim _posts As New List(Of Post)
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_GetPostsByCategory"
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@CategoryId", categoryId)
            Dim reader As SqlDataReader = command.ExecuteReader()
            Dim post As Post
            If reader.HasRows Then
                Do While reader.Read
                    post = New Post
                    post.PostId = CInt(reader("PostId"))
                    post.Description = reader("Description").ToString
                    post.Details = reader("Details").ToString
                    post.DateCreated = CDate(reader("DateCreated"))
                    post.UserId = reader("UserId").ToString
                    post.CategoryId = CInt(reader("CategoryId"))
                    post.Removed = CBool(reader("Removed"))
                    _posts.Add(post)
                    post = Nothing
                Loop
            End If
            reader.Close()
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
        Return _posts
    End Function

    <DataObjectMethod(DataObjectMethodType.Select)>
    Public Shared Function GetPostsByUser(ByRef userId As String) As List(Of Post)
        Dim conn As SqlConnection = GetSeeItDatabaseConnection()
        Dim _posts As New List(Of Post)
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_GetPostsByUser"
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@UserId", userId)
            Dim reader As SqlDataReader = command.ExecuteReader()
            Dim post As Post
            If reader.HasRows Then
                Do While reader.Read
                    post = New Post
                    post.PostId = CInt(reader("PostId"))
                    post.Description = reader("Description").ToString
                    post.Details = reader("Details").ToString
                    post.DateCreated = CDate(reader("DateCreated"))
                    post.UserId = reader("UserId").ToString
                    post.CategoryId = CInt(reader("CategoryId"))
                    post.Removed = CBool(reader("Removed"))
                    _posts.Add(post)
                    post = Nothing
                Loop
            End If
            reader.Close()
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
        Return _posts
    End Function

    <DataObjectMethod(DataObjectMethodType.Insert)>
    Public Shared Function InsertPost(ByVal post As Post) As Integer
        Dim value As Integer
        Dim conn As SqlConnection = GetSeeItDatabaseConnection()
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_InsertPost"
            command.Parameters.AddWithValue("@Description", post.Description)
            command.Parameters.AddWithValue("@Details", post.Details)
            command.Parameters.AddWithValue("@CategoryId", post.CategoryId)
            command.Parameters.AddWithValue("@UserId", HttpContext.Current.Session("UserId").ToString)
            command.CommandType = CommandType.StoredProcedure
            value = command.ExecuteNonQuery()
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
        Return value
    End Function

    <DataObjectMethod(DataObjectMethodType.Update)>
    Public Shared Function UpdatePost(ByVal post As Post, ByVal original_Post As Post) As Integer
        Dim value As Integer
        Dim conn As SqlConnection = GetSeeItDatabaseConnection()
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_UpdatePost"
            command.Parameters.AddWithValue("@Description", post.Description)
            command.Parameters.AddWithValue("@Details", post.Details)
            command.Parameters.AddWithValue("@CategoryId", post.CategoryId)
            command.Parameters.AddWithValue("@UserId", post.UserId)
            command.Parameters.AddWithValue("@Removed", post.Removed)
            command.Parameters.AddWithValue("@OriginalPostId", original_Post.PostId)
            command.Parameters.AddWithValue("@OriginalDescription", original_Post.Description)
            command.Parameters.AddWithValue("@OriginalDetails", original_Post.Details)
            command.Parameters.AddWithValue("@OriginalDateCreated", original_Post.DateCreated)
            command.Parameters.AddWithValue("@OriginalCategoryId", original_Post.CategoryId)
            command.Parameters.AddWithValue("@OriginalUserId", original_Post.UserId)
            command.Parameters.AddWithValue("@OriginalRemoved", original_Post.Removed)
            command.CommandType = CommandType.StoredProcedure
            value = command.ExecuteNonQuery()
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
        Return value
    End Function

    <DataObjectMethod(DataObjectMethodType.Delete)>
    Public Shared Function RemovePost(ByVal post As Post) As Integer
        Dim value As Integer
        Dim conn As SqlConnection = GetSeeItDatabaseConnection()
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_RemovePost"
            command.Parameters.AddWithValue("@PostId", post.PostId)
            command.CommandType = CommandType.StoredProcedure
            value = command.ExecuteNonQuery()
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
        Return value
    End Function

    <DataObjectMethod(DataObjectMethodType.Delete)>
    Public Shared Function RevertRemovePost(ByVal post As Post) As Integer
        Dim value As Integer
        Dim conn As SqlConnection = GetSeeItDatabaseConnection()
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_RevertRemovePost"
            command.Parameters.AddWithValue("@PostId", post.PostId)
            command.CommandType = CommandType.StoredProcedure
            value = command.ExecuteNonQuery()
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
        Return value
    End Function
End Class