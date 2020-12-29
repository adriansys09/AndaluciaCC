<%@ Page Title="" Language="C#" MasterPageFile="~/Datos/MPDatos.master" AutoEventWireup="true" CodeFile="DatosFamiliares.aspx.cs" Inherits="Datos_Datos_Familiares" %>

<asp:Content ID="CDatosFamiliares" ContentPlaceHolderID="cph_master" Runat="Server">

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
<div><h2>DATOS DE FAMILIARES</h2></div>
<div>
<div class="col3"></div><!-- borde izq en blanco-->
<div class="col2"><!-- inicio contenido-->
    <div>
        <div style="text-align:left"><h5><b>NOMBRE COMPLETO DEL CONYUGE</b></h5></div>
        <div class="col3"></div>  
        <div class="col3"><asp:Label ID="Label1" runat="server" Text="APELLIDO PATERNO" Width="150px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox1" runat="server" Width="200px"></asp:TextBox></div>
        <div class="col2"></div>
       <div class="col3"><asp:Label ID="Label14" runat="server" Text="APELLIDO MATERNO" Width="180px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox11" runat="server" Width="200px"></asp:TextBox></div>
        <div class="col2"></div>
        <div class="col3"><asp:Label ID="Label2" runat="server" Text="NOMBRES" Width="100px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox2" runat="server" Width="300px"></asp:TextBox></div>
        <div class="col2"></div>
        <div class="col3"><asp:Label ID="Label3" runat="server" Text="FECHA DE NACIMIENTO" Width="200px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox3" runat="server" Width="150px" EnableTheming="True" TextMode="Date"></asp:TextBox></div>
        <div class="col3"></div>        
    </div>
    <br />
    <div>
        <div class="col3"></div>
        <div class="col3"><asp:Label ID="Label4" runat="server" Text="NACIONALIDAD"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox4" runat="server"></asp:TextBox></div>
        <div class="col1"></div>
        <div class="col3"><asp:Label ID="Label5" runat="server" Text="CÉDULA"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox5" runat="server"></asp:TextBox></div>
        <div class="col1"></div>
        <div class="col3"><asp:Label ID="Label6" runat="server" Text="LUGAR DE TRABAJO" Width="150"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox6" runat="server"></asp:TextBox></div>
        <div class="col1"></div>        
        <div class="col3"><asp:Label ID="Label10" runat="server" Text="TELÉFONO"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox10" runat="server"></asp:TextBox></div>
        <div class="col3"></div>        
    </div>
    <br />
    <div>
        <div class="col3"></div>        
        <div class="col3"><asp:Label ID="Label7" runat="server" Text="FECHA INICIO SOCIEDAD CONYUGAL O UNION DE HECHO" Width="300px"></asp:Label>
            <asp:TextBox ID="TextBox7" runat="server" Width="300px"></asp:TextBox></div>
        <div class="col1"></div>
        <div class="col3"><div><asp:Label ID="Label8" runat="server" Text="TIENE SEPARACIÓN DE BIENES" Width="250px"></asp:Label></div>
            <div style="text-align:center; width:400px">
            <asp:RadioButton ID="rbSeparacionS" runat="server" Text="SI" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:RadioButton ID="rbSeparacionN" runat="server" Text="NO" />
            </div>
        </div>
        <div class="col1"></div>        
        <div class="col3"><div><asp:Label ID="Label9" runat="server" Text="TIENE ACTIVIDAD ECONÓMICA" Width="250px"></asp:Label></div>
            <div style="text-align:center; width:400px">
            <asp:RadioButton ID="RadioButton1" runat="server" Text="SI" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:RadioButton ID="RadioButton2" runat="server" Text="NO" />
            </div>
        </div>
        <div class="col3"></div>        
    </div>
<br />
    <div>
        <div class="col3"></div>        
        <div class="col3"><div><asp:Label ID="Label11" runat="server" Text="¿TIENE HIJOS MENORES DE 18 AÑOS?" Width="250px"></asp:Label></div>
            <div style="text-align:center; width:400px">
            <asp:RadioButton ID="RadioButton3" runat="server" Text="SI" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:RadioButton ID="RadioButton4" runat="server" Text="NO" />
            </div>
        </div>
        <div class="col1"></div>   
        <div class="col3"><asp:Label ID="Label15" runat="server" Text="NÚMERO DE HIJOS MENORES DE 18 AÑOS" Width="250px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox14" runat="server" Width="50px"></asp:TextBox></div>
        <div class="col3"></div>        
    </div>
<br />
    <div>
        <div style="text-align:left"><h5><b>DATOS DE LOS HIJOS</b></h5></div>
        <div class="col3"></div>        
        <div class="col3"><asp:Label ID="Label13" runat="server" Text="APELLIDO MATERNO" Width="180px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox9" runat="server" Width="150px"></asp:TextBox></div>
        <div class="col1"></div>        
        <div class="col3"><asp:Label ID="Label12" runat="server" Text="APELLIDO PATERNO" Width="180px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox8" runat="server" Width="150px"></asp:TextBox></div>
        <div class="col1"></div>        
        <div class="col3"><asp:Label ID="Label20" runat="server" Text="NOMBRES" Width="150px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox19" runat="server" Width="200px"></asp:TextBox></div>
        <div class="col1"></div>        
        <div class="col3"><asp:Label ID="Label21" runat="server" Text="FECHA DE NACIMIENTO" Width="200px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox20" runat="server" Width="150px" EnableTheming="True" TextMode="Date"></asp:TextBox></div>
        <div class="col2"></div>
        <div class="col3"><asp:Label ID="Label22" runat="server" Text="EDAD" Width="50px"></asp:Label></div>
        <div class="col3"><asp:TextBox ID="TextBox21" runat="server" Width="50px"></asp:TextBox></div>
        <div class="col3"></div>        
        </div>
<br />
    <div>
        <div class="col1"></div>
        <div class="col3"><asp:Button ID="btnAddhijo" runat="server" Text="AÑADIR"></asp:Button><asp:Button ID="btnUphijo" runat="server" Text="ACTUALIZAR" Visible="false"></asp:Button><asp:Button ID="btnDelhijo" runat="server" Text="ELIMINAR" Visible="false"></asp:Button></div>
        <div class="col3"><asp:GridView ID="GridView1" runat="server"></asp:GridView></div>
        <div class="col1"></div>
    </div>
<br/>
        <div>
            <asp:Button ID="btnGuardaFamilia" runat="server" Text="GUARDAR DATOS DE FAMILIARES" />
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
