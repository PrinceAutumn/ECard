<%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/11
  Time: 21:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>一卡通前端</title>

    <link rel="stylesheet" type="text/css" href="../../css/login.css">
</head>
<body>


<div class="wrapper">

    <div class="container" id="mainDiv">
        <h1>Welcome</h1>
        <form class="form" action="../LoginServlet" method="post" >
            <input type="button" id="recharge" value="充值" onclick="window.open(
                    '<%= request.getContextPath()%>/html/front/Recharge.jsp') "><br>

            <input type="button" id="Bill" value="对账" onclick="window.open(
                    '<%= request.getContextPath()%>/html/front/BillList.jsp')"><br>

            <input type="button" id="GuaHao" value="预约挂号" onclick="window.open(
                    '<%= request.getContextPath()%>/html/front/Booking.jsp')"><br>

            <input type="button" id="getNum" value="预约取号" onclick="window.open(
                    '<%= request.getContextPath()%>/html/front/GetNumber.jsp')"><br>
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

<script type="text/javascript" src="../../js/jquery-3.6.0.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#mainDiv").fadeIn(1000);
    });

</script>