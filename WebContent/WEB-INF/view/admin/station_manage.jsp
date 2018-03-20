<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>Spring - managed by GIT</title>
</head>
<style>
a {
	text-decoration: none;
}

input {
	padding: 5px;
	width: 100%;
}
</style>
<body>
	<div align="center">
		<div style="width: 980px;">
			<h2>기차역 관리하기</h2>
			<hr />
			<c:if test="${!empty info }">
				<script>
					alert('${err }');
				</script>
			</c:if>
			<table border="1">
				<colgroup>
					<col width="20%"/>
					<col width=""/>
					<col width="20%"/>
				</colgroup>
				<tr>
					<th>역 이름</th>
					<th>주소</th>
					<th>연락처</th>
				</tr>
				<c:forEach items="${station }" var="s">
				<tr>
					<td>${s.NAME }</td>
					<td>${s.ADDR }</td>
					<td>${s.CONTACT }</td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</body>
</html>
