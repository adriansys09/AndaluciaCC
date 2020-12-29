<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CatalogoOficina.aspx.cs" Inherits="ProyectoAndalucia.Catalogos.CatalogoOficina" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        
        <asp:GridView ID="gvDatos" runat="server" class="table table-condensed table-bordered table-hover">
                        <Columns>
                            <asp:BoundField DataField="">
                                <ItemStyle  HorizontalAlign="Center"/>
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
            
    </form>
</body>
</html>
