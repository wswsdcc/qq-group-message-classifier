<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>">
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

<!-- Page Content-->    
<div class="login-page bg5">
    <div class="login-page-wrapper">
        <div class="slider-style-1" style="height:300px; margin-top:-120px">
            <h2>QQ群信息分类助手</h2>
			<br>
			<br>
            <a href="servlet/StarterServlet" class="slider-button-1 button-blue">开始体验！</a>
        </div>
    </div>		
</div>
</body>
</html>