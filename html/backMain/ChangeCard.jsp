<%@ page import="Model.UserBean" %><%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/12
  Time: 3:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>换卡</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/layui/css/layui.css"  media="all">
</head>
<body>
<% UserBean ub = ((UserBean) session.getAttribute("User"));%>
<input type="hidden" id="pid" name="pid" value="">
<input type="hidden" id="oldCardnum" value="">

<form class="layui-form">
    <label class="layui-form-label" style="width: 200px;margin-top: 10px">请输入原卡号/手机号/证件号：</label>
    <div class="layui-input-inline" style="float: left;width: 300px;margin-top: 10px">
        <input type="tel" name="cardnum" id="cardnum"  lay-verify="cardnum" autocomplete="off" class="layui-input">
    </div>
    <button type="button" class="layui-btn layui-btn-lg" id="readCard" onclick="searchBtn()" style="float: left;margin-left: 20px;margin-top: 10px;">读卡</button>
    <br><br><br><br><br><br>
    <label class="layui-form-label">姓名：</label>
    <div class="layui-input-inline">
        <input style="border: 0px;" type="text" name="uname" id="uname"
               lay-verify="uname" disabled
               autocomplete="off" class="layui-input"/>
    </div>
    <br>
    <label class="layui-form-label">性别：</label>
    <div class="layui-input-inline">
        <input style="border: 0px;" type="text" id="sex" name="sex"
               lay-verify="sex" disabled
               autocomplete="off" class="layui-input"/>
    </div>
    <br>
    <label class="layui-form-label">年龄：</label>
    <div class="layui-input-inline">
        <input style="border: 0px;" type="text"  name="age" id="age"
               lay-verify="age" disabled
               autocomplete="off" class="layui-input"/>
    </div>
    <br>
    <label class="layui-form-label">籍贯：</label>
    <div class="layui-input-inline">
        <input style="border: 0px;" type="text" placeholder="" name="city" id="city"
               lay-verify="city" disabled
               autocomplete="off" class="layui-input"/>
    </div>
    <br>
    <label class="layui-form-label">证件号：</label>
    <div class="layui-input-inline">
        <input style="border: 0px;" type="text"  id="zheng" name="zheng"
               lay-verify="zheng" disabled
               autocomplete="off" class="layui-input"/>
    </div>
    <br>
    <label class="layui-form-label">联系电话：</label>
    <div class="layui-input-inline">
        <input style="border: 0px;" type="text" placeholder="" name="phone" id="phone"
               lay-verify="phone" disabled
               autocomplete="off" class="layui-input"/>
    </div>
    <br>
    <label class="layui-form-label">现住址：</label>
    <div class="layui-input-inline">
        <input style="border: 0px;" type="text" placeholder="" id="address" name="address"
               lay-verify="address" disabled
               autocomplete="off" class="layui-input"/>
    </div>
    <br>
    <label class="layui-form-label">卡余额：</label>
    <div class="layui-input-inline">
        <input style="border: 0px;" type="text" placeholder="" id="money" name="money"
               lay-verify="money" disabled
               autocomplete="off" class="layui-input"/>
    </div>
    <br>
    <label class="layui-form-label">押金：</label>
    <div class="layui-input-inline">
        <input style="border: 0px;" type="text" placeholder="" id="deposit"  name="deposit"
               lay-verify="deposit" disabled
               value="20"
               autocomplete="off" class="layui-input"/>
    </div>

    </div>
    <br><br><br>
    <label class="layui-form-label" style="width: 200px;">请输入新卡号：</label>
    <div class="layui-input-inline" style="float: left;width: 300px;margin-top: 10px">
        <input type="tel" name="newCard" id="newCard" onblur="cardBlur(this)" lay-verify="newCard" autocomplete="off" class="layui-input">
    </div>
    <button type="button" class="layui-btn layui-btn-lg" onclick="changeCard()" style="float: left;margin-left: 20px;margin-top: 10px;">换卡</button>
</form>
</body>
</html>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js" charset="utf-8"></script>
<script src="<%=request.getContextPath()%>/js/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    function searchBtn(){
        var value = $("#cardnum").val();
        $.ajax({
            url: '<%= request.getContextPath()%>/CardBusinessServlet',
            dataType:'json',
            type:'get',
            data:{action: "readCard", cardnum: value},
            success : function(data){
                if(data == 400){
                    layer.msg("查询不到该卡号", {icon: 5});
                } else{
                    layer.msg("读卡成功", {icon: 6});
                    $("#oldCardnum").val(value);
                    $("#uname").val(data.peoplename);
                    $("#age").val(data.peopleage);
                    $("#sex").val(data.peoplesex);
                    $("#city").val(data.peoplecity);
                    $("#zheng").val(data.peoplezheng);
                    $("#phone").val(data.peoplephone);
                    $("#address").val(data.peopleaddress);
                    $("#money").val(data.peoplemoney);
                    $("#pid").val(data.peopleid);
                }
            }
        });
    }


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

    function changeCard(){
        var value = $("#newCard").val();
        if( $("#oldCardnum").val() == ''){
            layer.msg("您还没有读卡！", {icon: 5});
        } else {
            $.ajax({
                url: '<%= request.getContextPath()%>/CardBusinessServlet',
                dataType:'json',
                type:'get',
                data:{action: "changeCard", newCard: value, oldCard: $("#oldCardnum").val()},
                success : function(data){
                    if(data == 400){
                        layer.msg("查询不到该卡号", {icon: 5});
                        // peoplecard
                    } else{
                        layer.msg("换卡成功", {icon: 6});
                    }
                }
            });
        }
    }
</script>
