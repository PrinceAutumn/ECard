<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/4/1
  Time: 11:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/layui/css/layui.css"  media="all">
</head>
<body>
<form class="layui-form" action="">
    <div class="layui-inline">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-inline">
            <input type="text" id="uname" name="uname" placeholder="请输入用户名"
                   autocomplete="off" class="layui-input"/>
        </div>

        <div class="layui-inline">
            <label class="layui-form-label">科室</label>
            <div class="layui-input-inline">
                <select name="department" id="department">
                    <option value="0">请选择</option>
                    <option value="4">内科</option>
                    <option value="5">外科</option>
                </select>
            </div>
        </div>

        <div class="layui-inline">
            <label class="layui-form-label">角色</label>
            <div class="layui-input-inline">
                <select name="role" id="role">
                    <option value="0">请选择</option>
                    <option value="1">管理员</option>
                    <option value="2">收费员</option>
                    <option value="3">医生</option>
                </select>
            </div>
        </div>

        <div class="layui-inline">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-inline">
                <select name="state" id="state">
                    <option value="0">请选择</option>
                    <option value="8">开启</option>
                    <option value="7">禁用</option>
                </select>
            </div>
        </div>

        <div class="layui-inline">
            <div class="layui-input-inline">
                <button class="layui-btn" id="searchBtn" lay-submit
                        lay-filter="formDemo" data-type="reload" style="margin-left: 15px">
                    <i class="layui-icon layui-icon-ok">  查询</i>
                </button>

            </div>
        </div>
    </div>
</form>


<table class="layui-hide" id="userList" lay-filter="test"></table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">启/禁用</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="init">重置密码</a>
</script>

<div class="layui-inline">
    <div class="layui-input-inline">
        <button class="layui-btn" id="addUser"
                lay-filter="formDemo" data-type="reload" style="margin-left: 15px">
            <i class="layui-icon layui-icon-addition">  新增人员</i>
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
        //执行一个 table 实例
        table.render({
            elem: '#userList'
            ,height: 280
            ,url: '<%=request.getContextPath()%>/UserServlet' //数据接口
            ,title: '用户表'
            ,page: true //开启分页
            ,limit:5
            ,id: 'testReload'
            ,smartReloadModel:true
            ,cols: [[ //表头
                {field: 'rn', title: '序号', width:80, sort: true, fixed: 'left'}
                ,{field: 'uaccount', title: 'ID', width:80}
                ,{field: 'uname', title: '用户名', width:80}
                ,{field: 'urole', title: '角色', width:80, sort: true}
                ,{field: "udepartment",title: "科室", width:80, sort: true}
                ,{field: 'ustate', title: '状态', width:80, sort: true}
                ,{fixed: 'right',  title: '操作',width: 300, align:'center', toolbar: '#barDemo'}
            ]]
        });
        //监听行工具事件
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值

            if(layEvent === 'detail'){
                if(data.ustate == "开启"){
                    layer.confirm('您确定要禁用吗', function(index){
                        $.ajax({
                            url: "<%=request.getContextPath()%>/UserServlet",
                            type: "POST",
                            data: {action: 'offUser', uid: data.uaccount},
                            success: function (msg) {
                                if (msg == 200) {
                                    //关闭弹框
                                    layer.close(index);
                                    layer.msg("禁用成功", {icon: 6});
                                    window.location.reload();
                                } else {
                                    layer.msg("禁用失败", {icon: 5});
                                }
                            }
                        });
                        return false;
                    });
                } else if(data.ustate == "禁用"){
                    layer.confirm('您确定要启用吗', function(index){
                        $.ajax({
                            url: "<%=request.getContextPath()%>/UserServlet",
                            type: "POST",
                            data: {action: 'onUser', uid: data.uaccount},
                            success: function (msg) {
                                if (msg == 200) {
                                    //关闭弹框
                                    layer.close(index);
                                    layer.msg("启用成功", {icon: 6});
                                    window.location.reload();
                                } else {
                                    layer.msg("启用失败", {icon: 5});
                                }
                            }
                        });
                        return false;
                    });
                }

            } else if(layEvent === 'del'){
                if(data.ustate == "已删除"){
                    layer.msg("该账号已删除");
                } else {
                    layer.confirm('真的删除行么', function(index){
                        $.ajax({
                            url: "<%=request.getContextPath()%>/UserServlet",
                            type: "POST",
                            data: {action: 'del', deluid: data.uaccount},
                            success: function (msg) {
                                if (msg == 200) {
                                    //删除这一行  毕业
                                    obj.del();
                                    //关闭弹框
                                    layer.close(index);
                                    layer.msg("删除成功", {icon: 6});
                                } else {
                                    layer.msg("删除失败", {icon: 5});
                                }
                            }
                        });
                        return false;
                    });
                }

            } else if(layEvent === 'edit'){
                layer.open({
                    type: 2,
                    title: '修改用户',
                    maxmin: true,
                    area: ['420px', '330px'],
                    shadeClose: false, //点击遮罩关闭
                    content: '<%=request.getContextPath()%>/UserServlet?action=updateUser&uid=' + data.uaccount
                });
                // update(data);
            } else if(layEvent === 'init'){
                layer.confirm('真的重置密码行么', function(index){
                    $.ajax({
                        url: "<%=request.getContextPath()%>/UserServlet",
                        type: "POST",
                        data: {action: 'initPwd', uid: data.uaccount},
                        success: function (msg) {
                            if (msg == 200) {
                                layer.close(index);
                                layer.msg("重置成功", {icon: 6});
                            } else {
                                layer.msg("重置失败", {icon: 5});
                            }
                        }
                    });
                    return false;
                });
            }
        });

        $('#searchBtn').on('click', function() {
            table.reload('testReload', {
                method : 'post',
                where : {
                    uname : $('#uname').val(),
                    department : $('#department').val(),
                    role:$('#role').val(),
                    state:$('#state').val()
                },
                page : {
                    curr : 1
                }
            });
            return false;
        });

        $('#addUser').on('click', function() {
            layer.open({
                type: 2,
                title: '申请单',
                maxmin: true,
                area: ['420px', '330px'],
                shadeClose: false, //点击遮罩关闭
                content: '<%=request.getContextPath()%>/html/backMain/NewUser.jsp'
            });
        });

    });

</script>

