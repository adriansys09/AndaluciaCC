<%@ Page Title="" Language="C#" MasterPageFile="~/Datos/MPDatos.master" AutoEventWireup="true" CodeFile="DatosEstudios.aspx.cs" Inherits="Datos_DatosEstudios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_master" Runat="Server">

        <div>
        <a href="photo.aspx" class="site-user">
            <img src="/assets/img/user.png" alt="logo"></a>
        <nav id="primary-navigation" class="site-navigation">
            <div class="container">

                <ul class="nav navbar-nav navbar-right">
                    <li class="page-scroll"><a href="Datos/DatosPersonales.aspx">Datos Personales</a></li>
                    <li class="page-scroll"><a href="Datos/DatosFamiliares.aspx">Datos Familiares</a></li>
                    <li class="page-scroll"><a href="Datos/DatosEstudios.aspx">Estudios</a></li>
                    <li class="page-scroll"><a href="Datos/DatosPatrimonio.aspx">Patrimonio</a></li>
                    <li class="page-scroll"><a href="Datos/DatosReferencia.aspx">Referencias</a></li>
                    <li class="page-scroll"><a href="#home">SALIR</a></li>
                </ul>
                <!-- /.navbar-nav -->
            </div>
            <!-- /.navbar-collapse -->
        </nav>
        <!-- /.primary-navigation -->
    </div>

    <!-- CONTENIDO-->
    <div>

        <!-- TABLA CONTENIDO -->

        <center>
<div class="tablacontenido">
<div><h2>ESTUDIOS Y CONOCIMIENTOS</h2></div>
<div>
<div class="col3"></div><!-- borde izq en blanco-->
<div class="col2"><!-- inicio contenido-->

    <div>
        <div style="text-align:left"><h3>ESTUDIOS REALIZADOS</h3></div>
        <div class="col3"></div>        
        <div class="col3"><asp:Label ID="Label19" runat="server" Text="TIPO DE ESTUDIOS" Width="180px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox18" runat="server" Width="200px"></asp:TextBox></div>
        <div class="col1"></div>        
        <div class="col3"><asp:Label ID="Label20" runat="server" Text="INSTITUCIÓN" Width="180px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox19" runat="server" Width="200px"></asp:TextBox></div>
        <div class="col1"></div>        
        <div class="col3"><asp:Label ID="Label21" runat="server" Text="PERÍODO" Width="150px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox20" runat="server" Width="120px"></asp:TextBox></div>
        <div class="col1"></div>        
        <div class="col3"><asp:Label ID="Label22" runat="server" Text="TÍTULO OBTENIDO" Width="200px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox21" runat="server" Width="200px"></asp:TextBox></div>
        <div class="col3"></div>        
        </div>
<br />
    <div>
        <div class="col3"></div>
        <div class="col3"><asp:Button ID="btnAddhijo" runat="server" Text="AÑADIR" OnClick="btnAddhijo_Click"></asp:Button><asp:Button ID="btnUphijo" runat="server" Text="ACTUALIZAR" Visible="false"></asp:Button><asp:Button ID="btnDelhijo" runat="server" Text="ELIMINAR" Visible="false"></asp:Button></div>
        <div class="col3"><asp:GridView ID="GridView1" runat="server"></asp:GridView></div>
        <div class="col3"></div>
    </div>

<br/>
    <div>
        <div style="text-align:left"><h3>ESTUDIOS ACTUALES</h3></div>
        <div class="col3"></div>        
        <div class="col3"><asp:Label ID="Label23" runat="server" Text="INSTITUCIÓN" Width="200px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox22" runat="server" Width="200px"></asp:TextBox></div>
        <div class="col1"></div>        
        <div class="col3"><asp:Label ID="Label24" runat="server" Text="CARRERA" Width="150px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox23" runat="server" Width="200px"></asp:TextBox></div>
        <div class="col1"></div>        
        <div class="col3"><asp:Label ID="Label25" runat="server" Text="AÑO CURSO" Width="200px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox24" runat="server" Width="200px"></asp:TextBox></div>
        <div class="col3"></div>
    </div>
<br/>
    <div>
        <div class="col3"></div>        
        <div class="col3"><asp:Label ID="Label26" runat="server" Text="FECHA DE FINALIZACIÓN" Width="200px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox28" runat="server" Width="200px" EnableTheming="True" TextMode="Date"></asp:TextBox></div>
        <div class="col1"></div>        
        <div class="col3"><asp:Label ID="Label30" runat="server" Text="HORARIO" Width="150px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox29" runat="server" Width="200px"></asp:TextBox></div>
        <div class="col1"></div>        
        <div class="col3"><asp:Label ID="Label31" runat="server" Text="TÍTULO A OBTENER" Width="200px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox30" runat="server" Width="200px"></asp:TextBox></div>
        <div class="col3"></div>        
        </div>
<br />
    <div>
        <div class="col3"></div>
        <div class="col3"><asp:Button ID="Button2" runat="server" Text="AÑADIR"></asp:Button><asp:Button ID="Button3" runat="server" Text="ACTUALIZAR" Visible="false"></asp:Button><asp:Button ID="Button4" runat="server" Text="ELIMINAR" Visible="false"></asp:Button></div>
        <div class="col3"><asp:GridView ID="GridView2" runat="server"></asp:GridView></div>
        <div class="col3"></div>
    </div>
<br/>



    <div>
        <div style="text-align:left"><h3>CAPACITACIONES</h3></div>
        <div class="col3"></div>        
        <div class="col3"><asp:Label ID="Label1" runat="server" Text="TEMA DE LA CAPACITACIÓN" Width="200px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox1" runat="server" Width="200px"></asp:TextBox></div>
        <div class="col1"></div>        
        <div class="col3"><asp:Label ID="Label2" runat="server" Text="INSTITUCIÓN CAPACITADORA" Width="200px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox2" runat="server" Width="200px"></asp:TextBox></div>
        <div class="col1"></div>        
        <div class="col3"><asp:Label ID="Label3" runat="server" Text="TIEMPO DE DURACIÓN" Width="150px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox3" runat="server" Width="120px"></asp:TextBox></div>
        <div class="col3"></div>        
        </div>
<br />
    <div>
        <div class="col3"></div>
        <div class="col3"><asp:Button ID="Button5" runat="server" Text="AÑADIR"></asp:Button><asp:Button ID="Button6" runat="server" Text="ACTUALIZAR" Visible="false"></asp:Button><asp:Button ID="Button7" runat="server" Text="ELIMINAR" Visible="false"></asp:Button></div>
        <div class="col3"><asp:GridView ID="GridView3" runat="server"></asp:GridView></div>
        <div class="col3"></div>
    </div>
<br/>

    <div>
        <div style="text-align:left"><h3>CONOCIMIENTOS ADICIONALES</h3></div>
        <div style="text-align:left">Por favor ingresar el nivel de conocimiento en las áreas de IDIOMAS, COMPUTACIÓN/TECNOLOGÍA y OTROS.</div>
        <div class="col3"></div>        
        <div class="col3"><asp:Label ID="Label4" runat="server" Text="ÁREA" Width="200px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox4" runat="server" Width="200px"></asp:TextBox></div>
        <div class="col1"></div>        
        <div class="col3"><asp:Label ID="Label5" runat="server" Text="NIVEL DE CONOCIMIENTO (%)" Width="50px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox5" runat="server" Width="200px"></asp:TextBox></div>
        <div class="col3"></div>
        </div>
<br />
    <div>
        <div class="col3"></div>
        <div class="col3"><asp:Button ID="Button8" runat="server" Text="AÑADIR"></asp:Button><asp:Button ID="Button9" runat="server" Text="ACTUALIZAR" Visible="false"></asp:Button><asp:Button ID="Button10" runat="server" Text="ELIMINAR" Visible="false"></asp:Button></div>
        <div class="col3"><asp:GridView ID="GridView4" runat="server"></asp:GridView></div>
        <div class="col3"></div>
    </div>
<br/>


<br/>
        <div>
            <asp:Button ID="btnEducacion" runat="server" Text="GUARDAR EDUCACIÓN" />
        </div>
            
            </div><!-- fin contenido-->
            <div class="col3">DERECHA</div><!-- borde der en blanco-->
        </div>
        <div>"footer" </div>
    </div><!-- FIN TABLA CONTENIDO -->
</center>
 <br /><br /><br /><br />
</div><!-- FIN CONTENIDO-->
</asp:Content>

