<%@ Page Title="Create New Post" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="false" CodeFile="CreatePost.aspx.vb" Inherits="LoggedUsers_CreatePost" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:ListView ID="ListViewInsertPost" runat="server" 
        DataSourceID="ObjectDataSourceInsertPost" InsertItemPosition="LastItem">
        <AlternatingItemTemplate>
        </AlternatingItemTemplate>
        <EditItemTemplate>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <span>No data was returned.</span>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <span style="">
                <asp:label CssClass="lbl" ID="DescriptionLbl" runat="server" Text="Description:"></asp:label>
                <asp:TextBox CssClass="control" ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' MaxLength="35" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorDescription" runat="server" ErrorMessage="The post description is required." ControlToValidate="DescriptionTextBox" Text="*" CssClass="error"></asp:RequiredFieldValidator>
                <br />
                <asp:label CssClass="lbl" ID="DetailsLbl" runat="server" Text="Details:"></asp:label>
                <asp:TextBox CssClass="textArea" ID="DetailsTextBox" runat="server" Text='<%# Bind("Details") %>' TextMode="MultiLine" Columns="0" MaxLength="1000" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorDetails" runat="server" ErrorMessage="The post details is required." ControlToValidate="DetailsTextBox" Text="*" CssClass="error"></asp:RequiredFieldValidator>
                <br />
                <asp:label CssClass="lbl" ID="CategoryIdLbl" runat="server" Text="Category:"></asp:label>
                <asp:DropDownList CssClass="control" ID="DropDownListCategories" runat="server" 
                    DataSourceID="ObjectDataSourceCategories" DataTextField="Name" 
                    DataValueField="CategoryId" AutoPostBack="True" SelectedValue='<%# Bind("CategoryID") %>'>
                </asp:DropDownList>
                <asp:ObjectDataSource ID="ObjectDataSourceCategories" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllCategories" 
                    TypeName="CategoriesDataAccess">
                </asp:ObjectDataSource>
                <br />
                <asp:Button CssClass="button" ID="InsertButton" runat="server" CommandName="Insert" Text="Create Post"/>
                <br />
                <br />
            </span>
        </InsertItemTemplate>
        <ItemTemplate>
        </ItemTemplate>
        <LayoutTemplate>
            <div ID="itemPlaceholderContainer" runat="server" style="">
                <span runat="server" id="itemPlaceholder" />
            </div>
            <div style="">
            </div>
        </LayoutTemplate>
        <SelectedItemTemplate>
        </SelectedItemTemplate>
    </asp:ListView>
    <asp:ObjectDataSource ID="ObjectDataSourceInsertPost" runat="server" 
        DataObjectTypeName="Post" DeleteMethod="RemovePost" InsertMethod="InsertPost" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllPosts" 
        TypeName="PostsDataAccess" UpdateMethod="UpdatePost">
        <UpdateParameters>
            <asp:Parameter Name="post" Type="Object" />
            <asp:Parameter Name="original_Post" Type="Object" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <br />
    <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>
    <asp:ValidationSummary ID="ValidationSummaryPosts" runat="server" CssClass="error"/>
</asp:Content>

