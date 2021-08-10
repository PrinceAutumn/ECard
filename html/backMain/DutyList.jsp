<%@ page import="java.util.List" %>
<%@ page import="Model.GuaHaoBean" %><%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/4/18
  Time: 0:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath();%>
<html>
<head>
    <meta charset='utf-8'/>
    <link href='<%=path%>/css/fullcalendar/fullcalendar.min.css' rel='stylesheet'/>
    <link href='<%=path%>/css/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print'/>
    <style>
        body {
            margin: 40px 10px;
            padding: 0;
            font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
            font-size: 14px;
        }

        #calendar {
            max-width: 900px;
            margin: 0 auto;
        }

        #box {
            display: none;
        }

        .form-inline {
            padding: 20px;
        }

        .select {
            display: block;
            width: 100%;
            padding: 5px 0;
            margin-bottom: 20px;
        }

        .label-success {
            background-color: #82af6f;
        }

        .label-danger {
            background-color: #d15b47;
        }
    </style>
</head>
<body>

<div id='calendar'></div>

<div id='box'>
    <form class='form-inline' id="form">
        <select name='username' class='select' id="username">
        </select>
        <!--        <div class='radios'>-->
        <!--            <label class='label_canlendar'><input class='ace' type='radio' value='#3a87ad' name='code' checked><span-->
        <!--                    class='classes' style='color:#3a87ad'>早班</span></label>-->
        <!--            <label class='label_canlendar'><input class='ace' type='radio' value='#82af6f' name='code'><span-->
        <!--                    class='classes' style='color:#82af6f'>中班</span></label>-->
        <!--            <label class='label_canlendar'><input class='ace' type='radio' value='#d15b47' name='code'><span-->
        <!--                    class='classes' style='color:#d15b47'>晚班</span></label>-->
        <!--        </div>-->
    </form>
</div>

<script src='<%=path%>/js/jquery-3.6.0.js'></script>
<script src='<%=path%>/js/fullcalendar/moment.min.js'></script>
<script src='<%=path%>/js/fullcalendar/fullcalendar.min.js'></script>
<script src="<%=path%>/js/fullcalendar/zh-cn.js"></script>
<script src="<%=path%>/js/layer/layer.js"></script>
<script>
    <% List<GuaHaoBean> guahao = (List<GuaHaoBean>) request.getAttribute("GuaHao");%>
    console.log(<%=guahao.size()%>);
    var events = [
        <% for(GuaHaoBean ghb : guahao){%>
        {
            id: <%=ghb.getGuaid()%>,
            text: '<%=ghb.getGuaaccount()%>',
            title: '<%=ghb.getGuaname()%>',
            backgroundColor: '#3a87ad',
            start: '<%=ghb.getGuaday()%>'
        },
        <%}%>
   /*,
     {
     id: 1011,
     title: '百度一下',
     url: 'http://baidu.com/',
     start: '2018-02-28'
     }*/
    ];

    $box = $('#box');
    $calendar = $('#calendar');
    $calendar.fullCalendar('destroy');

    var calendar = $calendar.fullCalendar({
        header: {
            left: 'month',
            center: '',
            right: 'prev,next today'
        },
        buttonText: {
            today: '今天'
        },
        locale: 'zh-cn',
        defaultView: "month", // basicWeek listWeek agendaWeek
        weekMode: 'liquid',
        // weekNumbers: true,
        // height: 'auto',

        timeFormat: 'HH:mm',
        navLinks: true,       // can click day/week names to navigate views
        eventLimit: 3,        // 限制一天中显示的事件数，默认false
        allDayText: '排班',   // 日历上显示全天的文本
        selectable: true,     // 允许用户通过单击或拖动选择日历中的对象，包括天和时间。
        selectHelper: false,  // 当点击或拖动选择时间时，显示默认加载的提示信息，该属性只在周/天视图里可用。
        unselectAuto: true,   // 当点击页面日历以外的位置时，自动取消当前的选中状态。
        eventBackgroundColor: '#3a87ad',    // 设置日程事件的背景色
        events: events,
        select: select,
        eventClick: eventClick
    });

    // 添加排班
    function select(start, end, allDay) {
        layer.open({
            type: 1,
            shade: false,
            content: $box,
            title: '选择班次',
            btn: ['确认', '关闭'],
            btn1: function () {
                layer.closeAll();
            },
            yes: addCallback
        });

        // 添加排班 - 弹窗回调
        function addCallback() {
            var bgColor = $box.find("input[name=code]:checked").val();
            var title = $box.find("input[name=code]:checked").next().text();
            var text = $box.find("option:selected").text();
            var val = $box.find("option:selected").val();

            var json = {
                title: text,
                text: val,
                allDay: allDay,
                backgroundColor: bgColor,
                start: start.format('YYYY-MM-DD'),
            };

            // test
            // $('#calendar').fullCalendar('renderEvent', json, true);// 添加日历
            addEvent(json);

            // 添加排班 post
            function addEvent(data) {
                if (data.title == null || data.title == '') {
                    return false;
                }
                if (checkStr(data.title) == false) {
                    alert("请不要输入非法字符！");
                    return;
                }

                $.ajax({
                    url: '<%=path%>/DutyServlet?action=addDuty',
                    dataType:'text',
                    type:'post',
                    data:{ guaname: json.title, guaaccount: json.text, guaday: json.start},
                    success : function(msg){
                        if(msg == 200){
                            $('#calendar').fullCalendar('renderEvent', json, true);// 添加日历
                        } else {
                            layer.msg("添加失败！！！");
                        }
                    }
                });
            }

            layer.closeAll();
        }

        calendar.fullCalendar('unselect');
    }


    // 更新排班
    function eventClick(calEvent, jsEvent, view) {

        layer.open({
            type: 1,
            shade: false,
            title: '当前班次：' + calEvent.title,
            btn: ['删除', '关闭'],
            btn1: function () {
                delEvent(calEvent);// 删除排班

                layer.closeAll();
            },
            btn2: function () {
                layer.closeAll();
            },
        });

        // 删除排班
        function delEvent(calEvent) {
            calendar.fullCalendar("removeEvents", calEvent._id); // 删除日历
        }

    }

    $.ajax({
        url: '<%= request.getContextPath()%>/ApplyServlet?action=userList',
        dataType:'json',
        type:'get',
        success : function(data){
            let str = "";
            for(let i of data){
                //组装数据
                str += "<option value='"+i.uaccount+"'>"+i.uname+"</option>";
            }
            //jquery赋值方式
            $("#username").html(str);
        }
    });


    // 是否全天
    function getAllDay(start, end) {
        var start_his = start.indexOf("00:00:00");
        var end_his = end.indexOf("00:00:00");
        if (start_his == -1 || end_his == -1) {
            return false;
        } else {
            return true;
        }
    }

    // 非法字符
    function checkStr(str) {
        var pattern = /[~#^$@%&!*'"]/gi;
        if (pattern.test(str)) {
            return false;
        }
        return true;
    }
</script>
</body>
</html>
