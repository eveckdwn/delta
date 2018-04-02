<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<%
	String logon = (String)session.getAttribute("logon");	
%>

<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="/">Together</a>
		</div>
		<div>
			<ul class="nav navbar-nav">
				<li class="active"><a href="/">Home</a></li>
				<li><a href="/travel/station?page=1">여행 정보</a></li>
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">여행모임 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="#">여행 가요</a></li>
						<li><a href="#">여행 후기</a></li>
					</ul></li>
				<li><a href="/chat">실시간 채팅</a></li>
				<li><a href="/board/main?page=1">여행 Q&A</a></li>
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
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">FRIENDS <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="/friend/friends">lists</a></li>
						<li><a href="/friend/follow">follow</a></li>
						<li><a href="/friend/request">requests</a></li>
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
