<%@ page import="Model.UserBean" %><%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/11
  Time: 21:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>卡充值</title>
</head>
<body>

<input type="text" name="cardnum" id="cardnum" placeholder="请输入卡号/证件号/手机号">
<input type="button" value="读卡" onclick="searchBtn()"><br><br>
<input type="hidden" id="pid" name="pid" value="">
<input type="hidden" id="cardnum2" name="cardnum" value="">

姓名：<span id="uname"></span>
性别：<span id="sex"></span>
籍贯：<span id="city"></span><br><br>
证件号码：<span id="zheng"></span>
联系电话：<span id="phone"></span><br><br>
住址：<span id="address"></span><br><br>
余额：<span id="money"></span>
押金：<span id="deposit">20</span><br><br>
<input type="text" id="moneynum" name="moneynum" placeholder="请输入充值金额" onkeyup="this.value=this.value.replace(/[^\d]/g,'')">
<input type="button" value="充值" onclick="rechargeBtn()">
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
                    $("#uname").text(data.peoplename);
                    $("#sex").text(data.peoplesex);
                    $("#sex").text(data.peoplesex);
                    $("#city").text(data.peoplecity);
                    $("#zheng").text(data.peoplezheng);
                    $("#phone").text(data.peoplephone);
                    $("#address").text(data.peopleaddress);
                    $("#money").text(data.peoplemoney);
                    $("#pid").val(data.peopleid);
                    $("#cardnum2").val(data.peoplecard);
                }
            }
        });
    }


    function rechargeBtn(){
        var value = $("#moneynum").val();
        if($("#cardnum2").val() == ''){
            layer.msg("您还没有读卡",{icon: 5});
        } else if(value = ''){
            layer.msg("充值金额不能为空",{icon: 5});
        } else {
            $.ajax({
                url: '<%= request.getContextPath()%>/CardBusinessServlet',
                dataType:'json',
                type:'get',
                data:{action: "recharge", rechargeNum: $("#moneynum").val(), pid: $("#pid").val(), money: $("#money").html(),
                    cardnum: $("#cardnum").val(), uname:  $("#uname").text()},
                success : function(data){
                    if(data == 400){
                        layer.msg("充值失败", {icon: 5});
                    } else{
                        layer.msg("充值成功", {icon: 6});
                    }
                }
            });
        }
    }
</script>