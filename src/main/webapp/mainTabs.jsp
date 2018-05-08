<%@page import="com.scienjus.smartqq.model.GroupUser"%>
<%@page import="com.scienjus.smartqq.model.Group"%>
<%@page import="com.scienjus.smartqq.model.UserInfo"%>
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
    if(QQMR.getVfwebqq() == null){
        QQMR.verifyAndStart();
    }
    UserInfo myInfo = QQMR.getAccountInfo();
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>欢迎使用QQ群信息分类助手！</title>
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
<!--notify style-->
<link rel="stylesheet"               href="css/htmleaf-demo.css" type="text/css">
<link rel="stylesheet"               href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet"               href="dist/notyf.min.css" type="text/css">

<script src="js/jquery.js" type="text/javascript"></script>
<script src="js/jqueryui.js" type="text/javascript"></script>
<script src="js/custom.js" type="text/javascript"></script>
<!--leftside bar-->
<script src="js/production/materialMenu.min.js"></script>
<!--tab style-->
<script src="js/modernizr.custom.js"></script>
<script src="js/cbpFWTabs.js"></script>
<!--notify style-->
<script src="dist/notyf.min.js" type="text/javascript"></script>
<!--keyword switch-->
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<!-- DWRclassify -->
<script type="text/javascript" src="dwr/engine.js"></script>  
<script type="text/javascript" src="dwr/util.js"></script>  
<script type="text/javascript" src="dwr/interface/DWRClassify.js"></script>

</head>

<body> 
    <div id="preloader">
        <div id="status">
   	        <p class="center-text">
		           内容加载中...
            </p>
        </div>
    </div>

    <div class="theme-popover-mask"></div>

	<div class="theme-popover" style="left:55%">
		<div class="theme-poptit" style="height:40px;">
			<a href="javascript:;" title="关闭" class="close">×</a>
			<h4 style="font-weight:100;">设置关键词</h4>
		</div>
	    
		<div class="container switch-box">
		    <br/>
			<h4 style="font-size:16px">关键词监听</h4>
			<a href="javascript:void(0);" id="setKeyword" class="switch switch-1">
				<span></span>
			</a>
			<em class="switch-box-subtitle"></em>
			<div class="switch-box-content">
				<br/>
			    <h4 style="font-size:16px">关键词为：</h4><input id="keyword" style="outline-style:solid;outline-width:1px;outline-color:#3498db;padding-left:10px;padding-right:10px;font-size:15px;vertical-align:middle;height:30px;line-height:30px;" type="text" name="fname"/>
				<br/><br/>
                <input class="slider-button-1 button-blue" onclick="getKeyword()" value="确定" />
			</div>			
		</div>	
	</div>

	<div class="login-page bg5">
	     <!--content-->
	    <div id="wrapper" class="wrapper">
	    <div class="header-clear"></div>
		<div class="container">
	         <section>
				  <div class="maintabs tabs-style-tzoid">
					  <nav>
						  <ul>
						      <li><a href="#section-tzoid-1" style="font-size:16px" id="classall" onclick="titleall()"><span style="font-size:16px">所有消息</span></a></li>
							  <li><a href="#section-tzoid-2" style="font-size:16px" id="class2" onclick="titlec2()"><span style="font-size:16px">工作学习</span></a></li>
							  <li><a href="#section-tzoid-4" style="font-size:16px" id="class4" onclick="titlec4()"><span style="font-size:16px">学校活动</span></a></li>
							  <li><a href="#section-tzoid-5" style="font-size:16px" id="class5" onclick="titlec5()"><span style="font-size:16px">闲聊</span></a></li>
							  <li><a href="#section-tzoid-6" style="font-size:16px" id="class6" onclick="titlec6()"><span style="font-size:16px">广告</span></a></li>
						  </ul>
					  </nav>
					  <div class="content-wrap">
						  <section id="section-tzoid-1"><textarea style="font-size:16px" id="classtext1" readonly="readonly"></textarea></section>
						  <section id="section-tzoid-2"><textarea style="font-size:16px" id="classtext2" readonly="readonly"></textarea></section>
						  <section id="section-tzoid-4"><textarea style="font-size:16px" id="classtext4" readonly="readonly"></textarea></section>
						  <section id="section-tzoid-5"><textarea style="font-size:16px" id="classtext5" readonly="readonly"></textarea></section>
						  <section id="section-tzoid-6"><textarea style="font-size:16px" id="classtext6" readonly="readonly"></textarea></section>
				  	  </div>
				  </div>
	          </section>
		  </div>	
	  </div>
	
	  <p id="userid" style="color:black;font-size:1px;height:0px;line-height: 0px; margin-bottom: 0px;"><%=myInfo.getUin()%></p>
	  
	  <!--leftside bar-->
	  <button id="mm-menu-toggle" class="mm-menu-toggle">Toggle Menu</button>
	      <nav id="mm-menu" class="mm-menu">
	      <div class="mm-menu__header">
	          <h2 class="mm-menu__title">你好！<%=myInfo.getNick()%></h2>
	      </div>
	      <ul class="mm-menu__items">
	      <li class="mm-menu__item">
	          <a class="mm-menu__link" href="javascript:;">
	          <span class="mm-menu__link-text theme-login"><i class="md md-edit"></i> 设置关键词</span>
	          </a>
		  </li>
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
	
	    <div class="footer" id="clickA" onclick="listenMsg()">
	        <p class="center-text">Copyright Chen Dong. All rights reserved.</p>
	    </div>
    </div>
<%
    session.setAttribute("QQMsgRsver",QQMR);
%>
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
//开启监听消息函数
//IE
if(document.all) {
	document.getElementById("clickA").click();
}
// 其它浏览器
else {
	var e = document.createEvent("MouseEvents");
	e.initEvent("click", true, true);
	document.getElementById("clickA").dispatchEvent(e);
} 
var xmlHttpReqListen; 
//创建一个XmlHttpRequest对象  
function createXmlHttpRequestA()  
{  
    if(window.XMLHttpRequest)  
    {  
       xmlHttpReqListen = new XMLHttpRequest();//非IE浏览器  
    }else  
    {  
       xmlHttpReqListen = new ActiveXObject("Microsoft.XMLHTTP");//IE浏览器  
    }  
}
function listenMsg(){  
    //首先创建精灵对象  
    createXmlHttpRequestA();  
    //指明准备状态改变时回调的函数名  
    xmlHttpReqListen.onreadystatechange=handleA;
    //尝试以异步的get方式访问某个URL
    //请求服务器端的一个servlet
    var url = "servlet/GetMsgServlet?timestamp=" + new Date().getTime(); 
    xmlHttpReqListen.open("get",url,true);  
    //向服务器发送请求  
    xmlHttpReqListen.send(null);  
} 
function handleA(){  
    //准备状态为4  
    if(xmlHttpReqListen.readyState==4)  
    {  
        //响应状态码为200，代表一切正常  
        if(xmlHttpReqListen.status==200)  
        {  
            var res = xmlHttpReqListen.responseText;
        }  
    }
}

 setInterval("displayC1()",3000); 

var xmlHttpReqC1;  
//创建一个XmlHttpRequest对象  
function createXmlHttpRequestC1()  
{  
    if(window.XMLHttpRequest)  
    {  
       xmlHttpReqC1 = new XMLHttpRequest();//非IE浏览器  
    }else  
    {  
       xmlHttpReqC1 = new ActiveXObject("Microsoft.XMLHTTP");//IE浏览器  
    }  
}
function displayC1(){  
    //首先创建精灵对象  
    createXmlHttpRequestC1();  
    //指明准备状态改变时回调的函数名  
    xmlHttpReqC1.onreadystatechange=handleC1;
    //尝试以异步的get方式访问某个URL
    //请求服务器端的一个servlet
    var url = "servlet/MsgDisplay?timestamp=" + new Date().getTime(); 
    xmlHttpReqC1.open("get",url,true);  
    //向服务器发送请求  
    xmlHttpReqC1.send(null);  
}
function handleC1(){  
    //准备状态为4  
    if(xmlHttpReqC1.readyState==4)  
    {  
        //响应状态码为200，代表一切正常  
        if(xmlHttpReqC1.status==200)  
        {  
            var res = xmlHttpReqC1.responseText;
            if(res.length>2){
                res = unescape(res.replace(/\\u/g, "%u"));
                document.getElementById("classall").innerHTML = "所有消息[new!]";
                document.getElementById("classtext1").innerHTML = document.getElementById("classtext1").innerHTML + res;
            }
        }  
    };
} 
</script>

<script type="text/javascript">
/*关键字监听开关*/
$(document).ready(function($){
	$('.theme-login').click(function(){
		$('.theme-popover-mask').show();
		$('.theme-popover-mask').height($(document).height());
		$('.theme-popover').slideDown(200);
	})
	$('.theme-poptit .close').click(function(){
		$('.theme-popover-mask').hide();
		$('.theme-popover').slideUp(200);
	})
});

$('.switch-1').click(function(){
    $(this).toggleClass('switch-1-on'); 
    return false;
});
$('.switch, .switch-icon').click(function(){
    $(this).parent().find('.switch-box-content').slideToggle(200); 
    $(this).parent().find('.switch-box-subtitle').slideToggle(200); 
    return false;
});

/*关闭关键词监听*/
var listenKey = 0;

document.getElementById("setKeyword").addEventListener('click',function(){
	if(document.getElementById("setKeyword").getAttribute("class") == "switch switch-1"){
	    listenKey = 0;
	}else if(document.getElementById("setKeyword").getAttribute("class") == "switch switch-1 switch-1-on"){
	    listenKey = 1;
	}	
});

/*获取关键字*/
var keyword;
function getKeyword(){
    keyword = document.getElementById("keyword").value;
    alert("关键字设置成功！关键字为："+keyword);
}

/*获取用户QQ号*/
var userid;
setTimeout(function(){
	userid = document.getElementById("userid").innerHTML;
}, 500);

var notyf = new Notyf({delay:5000});
function switchClass(data){
    switch(data){
        case "2":{
            document.getElementById("class2").innerHTML = "工作学习[new!]";
            DWRClassify.display(  
                function(data){
                    if(data != null){
                        document.getElementById("classtext2").innerHTML = document.getElementById("classtext2").innerHTML + data;
                        DWRClassify.classRecord(data,"2",userid);
                        if(listenKey == 1){
                            if(data.indexOf(keyword) > -1){
                                notyf.confirm(data);
                                DWRClassify.keyRecord(data,keyword,userid);
                            }
                        }
                    }  
                }  
            );
            break;
        }
        case "3":{
            document.getElementById("class2").innerHTML = "工作学习[new!]";
            DWRClassify.display(  
                function(data){
                    if(data != null){
                        document.getElementById("classtext2").innerHTML = document.getElementById("classtext2").innerHTML + data;
                        DWRClassify.classRecord(data,"2",userid);
                        if(listenKey == 1){
                            if(data.indexOf(keyword) > -1){
                                notyf.confirm(data);
                                DWRClassify.keyRecord(data,keyword,userid);
                                
                            }
                        }
                    }  
                }  
            );
            break;
        }
        case "4":{
            document.getElementById("class4").innerHTML = "学校活动[new!]";
            DWRClassify.display(  
                function(data){
                    if(data != null){
                        document.getElementById("classtext4").innerHTML = document.getElementById("classtext4").innerHTML + data;
                        DWRClassify.classRecord(data,"4",userid);
                        if(listenKey == 1){
                            if(data.indexOf(keyword) > -1){
                                notyf.confirm(data);
                                DWRClassify.keyRecord(data,keyword,userid);
                                
                            }
                        }
                    }
                }  
            );
            break;
        }
        case "5":{
            document.getElementById("class5").innerHTML = "闲聊[new!]";
            DWRClassify.display(  
                function(data){
                    if(data != null){
                        document.getElementById("classtext5").innerHTML = document.getElementById("classtext5").innerHTML + data;
                        DWRClassify.classRecord(data,"5",userid);
                        if(listenKey == 1){
                            if(data.indexOf(keyword) > -1){
                                notyf.confirm(data);
                                DWRClassify.keyRecord(data,keyword,userid);
                                
                            }
                        }
                    }  
                }  
            );
            break;
        }
        case "6":{
            document.getElementById("class6").innerHTML = "广告[new!]";
            DWRClassify.display(  
                function(data){
                    if(data != null){
                        document.getElementById("classtext6").innerHTML = document.getElementById("classtext6").innerHTML + data;
                        DWRClassify.classRecord(data,"6",userid);
                        if(listenKey == 1){
                            if(data.indexOf(keyword) > -1){
                                notyf.confirm(data);
                                DWRClassify.keyRecord(data,keyword,userid);
                                
                            }
                        }
                    }  
                }  
            );
            break;
        }
        default:{
            document.getElementById("class5").innerHTML = "闲聊[new!]";
            DWRClassify.display(  
                function(data){
                    if(data != null){
                        document.getElementById("classtext5").innerHTML = document.getElementById("classtext5").innerHTML + data;
                        DWRClassify.classRecord(data,"5",userid);
                        if(listenKey == 1){
                            if(data.indexOf(keyword) > -1){
                                notyf.confirm(data);
                                DWRClassify.keyRecord(data,keyword,userid);
                                
                            }
                        }
                    }  
                }  
            );
        }
    }    
}

function strClassify(){
    DWRClassify.classifyFirstLine(  
        function(data){
            if(data != "EMPTYSTRING"){
                switchClass(data);
            }
        }  
    ); 
}

setInterval("strClassify()",2000);

function titleall(){
    document.getElementById("classall").innerHTML = "所有消息";
}

function titlec2(){
    document.getElementById("class2").innerHTML = "工作学习";
}

function titlec4(){
    document.getElementById("class4").innerHTML = "学校活动";
} 

function titlec5(){
    document.getElementById("class5").innerHTML = "闲聊";
}

function titlec6(){
    document.getElementById("class6").innerHTML = "广告";
}

</script> 

</body>
</html>
