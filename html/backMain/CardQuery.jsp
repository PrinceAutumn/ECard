<%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/13
  Time: 11:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>卡查询</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/layui/css/layui.css"  media="all">
</head>
<body>
<form class="layui-form" action="">
    <div class="layui-inline">
        <div class="layui-input-inline">
            <input type="text" id="cardnum" name="cardnum" placeholder="请输入卡号"
                   autocomplete="off" class="layui-input"/>
        </div>

        <div class="layui-inline">
            <label class="layui-form-label">卡状态</label>
            <div class="layui-input-inline">
                <select name="state" id="state">
                    <option value="0">请选择</option>
                    <option value="11">未领用</option>
                    <option value="12">已领用</option>
                    <option value="16">已注销</option>
                    <option value="17">已销售</option>
                </select>
            </div>
        </div>

        <div class="layui-inline">
            <label class="layui-form-label">领用人</label>
            <div class="layui-input-inline">
                <select name="receiver" id="receiver">
                    <option value="0">请选择</option>
                </select>
            </div>
        </div>

        <div class="layui-inline">
            <div class="layui-input-inline">
                <button class="layui-btn" id="searchBtn" lay-submit
                        lay-filter="formDemo" data-type="reload" style="margin-left: 15px">
                    <i class="layui-icon layui-icon-search">  查询</i>
                </button>

            </div>
        </div>

    </div>

</form>


<table class="layui-hide" id="cardList" lay-filter="test"></table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
</script>

<div id="cardImfor" align="center" style="display: none">
    <h3>查看卡信息</h3>
    卡号：<span id="divCardnum"></span>
    卡余额：<span id="divMoney"></span><br><br>
    卡状态：<span id="divState"></span>
    就诊人：<span id="divPeople"></span><br><br>
    领用、售卡人：<span id="divApplyname"></span><br><br>
    领用时间：<span id="divApplydate"></span><br><br>
    售卡时间：<span id="divOkdate"></span><br><br>
</div>
</body>
</html>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js" charset="utf-8"></script>
<script src="<%=request.getContextPath()%>/js/layui/layui.js" charset="utf-8"></script>
<script>
    layui.use(['table','laypage', 'form'],function() {
        var table = layui.table; //表格
        var form = layui.form;
        //执行一个 table 实例
        table.render({
            elem: '#cardList'
            , height: 280
            , url: '<%=request.getContextPath()%>/CardServlet?action=cardQuery' //数据接口
            , title: '卡查询表'
            , page: true //开启分页
            , limit:5
            , id: 'testReload'
            , smartReloadModel: true
            , cols: [[ //表头
                {field: 'rn', title: '序号', width: 80, align: 'center'}
                , {field: 'cardnum', title: '卡号', width: 200, align: 'center'}
                , {field: 'pname', title: '卡状态', width: 100, sort: true, align: 'center'}
                , {field: "uname", title: "领用人", width: 110, sort: true, align: 'center'}
                , {field: "peoplename", title: "就诊人", width: 110, sort: true, align: 'center'}
                , {fixed: 'right',  title: '操作',width: 80, align:'center', toolbar: '#barDemo'}
            ]]
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){
                $("#divCardnum").text(data.cardnum);
                $("#divMoney").text(data.peoplemoney);
                $("#divState").text(data.pname);
                $("#divPeople").text(data.peoplename);
                $("#divApplyname").text(data.uname);
                $("#divApplydate").text(data.applydate);
                $("#divOkdate").text(data.okdate);
                layer.open({
                    type: 1,
                    title: '查看卡信息',
                    maxmin: true,
                    area: ['420px', '300px'],
                    shadeClose: false, //点击遮罩关闭
                    content: $('#cardImfor')
                });
            }
        });

        $.ajax({
            url: '<%= request.getContextPath()%>/ApplyServlet?action=userList',
            dataType:'json',
            type:'get',
            success : function(data){
                let str="<option value='0'>请选择</option>";
                for(let i of data){
                    //组装数据
                    str += "<option value='"+i.uaccount+"'>"+i.uname+"</option>";
                }
                //jquery赋值方式
                $("#receiver").html(str);
                //重新渲染生效
                form.render();
            }
        });


        $('#searchBtn').on('click', function() {
            table.reload('testReload', {
                method : 'post',
                where : {
                    cardnum : $('#cardnum').val(),
                    state : $('#state').val(),
                    receiver:$('#receiver').val(),
                },
                page : {
                    curr : 1
                }
            });
            return false;
        });
    });

</script>
