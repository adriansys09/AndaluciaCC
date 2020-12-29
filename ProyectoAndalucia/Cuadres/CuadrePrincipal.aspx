<%@ Page Title="" Language="C#" MasterPageFile="~/Cuadres/MPCuadres.Master" AutoEventWireup="true" CodeBehind="CuadrePrincipal.aspx.cs" Inherits="ProyectoAndalucia.Cuadres.CuadrePrincipal" %>

<asp:Content ID="CuadrePrincipal" ContentPlaceHolderID="cph_master" runat="server">
    <script type="text/javascript">
        $(function ($) {
            $("#txtCuenta").mask("9.9.99.99.99.99", { placeholder: "_._.__.__.__.__" });
        });
    </script>
    <a href="photo.aspx" class="site-user">
        <img src="../assets/img/user.png" alt="logo"></a>

    <%--BOTONERA--%>
    <div class="container">
        <div class="row" style="float: right;">
            <div class="row btn-group text-right" role="group">
                <asp:LinkButton runat="server" ID="btnConsultar" CssClass="btn btn-primary btn-info" AutoPostBack="true" OnClick="btnConsultar_Click">
                       <i class="glyphicon glyphicon-refresh" aria-hidden="true"></i><span class="hidden-xs"> Consultar</span>
                </asp:LinkButton>
                <asp:LinkButton runat="server" ID="bntLimpiar" CssClass="btn btn-primary btn-info" AutoPostBack="true" OnClick="bntLimpiar_Click">
                       <i class="glyphicon glyphicon-erase" aria-hidden="true"></i><span class="hidden-xs"> Limpiar</span>
                </asp:LinkButton>
                <asp:LinkButton runat="server" ID="btnExcel" CssClass="btn btn-primary btn-info" AutoPostBack="true" OnClick="btnExcel_Click" Visible="false">
                       <i class="glyphicon glyphicon-new-window" aria-hidden="true"></i><span class="hidden-xs"> Exportar a Excel</span>
                </asp:LinkButton>
                <asp:LinkButton runat="server" ID="btnSalir" CssClass="btn btn-primary btn-info" AutoPostBack="true" OnClick="btnSalir_Click">
                       <i class="glyphicon glyphicon-log-out" aria-hidden="true"></i><span class="hidden-xs"> Salir</span>
                </asp:LinkButton>

            </div>
        </div>

    </div>
    <%--MENSJA DE ERROR--%>
    <div class="container">
        <div class="row" style="float: right;">
            <asp:Label ID="lblMensajeError" runat="server" Text="" Visible="false" Style="color: red"></asp:Label>
            <asp:Label ID="lblMensajeExito" runat="server" Text="" Visible="false" Style="color: green"></asp:Label>
        </div>
    </div>
    <%-- FILTROS DE CONSULTA--%>
    <div class="container">
        <div class="row">
            
            <div class="forma-campo col-xs-12">
                <div class="text-left  col-md-3 col-xs-12">
                    <asp:Label ID="lblFecha" runat="server" Text="Fecha:"></asp:Label>
                </div>
                <div class="col-md-8 col-xs-12">
                    <asp:TextBox ID="txtFecha" runat="server" Width="200px" EnableTheming="True" TextMode="Date" OnTextChanged="txtFecha_TextChanged"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="text-left col-md-3 col-xs-12">
                    <asp:Label ID="lblOficina" runat="server" Text="Oficina:"></asp:Label>
                </div>
                <div class="text-left col-md-2 col-xs-12">
                    <asp:TextBox ID="txtCodigoOficina" runat="server" OnTextChanged="txtCodigoOficina_TextChanged" AutoPostBack="true"></asp:TextBox>
                </div>
                <div class="col-xs-2" runat="server" id="rowOficina">
                    <div class="row btn-toolbar col-xs-12" role="toolbar">
                        <asp:LinkButton runat="server" ID="btnShowModal" CssClass="btn btn-default" data-target="#myModal"
                            data-toggle="modal" OnClientClick="javascript:return false;" AutoPostBack="true">
                       <i class="glyphicon glyphicon-search" aria-hidden="true"></i><span class="hidden-xs"> Consultar</span>
                        </asp:LinkButton>
                        <asp:LinkButton runat="server" ID="btnLimpiarOficina" CssClass="btn btn-default" OnClick="btnLimpiarOficina_Click" Visible="false">
                        <i class="glyphicon glyphicon-remove" aria-hidden="true"></i> <span class="hidden-xs">Quitar</span>
                        </asp:LinkButton>
                    </div>
                </div>
                <div class="text-left col-md-4 col-xs-12">
                    <asp:CheckBox ID="chkConsolidado" runat="server" OnCheckedChanged="chkConsolidado_CheckedChanged" AutoPostBack="true" Text="Consolidado" />
                    <asp:Label ID="lblNombreOficina" runat="server" Text=""></asp:Label>
                </div>
            </div>
        </div>
        <div class="row" id="divProductoddl" runat="server">
            <div class="col-xs-12">
                <div class="text-left col-md-3 col-xs-12">
                    <asp:Label ID="lblProducto" runat="server" Text="Producto"></asp:Label>
                </div>
                <div class="text-left col-md-4 col-xs-12">
                    <asp:DropDownList ID="ddlProducto" runat="server" Width="250px" OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged" AutoPostBack="true">
                    </asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="row" runat="server" id="divCuentaddl">
            <div class="col-xs-12">
                <div class="text-left col-md-3 col-xs-12">
                    <asp:Label ID="Label1" runat="server" Text="Cuenta"></asp:Label>
                </div>
                <div class="text-left col-md-4 col-xs-12">
                    <asp:DropDownList ID="ddlCuenta" runat="server" Width="250px" OnSelectedIndexChanged="ddlCuenta_SelectedIndexChanged" AutoPostBack="true">
                    </asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="row" id="divCuentatxt" runat="server" visible="false">
            <div class="col-xs-12">
                <div class="text-left col-md-3 col-xs-12">
                    <asp:Label ID="Label2" runat="server" Text="Cuenta"></asp:Label>
                </div>
                <div class="text-left col-md-4 col-xs-12">
                    <asp:TextBox ID="txtCuenta" runat="server" ClientIDMode="static" OnTextChanged="txtCuenta_TextChanged" AutoPostBack="true"></asp:TextBox>
                </div>
                <div class="text-left col-md-4 col-xs-12">
                    <asp:Label ID="lblCuentaDes" runat="server"></asp:Label>
                </div>
            </div>
            
        </div>
        <div class="row" id="notificacionCorreo" runat="server" Visible="false">
            <div class="col-xs-12">
                <div class="col-md-3 col-xs-12">
                    <asp:Label ID="lblCorreo" runat="server" Text="Correo Notificacion"></asp:Label>
                </div>
                <div class="col-md-6 col-xs-12">
                    <asp:TextBox ID="txtCorreos" runat="server" Text="" CssClass="col-xs-12"></asp:TextBox>
                </div>
                 <div class="col-md-3 col-xs-12">
                     <asp:Button ID="btnEnvioNotificacion" runat="server" Text="Enviar Archivo" OnClick="btnEnvioNotificacion_Click"/>
                </div>
            </div>
            
        </div>
        <br />
        <br />
        <%--GRID PARA LA EL CUADRE DE CUENTAS SEGUN EL PRODUCTO--%>
        <div id="dvCuadreCont" runat="server" visible="false">
            <div style="margin-left: auto; margin-right: auto;">

                <asp:GridView ID="gvDatosCuadre" runat="server" AutoGenerateColumns="false" CssClass="table table-sm table-striped table-hover" Font-Size="Small" Width="100%"
                    OnRowDataBound="gvDatosCuadre_RowDataBound" FooterStyle-Wrap="False" HeaderStyle-CssClass="bg-primary" FooterStyle-CssClass="bg-primary" HeaderStyle-Width="90%" ShowFooter="true">
                    <Columns>
                        <asp:BoundField DataField="Cuenta" HeaderText="Cuenta">
                            <ItemStyle HorizontalAlign="Left" />

                        </asp:BoundField>
                        <asp:BoundField DataField="Oficina" HeaderText="Codigo">
                            <ItemStyle HorizontalAlign="Left" />

                        </asp:BoundField>
                        <asp:BoundField DataField="NombreOficina" HeaderText="Oficina">
                            <ItemStyle HorizontalAlign="Left" />
                            <ItemStyle Width="25%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CuentaDes" HeaderText="Detalle">
                            <ItemStyle HorizontalAlign="Left" />
                            <ItemStyle Width="25%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SaldoConsolidado" DataFormatString="{0:N2}">
                            <ItemStyle HorizontalAlign="Right" />
                            <ItemStyle Width="15%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SaldoTotContable" HeaderText="Saldo Conta" DataFormatString="{0:N2}">
                            <ItemStyle HorizontalAlign="Right" />
                            <ItemStyle Width="15%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Diferencia" HeaderText="Dif Saldos" DataFormatString="{0:N2}">
                            <ItemStyle HorizontalAlign="Right" />
                            <ItemStyle Width="15%" />

                        </asp:BoundField>
                        <asp:TemplateField ShowHeader="false">
                            <ItemTemplate>
                                <table width="100%">
                                    <tr>
                                        <%--<td style="width: 50%">
                                            <asp:ImageButton ID="btnEditar" runat="server" CausesValidation="False" CommandName="Edit"
                                                ImageUrl="~/assets/img/rechazar.png" ToolTip=""
                                                Visible="false" />
                                        </td>--%>
                                        <td style="width: 50%">
                                            <%--<asp:ImageButton ID="btnDetalle" runat="server" CausesValidation="False" CommandName="Select"
                                                    ImageUrl="~/images/detalle.gif" Style="background-color: Blue" ToolTip="Seleccionar" />--%>
                                            <asp:LinkButton runat="server" ID="btnDetalleSeleccionar" CommandName="Select"><i class="glyphicon glyphicon-hand-up" aria-hidden="true"></i></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            <div id="paginacionCC" class="row" runat="server">
                <div class="col-xs-12">
                    <nav>
                        <ul class="pagination pagination-lg col-xs-12">
                            <li>
                                <div class="col-xs-12">
                                    Filas:<asp:DropDownList ID="ddFilasCC" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddFilasCC_SelectedIndexChanged"></asp:DropDownList>
                                    Paginas:<asp:DropDownList ID="ddlPaginasCC" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPaginasCC_SelectedIndexChanged"></asp:DropDownList>
                                </div>
                            </li>
                            <li>
                                <div class="col-xs-12">
                                    Página:<asp:Label ID="lblPaginaCC" runat="server" Text=""></asp:Label>/<asp:Label ID="lblPaginasCC" runat="server" Text=""></asp:Label>
                                    Registros:<asp:Label ID="lblNropRegistrosCC" runat="server" Text=""></asp:Label>
                                </div>
                            </li>
                            <li>
                                <asp:LinkButton runat="server" ID="lbnPrevCC" OnClick="lbnPrevCC_Click">
                                    <i class="glyphicon glyphicon-chevron-left" aria-hidden="true"></i>
                                </asp:LinkButton>
                            </li>
                            <li>
                                <asp:LinkButton runat="server" ID="lbnNextCC" OnClick="lbnNextCC_Click">
                                    <i class="glyphicon glyphicon-chevron-right" aria-hidden="true"></i>
                                </asp:LinkButton>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>

        </div>
    </div>

    <!-- Modal CONSULTA OFICINA-->
    <div class="modal fade" id="myModal" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Lista de Oficinas Cobis</h4>
                </div>
                <div class="modal-body">
                    <asp:GridView ID="gvDatos" runat="server" class="table table-sm table-bordered table-hover" AutoGenerateColumns="false" OnPageIndexChanging="gvDatos_PageIndexChanging"
                        OnSelectedIndexChanging="gvDatos_SelectedIndexChanging" OnRowEditing="gvDatos_RowEditing" Font-Size="Small" OnRowCommand="gvDatos_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="IdRegistros" HeaderText="Nro">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <%-- Filial	Codigo	Oficina	Tipo	Direccion	Ciudad
                            <asp:BoundField DataField="Filial" HeaderText="Filial">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>--%>
                            <asp:BoundField DataField="Oficina" HeaderText="Codigo">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Nombre" HeaderText="Oficina">
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <%-- <asp:BoundField DataField="Subtipo" HeaderText="Tipo">
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Direccion" HeaderText="Dirección">
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Descripcion" HeaderText="Ciudad">
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>--%>
                            <asp:TemplateField ShowHeader="false">
                                <ItemTemplate>
                                    <table width="100%">
                                        <tr>
                                            <%--<td style="width: 50%">
                                            <asp:ImageButton ID="btnEditar" runat="server" CausesValidation="False" CommandName="Edit"
                                                ImageUrl="~/assets/img/rechazar.png" ToolTip=""
                                                Visible="false" />
                                        </td>--%>
                                            <td style="width: 50%">
                                                <%--<asp:ImageButton ID="btnDetalle" runat="server" CausesValidation="False" CommandName="Select"
                                                    ImageUrl="~/images/detalle.gif" Style="background-color: Blue" ToolTip="Seleccionar" />--%>
                                                <asp:LinkButton runat="server" ID="btnDetalle" CommandName="Select"><i class="glyphicon glyphicon-hand-up" aria-hidden="true"></i></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
</asp:Content>

