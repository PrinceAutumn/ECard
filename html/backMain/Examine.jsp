<%@ page import="Model.UserBean" %><%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/8
  Time: 10:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h3>领卡审核</h3>
    申请人：<%= request.getAttribute("name")%><br><br>
    申请时间：<%= request.getAttribute("date")%><br><br>
    申请张数：<%= request.getAttribute("number")%><br><br>
    <form action="<%=request.getContextPath()%>/ApplyServlet">
        <input type="hidden" name="action" value="adopt">
        <input type="hidden" name="aid" value="<%= request.getAttribute("aid")%>">
        <input type="hidden" name="uid" value="<%= ((UserBean) session.getAttribute("User")).getUaccount()%>">
        <input type="text" placeholder="请输入开始卡号" name="begin" onkeyup="this.value=this.value.replace(/[^\dA-Za-z]/g,'')">
        <input type="submit" value="审核通过">
    </form>
</body>
</html>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js" charset="utf-8"></script>
<script>
    $(":submit").on('click',function (){
        $("input").each(function (){
            if($(this).val() == ''){
                alert("输入框不能为空！");
                event.preventDefault();
                return false;
            }
        });
        window.parent.location.reload();
        parent.layer.close();
        return true;
    });
</script>
