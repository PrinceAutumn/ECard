<%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/16
  Time: 10:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>工作量统计</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/layui/css/layui.css"  media="all">
</head>
<body>
<form class="layui-form" action="">
    <div class="layui-inline">
        <div class="layui-input-inline">
            <input type="text" id="beginTime" name="beginTime" placeholder="请输入起始时间"
                   autocomplete="off" class="layui-input"/>
        </div>

        <div class="layui-input-inline">
            <input type="text" id="overTime" name="overTime" placeholder="请输入截止时间"
                   autocomplete="off" class="layui-input"/>
        </div>

        <div class="layui-inline">
            <label class="layui-form-label">统计人</label>
            <div class="layui-input-inline">
                <select name="uaccount" id="uaccount">
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
            elem: '#cardList'
            ,height: 280
            ,url: '<%=request.getContextPath()%>/WorkLoadServlet' //数据接口
            ,title: '统计表'
            ,page: true //开启分页
            ,limit:5
            ,id: 'testReload'
            ,smartReloadModel:true
            ,cols: [[ //表头
                {field: 'rn', title: '序号', width:80, sort: true, fixed: 'left', align:'center'}
                ,{field: 'uname', title: '工作人员', width:100, align:'center'}
                ,{field: 'worksold', title: '售卡量', width:100, align:'center'}
                ,{field: 'workchange', title: '换卡量', width:100, sort: true, align:'center'}
                ,{field: "workrefund",title: "退卡量", width:100, sort: true, align:'center'}
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
                $("#uaccount").html(str);
                //重新渲染生效
                form.render();
            }
        });


        $('#searchBtn').on('click', function() {
            table.reload('testReload', {
                method : 'post',
                where : {
                    uaccount : $('#uaccount').val(),
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