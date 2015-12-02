<%@ Page Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="false" CodeFile="ViewNewPosts.aspx.vb" Inherits="ViewPosts" Debug="true" Title="New Posts"%>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:ObjectDataSource ID="ObjectDataSourceAllPosts" runat="server" SelectMethod="GetAllPosts" 
        TypeName="PostsDataAccess" 
        OldValuesParameterFormatString="original_{0}"
        ConflictDetection="CompareAllValues" DataObjectTypeName="Post" 
        DeleteMethod="RemovePost" InsertMethod="InsertPost" UpdateMethod="UpdatePost">
        <UpdateParameters>
            <asp:Parameter Name="post" Type="Object" />
            <asp:Parameter Name="original_Post" Type="Object" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ListView ID="ListViewPosts" runat="server" 
        DataSourceID="ObjectDataSourceAllPosts" DataKeyNames="PostId">
        <AlternatingItemTemplate>
            <span style="">
                <asp:label id="DescriptionLbl" runat="server" Text="Post Description:"></asp:label>
                <asp:LinkButton ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>'  CommandName="Select"/>
                <br />
                <asp:label  ID="CreatedByLbl" runat="server" Text="Created by"></asp:label>
                <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
                <asp:Label  ID="CreatedOnLbl" runat="server" Text="on"></asp:Label>
                <asp:Label ID="DateCreatedLabel" runat="server" Text='<%# Eval("DateCreated") %>' />
                <br />
                <br />
            </span>   
        </AlternatingItemTemplate>
        <EditItemTemplate>
            <span>
                <asp:Label CssClass="lbl" ID="PostIdLbl" runat="server" Text="Post Id:" />
                <asp:Label ID="PostIdLabel" runat="server" Text='<%# Bind("PostId") %>' />
                <br />
                <asp:label CssClass="lbl" ID="DescriptionLbl" runat="server" Text="Description:"></asp:label>
                <asp:TextBox CssClass="control" ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' />
                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidatorDescription" runat="server" Text="*" ErrorMessage="The post description is required." ControlToValidate="DescriptionTextBox" CssClass="error">
                </asp:RequiredFieldValidator>
                <br />
                <asp:label CssClass="lbl" ID="DetailsLbl" runat="server" Text="Details:"></asp:label>
                <asp:TextBox CssClass="textArea" ID="DetailsTextBox" runat="server" Text='<%# Bind("Details") %>' TextMode="MultiLine" />
                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidatorDetails" runat="server" ErrorMessage="The post details are required." Text="*" ControlToValidate="DetailsTextBox" CssClass="error">
                </asp:RequiredFieldValidator>
                <br />
                <asp:Label CssClass="lbl" ID="DateCreatedLbl" runat="server" Text="Date Created:" />
                <asp:Label ID="DateCreatedLabel" runat="server" Text='<%# Bind("DateCreated") %>' />
                <br />
                <asp:Label CssClass="lbl" ID="UserIdLbl" runat="server" Text="User:" />
                <asp:Label ID="UserIdLabel" runat="server" Text='<%# Bind("UserId") %>' />
                <br />
                <asp:label CssClass="lbl" ID="CategoryIdLbl" runat="server" Text="Category:"></asp:label>
                <asp:DropDownList ID="DropDownListCategories" runat="server" 
                    DataSourceID="ObjectDataSourceCategories" DataTextField="Name" 
                    DataValueField="CategoryId" AutoPostBack="true" SelectedValue='<%# Bind("CategoryID") %>'>
                </asp:DropDownList>
                <br />
                <asp:ObjectDataSource ID="ObjectDataSourceCategories" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllCategories" 
                    TypeName="CategoriesDataAccess">
                </asp:ObjectDataSource>
                <asp:Label CssClass="lbl" ID="RemoveLbl" runat="server" Text="Removed:"></asp:Label>
                <asp:CheckBox ID="RemovedCheckBox" runat="server" Checked='<%# Bind("Removed") %>' />
                <br />
                <br />
                <asp:Button CssClass="button" ID="UpdateButton" runat="server" CommandName="Update" Text="Update Post" />
                <asp:Button CssClass="button" ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CausesValidation="False" />
                <br />
                <br />
            </span>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <span>There are no posts to view.  This is akward.</span>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <span style="">
                <asp:label  ID="PostIdLbl" runat="server" Text="PostId:" Visible='<%# user.IsInRole("Administrator") %>'></asp:label>
                <asp:TextBox ID="PostIdTextBox" runat="server" Text='<%# Bind("PostId") %>' Visible='<%# user.IsInRole("Administrator") %>'/>
                <br />
                <asp:label  ID="DescriptionLbl" runat="server" Text="Description:" Visible='<%# user.IsInRole("Administrator") %>'></asp:label>
                <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' Visible='<%# user.IsInRole("Administrator") %>'/>
                <br />
                <asp:label  ID="DetailsLbl" runat="server" Text="Details:" Visible='<%# user.IsInRole("Administrator") %>'></asp:label>
                <asp:TextBox ID="DetailsTextBox" runat="server" Text='<%# Bind("Details") %>' Visible='<%# user.IsInRole("Administrator") %>'/>
                <br />
                <asp:label  ID="DateCreatedLbl" runat="server" Text="Date Created:" Visible='<%# user.IsInRole("Administrator") %>'></asp:label>
                <asp:TextBox ID="DateCreatedTextBox" runat="server" Text='<%# Bind("DateCreated") %>' Visible='<%# user.IsInRole("Administrator") %>'/>
                <br />
                <asp:label  ID="UserIdLbl" runat="server" Text="User Id:" Visible='<%# user.IsInRole("Administrator") %>'></asp:label>
                <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' Visible='<%# user.IsInRole("Administrator") %>'/>
                <br />
                <asp:label  ID="CategoryIdLbl" runat="server" Text="Category Id:" Visible='<%# user.IsInRole("Administrator") %>'></asp:label>
                <asp:TextBox ID="CategoryIdTextBox" runat="server" Text='<%# Bind("CategoryId") %>' Visible='<%# user.IsInRole("Administrator") %>'/>
                <br />
                <asp:Label runat="server" ></asp:Label>
                <asp:CheckBox ID="RemovedCheckBox" runat="server" Checked='<%# Bind("Removed") %>' Text="Removed" Visible='<%# user.IsInRole("Administrator") %>'/>
                <br />
                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Create Post" Visible='<%# user.IsInRole("Administrator") %>'/>
                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear Fields" Visible='<%# user.IsInRole("Administrator") %>'/>
                <br />
                <br />
            </span>
        </InsertItemTemplate>
        <ItemTemplate>
            <span style="">
                <asp:label  ID="DescriptionLbl" runat="server" Text="Post Description:"></asp:label>
                <asp:LinkButton ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>'  CommandName="Select"/>
                <br />
                <asp:label  ID="CreatedByLbl" runat="server" Text="Created by"></asp:label>
                <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
                <asp:Label  ID="CreatedOnLbl" runat="server" Text="on"></asp:Label>
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
            <br />
            <asp:Button CssClass="button" ID="FavoriteButton" runat="server" Text="Add To Favorites" Visible='<%# user.IsInRole("Administrator") OR user.IsInRole("StandardUser") %>' OnClick="AddToFavorites" />
            <asp:Button CssClass="button" ID="EditButton" runat="server" CommandName="Edit" Text="Edit Post" Visible='<%# user.IsInRole("Administrator") %>'/>
            <asp:Button CssClass="button" ID="DeleteButton" runat="server" CommandName="Delete" Text="Remove Post" Visible='<%# user.IsInRole("Administrator") %>'/>
            <asp:Button CssClass="button" ID="CloseDetailsButton" runat="server" Text="Close Details" OnClick="CloseDetailsOnClick"/>
            <br />
            <br />
            </span>
        </SelectedItemTemplate>
    </asp:ListView>
    <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>
    <asp:ValidationSummary ID="ValidationSummaryPosts" runat="server" CssClass="error"/>
</asp:Content>

