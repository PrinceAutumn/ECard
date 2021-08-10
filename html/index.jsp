<%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/19
  Time: 16:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>一卡通首页</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/css/login.css">
</head>
<body>


<div class="wrapper">

    <div class="container" id="mainDiv">
        <h1>Welcome</h1>
        <form class="form"  method="post" >
            <input type="button"  value="一卡通前台" onclick="window.open(
                    '<%= request.getContextPath()%>/html/front/index.jsp') "><br>

            <input type="button"  value="一卡通后台" onclick="window.open(
                    '<%= request.getContextPath()%>/html/login.html') "><br>
        </form>
    </div>

    <ul class="bg-bubbles">
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
    </ul>

</div>

</body>
</html>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#mainDiv").fadeIn(1000);
        $('#login-button').click(function(event) {
            if (!reg.test($(".codeInput").val())) {
                $("#codeErr").show();
                return;
            }
        });
    });
</script>