<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<html>
<head>
</head>
<body>
	<div align="center">
		<h3>쪽 지 함</h3>
		<hr />
		<table style="width: 80%; height: 20%; margin-bottom: 15px;" border="1">
			<tr>
				<th style="width: 20%;">보낸 사람</th>
				<td>${msg.MNICK }</td>
			</tr>
			<tr>
				<th style="width: 20%;">보낸 시간</th>
				<td>${msg.MDATE }</td>
			</tr>
			<tr>	
				<th style="width: 20%;">내용</th>
				<td style="height: 300px;"> ${msg.CONTEXT }</td>
			</tr>
		</table>
		<a href="/message/box"><button type="button">목록</button></a>
		<button type="button" formaction="" value="${msg.MNICK }">답장</button>
	</div>
</body>
</html>