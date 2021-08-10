<%@ page import="Model.UserBean" %><%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/10
  Time: 17:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>售卡</title>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/Sold.css">
</head>
<body>
<% UserBean ub = ((UserBean) session.getAttribute("User"));%>
<div id="soldMain">
    <form action="<%=request.getContextPath()%>/CardBusinessServlet">
        <input type="hidden" name="action" value="insertPeople">
        <input type="hidden" name="Operator" value="<%=ub.getUname()%>">

        <input type="text"  name="uname" placeholder="姓名" id="uname">
        <input type="text" name="age" placeholder="年龄" id="age" onkeyup="this.value=this.value.replace(/[^\d]/g,'')">
        <div id="sexdiv">
            性别：<input type="radio" name="sex" value="male" checked>男
            <input type="radio" name="sex" value="female">女
        </div>
        <input type="text" name="originate" placeholder="籍贯" id="originate"><br>
        <input type="text" name="uid" placeholder="身份证" id="uid">
        <input type="text" name="phone" placeholder="电话号码" class="layui-input" id="phone"
               onkeyup="this.value=this.value.replace(/[^\d]/g,'')"><br><br>
        <input type="text" name="address" placeholder="现住址" id="address"><br><br>
        <input type="text" name="amount" placeholder="预存金额" id="amount" onkeyup="this.value=this.value.replace(/[^\d]/g,'')">
        <input type="text" name="card" placeholder="卡号" id="cards" onblur="cardBlur(this)"><br><br>
        <input type="submit" value="出售">
    </form>
</div>
</body>
</html>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js" charset="utf-8"></script>
<script src="<%=request.getContextPath()%>/js/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    function cardBlur(v){
        var value = v.value;
        $.ajax({
            url: "<%=request.getContextPath()%>/CardBusinessServlet",
            type: "POST",
            data: {action: 'selectCard', cardnum: value, applyperson: '<%=ub.getUaccount()%>'},
            success: function (msg) {
                if (msg == 200) {
                    layer.msg("卡号可使用", {icon: 6});
                } else {
                    layer.msg("查询不到该卡号", {icon: 5});
                }
            }
        });
    }

    $(":submit").on('click',function (){
        $("input").each(function (){
            if($(this).val() == ''){
                alert("输入框不能为空！");
                event.preventDefault();
                return false;
            }
        });
        return true;
    });
</script>
