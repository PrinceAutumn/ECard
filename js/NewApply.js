$(document).ready(function (){
    $.ajax({
        url: '<%= request.getContextPath()%>/ApplyServlet?action=getMaxCardnum',
        dataType:'text',
        type:'get',
        success : function(data){
            //jquery赋值方式
            $("#cardnum").text(data);
        }
    });
});