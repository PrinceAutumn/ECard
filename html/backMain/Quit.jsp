<%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/2
  Time: 10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>退出</title>
</head>
<body>
<div align="center">
    <h1 style="color: #ff000f">您确定要退出吗？</h1>
    <a href="<%= request.getContextPath()%>/html/login.html" target="_top"><input type="button" value="确定"></a>
    <input type="button" value="返回" onclick="window.location.href = '<%= request.getContextPath()%>/html/login.html'">
</div>
</body>
</html>
