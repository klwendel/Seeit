Imports Microsoft.VisualBasic

Public Class Favorite
    Private _postId As Integer
    Private _userId As String
    Private _notes As String
    Private _dateFavorited As DateTime
    Private _removed As Boolean

    Public Property PostId As Integer
        Set(ByVal value As Integer)
            _postId = value
        End Set
        Get
            Return _postId
        End Get
    End Property

    Public Property UserId As String
        Set(ByVal value As String)
            _userId = value
        End Set
        Get
            Return _userId
        End Get
    End Property

    Public Property Notes As String
        Set(ByVal value As String)
            _notes = value
        End Set
        Get
            Return _notes
        End Get
    End Property

    Public Property DateFavorited As DateTime
        Set(ByVal value As DateTime)
            _dateFavorited = value
        End Set
        Get
            Return _dateFavorited
        End Get
    End Property

    Public Property Removed As Boolean
        Set(ByVal value As Boolean)
            _removed = value
        End Set
        Get
            Return _removed
        End Get
    End Property
End Class
