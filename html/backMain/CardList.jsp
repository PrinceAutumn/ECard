<%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/1
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>卡表</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/layui/css/layui.css"  media="all">
</head>
<body>
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
            <label class="layui-form-label">卡状态</label>
            <div class="layui-input-inline">
                <select name="state" id="state">
                    <option value="0">请选择</option>
                    <option value="11">未领用</option>
                    <option value="12">已领用</option>
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
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

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
            ,url: '<%=request.getContextPath()%>/CardServlet' //数据接口
            ,title: '卡表'
            ,page: true //开启分页
            ,limit:11
            ,id: 'testReload'
            ,smartReloadModel:true
            ,cols: [[ //表头
                {field: 'rn', title: '序号', width:80, sort: true, fixed: 'left'}
                ,{field: 'cardid', title: '卡ID', width:80, align:'center'}
                ,{field: 'cardnum', title: '卡号', width: 160, sort: true, align:'center'}
                ,{field: 'carddate', title: '导入时间', width:200, sort: true, align:'center'}
                ,{field: 'cardstate', title: '卡状态', width:100, sort: true, align:'center'}
                ,{fixed: 'right',  title: '操作',width: 80, align:'center', toolbar: '#barDemo'}
            ]]
        });
        //监听行工具事件
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
                if(layEvent === 'del'){
                    if(data.cardstate != "未领用"){
                        layer.msg("仅能删除未领用的卡！");
                    } else {
                        layer.confirm('您确定删除此卡', function(index){
                            $.ajax({
                                url: "<%=request.getContextPath()%>/CardServlet",
                                type: "POST",
                                data: {action: 'del', cardid: data.cardid},
                                success: function (msg) {
                                    if (msg == 200) {
                                        //删除这一行
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
                }
        });
        $('#searchBtn').on('click', function() {
            table.reload('testReload', {
                method : 'post',
                where : {
                    begin : $('#begin').val(),
                    over : $('#over').val(),
                    begintime:$('#begintime').val(),
                    overtime:$('#overtime').val(),
                    state:$('#state').val()
                },
                page : {
                    curr : 1
                }
            });
            return false;
        });

    });



</script>