<%@ Page Title="My Favorites" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="false" CodeFile="ViewMyFavorites.aspx.vb" Inherits="LoggedUsers_ViewMyFavorites" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:ObjectDataSource ID="ObjectDataSourceViewFavorites" runat="server" 
    DeleteMethod="RemoveFavorite" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetFavoritesByUser" TypeName="FavoritesDataAccess"
    ConflictDetection="CompareAllValues" DataObjectTypeName="Post">
    <SelectParameters>
        <asp:Parameter Name="userId" Type="String" Direction="InputOutput" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ListView ID="ListViewFavorites" runat="server" 
        DataSourceID="ObjectDataSourceViewFavorites" DataKeyNames="PostId">
        <AlternatingItemTemplate>
            <span style="">
                <asp:label ID="DescriptionLbl" runat="server" Text="Post Description:"></asp:label>
                <asp:LinkButton ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>'  CommandName="Select"/>
                <br />
                <asp:label ID="CreatedByLbl" runat="server" Text="Created by"></asp:label>
                <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
                <asp:Label ID="CreatedOnLbl" runat="server" Text="on"></asp:Label>
                <asp:Label ID="DateCreatedLabel" runat="server" Text='<%# Eval("DateCreated") %>' />
                <br />
                <br />
            </span>
        </AlternatingItemTemplate>
        <EditItemTemplate>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <span>You do not have any favorites yet.</span>
        </EmptyDataTemplate>
        <InsertItemTemplate>
        </InsertItemTemplate>
        <ItemTemplate>
            <span style="">
                <asp:label ID="DescriptionLbl" runat="server" Text="Post Description:"></asp:label>
                <asp:LinkButton ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>'  CommandName="Select"/>
                <br />
                <asp:label ID="CreatedByLbl" runat="server" Text="Created by"></asp:label>
                <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
                <asp:Label ID="CreatedOnLbl" runat="server" Text="on"></asp:Label>
                <asp:Label ID="DateCreatedLabel" runat="server" Text='<%# Eval("DateCreated") %>' />
                <br />
                <br />
            </span>    
        </ItemTemplate>
        <LayoutTemplate>
            <div ID="itemPlaceholderContainer" runat="server" style="">
                <span runat="server" id="itemPlaceholder" />
            </div>
            <div style="">
                <asp:DataPager ID="DataPager1" runat="server">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                            ShowNextPageButton="False" ShowPreviousPageButton="False" />
                        <asp:NumericPagerField />
                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" 
                            ShowNextPageButton="False" ShowPreviousPageButton="False" />
                    </Fields>
                </asp:DataPager>
            </div>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <span style="">
            <asp:Label CssClass="lbl" ID="PostIdLbl" runat="server" Text="Post Id:"></asp:Label>
            <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PostId") %>' />
            <br />
            <asp:Label CssClass="lbl" ID="DescriptionLbl" runat="server" Text="Description:"></asp:Label>
            <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' />
            <br />
            <asp:Label CssClass="lbl" ID="DetailsLbl" runat="server" Text="Details:"></asp:Label>
            <asp:Label ID="DetailsLabel" runat="server" Text='<%# Eval("Details") %>' />
            <br />
            <asp:Label CssClass="lbl" ID="DateCreatedLbl" runat="server" Text="Date Created:"></asp:Label>
            <asp:Label ID="DateCreatedLabel" runat="server" Text='<%# Eval("DateCreated") %>' />
            <br />
            <asp:Label CssClass="lbl" ID="UserIdLbl" runat="server" Text="User Id:"></asp:Label>
            <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
            <br />
            <asp:Label CssClass="lbl" ID="CategoryIdLbl" runat="server" Text="Category Id:"></asp:Label>
            <asp:Label ID="CategoryIdLabel" runat="server" Text='<%# Eval("CategoryId") %>' />
            <br />
            <asp:Label CssClass="lbl" ID="RemoveLbl" runat="server" Text="Remove:"></asp:Label>
            <asp:CheckBox ID="RemovedCheckBox" runat="server" Checked='<%# Eval("Removed") %>' Enabled="false" />
            <br />
            <asp:Button CssClass="button" ID="DeleteButton" runat="server" CommandName="Delete" Text="Remove Favorite"/>
            <asp:Button CssClass="button" ID="CloseDetailsButton" runat="server" Text="Close Details" OnClick="CloseDetailsOnClick"/>
            <br />
            <br />
            </span>
        </SelectedItemTemplate>
</asp:ListView>
    <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>
</asp:Content>

