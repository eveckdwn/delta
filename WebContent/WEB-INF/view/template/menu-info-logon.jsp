<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<%
	String logon = (String)session.getAttribute("logon");	
%>
<style>
/* navbar */
.navbar-default {
   background-color:#5f5f5f;
    color:#f1f1f1;
    border-color: #E7E7E7;
    border: none;
    -webkit-box-shadow: none;
    box-shadow: none;
}
.dropdown-menu {
    border: none;
    -webkit-box-shadow: none;
    box-shadow: none;
}
/* Title */
.navbar-default .navbar-brand {
    color:#f1f1f1;
}
.navbar-default .navbar-brand:hover,
.navbar-default .navbar-brand:focus {
   color:#f1f1f1;
    background-color: #000;
}
/* Link */
.navbar-default .navbar-nav > li > a {
    color: #f1f1f1;
}
.navbar-default .navbar-nav > li > a:hover,
.navbar-default .navbar-nav > li > a:focus {
    color: #f1f1f1;
    background-color: #000;
}
.navbar-default .navbar-nav > .active > a,
.navbar-default .navbar-nav > .active > a:hover,
.navbar-default .navbar-nav > .active > a:focus {
    color: #f1f1f1;
    background-color: #4CAF50;
}
.navbar-default .navbar-nav > .open > a,
.navbar-default .navbar-nav > .open > a:hover,
.navbar-default .navbar-nav > .open > a:focus {
    color: #f1f1f1;
    background-color: #000;
}
/* Caret */
.navbar-default .navbar-nav > .dropdown > a .caret {
    border-top-color: #777;
    border-bottom-color: #777;
}
.navbar-default .navbar-nav > .dropdown > a:hover .caret,
.navbar-default .navbar-nav > .dropdown > a:focus .caret {
    border-top-color: #333;
    border-bottom-color: #333;
}
.navbar-default .navbar-nav > .open > a .caret,
.navbar-default .navbar-nav > .open > a:hover .caret,
.navbar-default .navbar-nav > .open > a:focus .caret {
    border-top-color: #555;
    border-bottom-color: #555;
}
/* Mobile version */
.navbar-default .navbar-toggle {
    border-color: #DDD;
}
.navbar-default .navbar-toggle:hover,
.navbar-default .navbar-toggle:focus {
    background-color: #DDD;
}
.navbar-default .navbar-toggle .icon-bar {
    background-color: #CCC;
}
@media (max-width: 767px) {
    .navbar-default .navbar-nav .open .dropdown-menu > li > a {
        color: #777;
    }
    .navbar-default .navbar-nav .open .dropdown-menu > li > a:hover,
    .navbar-default .navbar-nav .open .dropdown-menu > li > a:focus {
          color: #333;
    }
}
</style>
<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="/">Together</a>
		</div>
		<div>
			<ul class="nav navbar-nav">
				<li><a href="/">Home</a></li>
				<li class="active"><a href="/travel/station?page=1">여행 정보</a></li>
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">여행모임 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="/board/main?page=1&menu=1">여행 가요</a></li>
						<li><a href="/board/main?page=1&menu=2">여행 후기</a></li>
						<li><a href="/board/main?page=1&menu=3">여행 Q&A</a></li>
					</ul></li>
				<li><a href="/chat">실시간 채팅</a></li>
			</ul>
		</div>
		<div style="float: right;">
			<ul class="nav navbar-nav">
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">${sessionScope.logonNick }(${sessionScope.logon })<span
						class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="/mypage">PROFILE</a></li>
						<li><a onclick="popup();">MESSAGE <span id="cnt"></span></a></li>
					</ul></li>
				<li><a href="/login/out">Log Out</a></li>
			</ul>
		</div>
	</div>
</nav>
<script>
	function popup() {
		window
				.open(
						'/message/box?page=1',
						'쪽지 보내기',
						'width=700, height=550, toolbar=no, menubar=no, scrollbars=yes, resizable=no, copyhistory=no');
	}
	cnt();
	
	function cnt() {
		var log = "<%=logon%>";
		$.post("/message/cnt",{
			id : log
		},function(data){
			$("#cnt").html("<b>("+data.cnt+")</b>");
		})
	}
	setInterval(cnt,5000);
</script>
