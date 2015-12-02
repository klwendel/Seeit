Imports Microsoft.VisualBasic

Public Class Post
    Private _postId As Integer
    Private _description As String
    Private _details As String
    Private _dateCreated As DateTime
    Private _userId As String
    Private _categoryId As Integer
    Private _removed As Boolean

    Public Sub New()

    End Sub

    Public Property PostId As Integer
        Set(ByVal value As Integer)
            _postId = value
        End Set
        Get
            Return _postId
        End Get
    End Property

    Public Property Description As String
        Set(ByVal value As String)
            _description = value
        End Set
        Get
            Return _description
        End Get
    End Property

    Public Property Details As String
        Set(ByVal value As String)
            _details = value
        End Set
        Get
            Return _details
        End Get
    End Property

    Public Property DateCreated As DateTime
        Set(ByVal value As DateTime)
            _dateCreated = value
        End Set
        Get
            Return _dateCreated
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

    Public Property CategoryId As Integer
        Set(ByVal value As Integer)
            _categoryId = value
        End Set
        Get
            Return _categoryId
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
