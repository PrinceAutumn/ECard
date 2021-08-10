<%@ page import="Model.UserBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>后台管理界面</title>
  <% UserBean ub = (UserBean) session.getAttribute("User");%>
  <frameset rows="12%,*" border="1">
    <frame src="html/backMain/top.jsp">	 </frame>
    <frameset cols="20%,*">

      <frame src="<%= request.getContextPath() %>/MenuServlet?uid=<%=ub.getUaccount()%>">	 </frame>
      <frame src="<%= request.getContextPath() %>/img/Back_Bg.png" name="right">	 </frame>

    </frameset>
  </frameset>
</head>
</html>
