Imports Microsoft.VisualBasic
Imports System.Data.SqlClient

Public Class DatabaseConnections
    Private Const _connectionString As String = "Data Source=localhost\sqlexpress;Initial Catalog=SeeItDatabase;Integrated Security=True"
    Private Shared _connection As SqlConnection

    Public Shared Function GetSeeItDatabaseConnection() As SqlConnection
        _connection = If(_connection, New SqlConnection(_connectionString))
        Return _connection
    End Function
End Class