<%@page import="java.io.File"%>
<%@page import="com.scienjus.smartqq.model.UserInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@page import="entity.*"%>
<jsp:useBean id="QQMsgRsvMgr" class="entity.QQMsgRsvMgr" scope="application"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html class="no-js">
<head>
<base href="<%=basePath%>">
<%
	QQMsgRsvMgr QQMR = (QQMsgRsvMgr) session.getAttribute("QQMsgRsver");
	UserInfo myInfo = QQMR.getAccountInfo();
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>我的消息记录</title>
<!--tab style-->
<link rel="stylesheet"               href="css/normalize.css" type="text/css"/>
<link rel="stylesheet"               href="css/demo.css" type="text/css"/>
<link rel="stylesheet"               href="css/tabs.css" type="text/css"/>
<link rel="stylesheet"               href="css/tabstyles.css" type="text/css"/>
<!--leftside bar-->
<link rel="stylesheet" type="text/css" href="css/default.css">
<link rel="stylesheet" href="css/style.min.css">
<!--main architecture-->
<link href="css/style.css"     		 rel="stylesheet" type="text/css">
<link href="css/framework.css" 		 rel="stylesheet" type="text/css">
<link href="css/owl.theme.css" 		 rel="stylesheet" type="text/css">
<link href="css/swipebox.css"		 rel="stylesheet" type="text/css">
<link href="css/font-awesome.css"	 rel="stylesheet" type="text/css">
<link href="css/animate.css"	     rel="stylesheet" type="text/css">
<!--hint-->
<link rel="stylesheet" href="css/tippy.css">

<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/jqueryui.js" type="text/javascript"></script>
<script src="js/framework.plugins.js" type="text/javascript"></script>
<script src="js/custom.js" type="text/javascript"></script>
<!--leftside bar-->
<script src="js/production/materialMenu.min.js"></script>
<!--tab style-->
<script src="js/modernizr.custom.js"></script>
<script src="js/cbpFWTabs.js"></script>
<!--hint-->
<script src="js/tippy.js"></script>
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
    <%
        if ((String)request.getAttribute("delFlag") == "1") 
        {
    %>
 		<script>alert("文件删除成功");</script>
    <%
 		}
    %>
 	<%
 	    if ((String)request.getAttribute("delFlag") == "-1") 
    	{
    %>
 		<script>alert("文件删除失败");</script>
 	<%
 		}
 	%>
    <!--content-->
	<div id="wrapper" class="wrapper">
	    <a href="mainTabs.jsp"><img src="<%=basePath%>ky_img/home.png" style="margin-left:50px;"></a>
		<img style="margin-top:8px;margin-left:340px" src="<%=basePath%>ky_img/info.png" class="tippy-right" title="文件名说明：——————xx_class2:工作学习—————xx_class4:学校活动—————xx_class5:闲聊——————xx_class6:广告——————xx_keyrec:关键字监听">	
        <div class="wrapper-table">
            <div class="display-grouptable">
                <table>
                <%
                    File file = new File("../webapps/qqgmc2/records");
                    int fileNums = 0;
                    File[] exitFile = file.listFiles();
                    for(int i = 0; i < exitFile.length; i++){
                        if(exitFile[i].getName().startsWith(myInfo.getUin())){
                            fileNums++;  
                        }
                    }
                    if(fileNums == 0){
                %>
                    <tr>
                    <th colspan="2" scope="col">对不起，未找到相关记录</th>         
                    </tr>
                <%
                        
                    }else{
                        for(int i = 0; i < exitFile.length; i++){
                            if(exitFile[i].getName().startsWith(myInfo.getUin())){
                %>
			        <tr>
                    <th align="center" width="50%" scope="col"><img src="<%=basePath%>ky_img/document_48.png"><a href="<%=basePath%>records/<%=exitFile[i].getName()%>" target="_blank"><%=exitFile[i].getName()%></a></th> 
                    <th width="25%" scope="col"><a href="servlet/DownloadServlet?filename=<%=exitFile[i].getName()%>">下载</a></th>
                    <th width="25%" scope="col"><font color="red"><a href="servlet/DeleteServlet?filename=<%=exitFile[i].getName()%>" onclick='return window.confirm("该文件将被删除，\n是否确定？")'>删除</a></font></th> 					
                    </tr>
			    <% 
			                }
			            }
			        }
			    %>					
			    </table>
            </div>
        </div>	
	</div>

	<!--leftside bar-->
	<button id="mm-menu-toggle" class="mm-menu-toggle">Toggle Menu</button>
	    <nav id="mm-menu" class="mm-menu">
	    <div class="mm-menu__header">
	        <h2 class="mm-menu__title">你好！<%=myInfo.getNick()%></h2>
	    </div>
	    <ul class="mm-menu__items">
	    <li class="mm-menu__item">
	        <a class="mm-menu__link" href="groupAndDiscuss.jsp">
	        <span class="mm-menu__link-text"><i class="md md-group"></i> 我加入的组群</span>
	        </a>
	    </li>
	    <li class="mm-menu__item">
	        <a class="mm-menu__link" href="myInfo.jsp">
	        <span class="mm-menu__link-text"><i class="md md-info-outline"></i> 我的资料</span>
	        </a>
	    </li>
	    <li class="mm-menu__item">
	        <a class="mm-menu__link" href="recordFiles.jsp">
	        <span class="mm-menu__link-text"><i class="md md-file-download"></i> 消息记录管理</span>
	        </a>
	    </li>
	    <li class="mm-menu__item">
	        <a class="mm-menu__link" href="servlet/LogoutServlet" onclick='return window.confirm("离开后无法再接收消息啦\n是否确定？")'>
	        <span class="mm-menu__link-text"><i class="md md-exit-to-app"></i> 注销</span>
	        </a>
	    </li>
	</ul>
	</nav>
	
	<div class="footer">
        <p class="center-text"  style="">Copyright Chen Dong. All rights reserved.</p>
    </div>
</div>

<script>
	var menu = new Menu;
</script>
<script>
	(function() {
		[].slice.call( document.querySelectorAll( '.maintabs' ) ).forEach( function( el ) {
			new CBPFWTabs( el );
		});
	})();
</script>

<script type="text/javascript">
    new Tippy('.tippy-right', { position: 'right', animation: 'fade' })
</script>

</body>
</html>