<%@ Page Title="" Language="C#" MasterPageFile="~/Referidos/MPReferidos.master" AutoEventWireup="true" CodeBehind="DatosMarketing.aspx.cs" Inherits="ProyectoAndalucia.Referidos.DatosMarketing" EnableEventValidation = "false"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cph_master" runat="server">


    <div>
<%--        <a href="photo.aspx" class="site-user">
            <img src="/assets/img/user.png" alt="logo"></a>--%>
        <nav id="primary-navigation" class="site-navigation">
            <div class="container">

                <ul class="nav navbar-nav navbar-right">
                    <li class="page-scroll"><a href="/Referidos/DatosMarketing.aspx">Canje de Premios</a></li>
                    <li class="page-scroll"><a href="/Inicio.aspx">SALIR</a></li>
                </ul>
                <!-- /.navbar-nav -->
            </div>
            <!-- /.navbar-collapse -->
        </nav>
        <!-- /.primary-navigation -->
    </div>


<div><!-- CONTENIDO-->

    <div class="tablacontenido">  <!-- TABLA CONTENIDO -->
        <%--<div><center><h2><b>MARKETING</b></h2></center></div><br/>--%>
        <div class="tabla">
        <div class="col1"></div><!-- borde izq en blanco-->

        <div class="col2"><!-- inicio contenido-->

                <div>
                    <div class="col1"></div>
                    <div><h3><b>SOLICITUDES DE CANJE DE PREMIOS:</b></h3></div>
                    <div class="col1"></div>
                </div>
                    <br/>
                <div class="borde_form">
                    <div>

                        <div class="col1"></div>
                        <div class="col3">
                            <asp:Label ID="lblMensajeProductos" runat="server" Text="" Width="300px"></asp:Label><br/>

                            <asp:GridView ID="gvPremiosCanje" class="grid" runat="server" AutoGenerateColumns="False" OnSelectedIndexChanged="gvMarketing_SelectedIndexChanged" Font-Size="Medium" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowCommand="gvPremiosCanje_RowCommand" >
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:CommandField ShowSelectButton="True" />
                                    <asp:BoundField DataField="prc_id" HeaderText="Id" />
                                    <asp:BoundField DataField="prc_premio" HeaderText="Premio" />
                                    <asp:BoundField DataField="prc_idempleado" HeaderText="Codigo Empleado" />
                                    <asp:BoundField DataField="prc_empleado" HeaderText="Empleado" />
                                    <asp:BoundField DataField="prc_fecha" HeaderText="Fecha" />
                                    <asp:BoundField DataField="prc_puntos_prem" HeaderText="Puntos Premio" />
                                    <asp:BoundField DataField="prc_puntos_disp" HeaderText="Puntos Disponibles" />
                                    <asp:BoundField DataField="pr_estado" HeaderText="Estado" />
                                    <asp:BoundField DataField="pr_observacion" HeaderText="Observacion" />
                                    <asp:TemplateField HeaderText="Observacion">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtObservacion" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Modificar">
                                        <ItemTemplate>
                                            <asp:ImageButton runat="server" ID="btnModificar" ImageUrl="~/assets/img/guardar.png" CommandName="Validar" Enabled="true" CommandArgument='<%# Container.DataItemIndex.ToString() %>'   />
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
                            <asp:GridView ID="gvImprimePremiosCanje" class="grid" runat="server" AutoGenerateColumns="False" Font-Size="Medium" CellPadding="4" ForeColor="#333333" GridLines="None" >
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:BoundField DataField="prc_id" HeaderText="Id" />
                                    <asp:BoundField DataField="prc_premio" HeaderText="Premio" />
                                    <asp:BoundField DataField="prc_idempleado" HeaderText="Codigo Empleado" />
                                    <asp:BoundField DataField="prc_empleado" HeaderText="Empleado" />
                                    <asp:BoundField DataField="prc_fecha" HeaderText="Fecha" />
                                    <asp:BoundField DataField="prc_puntos_prem" HeaderText="Puntos Premio" />
                                    <asp:BoundField DataField="prc_puntos_disp" HeaderText="Puntos Disponibles" />
                                    <asp:BoundField DataField="pr_estado" HeaderText="Estado" />
                                    <asp:BoundField DataField="pr_observacion" HeaderText="Observacion" />
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
                        <div class="col3"></div>

                    </div>
                        <div><!--Exportar Premios Canje -->
                            <div class="col1"></div>
                            <div class="col3">
                                <asp:ImageButton ID="imgPremiosCanje" runat="server" ImageUrl="~/assets/img/excel.png" Width="30px" Height="30px" OnClick="imgPremiosCanje_Click"/>
                            </div>
                            <div class="col1"></div>
                        </div>

                    <br/>
                </div><!-- Solicitudes de canje-->
            <br />
                <div>
                    <div class="col1"></div>
                    <div><h3><b>PREMIOS ENTREGADOS:</b></h3></div>
                    <div class="col1"></div>
                </div>

                <div class="borde_form">
                    <div>
                        <div class="col1"></div>
                        <div class="col3">
                            <asp:Label ID="lblMensajeEntregados" runat="server" Text="" Width="300px"></asp:Label><br/>
                            <asp:GridView ID="gvPremiosEntregados" class="grid" runat="server" AutoGenerateColumns="False" OnSelectedIndexChanged="gvMarketing_SelectedIndexChanged"  Font-Size="Medium" CellPadding="4" ForeColor="#333333" GridLines="None">
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:BoundField DataField="prc_id" HeaderText="Id" />
                                    <asp:BoundField DataField="prc_premio" HeaderText="Premio" />
                                    <asp:BoundField DataField="prc_idempleado" HeaderText="Codigo Empleado" />
                                    <asp:BoundField DataField="prc_empleado" HeaderText="Empleado" />
                                    <asp:BoundField DataField="prc_fecha" HeaderText="Fecha" />
                                    <asp:BoundField DataField="prc_puntos_prem" HeaderText="Puntos Premio" />
                                    <asp:BoundField DataField="prc_puntos_disp" HeaderText="Puntos Disponibles" />
                                    <asp:BoundField DataField="pr_estado" HeaderText="Estado" />
                                    <asp:BoundField DataField="pr_observacion" HeaderText="Observacion" />
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
                        <div class="col3"></div>
                    </div>
                        <div><!--Exportar Premios Canje -->
                            <div class="col1"></div>
                            <div class="col3">
                                <asp:ImageButton ID="imgPremiosEntregados" runat="server" ImageUrl="~/assets/img/excel.png" Width="30px" Height="30px" OnClick="imgPremiosEntregados_Click"/>
                            </div>
                            <div class="col1"></div>
                        </div>
                    <br/>
                </div><!-- Premios Entregados-->

                <br />


<br/>
        </div><!-- fin contenido-->

        <div class="col1"></div><!-- borde derecha en blanco-->

        </div>
                <div><br /><br/><br /></div><!-- FOOTER -->
    </div><!-- FIN TABLA CONTENIDO -->

    <br /><br /><br /><br />
</div><!-- FIN CONTENIDO-->


</asp:Content>
