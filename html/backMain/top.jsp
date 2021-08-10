<%@ page import="Model.UserBean" %><%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/2
  Time: 10:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>top</title>
</head>
<body background="../../img/top_bg.png">
<h1 style="margin-left: 20px">一卡通</h1>
<span style="font-size: 20px; font-weight:bold; position: absolute; margin-left: 85%; margin-top: -2%">欢迎您，<%= ((UserBean) session.getAttribute("User")).getUname()%></span>
</body>
</html>
