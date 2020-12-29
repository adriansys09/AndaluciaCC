<%@ Page Title="" Language="C#" MasterPageFile="~/Referidos/MPReferidos.master" AutoEventWireup="true" CodeBehind="RegistroProducto.aspx.cs" Inherits="ProyectoAndalucia.Referidos.RegistroProducto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph_master" runat="server">
    <script src="../scripts/jquery-1.7.min.js"></script>
    <script src="../scripts/jquery.dataTables.js"></script>
    <link href="../Content/css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="../Content/css/jquery.dataTables.css" rel="stylesheet" />
 <script type="text/javascript"> 
 $(document).ready(function () {
              $(".sem").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable({
                  "bPaginate": true,
                 
                  "columnDefs": [{
                      "defaultContent": "-",
                      "targets": "_all"
                  }],
                  "bLengthChange": false,
                  "iDisplayLength": 5,
                  "bInfo": false,
                  "language": {
                      "sSearch": "Buscar",
                      "oPaginate": {
                          "sFirst": "Primero",
                          "sLast": "Último",
                          "sNext": "Siguiente",
                          "sPrevious": "Anterior"
                      }
                  }
              });
          });
</script>



<div>
    <nav id="primary-navigation" class="site-navigation">
        <div class="container">
            <ul class="nav navbar-nav navbar-right">
                <li class="page-scroll"><a href="/Referidos/RegistroProducto.aspx">Registro</a></li>
<%--                <li class="page-scroll"><a href="/Referidos/IngresoReferido.aspx">Ingresa un Referido</a></li>--%>
                <li class="page-scroll"><a href="/Inicio.aspx">SALIR</a></li>
            </ul>
        </div>
    </nav>
</div>

<div>
    <div class="tablacontenido">
        <div class="tabla">

            <div class="col3"></div>
            <div class="col2">

                <br/>
                <div class="col3"><h4><b>REGISTRO DEL PRODUCTO</b></h4></div>
                <div class="borde_form">
                    <div>
                        <div class="col1"></div> 
                        <div class="col3"><h3><b>DATOS DEL CLIENTE</b></h3></div>
                    </div>
                    <div>
                            <div class="col1"></div>        
                            <div class="col3">
                                <asp:Label ID="Label27" runat="server" Text="CÉDULA" Width="200px"></asp:Label><br/>
                                <asp:TextBox ID="txtCedulaR" runat="server" Width="250px" OnTextChanged="txtCedulaR_TextChanged" autocomplete="off" AutoPostBack ="true"></asp:TextBox>
                            </div>
                            <div class="col3"></div>

                            <div class="col3">
                                <asp:Label ID="Label1" runat="server" Text="NOMBRE" Width="200px" ></asp:Label><br/>
                                <asp:TextBox ID="txtNombre" runat="server" Width="250px" autocomplete="off" Style="text-transform: uppercase" Enabled="False"></asp:TextBox>
                            </div>
                            <div class="col3"></div> 

                            <div class="col3">
                                <asp:Label ID="Label4" runat="server" Text="CORREO" Width="200px"></asp:Label><br/>
                                <asp:TextBox ID="txtMail" runat="server" Width="250px" Enabled="False"></asp:TextBox>
                            </div>
                            <div class="col3"></div>
                                                    
                           
                    </div>
                    <div>
                             <div class="col1"></div> 
                             <div class="col3">
                                <asp:Label ID="Label6" runat="server" Text="TELEFONO" Width="200px"></asp:Label><br/>
                                <asp:TextBox ID="txtTelefono" runat="server" Width="250px" Enabled="False"></asp:TextBox>
                            </div>
                            <div class="col3"></div>
                             
                            <div class="col3">
                                <asp:Label ID="Label2" runat="server" Text="PRODUCTO" Width="200px"></asp:Label><br/>
                                <asp:DropDownList ID="ddlProducto" runat="server"  Width="250px" OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged" >
                                </asp:DropDownList>
                            </div>
                            <div class="col3"></div> 
                               
                            <div class="col3">
                                <asp:Label ID="Label3" runat="server" Text="CUENTA / OPERACION" Width="200px"></asp:Label><br/>
                                <asp:TextBox ID="txtCuenta" runat="server" Width="250px" Style="text-transform: uppercase" OnTextChanged="txtCuenta_TextChanged" autocomplete="off" AutoPostBack ="true"></asp:TextBox>
                                <asp:Label ID="lblNumEnteCli" runat="server" Text="" Visible ="false"></asp:Label><br/>
                                <asp:Label ID="lblMensajeE" runat="server" Text="" Visible ="false"></asp:Label>                                
                            </div>
                            <div class="col3"></div>   
                             
                            <!-- <div class="col3">
                                <asp:Label ID="Label7" runat="server" Text="TIPO DE ACTIVACION" Width="300px"></asp:Label><br/>
                                <asp:DropDownList ID="ddlTipoAct" runat="server"  Width="300"></asp:DropDownList>
                            </div>
                            <div class="col3"></div>  -->       
                    </div>

                    <div>
                        <div>
                            <div class="col1"></div> 
                            <div class="col3"><h3><b>DATOS DEL EMPLEADO</b></h3></div>
                        </div>
                        <div class="col1"></div>        
                        <div class="col3">
                            <asp:Label ID="Label5" runat="server" Text="NOMBRE" Width="200px" autocomplete="off"></asp:Label><br/>
                            <asp:TextBox ID="txtNombreE" runat="server" Width="200px" Style="text-transform: uppercase"></asp:TextBox>
                        </div>

                        <div class="col3"></div> 
                        <div class="col3">
                            <asp:label id="Label17" runat="server" text="APELLIDO PATERNO" width="200px" ></asp:label><br/>
                            <asp:TextBox ID="txtApellidoE" runat="server" Width="200px" OnTextChanged="txtApellidoE_TextChanged" autocomplete="off" AutoPostBack ="true" Style="text-transform: uppercase"></asp:TextBox>
                            <asp:Label ID="lblNombreEmpl" runat="server" Text="" Width="350px" Font-Size="Large" Font-Bold="true"></asp:Label><br/>
                            <asp:label id="lblNumEnteEmpl" runat="server" text="" width="10px" Visible ="false" ></asp:label><br/>
                        </div>       
                            <div class="col3"></div>
                    </div><!-- Datos del Empleado-->

                    <div>
                        <center><br/>
                            <asp:Button ID="btnRegistroProducto" runat="server" Text="REGISTRAR" OnClick="btnRegistroProducto_Click"></asp:Button><br/><br/>
                        </center>
                    </div>
                </div>
                <br/>
                <div>
                    <div>
                        <div class="col1"></div>
                        <div><b>PRODUCTOS REGISTRADOS</b></div>
                    </div>
                    <div>
                        <div class="col1"></div>
                        <div class="col1"></div>
                    </div>
                    <div>              
                        <div class="span12" style="width:100%">
                            <asp:GridView CssClass ="sem table table-striped table-bordered table-hover" ID="gvProdActivos" runat="server" Font-Size="Small" AutoGenerateColumns="False" >
                                    <Columns>
                                        <asp:BoundField DataField="Cuenta" HeaderText="Cuenta" />
                                        <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
                                        <asp:BoundField DataField="Empleado" HeaderText="Empleado" />
                                        <asp:BoundField DataField="Oficial" HeaderText="Oficial" />
                                        <asp:BoundField DataField="Fecha" HeaderText="Fecha" />
                                        <asp:BoundField DataField="Estado" HeaderText="Estado" />
                                        <asp:BoundField DataField="Observacion" HeaderText="Observacion" />
                                    </Columns>
                            </asp:GridView>
                        </div>
                        <div class="col1"></div>
                    </div>
                </div>

            </div>
            <br/>
            <div class="col3"></div>

        </div>

        <div><br /><br/><br /></div>
    </div>
    <br /><br /><br /><br />
</div>
</asp:Content>