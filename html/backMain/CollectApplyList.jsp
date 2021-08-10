<%@ page import="Model.UserBean" %><%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/6
  Time: 9:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/layui/css/layui.css"  media="all">
</head>
<body>
<% UserBean ub = (UserBean) session.getAttribute("User");%>
<form class="layui-form" action="">
    <div class="layui-inline">

        <div class="layui-inline">
            <label class="layui-form-label">审批状态</label>
            <div class="layui-input-inline">
                <select name="state" id="state">
                    <option value="0">请选择</option>
                    <option value="13">待审核</option>
                    <option value="14">已审核</option>
                </select>
            </div>
        </div>


        <div class="layui-input-inline">
            <input type="text" id="begintime" name="begintime" placeholder="开始时间"
                   autocomplete="off" class="layui-input"/>
        </div>
        <div class="layui-input-inline">
            <input type="text" id="overtime" name="overtime" placeholder="截止时间"
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

<table class="layui-hide" id="userList" lay-filter="test"></table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
</script>

<div class="layui-inline">
    <div class="layui-input-inline">
        <button class="layui-btn" id="newApply"
                lay-filter="formDemo" data-type="reload" style="margin-left: 15px">
            <i class="layui-icon layui-icon-addition">  新申请</i>
        </button>

    </div>
</div>

</body>
</html>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js" charset="utf-8"></script>
<script src="<%=request.getContextPath()%>/js/layui/layui.js" charset="utf-8"></script>
<script >

    layui.use(['table','laypage', 'form'],function(){
        var table = layui.table; //表格
        var form = layui.form;
        //执行一个 table 实例
        table.render({
            elem: '#userList'
            ,height: 280
            ,url: '<%=request.getContextPath()%>/ApplyServlet' //数据接口
            ,title: '用户表'
            ,page: true //开启分页
            ,limit:5
            ,id: 'testReload'
            ,smartReloadModel:true
            ,cols: [[ //表头
                {field: 'rn', title: '序号', width:80, sort: true, fixed: 'left'}
                ,{field: 'applyid', title: 'ID', width:80}
                ,{field: 'applydate', title: '申请时间', width:200}
                ,{field: 'applyperson', title: '申请人', width:100, sort: true}
                ,{field: "applynum",title: "申请数量", width:80, sort: true}
                ,{field: 'applymanger', title: '审核人', width:100, sort: true}
                ,{field: 'okdate', title: '审核时间', width:200}
                ,{field: 'applystate', title: '状态', width:80}
                ,{fixed: 'right',  title: '操作',width: 120, align:'center', toolbar: '#barDemo'}
            ]]
        });


        //监听行工具事件
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值

            if(layEvent === 'detail'){
                layer.msg(data.uaccount);
            } else if(layEvent === 'edit'){
                if(data.applystate.toString() === "已审核"){
                    layer.msg("该申请已审核，不可修改！");
                    return;
                }
                if(data.applyperson.toString() != "<%=ub.getUname()%>"){
                    layer.msg("只能修改自己的申请！");
                    return;
                }
                layer.open({
                    type: 2,
                    title: '修改申请单',
                    maxmin: true,
                    area: ['420px', '330px'],
                    shadeClose: false, //点击遮罩关闭
                    content: '<%=request.getContextPath()%>/ApplyServlet?action=getApplication&aid=' + data.applyid
                });
            }
        });

        $('#searchBtn').on('click', function() {
            table.reload('testReload', {
                method : 'post',
                where : {
                    applyperson : $('#applyperson').val(),
                    state : $('#state').val(),
                    begintime : $('#begintime').val(),
                    overtime : $('#overtime').val()
                },
                page : {
                    curr : 1
                }
            });
            return false;
        });

        $('#newApply').on('click', function() {
            layer.open({
                type: 2,
                title: '申请单',
                maxmin: true,
                area: ['420px', '330px'],
                shadeClose: false, //点击遮罩关闭
                content: '<%=request.getContextPath()%>/html/backMain/NewApply.jsp'
            });
        });


    });

</script>
