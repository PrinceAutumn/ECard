<%@ page import="Model.UserBean" %><%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/15
  Time: 11:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>领卡查询</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/layui/css/layui.css"  media="all">
</head>
<body>
<% UserBean ub = ((UserBean) session.getAttribute("User"));%>

<form class="layui-form" action="">
<div class="layui-inline">
    <div class="layui-input-inline">
        <input type="text" id="begin" name="begin" placeholder="请输入起始卡号"
               autocomplete="off" class="layui-input"/>
    </div>

    <div class="layui-input-inline">
        <input type="text" id="over" name="over" placeholder="请输入截止卡号"
               autocomplete="off" class="layui-input"/>
    </div>


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
            ,url: '<%=request.getContextPath()%>/CardServlet?action=collarCardQuery' //数据接口
            ,title: '卡表'
            ,page: true //开启分页
            ,limit:11
            ,id: 'testReload'
            ,smartReloadModel:true
            ,cols: [[ //表头
                {field: 'rn', title: '序号', width:80, sort: true, fixed: 'left'}
                ,{field: 'cardnum', title: '卡号', width:120, align:'center'}
                ,{field: 'applydate', title: '申请时间', width: 200, sort: true, align:'center'}
                ,{field: 'okdate', title: '审批时间', width:200, sort: true, align:'center'}
                ,{field: 'uname', title: '审批人', width:100, sort: true, align:'center'}
                ,{field: 'peoplename', title: '卡绑定病人', width:120, sort: true, align:'center'}
                ,{field: 'peoplemoney', title: '卡余额', width:100, sort: true, align:'center'}
                ,{field: 'pname', title: '卡状态', width:100, sort: true, align:'center'}
            ]]
        });

        $('#searchBtn').on('click', function() {
            table.reload('testReload', {
                method : 'post',
                where : {
                    begin : $('#begin').val(),
                    over : $('#over').val(),
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