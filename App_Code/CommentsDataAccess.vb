Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class CommentsDataAccess
    Inherits DatabaseConnections

    Public Shared Function GetCommentsByPost(ByRef postId As Integer, ByRef connection As SqlConnection) As List(Of Comment)
        Dim conn As SqlConnection = If(connection, GetSeeItDatabaseConnection())
        Dim comments As New List(Of Comment)
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_GetCommentsByPost"
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@PostId", postId)
            Dim reader As SqlDataReader = command.ExecuteReader()
            Dim comment As Comment
            If reader.HasRows Then
                Do While reader.Read
                    comment = New Comment
                    comment.CommentId = CInt(reader("CommentId"))
                    comment.PostId = CInt(reader("PostId"))
                    comment.UserId = reader("UserId").ToString()
                    comment.ParentCommentId = CInt(reader("ParentCommentId"))
                    comment.DateCreated = CDate(reader("DateCreated"))
                    comment.UnderModeration = CBool(reader("UnderModeration"))
                    comment.Removed = CBool(reader("Removed"))
                    comments.Add(comment)
                    comment = Nothing
                Loop
            End If
            reader.Close()
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
        Return comments
    End Function

    Public Shared Function GetCommentsByUser(ByRef userId As String, ByRef connection As SqlConnection) As List(Of Comment)
        Dim conn As SqlConnection = If(connection, GetSeeItDatabaseConnection())
        Dim comments As New List(Of Comment)
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_GetCommentsByUser"
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@UserId", userId)
            Dim reader As SqlDataReader = command.ExecuteReader()
            Dim comment As Comment
            If reader.HasRows Then
                Do While reader.Read
                    comment = New Comment
                    comment.CommentId = CInt(reader("CommentId"))
                    comment.PostId = CInt(reader("PostId"))
                    comment.UserId = reader("UserId").ToString()
                    comment.ParentCommentId = CInt(reader("ParentCommentId"))
                    comment.DateCreated = CDate(reader("DateCreated"))
                    comment.UnderModeration = CBool(reader("UnderModeration"))
                    comment.Removed = CBool(reader("Removed"))
                    comments.Add(comment)
                    comment = Nothing
                Loop
            End If
            reader.Close()
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
        Return comments
    End Function

    Public Shared Function InsertComment(ByRef newComment As Comment, ByRef connection As SqlConnection) As Boolean
        Dim conn As SqlConnection = If(connection, GetSeeItDatabaseConnection())
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_InsertComment"
            command.Parameters.AddWithValue("@PostId", newComment.PostId)
            command.Parameters.AddWithValue("@Comment", newComment.Comment)
            command.Parameters.AddWithValue("@UserId", newComment.UserId)
            command.Parameters.AddWithValue("@ParentCommentId", newComment.ParentCommentId)
            command.CommandType = CommandType.StoredProcedure
            command.ExecuteNonQuery()
            If command.ExecuteNonQuery() = 1 Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
    End Function

    Public Shared Function UpdateComment(ByRef comment As String, ByRef originalComment As Comment, ByRef connection As SqlConnection) As Boolean
        Dim conn As SqlConnection = If(connection, GetSeeItDatabaseConnection())
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_UpdateComment"
            command.Parameters.AddWithValue("@Comment", comment)
            command.Parameters.AddWithValue("@OriginalPostId", originalComment.PostId)
            command.Parameters.AddWithValue("@OriginalComment", originalComment.Comment)
            command.Parameters.AddWithValue("@OriginalUserId", originalComment.UserId)
            command.Parameters.AddWithValue("@OriginalParentCommentId", originalComment.ParentCommentId)
            command.CommandType = CommandType.StoredProcedure
            command.ExecuteNonQuery()
            If command.ExecuteNonQuery() = 1 Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
    End Function

    Public Shared Function UnderModerationComment(ByRef commentId As Integer, ByRef connection As SqlConnection) As Boolean
        Dim conn As SqlConnection = If(connection, GetSeeItDatabaseConnection())
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_UnderModerationComment"
            command.Parameters.AddWithValue("@CommentId", commentId)
            command.CommandType = CommandType.StoredProcedure
            command.ExecuteNonQuery()
            If command.ExecuteNonQuery() = 1 Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
    End Function

    Public Shared Function RevertUnderModerationComment(ByRef commentId As Integer, ByRef connection As SqlConnection) As Boolean
        Dim conn As SqlConnection = If(connection, GetSeeItDatabaseConnection())
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_RevertUnderModerationComment"
            command.Parameters.AddWithValue("@CommentId", commentId)
            command.CommandType = CommandType.StoredProcedure
            command.ExecuteNonQuery()
            If command.ExecuteNonQuery() = 1 Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
    End Function

    Public Shared Function RemoveComment(ByRef commentId As Integer, ByRef connection As SqlConnection) As Boolean
        Dim conn As SqlConnection = If(connection, GetSeeItDatabaseConnection())
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_RemoveComment"
            command.Parameters.AddWithValue("@CommentId", commentId)
            command.CommandType = CommandType.StoredProcedure
            command.ExecuteNonQuery()
            If command.ExecuteNonQuery() = 1 Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
    End Function

    Public Shared Function RevertRemoveComment(ByRef commentId As Integer, ByRef connection As SqlConnection) As Boolean
        Dim conn As SqlConnection = If(connection, GetSeeItDatabaseConnection())
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_RevertRemoveComment"
            command.Parameters.AddWithValue("@CommentId", commentId)
            command.CommandType = CommandType.StoredProcedure
            command.ExecuteNonQuery()
            If command.ExecuteNonQuery() = 1 Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
    End Function
End Class
