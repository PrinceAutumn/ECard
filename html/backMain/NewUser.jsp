<%@ page import="Model.UserBean" %><%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/6
  Time: 16:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<div class="top" align="center"><h3>新增人员</h3></div>
<div class="main" align="center">
    <form action="<%=request.getContextPath()%>/UserServlet" method="post" id="form">
        <input type="hidden" name="action" value="addUser">
        <input type="text" name="uname" id="uname" placeholder="用户名"><br><br>
        <input type="password" name="pwd" id="pwd" placeholder="密码"><br><br>
        <input type="password" id="pwd2" placeholder="确认密码"><br><br>
        <div id="d_dm"><select name="departMent">
            <option value ="4">内科</option>
            <option value ="5">外科</option>
        </select></div><br>
        <div id="d_role"><select name="role">
            <option value ="1">管理员</option>
            <option value ="2">收费员</option>
            <option value ="3">医生</option>
        </select></div><br>
        <div id="d_sub"><input type="submit" value="提交" id="save"><input type="reset" value="重置"></div>
        <div><label id="hint"></label></div>

    </form>
</div>

</body>
</html>

<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js" charset="utf-8"></script>
<script type="text/javascript">
    $(":submit").on('click',function (){
        $("input").each(function (){
            if($(this).val() == ''){
                alert("输入框不能为空！");
                event.preventDefault();
                return false;
            }
        });
        if($("#pwd").val() != $("#pwd2").val()){
            alert("两次密码不一致！");
            event.preventDefault();
            return false;
        }
        window.parent.location.reload();
        parent.layer.close();
        return true;
    });
</script>
