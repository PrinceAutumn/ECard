<%@ page import="java.util.List" %>
<%@ page import="Model.UserBean" %><%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/3/18
  Time: 9:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>医护人员表格</title>
    <link rel="stylesheet" type="text/css" src="<%= request.getContextPath()%>/css/userList.css">
    <style>
        table {
            width:800px;
            margin:15px 0;
            border:0;
        }
        .table11_3{
            margin: 0px auto;
        }
        .table11_3 th {
            background-color:#FF5675;
            color:#FFFFFF
        }
        .table11_3,.table11_3 th,.table11_3 td {
            font-size:0.95em;
            text-align:center;
            padding:4px;
            border-collapse:collapse;
        }
        .table11_3 th,.table11_3 td {
            border: 1px solid #fe2047;
            border-width:1px 0 1px 0;
            border:2px inset #ffffff;
        }
        .table11_3 tr {
            border: 1px solid #ffffff;
        }
        .table11_3 tr:nth-child(odd){
            background-color:#fec6d1;
        }
        .table11_3 tr:nth-child(even){
            background-color:#ffffff;
        }
    </style>
</head>
<body>

<form action="UserServlet" method="get">
    表格
    <table border="1px" class=table11_3>
        <tr name="titleLine">
            <th>账号</th>
            <th>名称</th>
            <th>科室</th>
            <th>职位</th>
            <th>状态</th>
            <th>操作</th>
        </tr>

        <%
            List<UserBean> ubs = (List<UserBean>) request.getAttribute("UserTable");
            for(int i = 0; i < ubs.size(); i++){
                UserBean ub = ubs.get(i);
        %>

        <tr onmouseover="mouseOver(this)" onmouseout="mouseOut(this)">
            <td><input type="checkbox" name="uid" value=<%= ub.getUaccount()%>><%= ub.getUaccount()%></td>
            <td><%= ub.getUname()%></td>
            <td>科室</td>
            <td>职位</td>
            <td>状态</td>
            <td>
                <a href="<%= request.getContextPath()%>/UserServlet?action=del&uid=<%= ub.getUaccount()%>">删除</a>|
                <a href="<%= request.getContextPath()%>/UserServlet?action=updateUser&uid=<%= ub.getUaccount()%>">修改</a>
            </td>
        </tr>

        <%}%>

    </table>
    <input type="button" name="btncheck" value="全选" onclick= "fullcheck()">
    <input type="button" name="rebtncheck" value="取消全选" onclick = "reFullCheck()">
    <input type="hidden" name="action" value="delUsers">
    <input type="submit" value="删除">
    <input type="button" onclick="upPage()" value="上一页">
    <input type="button" onclick="downPage()" value="下一页">
    <input type="button" value="新增人员" onclick="ShowInsertBox()">
    <div id="insertBox" style="display: none">
        123456
    </div>
    <%=request.getAttribute("CurrentPage")%>
</form>

</body>
</html>

<script type="text/javascript" src="<%= request.getContextPath()%>/js/userList.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/layer/layer.js"></script>
<script>

    function downPage(){
        window.location.href="<%= request.getContextPath()%>/UserServlet?action=down";
    }

    function upPage(){
        window.location.href="<%= request.getContextPath()%>/UserServlet?action=up";
    }

    function ShowInsertBox(){
        layer.open({
            type:1,
            title:"新增人员",
            area:["395px","300px"],
            content:$("#insertBox"),
        });
    }
</script>

