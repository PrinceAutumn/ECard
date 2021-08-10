<%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/18
  Time: 21:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>预约挂号</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/layui/css/layui.css" media="all">
</head>
<body>
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

</form>

<table class="layui-hide" id="cardList" lay-filter="test"></table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="booking">预约</a>
</script>
</body>
</html>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js" charset="utf-8"></script>
<script src="<%=request.getContextPath()%>/js/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    layui.use(['table','laypage'],function() {
        var table = layui.table; //表格
        var layerpage = layui.laypage;
        //执行一个 table 实例
        table.render({
            elem: '#cardList'
            , height: 470
            , url: '<%=request.getContextPath()%>/DutyServlet?action=list' //数据接口
            , title: '门诊排班表'
            , page: true //开启分页
            , limit: 11
            , id: 'testReload'
            , smartReloadModel: true
            , cols: [[ //表头
                {field: 'pname', title: '科室', width: 80, align: 'center'}
                , {field: 'guaday', title: '日期', width: 160, sort: true, align: 'center'}
                , {field: 'guaname', title: '医生', width: 160, sort: true, align: 'center'}
                , {fixed: 'right', title: '操作', width: 80, align: 'center', toolbar: '#barDemo'}
            ]]
        });
        //监听行工具事件
        table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                , layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'booking') {
                if($("#oldCardnum").val() == ""){
                    layer.msg("您还没有读卡！");
                } else {
                    layer.open({
                        type: 2,
                        title: '预约',
                        maxmin: true,
                        area: ['450px', '330px'],
                        shadeClose: false, //点击遮罩关闭
                        content: '<%=request.getContextPath()%>/DutyServlet?action=booking&guabatch=' + data.guabatch
                                    + "&cardnum=" + $("#oldCardnum").val() + "&guaadmin=" + $("#uname").val()
                    });
                }
            }
        });

    });

    function searchBtn() {
        var flag = false;
        var value = $("#cardnum").val();
        $.ajax({
            url: '<%= request.getContextPath()%>/CardBusinessServlet',
            dataType: 'json',
            type: 'get',
            data: {action: "readCard", cardnum: value},
            success: function (data) {
                if (data == 400) {
                    layer.msg("查询不到该卡号", {icon: 5});
                } else {
                    flag = true;
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
</script>

