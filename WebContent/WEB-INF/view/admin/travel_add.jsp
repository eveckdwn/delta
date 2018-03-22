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

select {
	padding: 10px;
	margin-top: 10px;
	margin-left: 10px
}
</style>
<body>
	<div align="center">
		<div style="width: 980px;">
			<h2>여행지 추가하기</h2>
			<hr />
			<div style="font-size: 17pt; margin-top: 50px;">여행지 정보를 추가하기 위해
				(*) 표시가 있는 모든 항목을 입력해주세요.</div>
			<div>
				<c:if test="${!empty info }">
					<script>
						alert('${info }');
					</script>
				</c:if>
				<form action="/admin/travel_add" method="post"
					style="width: 400px; text-align: left; line-height: 34px;"
					autocomplete="off">
					<p>
						<b>여행지 이름(*)</b><br /> <input type="text" name="tname"
							autofocus="autofocus" />
					</p>
					<p>
						<b>주변 기차역(*)</b> <select name="sname">
							<c:forEach items="${station }" var="s" varStatus="sts">
								<c:choose>
									<c:when test="${sts.first }">
										<option value="${s.NAME }" selected>${s.NAME }</option>
									</c:when>
									<c:otherwise>
										<option value="${s.NAME }">${s.NAME }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>

						</select>
					</p>
					<p>
						<b>관리자</b><br /> <input type="text" name="manager" />
					</p>
					<p>
						<b>여행지 주소(*)</b><br /> <input type="text" name="taddr" />
					</p>
					<p>
						<b>여행지 연락처(*)</b>
						<button type="button" onclick="howto()">?</button>
						<br /> <input type="text" name="contact" id="contact" /><br /> <span
							id="howto" style="color: red; display: none">번호만 입력가능하며,
							번호 사이에 하이픈(-)을 꼭 넣어주세요.</span>
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

		$("#contact").keyup(function(e) {
			//	console.log(e.originalEvent.key);
			var reg = /[^0-9\-]/g;
			if (reg.test($("#contact").val())) {
				$("#howto").css("display", "");
				$("#contact").val().replace($("#contact").val(), "");
			} else {
				var regEx = /\-+/g;
				if (regEx.test($("#contact").val())) {
					$("#howto").css("display", "none");
				} else {
					$("#howto").css("display", "");
				}
			}
		});
	</script>
</body>
</html>

