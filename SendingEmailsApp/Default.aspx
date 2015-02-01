<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SendingEmailsApp.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 450px;
            border-left-style: solid;
            border-left-width: 1px;
            border-right: 1px solid #C0C0C0;
            border-top-style: solid;
            border-top-width: 1px;
            border-bottom: 1px solid #C0C0C0;
            background-color: #3333FF;
        }
        .auto-style2 {
            width: 212px;
            color:ghostwhite;
        }
        .auto-style3 {
            width: 151px;
            color: ghostwhite;
        }
        .auto-style4 {
            width: 356px;
        }
        .txtClass {
            width:220;
        }
        .btnClass {
            width:100%;
            background-color: rgb(103, 226, 123);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <table cellpadding="2" class="auto-style1">
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="lblName" runat="server" Text="Name"></asp:Label>
                </td>
                <td class="auto-style4">
                    <asp:TextBox ID="txtName" CssClass="txtClass" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="lblLastName" runat="server" Text="Last Name"></asp:Label>
                </td>
                <td class="auto-style4">
                    <asp:TextBox ID="txtLastName" CssClass="txtClass" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="lblEmail" runat="server" Text="Email address"></asp:Label>
                </td>
                <td class="auto-style4">
                    <asp:TextBox ID="txtEmail" CssClass="txtClass" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="lblMessage" runat="server" Text="Message"></asp:Label>
                </td>
                <td class="auto-style4">
                    <asp:TextBox ID="txtMessage" runat="server" Height="102px" TextMode="MultiLine" Width="341px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2" colspan="2">
                    <asp:Button ID="btnSend" runat="server" Text="Send message" CssClass="btnClass" OnClick="btnSend_Click" />
                </td>

            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
