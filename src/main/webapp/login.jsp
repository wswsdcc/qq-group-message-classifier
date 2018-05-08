<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@page import="entity.*"%>
<jsp:useBean id="QQMsgRsvMgr" class="entity.QQMsgRsvMgr" scope="application"/>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<%
	QQMsgRsvMgr QQMR = (QQMsgRsvMgr) session.getAttribute("QQMsgRsver");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>欢迎使用QQ群信息分类助手！</title>
<link href="css/style.css"     		 rel="stylesheet" type="text/css">
<link href="css/framework.css" 		 rel="stylesheet" type="text/css">
<link href="css/owl.theme.css" 		 rel="stylesheet" type="text/css">
<link href="css/swipebox.css"		 rel="stylesheet" type="text/css">
<link href="css/font-awesome.css"	 rel="stylesheet" type="text/css">
<link href="css/animate.css"	     rel="stylesheet" type="text/css">

<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jqueryui.js"></script>
<script type="text/javascript" src="js/framework.plugins.js"></script>
<script type="text/javascript" src="js/custom.js"></script>
</head>

<body> 

<div id="preloader">
	<div id="status">
    	<p class="center-text">
			内容加载中...
        </p>
    </div>
</div>   
<div class="login-page bg5">
    <div class="login-page-wrapper">
        <div class="slider-style-qrcode" style="height:300px; margin-top:-120px">
            <img src="<%=basePath%>images/qrcode.png" style="margin:auto"/>
            <br>
			<br>
			<h3 id="clickMe" onclick="VQRCode()">请打开手机QQ扫描上方的二维码</h3>
			<!--二维码过期倒计时-->
			<a href="#" class="slider-button-1 button-blue">点击刷新</a>
        </div>
    </div>		
</div>
 
<script type="text/javascript">
// 两秒后模拟点击
setTimeout(function(){
	// IE
	if(document.all) {
		document.getElementById("clickMe").click();
	}
	// 其它浏览器
	else {
		var e = document.createEvent("MouseEvents");
		e.initEvent("click", true, true);
		document.getElementById("clickMe").dispatchEvent(e);
	}
}, 1000);


var xmlHttpReq;  
//创建一个XmlHttpRequest对象  
function createXmlHttpRequest()  
{  
    if(window.XMLHttpRequest)  
    {  
       xmlHttpReq = new XMLHttpRequest();//非IE浏览器  
    }else  
    {  
       xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");//IE浏览器  
    }  
}  
//检测用户名是否已经被注册  
function VQRCode()  
{   
    //首先创建精灵对象  
    createXmlHttpRequest();  
    //指明准备状态改变时回调的函数名  
    xmlHttpReq.onreadystatechange=handle;  
    //尝试以异步的get方式访问某个URL  
    //请求服务器端的一个servlet  
    var url = "servlet/QRVServlet?timestamp=" + new Date().getTime(); 
    xmlHttpReq.open("get",url,true);  
    //向服务器发送请求  
    xmlHttpReq.send(null);  
}  
//状态发生改变时回调的函数  
function handle(){  
    //准备状态为4  
    if(xmlHttpReq.readyState==4)  
    {  
        //响应状态码为200，代表一切正常  
        if(xmlHttpReq.status==200)  
        {  
            var res = xmlHttpReq.responseText;
            res = unescape(res.replace(/\\u/g, "%u"));
            alert(res); 
            setTimeout(function(){
                window.location.href="mainTabs.jsp";
            }, 1000);
        }  
    }
}
</script>
</body>
</html>
