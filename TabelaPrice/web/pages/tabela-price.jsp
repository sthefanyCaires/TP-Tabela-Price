<%-- 
    Document   : tabela_price
    Created on : 20 de set. de 2021, 18:37:11
    Author     : sthef
--%>

<%@page import="java.text.NumberFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    int tempo = 0;
    double juros = 0.0, valor = 0.0, parcela = 0.0;
    String error = null;
    Boolean exibe = false;
    if(request.getParameter("juros") == null ||  request.getParameter("tempo") == null ||  request.getParameter("valor") == null){
        error = "Preencha todos os parâmetros para que possamos exibir a tabela.";
    }
    else{
        try{
            tempo = Integer.parseInt(request.getParameter("tempo"));
            juros = Double.parseDouble(request.getParameter("juros"));
            valor = Double.parseDouble(request.getParameter("valor"));
            parcela = (valor * (juros/100)) / (1 - (1 / (Math.pow((1 + juros/100), tempo))));
        }catch(Exception e) {
            error = "Você deve inserir parâmetros válidos para o cálculo.";
        }
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
        <h2>Tabela price</h2> 
        <% if(error != null) { %>
                <div style="color:blue; font-size: 30px"><%= error %></div>
           <% }else{ %>
            <table border="1">
                <tr>
                    <th>Período</th>
                    <th>Saldo Devedor</th>
                    <th>Parcela</th>
                    <th>Juros</th>
                    <th>Amortização</th>
                </tr>
                <tr>
                    <td>0</td>                    
                    <td>
                        <%
                            String valorFormatado = NumberFormat.getCurrencyInstance().format(valor); 
                            out.println(valorFormatado);
                        %>
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                    <%
                        for(int i = 1; i <= tempo;i++){
                            double jurosValor = valor * (juros/100);
                            double amortizacao = parcela - jurosValor;
                            valor -= amortizacao;
                    %>
                    <tr>
                        <td><%= i + "" %></td>                    
                        <td>
                            <%
                                valorFormatado = NumberFormat.getCurrencyInstance().format(valor); 
                                out.println(valorFormatado);
                            %>
                        </td>
                        <td>
                            <%
                                valorFormatado = NumberFormat.getCurrencyInstance().format(parcela); 
                                out.println(valorFormatado);
                            %>
                        </td>
                        <td>
                            <%
                                valorFormatado = NumberFormat.getCurrencyInstance().format(jurosValor); 
                                out.println(valorFormatado);
                             %>
                        </td>
                        <td>
                            <%
                                valorFormatado = NumberFormat.getCurrencyInstance().format(amortizacao); 
                                out.println(valorFormatado);
                            %>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tr>
            </table>
           <% } %>
           <br>
        <form action="" method="GET">
               <input type="number" name="valor" placeholder="Digite o valor:" value="<%= request.getParameter("valor") %>"> 
               <input type="number" name="juros" placeholder="Digite o juros:" value="<%= request.getParameter("juros") %>">
               <input type="number" name="tempo" placeholder="Digite o número de parcelas:" step="1" style="width:250px"value="<%= request.getParameter("tempo") %>">
               <input type="submit" value="Gerar tabela">
            </form>
    </body>
</html>
