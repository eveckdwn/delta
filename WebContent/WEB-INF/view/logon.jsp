<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);

.font {
	font-size: 50px;
	font-family: impact;
	line-height: 2.0;
	letter-spacing: .4em;
}

.font2 {
	font-family: 'Jeju Gothic', sans-serif;
	font-size: 25px;
	line-height: 4.0;
	text-align: center;
	width: 100%;
	border-radius: 5px;
	background-color: rgba(255, 255, 255, 0.3);
}

#wrapper {
   position: relative; 
}
#wrapper:after {
    content : "";
    display: block;
    position: absolute;
    top: 0;
    left: 0;
    background-image: url('test.jpg'); 
    width: 100%;
    height: 100%;
    opacity : 0.4;
    z-index: -1;
}


</style>

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
<body >
	<div style="height: 570px;" id="wrapper" align="center">
		<table style="text-align: center;">
			<tr class="font">
				<td>WELCOME</td>
			</tr>
			<tr class="font">
				<td>TO</td>
			</tr>
			<tr class="font">
				<td>TOGETHER</td>
			</tr>
		</table>
		<table style="width: 100%;">
			<tr class="font2">
				<td><c:out value="${sessionScope.logon }" /> 님 어서오세요.</td>
			</tr>
		</table>
	</div>
</body>
</html>