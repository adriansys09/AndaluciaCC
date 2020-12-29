<%@ Page Title="" Language="C#" MasterPageFile="~/Referidos/MPReferidos.master" AutoEventWireup="true" CodeBehind="DatosCallcenter.aspx.cs" Inherits="ProyectoAndalucia.Referidos.DatosCallcenter" EnableEventValidation = "false"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cph_master" runat="server">


    <div>
<%--        <a href="photo.aspx" class="site-user">
            <img src="/assets/img/user.png" alt="logo">
        </a><!-- /.primary-navigation -->--%>

        <nav id="primary-navigation" class="site-navigation">
            <div class="container">
                <ul class="nav navbar-nav navbar-right">
                    <li class="page-scroll"><a href="/Referidos/DatosCallcenter.aspx">VERIFICAR DATOS</a></li>
                    <li class="page-scroll"><a href="/Inicio.aspx">SALIR</a></li>
                </ul>
                <!-- /.navbar-nav -->
            </div>
            <!-- /.navbar-collapse -->
        </nav>

    </div>


<div><!-- CONTENIDO-->

    <div class="tablacontenido"><!-- TABLA CONTENIDO -->
        <div>
            <center><h2><b>CALLCENTER</b></h2></center>
        </div>
        <div class="tabla">
            <div class="col3"></div><!-- borde izq en blanco-->

            <div class="col2"><!-- inicio contenido-->
                <div class=" borde_form">
                    <div>
                        <div class="col1"></div>
                        <div class="col3"><b>CLIENTE:</b></div>
                        <div class="col3"></div>
                        <div class="col3">
                            <!-- FILA 1-->
                            <asp:Label ID="lblNombreC" runat="server" Width="100px" Text="Nombre:"></asp:Label>
                            <asp:TextBox ID="txtNombreC" runat="server" Width="300px" Enabled="false"></asp:TextBox><br />
                            <asp:Label ID="lblCorreoC" runat="server" Width="100px" Text="Correo:"></asp:Label>
                            <asp:TextBox ID="txtCorreoC" runat="server" Width="300px" Enabled="false"></asp:TextBox><br />
<%--                            <asp:Label ID="lblTelefonoC" runat="server" Width="100px" Text="Teléfono:"></asp:Label>
                            <asp:TextBox ID="txtTelefonoC" runat="server" Width="300px" Enabled="false"></asp:TextBox><br />--%>
                        </div>
                        <div class="col3"></div>
                        <div class="col3">
                            <asp:Label ID="lblTelefonosC" runat="server" Width="100px" Text="Telefonos:"></asp:Label>
<%--                            <asp:TextBox ID="txtTelefonoC" runat="server" Width="300px" Enabled="false"></asp:TextBox><br />--%>
                            <asp:DropDownList ID="ddlTelefonos" runat="server"  Width="200px"></asp:DropDownList><br/>
                            <asp:Label ID="lblProductosC" runat="server" Width="100px" Text="Productos:"></asp:Label>
                            <%--<asp:TextBox ID="txtCorreoE" runat="server" Width="300px" Enabled="false"></asp:TextBox>--%>
                            <asp:DropDownList ID="ddlProductos" runat="server" Width="200px" OnSelectedIndexChanged="ddlProductos_SelectedIndexChanged"></asp:DropDownList><br />
                            <asp:Label ID="lblTipoProducto" runat="server" Width="100px" Text="Tipo:"></asp:Label>
                            <asp:Label ID="lblTipoProductoC" runat="server" Width="350px" Text=""></asp:Label>
                        </div>
                        <div class="col3"></div>
                    </div>
                    <div>
                        <div class="col1"></div>
<%--                        <div class="col3"><b>EMPLEADO:</b></div>
                        <div class="col3"></div>--%>
                        <div class="col3">
                            <asp:Label ID="lblNombreE" runat="server" Width="190px" Text="EMPLEADO:" Font-Bold="true"></asp:Label>
                            <asp:TextBox ID="txtNombreE" runat="server" Width="300px" Enabled="false"></asp:TextBox><br />
                            <%--                            <asp:Label ID="lblTelefonoE" runat="server"  Width="100px" Text="Telefono:"></asp:Label>
                            <asp:TextBox ID="txtTelefonoE" runat="server" Width="300px" Enabled="false"></asp:TextBox><br/>
                            <asp:Label ID="lblCorreoE" runat="server"  Width="100px" Text="Correo:"></asp:Label>
                            <asp:TextBox ID="txtCorreoE" runat="server" Width="300px" Enabled="false"></asp:TextBox>--%>
                        </div>
                        <div class="col3"></div>

                    </div>
                </div>

                <br />
                <div class="borde_form">
                    <br />
                    <div><b>PRODUCTOS ACTIVADOS</b></div>
                    <asp:Label ID="lblMensaje" runat="server" Text=""></asp:Label>
                    <div>
                        <div class="col1"></div>
                        <div class="col3">
                            <asp:Label ID="lblMensajeProductos" runat="server" Text=""></asp:Label><br />
                            <asp:GridView ID="gvProductos" class="grid" runat="server" AutoGenerateColumns="False" DataKeyNames="id" OnSelectedIndexChanged="gvProductos_SelectedIndexChanged" Font-Size="Medium"
                                DisplayMemberBinding="{Binding Path=VeryLongTextWithCRs}" OnRowCommand="gvProductos_RowCommand" CellPadding="4" ForeColor="#333333" CellSpacing="5" GridLines="None">
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:CommandField ShowSelectButton="True" />
                                    <asp:BoundField DataField="ls_id" HeaderText="Id" />
                                    <asp:BoundField DataField="ls_fecha_registro" HeaderText="Fecha Registro" />
                                    <asp:BoundField DataField="ls_cuenta" HeaderText="Cuenta" />
                                    <asp:BoundField DataField="ls_regla" HeaderText="Regla" />
                                    <asp:BoundField DataField="ls_estado" HeaderText="Estado" />
                                    <asp:BoundField DataField="ls_agencia" HeaderText="Oficina" />
                                    <asp:BoundField DataField="ls_idreferido" HeaderText="Referido" />
                                    <asp:BoundField DataField="ls_idempleado" HeaderText="Empleado" />
                                    <asp:BoundField DataField="ls_oficial" HeaderText="Oficial" />
                                    <asp:TemplateField HeaderText="Observacion">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtObservacion" Width="250px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Verificar">
                                        <ItemTemplate>
                                            <asp:ImageButton runat="server" ID="btnModificar" ImageUrl="~/assets/img/guardar.png" CommandName="Validar" Enabled="true" CommandArgument='<%# Container.DataItemIndex.ToString() %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Rechazar">
                                        <ItemTemplate>
                                            <asp:ImageButton runat="server" ID="btnRechazar" ImageUrl="~/assets/img/rechazar.png" CommandName="Rechazar" Enabled="true" CommandArgument='<%# Container.DataItemIndex.ToString() %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EditRowStyle BackColor="#999999" />
                                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                            </asp:GridView>
                            <!-- IMPRESION DATOS-->
                            <div style="display: none">                            <!-- OCULTA DIV-->
                                <asp:GridView ID="gvGuardarPendientes" class="grid" runat="server" AutoGenerateColumns="False" DataKeyNames="id" Visible="true" Font-Size="Medium"
                                    DisplayMemberBinding="{Binding Path=VeryLongTextWithCRs}" CellPadding="4" ForeColor="#333333" CellSpacing="5" GridLines="None">
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    <Columns>
                                        <asp:BoundField DataField="ls_id" HeaderText="Id" />
                                        <asp:BoundField DataField="ls_fecha_registro" HeaderText="Fecha Registro" />
                                        <asp:BoundField DataField="ls_cuenta" HeaderText="Cuenta" />
                                        <asp:BoundField DataField="ls_regla" HeaderText="Regla" />
                                        <asp:BoundField DataField="ls_estado" HeaderText="Estado" />
                                        <asp:BoundField DataField="ls_agencia" HeaderText="Oficina" />
                                        <asp:BoundField DataField="ls_idreferido" HeaderText="Referido" />
                                        <asp:BoundField DataField="ls_idempleado" HeaderText="Empleado" />
                                        <asp:BoundField DataField="ls_oficial" HeaderText="Oficial" />
                                    </Columns>
                                    <EditRowStyle BackColor="#999999" />
                                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                </asp:GridView>
                            </div>
                        </div>
                        <div class="col1"></div>
                        <div><!--Exportar Rechazados -->
                            <div class="col1"></div>
                            <div class="col3">
                                <asp:ImageButton ID="imgPendientes" runat="server" ImageUrl="~/assets/img/excel.png" OnClick="imgPendientes_Click" Width="30px" Height="30px"/>
                            </div>
                            <div class="col1"></div>
                        </div>
                    </div>
                    <br />
                    <br />
                    <div><b>PRODUCTOS RECHAZADOS:</b></div>
                    <div>
                        <div class="col1"></div>
                        <div class="col3">
                            <asp:Label ID="lblMensajeRechazados" runat="server" Text=""></asp:Label><br />
                            <asp:GridView ID="gvRechazadas" class="grid" runat="server" AutoGenerateColumns="False" DataKeyNames="id" Font-Size="Medium"
                                DisplayMemberBinding="{Binding Path=VeryLongTextWithCRs}"  CellPadding="4" ForeColor="#333333" CellSpacing="5" GridLines="None">
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:BoundField DataField="ls_id" HeaderText="Id" />
                                    <asp:BoundField DataField="ls_fecha_registro" HeaderText="Fecha Registro" />
                                    <asp:BoundField DataField="ls_cuenta" HeaderText="Cuenta" />
                                    <asp:BoundField DataField="ls_regla" HeaderText="Regla" />
                                    <asp:BoundField DataField="ls_estado" HeaderText="Estado" />
                                    <asp:BoundField DataField="ls_agencia" HeaderText="Oficina" />
                                    <asp:BoundField DataField="ls_referido" HeaderText="Referido" />
                                    <asp:BoundField DataField="ls_empleado" HeaderText="Empleado" />
                                    <asp:BoundField DataField="ls_oficial" HeaderText="Oficial" />
                                </Columns>
                                <EditRowStyle BackColor="#999999" />
                                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                            </asp:GridView>
                        </div>
                        <div class="col1"></div>
                    </div>
                    <div><!--Exportar Rechazados -->
                        <div class="col1"></div>
                        <div class="col3">
                            <asp:ImageButton ID="imgRechazados" runat="server" ImageUrl="~/assets/img/excel.png" OnClick="imgRechazados_Click" Width="30px" Height="30px"/>
                        </div>
                        <div class="col1"></div>
                    </div>
                    <br/>

                </div>
                <br />
            </div> <!-- fin contenido-->

            <div class="col3"></div><!-- borde derecha en blanco-->
        </div>
        <div><br /><br /><br /></div><!-- "footer" -->
    </div><!-- FIN TABLA CONTENIDO -->

    <br /><br /><br /><br />
</div><!-- FIN CONTENIDO-->



</asp:Content>
