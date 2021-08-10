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
    <link rel="stylesheet" href="<%=request.getContextPath()%>/layui/css/layui.css"  media="all">

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
                            <select name="majorid" id="majorid">
                                <option value="0">请选择</option>
                                <option value="1">内科</option>
                                <option value="2">外科</option>
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


<!--lay-data="{id: 'testReload'}"-->
<table class="layui-hide" id="userList" lay-filter="test"></table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
</body>
</html>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js" charset="utf-8"></script>
<script src="<%=request.getContextPath()%>/layui/layui.js" charset="utf-8"></script>
<script >

    layui.use(['table','laypage', 'form'],function(){
        var table = layui.table; //表格

        //下拉框参数数据获取
        //获取下拉框专业
        // $.ajax({
        //     url : '../../MajorFindAllServlet?deptid=5',
        //     dataType : 'json',
        //     data : {
        //         'state' : 0
        //     }, //查询状态为正常的所有机构类型
        //     type : 'post',
        //     success : function(data) {
        //         $.each(data, function(index, item) {
        //             $('#majorid').append(
        //                 new Option(item.majorname, item.majorid));// 下拉菜单里添加元素
        //         });
        //         layui.form.render("select");
        //     }
        // });

        //执行一个 table 实例
        table.render({
             elem: '#userList'
            ,height: 420
            ,url: '<%=request.getContextPath()%>/userservlet' //数据接口
            ,title: '用户表'
            ,page: true //开启分页
            ,limit:5
            ,id: 'testReload'
           // ,curr: location.hash.replace('#!fenye=', '')
            // ,toolbar: 'default' //开启工具栏，此处显示默认图标，可以自定义模板，详见文档
        //    ,totalRow: true //开启合计行
            ,where : {
                //majorid : '',
                uname : ''
                }
            ,smartReloadModel:true
            ,cols: [[ //表头
                {type: 'checkbox', fixed: 'left'}
                ,{field: 'USERID', title: 'ID', width:80, sort: true, fixed: 'left'}
                ,{field: 'UNAME', title: '用户名', width:80}
                ,{field: 'UPWD', title: '密码', width: 90, sort: true}
                ,{field: 'RID', title: '角色ID', width:80, sort: true}
                ,{field: "ksID",title: "科室", width:80, sort: true}
                ,{fixed: 'right',  title: '操作',width: 300, align:'center', toolbar: '#barDemo'}
            ]]
        });
        //监听行工具事件
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){
                layer.msg('查看操作11111');
            } else if(layEvent === 'del'){
                layer.confirm('真的删除行么', function(index){
                   <%-- obj.del(); //删除对应行（tr）的DOM结构--%>
                   <%-- layer.close(index);--%>
                   <%-- console.log(data.USERID);--%>
                   <%-- console.log(  $(".layui-input").val());--%>

                    $.ajax({
                        url: "<%=request.getContextPath()%>/userservlet",
                        type: "POST",
                        data: {action: 'del', uid: data.USERID,page:$(".layui-input").val()},
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
            } else if(layEvent === 'edit'){
                layer.msg('编辑操作2222');
                layer.open({
                    type: 2,
                    title: '修改用户',
                    maxmin: true,
                    area: ['420px', '330px'],
                    shadeClose: false, //点击遮罩关闭
                    content: 'editUser.jsp',
                });
                update(data);
            }
        });
        $('#searchBtn').on('click', function() {
            console.log('1111'+$('#uname').val());
            table.reload('testReload', {
                method : 'post',
                where : {
                    uname : $('#uname').val()
                   // majorid : $('#majorid').val()
                },
                page : {
                    curr : 1
                }
            });
            return false;
        });

    });

</script>

