<%@ Page Title="Create New Category" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="false" CodeFile="CreateCategory.aspx.vb" Inherits="LoggedUsers_CreateCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:ListView ID="ListView1" runat="server" 
        DataSourceID="ObjectDataSourceCategories" InsertItemPosition="LastItem">
        <AlternatingItemTemplate>
            
        </AlternatingItemTemplate>
        <EditItemTemplate>
            
        </EditItemTemplate>
        <EmptyDataTemplate>
            <span>No data was returned.</span>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <span style="">
            <asp:Label CssClass="lbl" ID="NameLbl" runat="server" Text="Name:"></asp:Label>
            <asp:TextBox CssClass="control" ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' MaxLength="35" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorName" runat="server" ErrorMessage="The category name is required." ControlToValidate="NameTextBox" Text="*" CssClass="error"></asp:RequiredFieldValidator>
            <br />
            <asp:Label CssClass="lbl" ID="DescriptionLbl" runat="server" Text="Description:"></asp:Label>
            <asp:TextBox CssClass="textArea" ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' MaxLength="500" TextMode="MultiLine" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorDescription" runat="server" ErrorMessage="The category description is required." ControlToValidate="DescriptionTextBox" Text="*" CssClass="error"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Button CssClass="button" ID="InsertButton" runat="server" CommandName="Insert" 
                Text="Create Category" />
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

        </SelectedItemTemplate>
    </asp:ListView>
    <asp:ObjectDataSource ID="ObjectDataSourceCategories" runat="server" 
        DataObjectTypeName="Category" InsertMethod="InsertCategory" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllCategories" 
        TypeName="CategoriesDataAccess" UpdateMethod="UpdateCategory" 
        DeleteMethod="RemoveCategory">
        <UpdateParameters>
            <asp:Parameter Name="category" Type="Object" />
            <asp:Parameter Name="original_Category" Type="Object" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>
    <asp:ValidationSummary ID="ValidationSummaryPosts" runat="server" CssClass="error"/>
</asp:Content>

