Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports System.ComponentModel

<DataObject(True)>
Public Class CategoriesDataAccess
    Inherits DatabaseConnections

    <DataObjectMethod(DataObjectMethodType.Select)>
    Public Shared Function GetAllCategories() As List(Of Category)
        Dim conn As SqlConnection = GetSeeItDatabaseConnection()
        Dim categories As New List(Of Category)
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_GetAllCategories"
            command.CommandType = CommandType.StoredProcedure
            Dim reader As SqlDataReader = command.ExecuteReader()
            Dim category As Category
            If reader.HasRows Then
                Do While reader.Read
                    category = New Category
                    category.CategoryId = CInt(reader("CategoryId"))
                    category.Name = reader("Name").ToString
                    category.Description = reader("Description").ToString
                    category.DateCreated = CDate(reader("DateCreated"))
                    category.UserId = reader("UserId").ToString
                    categories.Add(category)
                    category = Nothing
                Loop
            End If
            reader.Close()
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
        Return categories
    End Function

    <DataObjectMethod(DataObjectMethodType.Update)>
    Public Shared Function UpdateCategory(ByVal category As Category, ByVal original_Category As Category) As Integer
        Dim value As Integer
        Dim conn As SqlConnection = GetSeeItDatabaseConnection()
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_UpdateCategory"
            command.Parameters.AddWithValue("@Description", category.Description)
            command.Parameters.AddWithValue("@Name", category.Name)
            command.Parameters.AddWithValue("@UserId", category.UserId)
            command.Parameters.AddWithValue("@Removed", category.Removed)
            command.Parameters.AddWithValue("@OriginalCategoryId", original_Category.CategoryId)
            command.Parameters.AddWithValue("@OriginalDescription", original_Category.Description)
            command.Parameters.AddWithValue("@OriginalName", original_Category.Name)
            command.Parameters.AddWithValue("@OriginalDateCreated", original_Category.DateCreated)
            command.Parameters.AddWithValue("@OriginalUserId", original_Category.UserId)
            command.Parameters.AddWithValue("@OriginalRemoved", original_Category.Removed)
            command.CommandType = CommandType.StoredProcedure
            value = command.ExecuteNonQuery()
        Catch ex As Exception
            Throw ex
        Finally
            conn.Close()
        End Try
        Return value
    End Function

    <DataObjectMethod(DataObjectMethodType.Insert)>
    Public Shared Function InsertCategory(ByVal category As Category) As Integer
        Dim value As Integer
        Dim conn As SqlConnection = GetSeeItDatabaseConnection()
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_InsertCategory"
            command.Parameters.AddWithValue("@Description", category.Description)
            command.Parameters.AddWithValue("@Name", category.Name)
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

    <DataObjectMethod(DataObjectMethodType.Delete)>
    Public Shared Function RemoveCategory(ByVal category As Category) As Integer
        Dim value As Integer
        Dim conn As SqlConnection = GetSeeItDatabaseConnection()
        Try
            conn.Open()
            Dim command As New SqlCommand()
            command.Connection = conn
            command.CommandText = "proc_RemoveCategory"
            command.Parameters.AddWithValue("@CategoryId", category.CategoryId)
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
