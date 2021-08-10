<%@ page import="Model.UserBean" %><%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/3/18
  Time: 23:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改用户信息</title>
</head>
<body>

<div class="top"><h3>用户修改</h3></div>
<div class="main">
    <%
        UserBean ub = (UserBean) request.getAttribute("USER");
    %>
    <form action="UserServlet" method="post">
        <input type="hidden" name="uid" value="<%= ub.getUaccount()%>">
        <input type="hidden" name="action" value="save">

<%--        <div id="d_id">用户ID：<input id="userId" name="userId" class="inp" type="text" value="<%= udb.getId()%>" disabled></div>--%>
        <div id="d_name">用户名：<%= ub.getUname()%></div>
        <div id="d_dm"><select name="departMent">
            <option value ="4">内科</option>
            <option value ="5">外科</option>
        </select></div>
        <div id="d_role"><select name="role">
            <option value ="1">管理员</option>
            <option value ="2">收费员</option>
            <option value ="3">医生</option>
        </select></div>
        <div id="d_sub"><input type="submit" value="保存"><input type="reset" value="重置"></div>
        <div><label id="hint"></label></div>

    </form>
</div>

</body>
</html>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js" charset="utf-8"></script>
<script type="text/javascript">
    $(":submit").on('click',function (){
        window.parent.location.reload();
        parent.layer.close();
        return true;
    });
</script>