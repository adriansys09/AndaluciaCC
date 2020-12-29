<%@ Page Title="" Language="C#" MasterPageFile="~/Datos/MPDatos.master" AutoEventWireup="true" CodeFile="DatosPatrimonio.aspx.cs" Inherits="Datos_DatosPatrimonio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph_master" runat="Server">

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
                    <li class="page-scroll"><a href="#home">SALIR</a></li>
                </ul>
                <!-- /.navbar-nav -->
            </div>
            <!-- /.navbar-collapse -->
        </nav>
        <!-- /.primary-navigation -->
    </div>


<div><!-- CONTENIDO-->

    <div class="tablacontenido">  <!-- TABLA CONTENIDO -->
        <div style="text-align:center"><h2><b>INFORMACIÓN PATRIMONIAL</b></h2></div><br/>
        <div>
        <div class="col1"></div><!-- borde izq en blanco-->

        <div class="col3"><!-- inicio contenido-->
        <div  class="borde_form">
            <div class="col3"><b>BIENES INMUEBLES</b> ( CASAS, TERRENOS, EDIFICIOS, ETC )</div>
            <div>
                <div class="col3">
                    <asp:Label ID="Label19" runat="server" Text="DESCRIPCIÓN" Width="400px"></asp:Label><br/>
                    <asp:TextBox ID="TextBox18" runat="server" Width="400px"></asp:TextBox>
                </div>
                <div class="col1"></div>
                <div class="col3">
                    <asp:Label ID="Label21" runat="server" Text="FECHA ADQUISICIÓN" Width="180px" EnableTheming="True" TextMode="Date"></asp:Label><br />
                    <asp:TextBox ID="TextBox20" runat="server" Width="180px" EnableTheming="True" TextMode="Date"></asp:TextBox>
                </div>
                <div class="col1"></div>
                <div class="col3">
                    <center>
                        <asp:Label ID="Label2" runat="server" Text="HIPOTECA" Width="150px"></asp:Label>
                    </center>
                        <div style="text-align: center; width: 150px">
                            <asp:RadioButton ID="rbSeparacionS" runat="server" Text="SI" />
                            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                            <asp:RadioButton ID="rbSeparacionN" runat="server" Text="NO" />
                        </div>
                </div>
                <div class="col1"></div>
                <div class="col3">
                    <asp:Label ID="Label3" runat="server" Text="VALOR COMERCIAL" Width="150px"></asp:Label><br/>
                    <asp:TextBox ID="TextBox2" runat="server" Width="150px"></asp:TextBox></div>
                <div class="col3"></div>

            </div><!-- Bienes Inmuebles-->
            <div>
                <div class="col3">
                    <asp:Label ID="Label20" runat="server" Text="UBICACIÓN (DIRECCIÓN EXACTA)" Width="300px"></asp:Label><br/>
                    <asp:TextBox ID="TextBox19" runat="server" Width="700"></asp:TextBox>
                </div>
            </div>
            <div> 
                    <div class="col_center">
                        <asp:Button ID="btnAddhijo" runat="server" Text="AÑADIR"></asp:Button>
                        <asp:Button ID="btnUphijo" runat="server" Text="ACTUALIZAR" Visible="false"></asp:Button>
                        <asp:Button ID="btnDelhijo" runat="server" Text="ELIMINAR" Visible="false"></asp:Button>
                    </div>
                    <div class="col_center"><asp:GridView ID="GridView1" runat="server"></asp:GridView></div>
            </div><!-- Botones-->
        </div>
<br/>
        <div  class="borde_form">
            <div class="col3"><b>BIENES MUEBLES</b> ( VEHICULOS, MAQUINARIA, EQUIPOS )</div>
            <div>
                <div class="col3"></div>
                <div class="col3"><asp:Label ID="Label7" runat="server" Text="MARCA" Width="250px"></asp:Label>
                <asp:TextBox ID="TextBox7" runat="server" Width="250px"></asp:TextBox></div>
                <div class="col1"></div>        
                <div class="col3"><asp:Label ID="Label8" runat="server" Text="MODELO" Width="200px"></asp:Label>
                <asp:TextBox ID="TextBox8" runat="server" Width="200px"></asp:TextBox></div>
                <div class="col1"></div>        
                <div class="col3"><asp:Label ID="Label9" runat="server" Text="AÑO" Width="70px" EnableTheming="True" TextMode="Date"></asp:Label>
                <asp:TextBox ID="TextBox9" runat="server" Width="70px"></asp:TextBox></div>
                <div class="col1"></div>        
                <div class="col3">
                    <center>
                        <asp:Label ID="Label1" runat="server" Text="PRENDADO" Width="150px"></asp:Label>
                    </center>
                        <div style="text-align: center; width: 150px">
                            <asp:RadioButton ID="RadioButton1" runat="server" Text="SI" />
                            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                            <asp:RadioButton ID="RadioButton2" runat="server" Text="NO" />
                        </div>
                </div>
                <div class="col1"></div>
                <div class="col3">
                    <asp:Label ID="Label11" runat="server" Text="VALOR COMERCIAL" Width="150px"></asp:Label>
                    <asp:TextBox ID="TextBox11" runat="server" Width="150px"></asp:TextBox>
                </div>
                <div class="col3"></div>
        </div><!-- Bienes Muebles-->
            <div>
            <div class="col3"></div>
            <div class="col3">
                <asp:Button ID="Button2" runat="server" Text="AÑADIR"></asp:Button>
                <asp:Button ID="Button11" runat="server" Text="ACTUALIZAR" Visible="false"></asp:Button>
                <asp:Button ID="Button12" runat="server" Text="ELIMINAR" Visible="false"></asp:Button>
            </div>
            <div class="col3">
                <asp:GridView ID="GridView5" runat="server"></asp:GridView>
            </div>
            <div class="col3"></div>
        </div><!-- Botones-->
        </div>
<br/>
        <div  class="borde_form">
            <div class="col3"><b>OTROS BIENES MUEBLES</b><br/>(MENAJE, se entiende por menaje de casa todos los muebles, enseres, equipos, electrodomésticos de línea blanca, etc. Que no sean utilizados con fines comerciales, al llenar este dato se deberá agrupar todos los bienes antes descritos dentro del concepto “Menaje” estableciendo su valor aproximado.  OBRAS DE ARTE, JOYAS)</div>
            <div>
                    <div class="col3"></div>        
                    <div class="col3">
                        <asp:Label ID="Label23" runat="server" Text="DESCRIPCIÓN DEL ARTÍCULO" Width="700px"></asp:Label><br/>
                        <asp:TextBox ID="TextBox22" runat="server" Width="700px"></asp:TextBox>
                    </div>
                    <div class="col1"></div>
                    <div class="col3">
                        <asp:Label ID="Label4" runat="server" Text="VALOR COMERCIAL" Width="150px"></asp:Label><br/>
                        <asp:TextBox ID="TextBox1" runat="server" Width="150px"></asp:TextBox>
                    </div>
                    <div class="col3"></div>
                </div><!-- Otros Bienes Muebles-->
            <div>
        <div class="col3"></div>
        <div class="col3">
            <asp:Button ID="Button16" runat="server" Text="AÑADIR"></asp:Button>
            <asp:Button ID="Button17" runat="server" Text="ACTUALIZAR" Visible="false"></asp:Button>
            <asp:Button ID="Button18" runat="server" Text="ELIMINAR" Visible="false"></asp:Button></div>
        <div class="col3"><asp:GridView ID="GridView7" runat="server"></asp:GridView></div>
        <div class="col3"></div>
    </div><!-- Botones-->
        </div>
<br/>
        <div  class="borde_form">
            <div class="col3"><b>INVERSIONES Y CUENTAS POR COBRAR</b> ( ACCIONES, DEPÓSITOS A PLAZO U OTROS DOCUMENTOS FIDUCIARIOS, CUENTAS POR COBRAR A INSTITUCIONES Y TERCERAS)</div>
            <div>
                <div class="col3"></div>        
                <div class="col3">
                    <asp:Label ID="Label12" runat="server" Text="INSTITUCIÓN" Width="300px"></asp:Label><br/>
                    <asp:TextBox ID="TextBox12" runat="server" Width="300px"></asp:TextBox></div>
                <div class="col1"></div>        
                <div class="col3"><asp:Label ID="Label13" runat="server" Text="TIPO DE DOCUMENTO" Width="200px"></asp:Label><br/>
                <asp:TextBox ID="TextBox13" runat="server" Width="200px"></asp:TextBox></div>
                <div class="col1"></div>        
                <div class="col3"><asp:Label ID="Label14" runat="server" Text="FECHA DE INVERSIÓN" Width="200px" EnableTheming="True" TextMode="Date"></asp:Label><br/>
                <asp:TextBox ID="TextBox14" runat="server" Width="120px" EnableTheming="True" TextMode="Date"></asp:TextBox></div>
                <div class="col1"></div>        
                <div class="col3"><asp:Label ID="Label5" runat="server" Text="FECHA DE VENCIMIENTO" Width="200px" EnableTheming="True" TextMode="Date"></asp:Label><br/>
                <asp:TextBox ID="TextBox3" runat="server" Width="120px" EnableTheming="True" TextMode="Date"></asp:TextBox></div>
                <div class="col1"></div>        
                <div class="col3"><asp:Label ID="Label16" runat="server" Text="VALOR" Width="150px"></asp:Label><br/>
                <asp:TextBox ID="TextBox16" runat="server" Width="150px"></asp:TextBox></div>
                <div class="col3"></div>        
                </div><!-- Inversiones-->
            <div>
        <div class="col3"></div>
        <div class="col3"><asp:Button ID="Button13" runat="server" Text="AÑADIR"></asp:Button>
            <asp:Button ID="Button14" runat="server" Text="ACTUALIZAR" Visible="false"></asp:Button>
            <asp:Button ID="Button15" runat="server" Text="ELIMINAR" Visible="false"></asp:Button>

        </div>
        <div class="col3"><asp:GridView ID="GridView6" runat="server"></asp:GridView></div>
        <div class="col3"></div>
    </div><!-- Botones-->
        </div>
<br/>
        <div  class="borde_form">
            <div class="col3"><b>CUENTAS BANCARIAS</b> ( NACIONALES O EXTRANJERAS, Incluir cuentas en cooperativa Andalucía)</div>
            <div>
                <div class="col3"></div>        
                <div class="col3"><asp:Label ID="Label17" runat="server" Text="INSTITUCIÓN" Width="300px"></asp:Label><br/>
                <asp:TextBox ID="TextBox17" runat="server" Width="300px"></asp:TextBox></div>
                <div class="col1"></div>        
                <div class="col3">
                    <asp:Label ID="Label18" runat="server" Text="TIPO DE CUENTA" Width="150px"></asp:Label><br/>
                    <asp:DropDownList ID="ddlTipocta" runat="server" >
                        <asp:ListItem Value="cta_ahorros">Cta. de Ahorros</asp:ListItem>
                        <asp:ListItem Value="cta_corriente">Cta. Corriente</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col1"></div>
                <div class="col3">
                    <asp:Label ID="Label27" runat="server" Text="NÚMERO DE CUENTA" Width="200px" EnableTheming="True" TextMode="Date"></asp:Label><br/>
                    <asp:TextBox ID="TextBox26" runat="server" Width="200px"></asp:TextBox></div>
                <div class="col1"></div>        
                <div class="col3"><asp:Label ID="Label29" runat="server" Text="SALDO PROMEDIO" Width="150px"></asp:Label><br/>
                <asp:TextBox ID="TextBox31" runat="server" Width="150px"></asp:TextBox></div>
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
         </div><!-- Cuentas Bancarias-->
<br/>
        <div  class="borde_form">
            <div class="col3"><b>OBLIGACIONES POR PAGAR</b> ( SALDO DE CREDITOS Y OBLIGACIONES POR PAGAR A LA FECHA DE ESTA DECLARACION - Incluir créditos en cooperativa Andalucía )</div>
                <div>
                <div class="col3"></div>        
                <div class="col3"><asp:Label ID="Label32" runat="server" Text="TIPO DE OBLIGACIÓN" Width="300px"></asp:Label><br/>
                <asp:TextBox ID="TextBox32" runat="server" Width="300px"></asp:TextBox></div>
                <div class="col1"></div>        
                <div class="col3"><asp:Label ID="Label33" runat="server" Text="INSTITUCIÓN QUE FINANCIA" Width="300px"></asp:Label><br/>
                <asp:TextBox ID="TextBox33" runat="server" Width="300px"></asp:TextBox></div>
                <div class="col1"></div>        
                <div class="col3"><asp:Label ID="Label34" runat="server" Text="FECHA DE CONCESIÓN" Width="150px" EnableTheming="True" TextMode="Date"></asp:Label><br/>
                <asp:TextBox ID="TextBox34" runat="server" Width="150px" EnableTheming="True" TextMode="Date"></asp:TextBox></div>
                <div class="col1"></div>        
                <div class="col3"><asp:Label ID="Label36" runat="server" Text="VALOR" Width="150px"></asp:Label><br/>
                <asp:TextBox ID="TextBox36" runat="server" Width="150px"></asp:TextBox></div>
                <div class="col3"></div>        
                </div>
                <div>
                    <div class="col3"></div>
                    <div class="col3">
                        <asp:Button ID="Button22" runat="server" Text="AÑADIR"></asp:Button>
                        <asp:Button ID="Button23" runat="server" Text="ACTUALIZAR" Visible="false"></asp:Button>
                        <asp:Button ID="Button24" runat="server" Text="ELIMINAR" Visible="false"></asp:Button></div>
                    <div class="col3">
                        <asp:GridView ID="GridView9" runat="server"></asp:GridView>
                    </div>
                    <div class="col3"></div>
                </div><!-- Botones-->
            </div><!-- Obligaciones-->
<br/>
        <div  class="borde_form">
            <div class="col3"><b>INGRESOS DEL CONYUGE</b> ( INGRESO MENSUAL )</div>
                <div>
                    <div>
                        <div class="col1"></div>
                        <div class="col3" style="width: 340px"><b>DESCRIPCIÓN</b></div>
                        <div class="col3" style="width: 320px"><b>INSTITUCIÓN O ACTIVIDAD</b></div>
                        <div class="col3" style="width: 250px"><b>INGRESO MENSUAL PROMEDIO</b></div>
                    </div>
                    <div style="padding-left: 100px">
                        <div style="width: 800px">
                            <asp:Label ID="Label37" runat="server" Text="SUELDO EN RELACION DE DEPENDENCIA" Width="320px"></asp:Label>
                            <asp:TextBox ID="TextBox25" runat="server" Width="320px"></asp:TextBox>
                            <asp:TextBox ID="TextBox37" runat="server" Width="150px"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Label ID="Label38" runat="server" Text="EJERCICIO PROFESIONAL" Width="320px"></asp:Label>
                            <asp:TextBox ID="TextBox38" runat="server" Width="320px"></asp:TextBox>
                            <asp:TextBox ID="TextBox41" runat="server" Width="150px"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Label ID="Label41" runat="server" Text="NEGOCIO PROPIO" Width="320px"></asp:Label>
                            <asp:TextBox ID="TextBox50" runat="server" Width="320px"></asp:TextBox>
                            <asp:TextBox ID="TextBox51" runat="server" Width="150px"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Label ID="Label48" runat="server" Text="OTRAS FUENTES (ESPECIFIQUE)" Width="320px"></asp:Label>
                            <asp:TextBox ID="TextBox56" runat="server" Width="320px"></asp:TextBox>
                            <asp:TextBox ID="TextBox57" runat="server" Width="150px"></asp:TextBox>
                        </div>
                    </div>
                </div>
            <br/>
            </div><!-- Ingresos Conyugue-->
<br/>
        <div class="borde_form">
                <div class="col3"><b>INGRESOS ECONOMICOS ADICIONALES</b> ( INGRESOS POR ARRIENDOS, TAXI, VENTAS, PENSIONES ALIMENTICIAS, AYUDAS FAMILIARES, OTROS )</div>
                <div>
                    <div>
                        <div class="col1"></div>
                        <div class="col3" style="width: 320px"><b>DESCRIPCIÓN</b></div>
                        <div class="col3" style="width: 320px"><b>INSTITUCIÓN O ACTIVIDAD</b></div>
                        <div class="col3" style="width: 250px"><b>INGRESO MENSUAL PROMEDIO</b></div>
                    </div>
                    <div style="padding-left: 100px">
                        <div style="width: 790px">
                            <asp:Label ID="Label42" runat="server" Text="ARRIENDOS" Width="300px"></asp:Label>
                            <asp:TextBox ID="TextBox42" runat="server" Width="320px"></asp:TextBox>
                            <asp:TextBox ID="TextBox29" runat="server" Width="150px"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Label ID="Label46" runat="server" Text="PENSIONES ALIMENTICIAS" Width="300px"></asp:Label>
                            <asp:TextBox ID="TextBox30" runat="server" Width="320px"></asp:TextBox>
                            <asp:TextBox ID="TextBox46" runat="server" Width="150px"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Label ID="Label6" runat="server" Text="EJERCICIO PROFESIONAL " Width="300px"></asp:Label>
                            <asp:TextBox ID="TextBox35" runat="server" Width="320px"></asp:TextBox>
                            <asp:TextBox ID="TextBox15" runat="server" Width="150px"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Label ID="Label10" runat="server" Text="NEGOCIO PROPIO" Width="300px"></asp:Label>
                            <asp:TextBox ID="TextBox39" runat="server" Width="320px"></asp:TextBox>
                            <asp:TextBox ID="TextBox21" runat="server" Width="150px"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Label ID="Label15" runat="server" Text="INTERESES" Width="300px"></asp:Label>
                            <asp:TextBox ID="TextBox40" runat="server" Width="320px"></asp:TextBox>
                            <asp:TextBox ID="TextBox23" runat="server" Width="150px"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Label ID="Label22" runat="server" Text="OTRAS FUENTES (ESPECIFIQUE)" Width="300px"></asp:Label>
                            <asp:TextBox ID="TextBox43" runat="server" Width="320px"></asp:TextBox>
                            <asp:TextBox ID="TextBox24" runat="server" Width="150px"></asp:TextBox>
                        </div>
                    </div>
                </div>
            <br/>
            </div><!-- Ingresos Adicionales-->
<br/>
        <div class="borde_form">
                <div class="col3"><b>GASTOS</b></div>
                <div>
                    <div>
                        <div class="col1"></div>
                        <div class="col3" style="width: 420px"><b>DESCRIPCIÓN</b></div>
                        <div class="col3" style="width: 200px"><b>GASTO MENSUAL</b></div>
                    </div>
                    <div style="padding-left: 100px">
                        <div style="width: 650px">
                            <asp:Label ID="Label24" runat="server" Text="ALIMENTACIÓN" Width="400px"></asp:Label>
                            <asp:TextBox ID="TextBox4" runat="server" Width="200px"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Label ID="Label25" runat="server" Text="EDUCACIÓN" Width="400px"></asp:Label>
                            <asp:TextBox ID="TextBox5" runat="server" Width="200px"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Label ID="Label26" runat="server" Text="VESTIMENTA" Width="400px"></asp:Label>
                            <asp:TextBox ID="TextBox6" runat="server" Width="200px"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Label ID="Label28" runat="server" Text="SALUD" Width="400px"></asp:Label>
                            <asp:TextBox ID="TextBox10" runat="server" Width="200px"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Label ID="Label30" runat="server" Text="VIVIENDA" Width="400px"></asp:Label>
                            <asp:TextBox ID="TextBox27" runat="server" Width="200px"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Label ID="Label31" runat="server" Text="TRANSPORTE" Width="400px"></asp:Label>
                            <asp:TextBox ID="TextBox28" runat="server" Width="200px"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Label ID="Label35" runat="server" Text="SERVICIOS BÁSICOS" Width="400px"></asp:Label>
                            <asp:TextBox ID="TextBox44" runat="server" Width="200px"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Label ID="Label39" runat="server" Text="PAGO MENSUAL DE PRÉSTAMOS" Width="400px"></asp:Label>
                            <asp:TextBox ID="TextBox45" runat="server" Width="200px"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Label ID="Label40" runat="server" Text="PAGO MENSUAL DE TARJETAS DE CRÉDITO" Width="400px"></asp:Label>
                            <asp:TextBox ID="TextBox47" runat="server" Width="200px"></asp:TextBox>
                        </div>
                        <div>
                            <asp:Label ID="Label43" runat="server" Text="OTROS GASTOS" Width="400px"></asp:Label>
                            <asp:TextBox ID="TextBox48" runat="server" Width="200px"></asp:TextBox>
                            <asp:Label ID="Label44" runat="server" Text="ESPECIFIQUE" Width="120px"></asp:Label>
                            <asp:TextBox ID="TextBox49" runat="server" Width="400px"></asp:TextBox>
                        </div>
                    </div>
                </div><!-- Gastos-->
            <br/>
            </div>
<br />
            <div>
                <center>
                    <asp:Button ID="Button1" runat="server" Text="Button" />
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

