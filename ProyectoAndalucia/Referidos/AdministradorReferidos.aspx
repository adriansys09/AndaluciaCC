<%@ Page Title="" Language="C#" MasterPageFile="~/Referidos/MPReferidos.master" AutoEventWireup="true" CodeBehind="AdministradorReferidos.aspx.cs" Inherits="ProyectoAndalucia.Referidos.AdministradorReferidos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph_master" runat="server">



    <div>
<%--        <a href="photo.aspx" class="site-user">
            <img src="/assets/img/user.png" alt="logo"></a>--%>
        <nav id="primary-navigation" class="site-navigation">
            <div class="container">

                <ul class="nav navbar-nav navbar-right">
                    <li class="page-scroll"><a href="Referidos/AdministradorReferidos.aspx">Administrador</a></li>
<%--                    <li class="page-scroll"><a href="#acceder" /></li>--%>
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
        <div><center><h2><b>ADMINISTRADOR REFERIDOS</b></h2></center></div><br/>
        <div>
        <div class="col1"></div><!-- borde izq en blanco-->

        <div class="col3"><!-- inicio contenido-->

        <div  class="borde_form">
            <div class="col3"><b>DATOS DE PRODUCTOS</b></div>
            <div class="col3">Productos Andalucia</></div>
            <div>
                <div class="col3"></div>        
                <div class="col3">
                    <asp:label id="Label17" runat="server" text="NOMBRES" width="300px"></asp:label><br/>
                    <asp:TextBox ID="TextBox17" runat="server" Width="300px"></asp:TextBox>
                </div>
                <div class="col1"></div>        
                <div class="col3"><asp:Label ID="Label5" runat="server" Text="APELLIDO PATERNO" Width="200px"></asp:Label><br/>
                <asp:TextBox ID="TextBox4" runat="server" Width="200px"></asp:TextBox></div>
                <div class="col1"></div>        
                <div class="col3"><asp:Label ID="Label6" runat="server" Text="APELLIDO MATERNO" Width="200px"></asp:Label><br/>
                <asp:TextBox ID="TextBox5" runat="server" Width="200px"></asp:TextBox></div>
                <div class="col1"></div>        
                <div class="col3">
                    <asp:Label ID="Label27" runat="server" Text="TELÉFONO" Width="150px" EnableTheming="True" TextMode="Date"></asp:Label><br/>
                    <asp:TextBox ID="TextBox26" runat="server" Width="150px"></asp:TextBox></div>
                <div class="col1"></div>        
                <div class="col3"><asp:Label ID="Label29" runat="server" Text="DIRECCIÓN" Width="300px"></asp:Label><br/>
                <asp:TextBox ID="TextBox31" runat="server" Width="300px"></asp:TextBox></div>
                <div class="col3"></div>        
            </div>
            <div>
        <div class="col3"></div>
        <div class="col3">
    <asp:Button ID="Button19" runat="server" Text="AÑADIR"></asp:Button>
    <asp:Button ID="Button20" runat="server" Text="ACTUALIZAR" Visible="false"></asp:Button>
    <asp:Button ID="Button21" runat="server" Text="ELIMINAR" Visible="false"></asp:Button></div>
        <div class="col3"><asp:GridView ID="GridView8" runat="server"></asp:GridView></div>
        <div class="col3"></div>
    </div><!-- Botones-->
         </div><!-- Referidos-->
<br/>
            <div>
                <center>
                    <asp:Button ID="Button1" runat="server" Text="Button" />
                </center>
            </div>
        </div><!-- fin contenido-->


        <div class="col3"><!-- inicio contenido-->

        <div  class="borde_form">
            <div class="col3"><b>DATOS DE PREMIOS</b></div>
            <div class="col3">Premios Andalucia</></div>
            <div>
                <div class="col3"></div>        
                <div class="col3">
                    <asp:label id="Label1" runat="server" text="NOMBRES" width="300px"></asp:label><br/>
                    <asp:TextBox ID="TextBox1" runat="server" Width="300px"></asp:TextBox>
                </div>
                <div class="col1"></div>        
                <div class="col3"><asp:Label ID="Label2" runat="server" Text="APELLIDO PATERNO" Width="200px"></asp:Label><br/>
                <asp:TextBox ID="TextBox2" runat="server" Width="200px"></asp:TextBox></div>
                <div class="col1"></div>        
                <div class="col3"><asp:Label ID="Label3" runat="server" Text="APELLIDO MATERNO" Width="200px"></asp:Label><br/>
                <asp:TextBox ID="TextBox3" runat="server" Width="200px"></asp:TextBox></div>
                <div class="col1"></div>        
                <div class="col3">
                    <asp:Label ID="Label4" runat="server" Text="TELÉFONO" Width="150px" EnableTheming="True" TextMode="Date"></asp:Label><br/>
                    <asp:TextBox ID="TextBox6" runat="server" Width="150px"></asp:TextBox></div>
                <div class="col1"></div>        
                <div class="col3"><asp:Label ID="Label7" runat="server" Text="DIRECCIÓN" Width="300px"></asp:Label><br/>
                <asp:TextBox ID="TextBox7" runat="server" Width="300px"></asp:TextBox></div>
                <div class="col3"></div>        
            </div>
            <div>
        <div class="col3"></div>
        <div class="col3">
    <asp:Button ID="Button2" runat="server" Text="AÑADIR"></asp:Button>
    <asp:Button ID="Button3" runat="server" Text="ACTUALIZAR" Visible="false"></asp:Button>
    <asp:Button ID="Button4" runat="server" Text="ELIMINAR" Visible="false"></asp:Button></div>
        <div class="col3"><asp:GridView ID="GridView1" runat="server"></asp:GridView></div>
        <div class="col3"></div>
    </div><!-- Botones-->
         </div><!-- Referidos-->
<br/>
            <div>
                <center>
                    <asp:Button ID="Button5" runat="server" Text="Button" />
                </center>
            </div>
        </div><!-- fin contenido-->

        <div class="col1"></div><!-- borde derecha en blanco-->

        </div>
        <div><br /><br/><br />"footer" </div>
    </div><!-- FIN TABLA CONTENIDO -->

    <br /><br /><br /><br />
</div><!-- FIN CONTENIDO-->


</asp:Content>
