<%@ Page Title="" Language="C#" MasterPageFile="~/Referidos/MPReferidos.master" AutoEventWireup="true" CodeBehind="DatosReferidos.aspx.cs" Inherits="ProyectoAndalucia.Referidos.DatosReferidos" EnableEventValidation = "false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph_master" runat="server">

<div>
<%--        <a href="photo.aspx" class="site-user">
            <img src="/assets/img/user.png" alt="logo"></a>--%>
        <nav id="primary-navigation" class="site-navigation">
            <div class="container">
                <ul class="nav navbar-nav navbar-right">
                    <li class="page-scroll"><a href="/Referidos/ConsultaPuntos.aspx">Tus Puntos</a></li>
                    <li class="page-scroll"><a href="/Referidos/DatosReferidos.aspx">Referidos</a></li>
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
        <div class="tabla">
            <div class="col1"></div><!-- borde izq en blanco-->
            
            <div class="col2"><!-- inicio contenido-->

                <div>
                    <div class="col1"></div>
                    <div><h3><b>REFERIDOS:</b></h3></div>
                    <div class="col1"></div>
                </div>
                <div class="borde_form">
                    <div>
                        <div class="col1"></div>
                        <div class="col3">
                            <asp:Label ID="lblMensajeProductos" runat="server" Text="" Width="200px"></asp:Label><br/>

                            <asp:GridView ID="gvReferidos" class="grid"  runat="server" AutoGenerateColumns="False" Font-Size="Medium" CellPadding="4" 
                            ForeColor="#333333" CellSpacing="5" GridLines="None" >
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
                    <br/>
                </div><!-- Solicitudes de canje-->
                <br />
                <div><!--Exportar Rechazados -->
                    <div class="col1"></div>
                    <div class="col3">
                        <asp:ImageButton ID="imgReferidos" runat="server" ImageUrl="~/assets/img/excel.png" Width="30px" Height="30px" OnClick="imgReferidos_Click"/>
                    </div>
                    <div class="col1"></div>
                </div>

        </div><!-- fin contenido-->

        <div class="col1"></div><!-- borde derecha en blanco-->

        </div>
                <div><br /><br/><br /></div><!-- FOOTER -->
    </div><!-- FIN TABLA CONTENIDO -->

    <br /><br /><br /><br />
</div><!-- FIN CONTENIDO-->




</asp:Content>
