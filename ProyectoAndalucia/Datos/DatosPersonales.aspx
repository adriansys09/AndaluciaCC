<%@ Page Title="" Language="C#" MasterPageFile="~/Datos/MPDatos.master" AutoEventWireup="true" CodeFile="DatosPersonales.aspx.cs" Inherits="Datos_Personales" %>
<%--<%@ Page Title="" Language="C#" MasterPageFile="~/UC.master" AutoEventWireup="true" CodeFile="DatosPersonales.aspx.cs" Inherits="Datos_Personales" %>--%>

<asp:Content ID="CDatosPersonales" ContentPlaceHolderID="cph_master" runat="Server">
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
                    <li class="page-scroll"><a href="#acceder">
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
        <div><center><h2>DATOS PERSONALES</h2></center></div><br/>
        <div>
            <div class="col1">IZQUIERDA</div><!-- borde izq en blanco-->

            <div class="col3"><!-- inicio contenido-->
                <div  class="borde_form">
                    <div>
                        <div class="col3"></div>        
                        <div class="col3"><asp:Label ID="Label1" runat="server" Text="APELLIDO PATERNO" Width="150px"></asp:Label></div>
                        <div class="col3"><asp:TextBox ID="TextBox1" runat="server" Width="150px"></asp:TextBox></div>
                        <div class="col1"></div>
                        <div class="col3"><asp:Label ID="Label2" runat="server" Text="APELLIDO MATERNO" Width="180px"></asp:Label></div>
                        <div class="col3"><asp:TextBox ID="TextBox2" runat="server" Width="150px"></asp:TextBox></div>
                        <div class="col1"></div>
                        <div class="col3"><asp:Label ID="Label3" runat="server" Text="NOMBRES" Width="150px"></asp:Label></div>
                        <div class="col3"><asp:TextBox ID="TextBox3" runat="server" Width="300px"></asp:TextBox></div>
                        <div class="col3"></div>
                    </div>
                    <br />
                    <div>
                        <div class="col3"></div>        
                        <div class="col3"><asp:Label ID="Label4" runat="server" Text="NACIONALIDAD"></asp:Label></div>
                        <div class="col3"><asp:TextBox ID="TextBox4" runat="server"></asp:TextBox></div>
                        <div class="col2"></div>
                        <div class="col3"><asp:Label ID="Label5" runat="server" Text="CÉDULA"></asp:Label></div>
                        <div class="col3"><asp:TextBox ID="TextBox5" runat="server"></asp:TextBox></div>
                        <div class="col2"></div>
                        <div class="col3"><asp:Label ID="Label6" runat="server" Text="ESTADO CIVIL" Width="150px"></asp:Label></div>
                        <div class="col3"><asp:TextBox ID="TextBox6" runat="server"></asp:TextBox></div>
                        <div class="col2"></div>        

                        <div class="col3"><div><asp:Label ID="Label30" runat="server" Text="SEXO" Width="50px"></asp:Label></div>
                            <div style="text-align:center; width:300px">
                            <asp:RadioButton ID="rbMasculino" runat="server" Text="MASCULINO" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:RadioButton ID="rbFemenino" runat="server" Text="FEMENINO" />
                            </div>
                        </div>

                        <div class="col2"></div>        
                        <div class="col3"><asp:Label ID="Label11" runat="server" Text="TIPO DE SANGRE" Width="150px"></asp:Label></div>
                        <div class="col2"></div>
                        <div class="col3"><asp:TextBox ID="TextBox10" runat="server" Width="100px"></asp:TextBox></div>
                        <div class="col2"></div>        
                    </div>
                </div>
                <br />
            <div  class="borde_form">
            <div class="col3"><b>LUGAR DE NACIMIENTO</b></div><br/>

<%--                    <div style="text-align:left"><h3>LUGAR DE NACIMIENTO</h3></div>--%>
                    <div class="col3"></div>
                    <div class="col3"><asp:Label ID="Label7" runat="server" Text="PAÍS"></asp:Label></div>
                    <div class="col3"><asp:TextBox ID="TextBox7" runat="server" Width="200px"></asp:TextBox></div>
                    <div class="col1"></div>
                    <div class="col3"><asp:Label ID="Label8" runat="server" Text="PROVINCIA" Width="100px"></asp:Label></div>
                    <div class="col3"><asp:TextBox ID="TextBox8" runat="server"></asp:TextBox></div>
                    <div class="col1"></div>
                    <div class="col3"><asp:Label ID="Label9" runat="server" Text="CANTÓN" Width="100px"></asp:Label></div>
                    <div class="col3"><asp:TextBox ID="TextBox9" runat="server" Width="200px"></asp:TextBox></div>
                    <div class="col1"></div>
                    <div class="col3"><asp:Label ID="Label12" runat="server" Text="FECHA DE NACIMIENTO" Width="200px"></asp:Label></div>
                    <div class="col3"><asp:TextBox ID="TextBox11" runat="server" Width="150px" EnableTheming="True" TextMode="Date"></asp:TextBox></div>
                    <div class="col1"></div>
                    <div class="col3"><asp:Label ID="Label13" runat="server" Text="EDAD" Width="70px"></asp:Label></div>
                    <div class="col3"><asp:TextBox ID="TextBox12" runat="server" Width="70px"></asp:TextBox></div>
                    <div class="col3"></div>
                </div>
                <br />
            <div  class="borde_form">
            <div class="col3"><b>DIRECCION DE RESIDENCIA ACTUAL</b></div><br/>
                <div>
                    <div class="col3"></div>
                    <div class="col3"><asp:Label ID="Label15" runat="server" Text="PROVINCIA" Width="100px"></asp:Label></div>
                    <div class="col3"><asp:TextBox ID="TextBox14" runat="server"></asp:TextBox></div>
                    <div class="col1"></div>
                    <div class="col3"><asp:Label ID="Label16" runat="server" Text="CANTÓN" Width="100px"></asp:Label></div>
                    <div class="col3"><asp:TextBox ID="TextBox15" runat="server" Width="200px"></asp:TextBox></div>
                    <div class="col1"></div>        
                    <div class="col3"><asp:Label ID="Label14" runat="server" Text="CALLE PRINCIPAL" Width="150px"></asp:Label></div>
                    <div class="col3"><asp:TextBox ID="TextBox13" runat="server" Width="200px"></asp:TextBox></div>
                    <div class="col1"></div>
                    <div class="col3"><asp:Label ID="Label17" runat="server" Text="NÚMERO" Width="100px"></asp:Label></div>
                    <div class="col3"><asp:TextBox ID="TextBox16" runat="server" Width="50px"></asp:TextBox></div>
                    <div class="col1"></div>        
                    <div class="col3"><asp:Label ID="Label18" runat="server" Text="INTERSECCIÓN" Width="150px"></asp:Label></div>
                    <div class="col3"><asp:TextBox ID="TextBox17" runat="server" Width="200px"></asp:TextBox></div>
                    <div class="col3"></div>
                </div>
            <br />
                    <div>
                        <div class="col3"></div>
                        <div class="col3"><asp:Label ID="Label19" runat="server" Text="CONJUNTO" Width="100px"></asp:Label></div>
                        <div class="col3"><asp:TextBox ID="TextBox18" runat="server"></asp:TextBox></div>
                        <div class="col1"></div>
                        <div class="col3"><asp:Label ID="Label20" runat="server" Text="EDIFICIO" Width="100px"></asp:Label></div>
                        <div class="col3"><asp:TextBox ID="TextBox19" runat="server" Width="200px"></asp:TextBox></div>
                        <div class="col1"></div>        
                        <div class="col3"><asp:Label ID="Label21" runat="server" Text="PISO" Width="70px"></asp:Label></div>
                        <div class="col3"><asp:TextBox ID="TextBox20" runat="server" Width="200px"></asp:TextBox></div>
                        <div class="col1"></div>
                        <div class="col3"><asp:Label ID="Label22" runat="server" Text="DEPARTAMENTO" Width="150px"></asp:Label></div>
                        <div class="col3"><asp:TextBox ID="TextBox21" runat="server" Width="50px"></asp:TextBox></div>
                        <div class="col3"></div>        
                        </div>
            <br/>
                    <div>
                    <div class="col3"></div>
                    <div class="col3"><asp:Label ID="Label23" runat="server" Text="MANZANA" Width="100px"></asp:Label></div>
                    <div class="col3"><asp:TextBox ID="TextBox22" runat="server"></asp:TextBox></div>
                    <div class="col1"></div>
                    <div class="col3"><asp:Label ID="Label24" runat="server" Text="BARRIO O SECTOR" Width="150px"></asp:Label></div>
                    <div class="col3"><asp:TextBox ID="TextBox23" runat="server" Width="150px"></asp:TextBox></div>
                    <div class="col1"></div>        
                    <div class="col3"><asp:Label ID="Label25" runat="server" Text="REFERENCIA" Width="120px"></asp:Label></div>
                    <div class="col3"><asp:TextBox ID="TextBox24" runat="server" Width="200px"></asp:TextBox></div>
                    <div class="col1"></div>
                    <div class="col3"><div><asp:Label ID="Label26" runat="server" Text="TIPO DE VIVIENDA" Width="150px"></asp:Label></div>
                        <div style="text-align:justify;width:450px">
                        <asp:RadioButton ID="rbPropia" runat="server" Text="PROPIA" />
                        &nbsp;
                        <asp:RadioButton ID="rbArrendada" runat="server" Text="ARRENDADA" />
                        &nbsp;
                        <asp:RadioButton ID="rbAnticresis" runat="server" Text="ANTICRESIS" />
                        &nbsp;
                        <asp:RadioButton ID="rbFamiliar" runat="server" Text="FAMILIAR" />
                        </div>
                    </div>
                    <div class="col3"></div>        
                    </div>
            <br/>
                    <div>
                    <div class="col3"></div>
                    <div class="col3"><asp:Label ID="Label27" runat="server" Text="PROFESION" Width="100px"></asp:Label></div>
                    <div class="col3"><asp:TextBox ID="TextBox25" runat="server"></asp:TextBox></div>
                    <div class="col1"></div>
                    <div class="col3"><asp:Label ID="Label28" runat="server" Text="ÁREA / AGENCIA ASIGNADA" Width="250px"></asp:Label></div>
                    <div class="col3"><asp:TextBox ID="TextBox26" runat="server" Width="150px"></asp:TextBox></div>
                    <div class="col1"></div>        
                    <div class="col3"><asp:Label ID="Label29" runat="server" Text="CARGO ACTUAL" Width="150px"></asp:Label></div>
                    <div class="col3"><asp:TextBox ID="TextBox27" runat="server" Width="200px"></asp:TextBox></div>
                    <div class="col3"></div>
                    </div>
                </div>

            <br />
            <div  class="borde_form">
            <div class="col3"><b>CONTACTOS</b></div><br/>
                    <div class="col3"></div>
                    <div class="col3"><asp:Label ID="Label10" runat="server" Text="TELÉFONO DOMICILIO" Width="200px"></asp:Label></div>
                    <div class="col3"><asp:TextBox ID="TextBox28" runat="server"></asp:TextBox></div>
                    <div class="col1"></div>
                    <div class="col3"><asp:Label ID="Label31" runat="server" Text="TELÉFONO CELULAR" Width="200px"></asp:Label></div>
                    <div class="col3"><asp:TextBox ID="TextBox29" runat="server" Width="200px"></asp:TextBox></div>
                    <div class="col1"></div>        
                    <div class="col3"><asp:Label ID="Label32" runat="server" Text="CORREO ELECTRÓNICO" Width="250px"></asp:Label>
                        <div class="col3"><asp:Label ID="Label33" runat="server" Text="CORPORATIVO" Width="150px"></asp:Label></div>
                        <div class="col3"><asp:TextBox ID="TextBox31" runat="server" Width="200px"></asp:TextBox></div>
                        <div class="col3"><asp:Label ID="Label34" runat="server" Text="PERSONAL" Width="150px"></asp:Label></div>
                        <div class="col3"><asp:TextBox ID="TextBox32" runat="server" Width="200px"></asp:TextBox></div>
                    </div>
                    <div class="col3"></div>
                </div>
            <br />
                    <div>
                    <asp:Button ID="Button1" runat="server" Text="Button" />
                    </div>
            </div><!-- fin contenido-->
        
            <div class="col1">DERECHA</div><!-- borde der en blanco-->
        </div>
        <div><br /><br/><br />"footer" </div>
        </div><!-- FIN TABLA CONTENIDO -->
    <br /><br /><br /><br />
</div><!-- FIN CONTENIDO-->
</asp:Content>

