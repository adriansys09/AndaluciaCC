<%@ Page Title="" Language="C#" MasterPageFile="~/Referidos/MPReferidos.master" AutoEventWireup="true" CodeBehind="NOCanjePremios.aspx.cs" Inherits="ProyectoAndalucia.Referidos.CanjePremios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph_master" runat="server">


    <div>
<%--        <a href="photo.aspx" class="site-user">
            <img src="/assets/img/user.png" alt="logo"></a>--%>
        <nav id="primary-navigation" class="site-navigation">
            <div class="container">

                <ul class="nav navbar-nav navbar-right">
                    <li class="page-scroll"><a href="/Referidos/ConsultaPuntos.aspx">Consulta de Puntos</a></li>
                    <li class="page-scroll"><a href="/Referidos/IngresoReferido.aspx">Ingreso de Referido</a></li>
                    <li class="page-scroll"><a href="/Referidos/CanjePremios.aspx">Canje de Premios</a></li>
                    <%--<li class="page-scroll"><a href="/Inicio.aspx">SALIR</a></li>--%>
                </ul>
                <!-- /.navbar-nav -->
            </div>
            <!-- /.navbar-collapse -->
        </nav>
        <!-- /.primary-navigation -->
    </div>


<div><!-- CONTENIDO-->

    <div class="tabla"><!-- TABLA CONTENIDO -->
        <div style="text-align: center">
            <h2><b>COLABORADOR ANDALUCÍA</b></h2>
        </div>
        <br />
        <div>
            <center>
                <div style="width:60%">
                    <img src="/assets/img/premios.png" alt="logo" />
                </div>
            </center>
        </div>
        <div>
            <div class="col1"></div>
            <!-- borde izq en blanco-->
            <div class="col2">
                <!-- inicio contenido-->
                <div class="borde_form">
                    <div class="col3"><b>CANJE PREMIOS</b></div>
                    <div class="col3">Seleccione los premios que desea canjear</div>
                    <div>
                        <div class="col3"></div>
                        <div class="col3" style="width: 200px">
                            <br />
                            <asp:RadioButton ID="rbPremio1" runat="server" Text=" GifCard x $50" /><br />
                            <asp:RadioButton ID="rbPremio2" runat="server" Text=" GifCard x $100" /><br />
                            <asp:RadioButton ID="rbPremio3" runat="server" Text=" GifCard x $200" /><br />
                        </div>
                        <div class="col1"></div>
                        <div class="col3">
                            <asp:Label ID="Label6" runat="server" Text="PUNTOS DISPONIBLES" Width="200px"></asp:Label><br />
                            <div class="borde_form col_center">
                                <asp:Label ID="Label27" runat="server" Text="50" Width="75px" Height="75px" Font-Size="40px"></asp:Label><br />
                            </div>
                        </div>
                        <div class="col1"></div>
                        <div class="col3">
                            <br />
                            <br />
                            <asp:Button ID="Button19" runat="server" Text="CANJEAR"></asp:Button>
                        </div>
                        <div class="col3"></div>
                    </div>

                </div>
                <!-- Puntos-->
                <br />
                <div class="borde_form">
                    <div class="col2"><b>PREMIOS CANJEADOS</b></div>
                    <div>

                        <div class="col3">
                            <asp:GridView ID="gvPuntos" runat="server"></asp:GridView>
                        </div>

                        <div class="col3"></div>
                    </div>

                </div>
                <!-- Canje-->
                <br />
                <div>
                    <center>
                        <asp:Button ID="Button1" runat="server" Text="Button" />
                    </center>
                </div>
            </div>
            <!-- fin contenido-->
            <div class="col3"></div>
            <!-- borde derecha en blanco-->
        </div>
        <div>
            <br />
            <br />
            <br />
            "footer" </div>
    </div><!-- FIN TABLA CONTENIDO -->
    <br /><br /><br /><br />    
</div><!-- FIN CONTENIDO-->
</asp:Content>
