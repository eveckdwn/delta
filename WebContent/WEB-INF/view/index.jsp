<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Spring - managed by GIT</title>
</head>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<body>
	<div align="center" class="container">
		<div class="jumbotron">
			<a href="/"><h1>Spring</h1></a><br /> <small>- ${ment } -</small>
		</div>
		<hr />
		<div class="alert alert-warning alert-dismissible" id="warn"
			style="display: none">
			<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
			<strong>경고!</strong> 다른 윈도우 혹은 탭에서 상태가 변경되었습니다. 새로고침을 원하시면<span
				style="cursor: pointer; color: blue; text-decoration: underline"
				onclick="location.reload()">여기</span>를 눌러주세요.
		</div>
		<div align="right" style="padding-right: 20px;">
			<a href="/login"><span>Sign in</span></a> <span>or</span> <a
				href="/join"><span>Sign up</span></a>
		</div>
		<hr />
		<div>
			<div class="alert alert-info">
				<strong>현재접속자수:</strong><span id="cnt"></span> / <strong>서버알림</strong><span
					id="info"></span>
			</div>
		</div>
	</div>
</body>
</html>