<%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/6
  Time: 9:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>审批表</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/layui/css/layui.css"  media="all">
</head>
<body>
<form class="layui-form" action="">
    <div class="layui-inline">

        <div class="layui-inline">
            <label class="layui-form-label">申请人</label>
            <div class="layui-input-inline">
                <select name="applyperson" id="applyperson">
                    <option value="0">请选择</option>
                </select>
            </div>
        </div>

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
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">审核</a>
</script>
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
                {field: 'rn', title: '序号', width:80, sort: true, fixed: 'left', align:'center'}
                ,{field: 'applyid', title: 'ID', width:80, align:'center'}
                ,{field: 'applydate', title: '申请时间', width:200, align:'center'}
                ,{field: 'applyperson', title: '申请人', width:100, sort: true, align:'center'}
                ,{field: "applynum",title: "申请数量", width:110, sort: true, align:'center'}
                ,{field: 'applymanger', title: '审核人', width:100, sort: true, align:'center'}
                ,{field: 'okdate', title: '审核时间', width:200, align:'center'}
                ,{field: 'applystate', title: '状态', width:80, align:'center'}
                ,{fixed: 'right',  title: '操作',width: 120, align:'center', toolbar: '#barDemo'}
            ]]
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
                $("#applyperson").html(str);
                //重新渲染生效
                form.render();
            }
        });


        //监听行工具事件
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值

            if(layEvent === 'detail'){
                layer.open({
                    type: 2,
                    title: '查看',
                    maxmin: true,
                    area: ['450px', '330px'],
                    shadeClose: false, //点击遮罩关闭
                    content: '<%=request.getContextPath()%>/ApplyServlet?action=check&applyid=' + data.applyid
                    + '&applydate=' + data.applydate + '&applyperson=' + data.applyperson + '&applynum=' +
                        data.applynum + '&applymanger=' + data.applymanger + '&okdate=' + data.okdate
                });
            } else if(layEvent === 'edit'){
                if(data.applystate.toString() === "已审核"){
                    layer.msg("该申请已审核！");
                } else {
                    layer.open({
                        type: 2,
                        title: '审核',
                        maxmin: true,
                        area: ['420px', '330px'],
                        shadeClose: false, //点击遮罩关闭
                        content: '<%=request.getContextPath()%>/ApplyServlet?action=examine&name=' + data.applyperson
                            + '&date=' + data.applydate + '&aid=' + data.applyid + '&number=' + data.applynum
                    });
                }
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

    });

</script>
