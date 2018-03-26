<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h4>Welcome to Spring</h4>
<hr />
<ul class="nav nav-pills nav-stacked">

	<li><a>MY PAGE</a>
		<ul>
			<li><a href="/mypage">PROFILE</a></li>
			<li><a href="/">MESSAGE</a></li>
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
