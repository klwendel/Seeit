<%@ Page Title="Home Page" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="false"
    CodeFile="Default.aspx.vb" Inherits="_Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Welcome to SeeIt, your number one spot to share and receive the most important information.
    </h2>
    <p>
        If this is your first time visiting the site, don't worry!  You have the honorary title of guest.  As a guest you will have the privelege of viewing all available posts.  What a great deal!

        If you would like to get in on the action and contribute to the plethora of information you can become a member <a href="Account/Register.aspx">here</a>.
    </p>
</asp:Content>