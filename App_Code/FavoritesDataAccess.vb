Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports System.ComponentModel

<DataObject(True)>
Public Class FavoritesDataAccess
    Inherits DatabaseConnections

    <DataObjectMethod(DataObjectMethodType.Select)>
    Public Shared Function GetFavoritesByUser(ByRef userId As String) As List(Of Post)
        Dim conn As SqlConnection = GetSeeItDatabaseConnection()
        Dim _posts As New List(Of Post)
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_GetFavoritesByUser"
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
    Public Shared Function InsertFavorite(ByVal postId As Integer, ByVal userId As String) As Integer
        Dim value As Integer
        Dim conn As SqlConnection = GetSeeItDatabaseConnection()
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_InsertFavorite"
            command.Parameters.AddWithValue("@PostId", postId)
            command.Parameters.AddWithValue("@UserId", userId)
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
    Public Shared Function RemoveFavorite(ByVal post As Post) As Integer
        Dim value As Integer
        Dim conn As SqlConnection = GetSeeItDatabaseConnection()
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_RemoveFavorite"
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