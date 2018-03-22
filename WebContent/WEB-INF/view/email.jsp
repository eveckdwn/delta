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
		<c:out value="${user.NICK }" />
		's PAGE
	</h2>
	<hr />
	<form method="post" action="/email/check">

		<div align="center">
			<p>
				<c:if test="${!empty su }">
					<a style="color: blue"><b>${su }</b></a>
				</c:if>
			</p>
			<p>
				<c:if test="${!empty f }">
					<a style="color: red"><b>${f }</b></a>
				</c:if>
			</p>
			<p>
			이메일 인증키 : <input type="text" name="key"/>
			</p>
			<p>
			<button type="submit">인 증</button>
			</p>
		</div>
	</form>
</body>
</html>

