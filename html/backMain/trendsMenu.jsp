<%@ page import="java.util.List" %>
<%@ page import="Model.MenuBean" %><%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/3/21
  Time: 23:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>left</title>
    <script language = JavaScript>
        function showmenu(id) {
            var list = document.getElementById("list"+id);
            var menu = document.getElementById("menu"+id)
            if (list.style.display=="none") {
                document.getElementById("list"+id).style.display="block";
                menu.className = "title1";
            }else {
                document.getElementById("list"+id).style.display="none";
                menu.className = "title";
            }
        }
    </script>

    <style type="text/css">
        <!--
        *{margin:0;padding:0;list-style:none;font-size:14px}
        #nav{margin:10px;text-align:center;line-height:25px;width:200px;}
        .title{background:#336699;color:#fff;border-bottom:1px solid #fff;cursor:pointer;}
        .title1{background:#888;color:#000;border-bottom:1px solid #666;cursor:pointer;}
        .content li{color:#336699;background:#ddd;border-bottom:1px solid #fff;}
        -->
    </style>
</head>
<body>
<% List<MenuBean> mbs = (List<MenuBean>) request.getAttribute("Menu");%>
<div id="nav">
<%
    int menuCount = 1;
    for(int i = 0; i < mbs.size(); i++){
        if(mbs.get(i).getPid().equals("0")){
%>
    <div class="title" id="menu<%=menuCount%>" onclick="showmenu('<%=menuCount%>') "><%=mbs.get(i).getMname()%></div>
    <div id="list<%=menuCount%>"  class="content" style="display:none">
        <ul>
            <%
                for(int j = 0; j < mbs.size(); j++){
                    if(mbs.get(j).getPid().equals(mbs.get(i).getMid())){
            %>
            <li><a href="<%=request.getContextPath()%><%= mbs.get(j).getUrl()%>" target="right"><%= mbs.get(j).getMname()%></a></li>
                <%}%>
            <%}%>
        </ul>
    </div>
    <% menuCount++;%>
        <%}%>
    <%}%>
</div>


</body>
</html>
