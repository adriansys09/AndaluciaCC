﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Referidos/MPReferidos.master" AutoEventWireup="true" CodeBehind="IngresoReferido.aspx.cs" Inherits="ProyectoAndalucia.Referidos.IngresoReferido" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph_master" runat="server">
        
    <div class="site-user">
            <div style="padding-left: 2px; position: absolute; top: 10px; right: 10px; height:100px; width:100px;">
                <asp:ImageButton ID="btnImagen" runat="server" ImageUrl="~/assets/imguser/user.jpg"
                     Height="100px" Width="100px" BorderStyle="None" EnableTheming="False"
                     OnMouseOver = "cambiarimagen('btnImagen','286583.jpg')"
                      OnMouseOut = "cambiarimagen('btnImagen','user.jpg')"  />
<%--                <asp:Button ID="btnImagen1" runat="server" Text="ANDRES"
                     Height="100px" Width="100px" BorderStyle="None" EnableTheming="False" />--%>
<%--                <a href="photo.aspx" ><img src="/assets/img/user.png" alt="logo" Height="100px" Width="100px"></a>--%>
            </div>
        </div>

        <nav id="primary-navigation" class="site-navigation">
            <div class="container">
                <ul class="nav navbar-nav navbar-right">
                    <li class="page-scroll"><a href="/Referidos/RegistroProducto.aspx">Registro</a></li>
                    <li class="page-scroll"><a href="/Referidos/IngresoReferido.aspx">Ingresa un Referido</a></li>
                    <li class="page-scroll"><a href="/Inicio.aspx">SALIR</a></li>
                </ul>
                <!-- /.navbar-nav -->
            </div>
            <!-- /.navbar-collapse -->
        </nav>
        <!-- /.primary-navigation -->



<div><!-- CONTENIDO-->

    <div class="tablacontenido"><!-- TABLA CONTENIDO -->
        <%--<div style="text-align:center"><h2><b>COLABORADOR ANDALUCÍA</b></h2></div><br/>--%>
        <div>
            <div class="col3"></div><!-- borde izq en blanco-->
            <div class="col2"><!-- inicio contenido-->
                    <div class="col3"><h3><b>REGISTRO DE CLIENTE</b></h3></div>
                    <%--<div class="col3"> (Ingrese los datos del referido)</div>--%>

                <div class="borde_form">
                    <div>
                            <div class="col3"></div>        
                            <div class="col3">
                                <asp:Label ID="Label27" runat="server" Text="CÉDULA" Width="150px"></asp:Label><br/>
                                <asp:TextBox ID="txtCedC" runat="server" Width="150px" OnTextChanged="TextBox26_TextChanged"></asp:TextBox>
                                <asp:Label ID="lblMensajeC" runat="server" Text="" Width="150px"></asp:Label>
                                
                            </div>
                            <div class="col1"></div>
                        </div>
                    <div>
                            <div class="col3"></div>        
                            <div class="col3">
                                <asp:label id="Label17" runat="server" text="NOMBRES" width="300px"></asp:label><br/>
                                <asp:TextBox ID="TextBox17" runat="server" Width="300px" Enabled="False"></asp:TextBox>
                            </div>
                            <div class="col3"></div>        
                            <div class="col3">
                                <asp:Label ID="Label5" runat="server" Text="APELLIDO PATERNO" Width="200px"></asp:Label><br/>
                                <asp:TextBox ID="TextBox4" runat="server" Width="200px" Enabled="False"></asp:TextBox>
                            </div>
                            <div class="col3"></div>        
                            <div class="col3">
                                <asp:Label ID="Label6" runat="server" Text="APELLIDO MATERNO" Width="200px"></asp:Label><br/>
                                <asp:TextBox ID="TextBox5" runat="server" Width="200px" Enabled="False"></asp:TextBox>
                            </div>
                            <div class="col3"></div> 
                            <div class="col3">
                                <asp:Label ID="Label4" runat="server" Text="PRODUCTO" Width="200px"></asp:Label><br/>
                                <asp:DropDownList ID="ddlProducto" runat="server"  Width="200">
                                    <asp:ListItem></asp:ListItem>
                                    <asp:ListItem Value="aho">AHORROS</asp:ListItem>
                                    <asp:ListItem Value="dpf">PLAZO FIJO</asp:ListItem>
                                    <asp:ListItem Value="cre">CRÉDITO</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="col3"></div>
                        </div>
                    <div>
                            <div class="col3"></div>        
                            <div class="col3">
                                <asp:Label ID="Label2" runat="server" Text="CORREO" Width="300px"></asp:Label><br/>
                                <asp:TextBox ID="TextBox2" runat="server" Width="300px" Enabled="False"></asp:TextBox>
                            </div>
                            <div class="col3"></div>        
                            <div class="col3">
                                <asp:Label ID="Label3" runat="server" Text="PROVINCIA" Width="200px"></asp:Label><br/>
                                <asp:DropDownList ID="ddlProvincia" runat="server" Width="200" Enabled="False">
                                    <asp:ListItem>PICHINCHA</asp:ListItem>
                                    <asp:ListItem>SUCUMBIOS</asp:ListItem>
                                    <asp:ListItem>IMBABURA</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col3"></div>        
                            <div class="col3">
                                <asp:Label ID="Label7" runat="server" Text="CIUDAD" Width="200px"></asp:Label><br/>
                                <asp:DropDownList ID="ddlCiudad" runat="server"  Width="250" Enabled="False">
                                    <asp:ListItem Value="uio">QUITO</asp:ListItem>
                                    <asp:ListItem Value="pvm">PEDRO VICENTE MALDONADO</asp:ListItem>
                                    <asp:ListItem Value="lago">LAGO AGRIO</asp:ListItem>
                                    <asp:ListItem Value="urcu">URCUQUI</asp:ListItem>
                                    <asp:ListItem Value="cota">COTACACHI</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col3"></div>        
                            <div class="col3">
                                <asp:label id="Label1" runat="server" text="TELÉFONO" width="200px"></asp:label><br/>
                                <asp:TextBox ID="TextBox1" runat="server" Width="150px" Enabled="False"></asp:TextBox>
                            </div>
                            <div class="col3"></div>        
                        </div>
                    <div>
                            <div class="col3"></div>
                            <div class="col_center">
                                <asp:Button ID="Button19" runat="server" Text="AÑADIR"></asp:Button>
                                <asp:Button ID="Button20" runat="server" Text="ACTUALIZAR" Visible="false"></asp:Button>
                                <asp:Button ID="Button21" runat="server" Text="ELIMINAR" Visible="false"></asp:Button>
                            </div>
                            <div class="col3"><asp:GridView ID="GridView8" runat="server"></asp:GridView></div>
                            <div class="col3"></div>
                        </div><!-- Botones-->
                </div><!-- Puntos-->
<br/>
            </div><!-- fin contenido-->
            
            <div class="col3"></div><!-- borde derecha en blanco-->
        </div>
        <div><br /><br/><br /></div><!-- "footer"-->
    </div><!-- FIN TABLA CONTENIDO -->
    <br /><br /><br /><br />
</div><!-- FIN CONTENIDO-->


<script type="text/javascript">

    function cambiarimagen(btnImagen, nombreimagen) {
        var control = document.getElementById(btnImagen);
        control.src = '~/assets/imguser/' + nombreimagen;
    }

</script>

</asp:Content>
