<%@ page import="Model.UserBean" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/8
  Time: 15:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改申请</title>
</head>
<body>
<% UserBean ub = (UserBean) session.getAttribute("User");%>
总卡量：<span id="cardnum"></span><br><br>
<form action="<%=request.getContextPath()%>/ApplyServlet" id="newApplyfrom">
    <input type="hidden" value="applicationApply" name="action">
    <input type="hidden" value="<%=ub.getUaccount()%>" name="uid">
    <input type="hidden" value="<%=(String) request.getAttribute("aid")%>" name="aid">
    申请人：<input type="text" value="<%= ub.getUname()%>" disabled><br><br>
    申请时间：<input type="text" value="<%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss:SS").format(new Date())%>" disabled><br><br>
    申请卡数量：<input type="text" name="number" onkeyup="this.value=this.value.replace(/[^\d]/g,'')">张<br><br>
    <input type="submit" value="提交">
</form>
</body>
</html>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js" charset="utf-8"></script>
<script>
    $.ajax({
        url: '<%= request.getContextPath()%>/ApplyServlet?action=getMaxCardnum',
        dataType:'text',
        type:'get',
        success : function(data){
            //jquery赋值方式
            $("#cardnum").text(data);
        }
    });

    $(":submit").on('click',function (){
        $("input").each(function (){
            if($(this).val() == ''){
                alert("输入框不能为空！");
                event.preventDefault();
                return false;
            }
        });
        if(parseInt($("#cardnum").text()) < parseInt($("#number").val())){
            alert("申请量不能超过总卡量");
            event.preventDefault();
            return false;
        }
        window.parent.location.reload();
        parent.layer.close();
        return true;
    });
</script>
</body>
</html>
