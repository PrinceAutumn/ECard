<%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/19
  Time: 14:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>日志查看</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/layui/css/layui.css"  media="all">
</head>
<body>
<form class="layui-form" action="">
    <div class="layui-inline">

        <div class="layui-input-inline">
            <input type="text" id="begintime" name="over" placeholder="请输入开始日期"
                   autocomplete="off" class="layui-input"/>
        </div>

        <div class="layui-input-inline">
            <input type="text" id="overtime" name="over" placeholder="请输入截止日期"
                   autocomplete="off" class="layui-input"/>
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

</body>
</html>

<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js" charset="utf-8"></script>
<script src="<%=request.getContextPath()%>/js/layui/layui.js" charset="utf-8"></script>
<script >

    layui.use(['table','laypage'],function(){
        var table = layui.table; //表格
        var layerpage = layui.laypage;
        //执行一个 table 实例
        table.render({
            elem: '#cardList'
            ,height: 470
            ,url: '<%=request.getContextPath()%>/DayLogServlet' //数据接口
            ,title: '卡表'
            ,page: true //开启分页
            ,limit:11
            ,id: 'testReload'
            ,smartReloadModel:true
            ,cols: [[ //表头
                {field: 'rn', title: '序号', width:80, sort: true, fixed: 'left'}
                ,{field: 'logrenname', title: '操作人', width:80, align:'center'}
                ,{field: 'logtime', title: '操作时间', width: 200, sort: true, align:'center'}
                ,{field: 'logthing', title: '操作事项', width:160, align:'center'}
            ]]
        });

        $('#searchBtn').on('click', function() {
            table.reload('testReload', {
                method : 'post',
                where : {
                    begintime:$('#begintime').val(),
                    overtime:$('#overtime').val(),
                },
                page : {
                    curr : 1
                }
            });
            return false;
        });

    });



</script>
