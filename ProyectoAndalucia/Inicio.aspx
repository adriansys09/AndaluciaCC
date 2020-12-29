<%@ Page Title="" Language="C#" MasterPageFile="~/MPAndalucia.Master" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="ProyectoAndalucia.Inicio" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph_master" runat="server">

    <div class="tabla" style="justify-content:center; text-align:center";><!-- TABLA CONTENIDO -->
        <%--<div>
            <h2><b>SISTEMA DE REFERIDOS ANDALUCÍA</b></h2>
        </div>--%>

<%--        <div style="background-image: url('/assets/img/LoginBack.png');--%>
        <div style="background-image: url('assets/img/PANTALLA-CONTABLE.png'); background-repeat: no-repeat; background-attachment: fixed; background-size: auto;background-position:center; width: auto; height: 600px;"><!-- inicio contenido-->
        <div>
            <div class="col1"></div><!-- borde izq en blanco-->

            <div class="col3">

                <div class="contenedor centrado" style="opacity:0.80;">
                    <div><center>
                        <div class="col3"></div>
                        <div class="col3 borde_form" >
                            <img src="assets/img/LOGO-A.png" style="height: 200px; width: 200px; margin-top:10px" alt="" />
    
                            <div>
                                <div class="columna1">
                                    <asp:Label ID="lblUser" runat="server" Text="USUARIO:"></asp:Label>
                                </div>
                                <div class="columna2">
                                    <asp:TextBox ID="txtUsuario" runat="server"  Width="200px" autocomplete="off"></asp:TextBox>
                                    <asp:TextBox ID="txtCedula" runat="server"  Width="200px" autocomplete="off" Visible="False"></asp:TextBox>
                                </div>
                            </div>

                            <div>
                                <div class="columna1">
                                    <asp:Label ID="lblClave" runat="server" Text="CLAVE:" ></asp:Label>
                                </div>
                                <div class="columna2">
                                    <asp:TextBox ID="txtClave" runat="server" TextMode="Password" autocomplete="off" Width="200px"></asp:TextBox>
                                </div>
                            </div>
                            <div>
                                <div class="columna1">
                                    <asp:Label ID="lblRol" runat="server" Text="ROL:"></asp:Label>
                                </div>
                                <div class="columna2">
                                    <asp:DropDownList ID="ddlRol" runat="server"  Width="200px">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                            <div>
                                <asp:Button ID="btnIngresar" runat="server" OnClick="btnIngresar_Click" Text="INGRESAR" />
                            </div>
                            <asp:Button ID="btnCedula" runat="server" Text="VALIDAR" OnClick="btnCedula_Click" />
                        </div>
                        <div class="col3"></div>
                        </center>
                    </div>
                        <br />
                    <div>
                        <div class="col3"></div>
                        <div class ="col2 borde_form">
                            <asp:Label ID="lblMensaje" runat="server"></asp:Label>
                        </div>
                        <div class="col3"></div>
                    </div>
                    <br />
                    <br />
                    <br />
                </div>
            </div>

            <div class="col1"></div><!-- borde derecha en blanco-->

        </div>
            <div>   <br /><br /><br />    </div><!-- "footer" -->
        
        </div><!-- FIN TABLA CONTENIDO -->


<%--        <div><h1><br />ANDALUCIA<br />TEMA 1</h1><br />
            <p style="text-align: justify">La presente página tiene como finalidad permitir la actualización de la información y la generación del Formulario UC001, de los empleados de la</p>
            <div class="page-scroll">
                <p class="job-title">COOPERATIVA ANDALUCÍA</p>
            </div>
        </div>--%>

    </div><!-- /.home-->


</asp:Content>
