<%@page import="com.scienjus.smartqq.model.GroupUser"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.scienjus.smartqq.model.GroupInfo"%>
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
    Long gcode = Long.parseLong(request.getParameter("gcode"));
    GroupInfo ginfo = QQMR.getGroupInfo(gcode);
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>群资料</title>
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
<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/jqueryui.js" type="text/javascript"></script>
<!--script src="js/framework.plugins.js" type="text/javascript"></script><-->
<script src="js/custom.js" type="text/javascript"></script>
<!--leftside bar-->
<script src="js/production/materialMenu.min.js"></script>
<!--tab style-->
<script src="js/modernizr.custom.js"></script>
<script src="js/cbpFWTabs.js"></script>

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
    <!--content-->
	<div id="wrapper" class="wrapper">
	    <a href="mainTabs.jsp"><img src="<%=basePath%>ky_img/home.png" style="margin-left:50px;"></a>
		<div class="header-clear" style="margin-top:10px;"></div>
        <div class="wrapper-table">
            <div class="display-infotable">
                <table>
			        <tr>
                    <th colspan="2" scope="col" align="left"><i class="md md-pageview"></i> 群号：<%=Long.toString(ginfo.getGid())%></th>
                    <th colspan="2" scope="col" align="left"><i class="md md-loyalty"></i> 群名称：<%=ginfo.getName() %></th>           
                    </tr>
                    <%
                        SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
        				Date dt = new Date(ginfo.getCreatetime() * 1000);  
        				String createTime = sdf.format(dt);  //得到精确到秒的表示
                    %>
					<tr>
                    <th colspan="4" scope="col" align="left"><i class="md md-access-time"></i> 本群创建于<%=createTime%></th> 
                    </tr>
					<tr>
                    <th colspan="4" scope="col" align="left"><i class="md md-assignment"></i> 群公告：<%=ginfo.getMemo() %></th>         
                    </tr>
					<tr>
                    <th colspan="2" scope="col" align="left"><i class="md md-people-outline"></i> 群成员:</th>
                    </tr>
                    <%
                        List<GroupUser> gUserList = ginfo.getUsers();
                        int gunum = gUserList.size();
                        System.out.println("gunum="+gunum);
                        GroupUser[] gUser = new GroupUser[gunum];
                        gUserList.toArray(gUser);
                        for(int i = 0 ; i<(gunum%4==0?gunum/4:gunum/4+1) ; i++){ 
                    %>
                    <tr>
                    <%
                            for(int j = i*4 ; j<gunum && j<(i+1)*4 ; j++){
                    %>
                    <th><%=gUser[j].getNick()%></th>
                    <%
                            }
                    %>
                    </tr>
                    <%
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

</body>
</html>