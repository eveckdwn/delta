<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>SPRING - by git</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<h2>
		비밀번호 찾기
	</h2>
	<hr />
	<form method="post" action="/findpass/confirm">

		<div align="center">
			<p>
			<c:if test="${!empty f}">
				<h4 style="color: red">${f }</h4>
			</c:if>
			<c:if test="${empty f}">
				<h4>임시 비밀번호를 받으실 가입시 사용한 아이디와 이메일 주소를 입력하여 주십시오.</h4>
			</c:if>
			</p>
			<p>
			아이디 : <input type="text" name="id"/>
			</p>
			<p>
			이메일 : <input type="email" name="email"/>
			</p>
			<p>
			<button type="submit">찾 기</button>
			</p>
		</div>
	</form>
</body>
</html>

