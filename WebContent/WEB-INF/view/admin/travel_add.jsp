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
			<h2>기차역 추가하기</h2>
			<hr />
			<div style="font-size: 17pt; margin-top: 50px;">기차역 정보를 추가하기 위해
				(*) 표시가 있는 모든 항목을 입력해주세요.</div>
			<div>
				<c:if test="${!empty info }">
					<script>
						alert('${info }');
					</script>
				</c:if>
				<form action="/admin/station_add" method="post"
					style="width: 330px; text-align: left; line-height: 34px;"
					autocomplete="off">
					<p>
						<b>여행지 이름(*)</b><br /> <input type="text" name="name">
					</p>
					<p>
						<b>네이버 지도상 링크(*)</b>
						<button type="button" onclick="howto()">?</button>
						<span id="howto" style="color: red; display: none">네이버
							지도에서 주소을 검색하고 주소부분을 우클릭하여 검사를 누르신 뒤, 영역표시 되어있는 부분을 복사(Ctrl + c)해서
							넣어주세요.</span><br /> <input type="text" name="map" id="map"
							onchange="apply()">
					</p>
					<p>
						<b>여행지 주소(*)</b><br /> <input type="text" name="addr">
					</p>
					<p>
						<b>여행지 연락처(*)</b><br /> <input type="text" name="contact">
					</p>
					<p>
						<button id="sbt" type="submit" style="width: 100%; height: 30px;">추가</button>
					</p>
				</form>
			</div>
		</div>
	</div>
	<script>
		function howto() {
			$("#howto").toggle();
		}

		function apply() {
			var src = $("#map").val();
			console.log("--1)" + src);
			var srccommit = src.substring(src.indexOf('\"') + 1, src.indexOf(
					"\"", 30));
			console.log("--2)" + srccommit);
			$("#map").val(srccommit);
		}
	</script>
</body>
</html>
