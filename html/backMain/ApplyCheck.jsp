<%@ page import="Model.CardBean" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/18
  Time: 0:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>查看</title>
</head>
<body>
<% List<CardBean> cards = ((List<CardBean>) request.getAttribute("cards"));%>
<div align="center">
    申请人：<%= request.getAttribute("applyperson")%><br><br>
    申请时间：<%= request.getAttribute("applydate")%><br><br>
    申请数量：<%= request.getAttribute("applynum")%><br><br>
    审核人：<%= request.getAttribute("applymanger")%><br><br>
    审核时间：<%= request.getAttribute("okdate")%><br><br>
    领用卡号：<%
            for(int i = 0; i < cards.size(); i++){
        %>
    <%= cards.get(i).getCardnum()%>,
    <% if (i % 2 == 0){%>
    <%= "<br>"%>
    <%}%>
<%}%><br><br>
</div>

</body>
</html>
