<%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/19
  Time: 9:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>预约取号</title>
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

    <table class="layui-hide" id="userList" lay-filter="test"></table>

    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">取号</a>
    </script>
</form>
</body>
</html>


<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js" charset="utf-8"></script>
<script src="<%=request.getContextPath()%>/js/layui/layui.js" charset="utf-8"></script>
<script >

    layui.use(['table','laypage', 'form'],function() {
        var table = layui.table; //表格
        var form = layui.form;
        //执行一个 table 实例
        table.render({
            elem: '#userList'
            , height: 280
            , url: '<%=request.getContextPath()%>/DutyServlet' //数据接口
            , title: '对账表'
            , page: false //开启分页
            , id: 'testReload'
            , smartReloadModel: true
            , cols: [[ //表头
                {field: 'pname', title: '预约科室', width: 80, align: 'center'}
                , {field: 'guaday', title: '预约日期', width: 160, sort: true, align: 'center'}
                , {field: 'guaname', title: '预约医生', width: 160, sort: true, align: 'center'}
                , {fixed: 'right', title: '操作', width: 80, align: 'center', toolbar: '#barDemo'}
            ]]
        });

        //监听行工具事件
        table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                , layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'del') {
                if($("#oldCardnum").val() == ""){
                    layer.msg("您还没有读卡！");
                } else {
                    $.ajax({
                        url: '<%= request.getContextPath()%>/DutyServlet',
                        dataType:'text',
                        type:'post',
                        data:{action: "delGuaHao", gid: data.guaid},
                        success : function(data){
                            if(data == 200){
                                obj.del();
                                layer.msg("取号成功", {icon: 6});
                            } else {
                                layer.msg("取号失败", {icon: 5});
                            }
                        }
                    });
                }
            }
        });
    });

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

                    layui.table.reload('testReload', {
                        method : 'post',
                        where : {
                            action:"getNumberList",
                            cardnum: $("#cardnum").val()
                        },
                        page : {
                            curr : 1
                        }
                    });
                }
            }
        });
    }
</script>