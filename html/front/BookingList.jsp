<%@ page import="Model.CardBean" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.GuaHaoBean" %><%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/3/31
  Time: 23:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>CardList</title>
  <meta charset="utf-8">
  <style>
    table {
      width:300px;
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
<%
  List<GuaHaoBean> ghbs = (List<GuaHaoBean>) request.getAttribute("GuaHao");
  String cardnum = (String) request.getAttribute("cardnum");
  String guaadmin = (String) request.getAttribute("guaadmin");
%>
<%%>
<h3 align="center">医生：<%= ghbs.get(0).getGuaname()%></h3>
<table class=table11_3>
  <tr>
    <th>序号</th><th>门诊时间</th><th>预约人</th>
  </tr>
  <% for(int i = 0; i < ghbs.size(); i++){%>
    <% if (ghbs.get(i).getGuaadmin() != null){%>
    <tr>
      <td><%=i%></td><td><%= i + 7%>:00--<%= i + 8%>:00</td><td><%=ghbs.get(i).getGuaadmin()%></td>
    </tr>
    <%} else {%>
    <tr>
      <td><%=i%></td><td><%= i + 7%>:00--<%= i + 8%>:00</td><td><input type="button" id="<%=ghbs.get(i).getGuaid()%>"
                                                                       value="可预约" onclick="booking(this)"></td>
    </tr>
    <%}%>
  <%}%>

</table>

</body>
</html>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js" charset="utf-8"></script>
<script src="<%=request.getContextPath()%>/js/layui/layui.js" charset="utf-8"></script>
<script>
  function booking(date){
    var gid = date.id;
    $.ajax({
      url: '<%= request.getContextPath()%>/DutyServlet',
      dataType:'json',
      type:'get',
      data:{action: "save", cardnum: "<%=cardnum%>", gid:gid, guaadmin:"<%=guaadmin%>"},
      success : function(data){
            if(data == 200){
              layer.msg("预约成功", {icon: 6});
              setTimeout(function(){//两秒后关闭
                parent.layer.closeAll();
              },1000);
            } else {
              layer.msg("预约失败", {icon: 5});
            }
        }
    });
  }
</script>
