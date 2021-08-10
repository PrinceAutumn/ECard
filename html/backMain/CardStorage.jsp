<%--
  Created by IntelliJ IDEA.
  User: NewOwl
  Date: 2021/3/31
  Time: 22:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>卡入库</title>
    <script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-3.6.0.js"></script>
    <style>
        div {
            width:800px;
            margin:200px auto;
            border:1px solid red;
            text-align:center;
        }
        input {
            width:100%;
            height:40px;
            border:1px solid #dbdbdb;
            outline:none;
            font-size:20px;
            text-indent:10px;
        }
        label {
            position:relative;
            width:400px;
            margin:10px auto;
            display:inline-block;
        }
        label:after {
            content:"";
            display:inline-block;
            width:0;
            height:2px;
            background:red;
            transition:width 1s;
            position:absolute;
            bottom:1px;
            left:1px;
        }
        .active:after {
            width:calc(100% - 2px)
        }
        form button {
            /*outline: 0;*/
            background-color: #696969;
            border: 0px;
            padding: 10px 15px;
            color: 	#F5F5F5;
            border-radius: 3px;
            width: 250px;
            cursor: pointer;
            font-size: 18px;
            -webkit-transition-duration: 0.25s;
            transition-duration: 0.25s;
            margin: 10px 0px;
        }
        form button:hover {
            background-color: #C0C0C0;
        }
    </style>
</head>
<body>
<form action="CardStorageServlet">
    <input type="hidden" name="action" value="NewStorage">
    <div>
        <h3>卡入库</h3>
        <label>
            <input type="text" name="begin" placeholder="开始卡号" onkeyup="this.value=this.value.replace(/[^\d]/g,'')">
        </label>
        <label>
            <input type="text" name="over" placeholder="截止卡号" onkeyup="this.value=this.value.replace(/[^\d]/g,'')">
        </label>
        <label>
            <input type="text" name="prefix" id="prefix" placeholder="前缀 " onkeyup="this.value=this.value.replace(/[^a-zA-z]/g,'')">
        </label>
        <br>
        <button type="submit" id="Storage">入库</button>
        <button type="button" id="back">返回</button>
    </div>
</form>

<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js" charset="utf-8"></script>
<script src="<%=request.getContextPath()%>/js/layui/layui.js" charset="utf-8"></script>
<script>
    $("input").focus(function() {
        $(this).parent("label").addClass("active");
    });
    $("input").blur(function() {
        if ($(this).val() == "") {
            $(this).parent("label").removeClass("active");
        }
    })
</script>

<script type="text/javascript">
    $(document).ready(function(){
        $("#prefix").blur(function(){
            var value = $("#prefix").val();
            var reg = /^[a-zA-z]{2}$/;
            if(value.length != 2 || !reg.test(value)){
                alert("输入不合法，请输入两位英文字母");
            }
            var up = value.toUpperCase();
            $("#prefix").val(up);
        });
    });

    $(":submit").on('click',function (){
        $("input").each(function (){
            if($(this).val() == ''){
                alert("输入框不能为空！");
                event.preventDefault();
                return false;
            }
        });
        return true;
    });

</script>

</body>
</html>

