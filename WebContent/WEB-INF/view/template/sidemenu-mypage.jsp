<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<%
	String logon = (String)session.getAttribute("logon");	
%>
<h4>Welcome to Together</h4>
<hr />
<ul class="nav nav-pills nav-stacked">

	<li><a>MY PAGE</a>
		<ul>
			<li><a href="/mypage">PROFILE</a></li>
			<li><a onclick="popup();">MESSAGE <span id="cnt"></span></a></li>
		</ul></li>
	<li class="dropdown"><a class="dropdown-toggle"
		data-toggle="dropdown" href="#">Friends <span class="caret"></span></a>
		<ul class="dropdown-menu">
			<li><a href="/friend/friends">lists</a></li>
			<li><a href="/friend/follow">follow</a></li>
			<li><a href="/friend/request">requests</a></li>
		</ul></li>
	<li><a href="/login/out">Log Out</a></li>
</ul>
<br>
<div class="input-group">
	<input type="text" class="form-control" placeholder="Search Blog..">
	<span class="input-group-btn">
		<button class="btn btn-default" type="button">
			<span class="glyphicon glyphicon-search"></span>
		</button>
	</span>
</div>
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
