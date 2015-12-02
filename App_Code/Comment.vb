Imports Microsoft.VisualBasic

Public Class Comment
    Private _commentId As Integer
    Private _comment As String
    Private _postId As Integer
    Private _userId As String
    Private _parentCommentId As Integer
    Private _dateCreated As DateTime
    Private _underModeration As Boolean
    Private _removed As Boolean

    Public Property CommentId As Integer
        Set(ByVal value As Integer)
            _commentId = value
        End Set
        Get
            Return _commentId
        End Get
    End Property

    Public Property Comment As String
        Set(ByVal value As String)
            _comment = value
        End Set
        Get
            Return _comment
        End Get
    End Property

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

    Public Property ParentCommentId As Integer
        Set(ByVal value As Integer)
            _parentCommentId = value
        End Set
        Get
            Return _parentCommentId
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

    Public Property UnderModeration As Boolean
        Set(ByVal value As Boolean)
            _underModeration = value
        End Set
        Get
            Return _underModeration
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
