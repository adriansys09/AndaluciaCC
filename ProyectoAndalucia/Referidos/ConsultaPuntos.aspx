<%@ Page Title="" Language="C#" MasterPageFile="~/Referidos/MPReferidos.master" AutoEventWireup="true" CodeBehind="ConsultaPuntos.aspx.cs" Inherits="ProyectoAndalucia.Referidos.ConsultaPuntos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph_master" runat="server">
    <script src="../scripts/jquery-1.7.min.js"></script>
    <script src="../scripts/jquery.dataTables.js"></script>
    <link href="../Content/css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="../Content/css/jquery.dataTables.css" rel="stylesheet" />
 <script type="text/javascript"> 

     function Esconder() {
         $('#Controles').addClass('collapse');
     }
          
     $('#lblSelect').click(function (e) {
         console.log("a");
         //e.stopPropagation();
         e.preventDefault();
         $('#Controles').addClass('expand')
     })


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
<script type="text/javascript">
    function checkRadioBtn(id) {
        var gdvPremios = document.getElementById('<%=gdvPremios.ClientID%>');

        for (var i = 1; i < gdvPremios.rows.length; i++) {
            var radioBtn = gdvPremios.rows[i].cells[0].getElementsByTagName("input");

            // Check if the id not same
            if (radioBtn[0].id != id.id) {
                radioBtn[0].checked = false;
            }
        }
    }
</script>
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
    <div class="tablacontenido"><!-- TABLA CONTENIDO -->
        <div style="text-align: center; width:100%">
            <%--<h2><b>COLABORADOR ANDALUCÍA</b></h2>--%>
        </div><br />
        <div>
            <div class="col1"></div><!-- borde izq en blanco-->
            <div class="col2">

                    <div class="col1"></div>
                    <div class="col3" style="vertical-align: top">
                        <!-- CONSULTA PUNTOS-->
                        <div>
                            <div>
                                <h3><b>TUS PUNTOS</b></h3>
                                <p>Aquí se presenta los puntos que has ganado por las activaciones de productos de sus referidos.</p>
                            </div>
                            <br />
                            <div class="borde_form">
                                <div class="col3" ><b>PUNTOS ACUMULADOS:</b></div>
                                <div class="col1"><b>
                                    <asp:GridView ID="gdvConsolidado" runat="server" CssClass ="sem table table-striped table-bordered table-hover" AutoGenerateColumns="False">
                                        <Columns>
                                            <asp:BoundField DataField="PRODUCTOS" HeaderText="Productos"  />
                                            <asp:BoundField DataField="PUNTOS" HeaderText="Puntos" />
                                        </Columns>
                                    </asp:GridView></b>
                                </div>   
                            </div>

                        </div>
                        <br />
                        <br />
                        <!--  CANJE DE PUNTOS -->

                            <div class="col3">
                                <div>
                                    <div>
                                        <h3><b>CANJE DE PREMIOS</b></h3>
                                        <p>Selecciona los premios que deseas canjear.</p>
                                    </div>
                                    <div  class="borde_form">
                                        <div class="col3" style="width: 250px">
                                            <asp:GridView ID="gdvPremios" CssClass ="sem table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" OnSelectedIndexChanged="gdvPremios_SelectedIndexChanged" >
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Selec"> 
                                                      <ItemTemplate>
                                                          <asp:RadioButton ID="lblSelect" runat="server" onclick="checkRadioBtn(this);" ></asp:RadioButton>
                                                         </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Id" HeaderText="Id" />
                                                    <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" />
                                                    <asp:BoundField DataField="Puntos" HeaderText="Puntos" />
                                                </Columns>
                                            </asp:GridView> 
                                            <asp:Label ID="lblPuntoPre" runat="server" Visible ="false" ></asp:Label><br />
                                            <asp:Label ID="lblIdPremio" runat="server" Visible="false"></asp:Label><br />
                                        </div>
                                        <div class="col1"></div>
                                        <div class="col3">
                                            <center>
                                            <br/><br/>
                                            <asp:Label ID="Label6" runat="server" Text="PUNTOS DISPONIBLES" Width="150px" Font-Bold="True"></asp:Label><br />
                                            <div class="borde_form col_center">
                                                <asp:Label ID="lblPuntos" runat="server"  Width="75px" Height="75px" Font-Size="40px"></asp:Label><br />
                                            </div>
                                            <br />
                                            <asp:Button ID="btn_canjear" runat="server" Text="CANJEAR PREMIO " Width="150px" Height="75px" BorderStyle="NotSet" Font-Bold="True" OnClick="btn_canjear_Click"></asp:Button>
                                            </center>
                                        </div>
                                    </div>

                                </div>
                                <!-- Puntos-->
                                <br />
                                <div  class="borde_form">
                                    <div class="col3">
                                        <p><b>PREMIOS CANJEADOS:</b></p>
                                    </div>
                                    <div>
                                        <div class="col3">
                                            <asp:GridView ID="gvCanjes" runat="server" CssClass ="sem table table-striped table-bordered table-hover"  AutoGenerateColumns="False">
                                                <Columns>
                                                    <asp:BoundField DataField="pr_descripcion" HeaderText="Descripcion" />
                                                    <asp:BoundField DataField="pr_puntos" HeaderText="Puntos" />
                                                    <asp:BoundField DataField="pr_estado" HeaderText="Estado" />                                      
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <div class="col3">
                                            
                                        </div>
                                    </div>
                                </div>
                                <!-- Canje-->
                                <br />
                            </div>

                    </div>
                    <div class="col1"></div>
                    <div class="col3">
                        <br />
                        <div>
                            <img src="/assets/img/METODOLOGIA.png" alt="logo" width="525" height="300" /><br /><br />
                        </div>
                        <br />
                        <div>
                            <img src="/assets/img/SORTEO-MENSUAL.png" alt="logo" width="525" height="300" /><br /><br />
                        </div>
                        <br />
                        <div>
                            <img src="/assets/img/SORTEO-FINAL.png" alt="logo"  width="525" height="300" /><br /><br />
                        </div>
                    </div>
                    <div class="col3"></div>
            </div>
            <div class="col1"></div><!-- borde derecha en blanco-->
        </div>
    </div><!-- fin contenido-->
    <br /><br /><br /><br /><br /><br />
</div><!-- FIN CONTENIDO-->    
 
 </asp:Content>
