<%@ Page Title="" Language="C#" MasterPageFile="~/Datos/MPDatos.master" AutoEventWireup="true" CodeFile="DatosReferencia.aspx.cs" Inherits="Datos_DatosReferencia" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph_master" Runat="Server">

    <div>
        <a href="photo.aspx" class="site-user">
            <img src="/assets/img/user.png" alt="logo"></a>
        <nav id="primary-navigation" class="site-navigation">
            <div class="container">

                <ul class="nav navbar-nav navbar-right">
                    <li class="page-scroll"><a href="/Datos/DatosPersonales.aspx">Datos Personales</a></li>
                    <li class="page-scroll"><a href="/Datos/DatosFamiliares.aspx">Datos Familiares</a></li>
                    <li class="page-scroll"><a href="/Datos/DatosEstudios.aspx">Estudios</a></li>
                    <li class="page-scroll"><a href="/Datos/DatosPatrimonio.aspx">Patrimonio</a></li>
                    <li class="page-scroll"><a href="/Datos/DatosReferencia.aspx">Referencias</a></li>
                    <li class="page-scroll"><a href="#acceder"></a></li>
                    <li class="page-scroll"><a href="/Inicio.aspx">SALIR</a></li>
                </ul>
                <!-- /.navbar-nav -->
            </div>
            <!-- /.navbar-collapse -->
        </nav>
        <!-- /.primary-navigation -->
    </div>

<div><!-- CONTENIDO-->

    <div class="tablacontenido"><!-- TABLA CONTENIDO -->
        <div><center><h2><b>INFORMACIÓN PATRIMONIAL</b></h2></center></div><br/>
        <div>
            <div class="col1"></div>
            <!-- borde izq en blanco-->
            <div class="col2">
                <!-- inicio contenido-->
                <div class="borde_form">
                    <div class="col3"><b>REFERENCIAS</b></div>
                    <div class="col3">Dos personas de contacto para casos de emergencia</div>
                    <div>
                        <div class="col3"></div>
                        <div class="col3">
                            <asp:Label ID="Label17" runat="server" Text="NOMBRES" Width="300px"></asp:Label><br />
                            <asp:TextBox ID="TextBox17" runat="server" Width="300px"></asp:TextBox>
                        </div>
                        <div class="col3"></div>
                        <div class="col3">
                            <asp:Label ID="Label5" runat="server" Text="APELLIDO PATERNO" Width="200px"></asp:Label><br />
                            <asp:TextBox ID="TextBox4" runat="server" Width="200px"></asp:TextBox>
                        </div>
                        <div class="col3"></div>
                        <div class="col3">
                            <asp:Label ID="Label6" runat="server" Text="APELLIDO MATERNO" Width="200px"></asp:Label><br />
                            <asp:TextBox ID="TextBox5" runat="server" Width="200px"></asp:TextBox>
                        </div>
                        <div class="col3"></div>
                        <div class="col3">
                            <asp:Label ID="Label27" runat="server" Text="TELÉFONO" Width="150px" EnableTheming="True" TextMode="Date"></asp:Label><br />
                            <asp:TextBox ID="TextBox26" runat="server" Width="150px"></asp:TextBox>
                        </div>
                        <div class="col3"></div>
                        <div class="col3">
                            <asp:Label ID="Label29" runat="server" Text="DIRECCIÓN" Width="300px"></asp:Label><br />
                            <asp:TextBox ID="TextBox31" runat="server" Width="300px"></asp:TextBox>
                        </div>
                        <div class="col3"></div>
                    </div>
                    <div>
                        <div class="col3"></div>
                        <div class="col3">
                            <asp:Button ID="Button19" runat="server" Text="AÑADIR"></asp:Button>
                            <asp:Button ID="Button20" runat="server" Text="ACTUALIZAR" Visible="false"></asp:Button>
                            <asp:Button ID="Button21" runat="server" Text="ELIMINAR" Visible="false"></asp:Button>
                        </div>
                        <div class="col3">
                            <asp:GridView ID="GridView8" runat="server">

                            </asp:GridView>
                        </div>
                        <div class="col3"></div>
                    </div>
                    <!-- Botones-->
                </div>
                <!-- Referencias Personales-->
                <br />
                <div class="borde_form">
                    <div class="col3"><b>PARIENTES</b></div>
                    <div class="col3">Mis parientes hasta el cuarto grado de consanguinidad (Padres, hijos, hermanos, abuelos, nietos, tíos, sobirnos. primos hermanos) y hasta el segundo de afinidad (cónyuge, suegros, nueras, yernos, cuñados, abuelos políticos) , de conformidad a lo establecido en los Art. 22 y 23 del Código Civil vigente son los siguientes: (favor llenar la información completa)</></div>
                    <div>
                        <div class="col3"></div>
                        <div class="col3">
                            <asp:Label ID="Label2" runat="server" Text="PARENTESCO" Width="150px"></asp:Label><br />
                            <asp:DropDownList ID="DropDownList1" runat="server">
                                <asp:ListItem Value="cta_ahorros">Padres</asp:ListItem>
                                <asp:ListItem Value="cta_corriente">Hijos</asp:ListItem>
                                <asp:ListItem Value="cta_ahorros">Hermanos</asp:ListItem>
                                <asp:ListItem Value="cta_corriente">Abuelos</asp:ListItem>
                                <asp:ListItem Value="cta_ahorros">Nietos</asp:ListItem>
                                <asp:ListItem Value="cta_corriente">Tios</asp:ListItem>
                                <asp:ListItem Value="cta_ahorros">Sobrinos</asp:ListItem>
                                <asp:ListItem Value="cta_corriente">Primos</asp:ListItem>
                                <asp:ListItem Value="cta_ahorros">Conyuge</asp:ListItem>
                                <asp:ListItem Value="cta_corriente">Suegro/a</asp:ListItem>
                                <asp:ListItem Value="cta_ahorros">Yerno</asp:ListItem>
                                <asp:ListItem Value="cta_corriente">Nuera</asp:ListItem>
                                <asp:ListItem Value="cta_ahorros">Cuñados(hermanos del conyuge)</asp:ListItem>
                                <asp:ListItem Value="cta_corriente">Cuñados(conyugue de mis hermanos)</asp:ListItem>
                                <asp:ListItem Value="cta_ahorros">Abuelos Políticos</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col1"></div>
                        <div class="col3">
                            <asp:Label ID="Label1" runat="server" Text="NOMBRES" Width="200px"></asp:Label><br />
                            <asp:TextBox ID="TextBox1" runat="server" Width="200px"></asp:TextBox>
                        </div>
                        <div class="col1"></div>
                        <div class="col1"></div>
                        <div class="col3">
                            <asp:Label ID="Label7" runat="server" Text="APELLIDO PATERNO" Width="160px"></asp:Label><br />
                            <asp:TextBox ID="TextBox6" runat="server" Width="150px"></asp:TextBox>
                        </div>
                        <div class="col1"></div>
                        <div class="col1"></div>
                        <div class="col3">
                            <asp:Label ID="Label8" runat="server" Text="APELLIDO MATERNO" Width="160px"></asp:Label><br />
                            <asp:TextBox ID="TextBox7" runat="server" Width="150px"></asp:TextBox>
                        </div>
                        <div class="col1"></div>
                        <div class="col3">
                            <asp:Label ID="Label3" runat="server" Text="CÉDULA" Width="100px" EnableTheming="True" TextMode="Date"></asp:Label><br />
                            <asp:TextBox ID="TextBox2" runat="server" Width="100px"></asp:TextBox>
                        </div>
                        <div class="col3"></div>
                    </div>
                    <div>
                        <div class="col3"></div>
                        <div class="col3">
                            <asp:Button ID="Button2" runat="server" Text="AÑADIR"></asp:Button>
                            <asp:Button ID="Button3" runat="server" Text="ACTUALIZAR" Visible="false"></asp:Button>
                            <asp:Button ID="Button4" runat="server" Text="ELIMINAR" Visible="false"></asp:Button>
                        </div>
                        <div class="col3">
                            <asp:GridView ID="GridView1" runat="server"></asp:GridView>
                        </div>
                        <div class="col3"></div>
                    </div>
                    <!-- Botones-->
                </div>
                <!-- Parientes -->

                <br />
                <div>
                    <center>
                        <asp:Button ID="Button1" runat="server" Text="Button" />
                    </center>
                </div>
            </div>
            <!-- fin contenido-->
            <div class="col1"></div>
            <!-- borde derecha en blanco-->
        </div>
        <div><br /><br/><br />"footer" </div>
    </div><!-- FIN TABLA CONTENIDO -->
    <br /><br /><br /><br />
</div><!-- FIN CONTENIDO-->
</asp:Content>

