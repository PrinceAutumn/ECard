<%@ page import="Model.UserBean" %><%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/13
  Time: 9:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改密码</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/layui/css/layui.css"  media="all">
</head>
<body>
<% UserBean ub = ((UserBean) session.getAttribute("User"));%>

<div class="layui-main">
    <form class="layui-form" action="">
        <label class="layui-form-label">旧密码</label>
        <div class="layui-input-inline">
            <input type="password" id="oldPwd" name="oldPwd" placeholder="请输入旧密码"
                   autocomplete="off" class="layui-input"/>
        </div><br><br><br><br>

        <label class="layui-form-label">新密码</label>
        <div class="layui-input-inline">
            <input type="password" id="newPwd" name="newPwd" placeholder="请输入新密码"
                   autocomplete="off" class="layui-input"/>
        </div><br><br><br><br>

        <label class="layui-form-label">确认密码</label>
        <div class="layui-input-inline">
            <input type="password" id="confirm" name="confirm" placeholder="请输入新密码"
                   autocomplete="off" class="layui-input"/>
        </div><br><br><br><br>

        <div class="layui-inline">
            <div class="layui-input-inline">
                <button type="button" class="layui-btn layui-btn-normal" id="okBtn" style="margin-left: 120px">
                    <i class="layui-icon layui-icon-ok">  确认</i>
                </button>
            </div>
        </div>

    </form>
</div>

</body>
</html>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js" charset="utf-8"></script>
<script src="<%=request.getContextPath()%>/js/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    $("#okBtn").on("click", function() {
        var oldPwd = $("#oldPwd").val();
        var newPwd = $("#newPwd").val();
        var confirm = $("#confirm").val();
        if(oldPwd == "" || newPwd == "" || confirm == ""){
            layer.msg("输入框不能为空");
        } else if(newPwd != confirm){
            layer.msg("密码不一致");
        } else {
                $.ajax({
                    url: "<%=request.getContextPath()%>/UserServlet",
                    type: "POST",
                    data: {action: "ModlifyPwd", oldPwd:oldPwd, newPwd:newPwd, account:"<%=ub.getUaccount()%>" },
                    success: function (msg) {
                        if(msg == 200){
                            layer.msg("修改成功");
                        } else {
                            layer.msg("修改失败");
                        }
                    }
                });
        }
    });

</script>