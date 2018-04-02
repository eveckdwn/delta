<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
a {
	text-decoration: none;
}

input {
	padding: 5px;
	width: 100%;
}
</style>
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
				style="width: 400px; text-align: left; line-height: 34px;"
				autocomplete="off">
				<p>
					<b>기차역 이름(*)</b><br /> <input type="text" name="name"
						autofocus="autofocus" />
				</p>
				<p>
					<b>위도(*)</b><br />
					<input type="text" name="lat" />
				</p>
				<p>
					<b>경도(*)</b><br />
					<input type="text" name="lng" />
				</p>
				<p>
					<b>기차역 주소(*)</b><br /> <input type="text" name="addr" />
				</p>
				<p>
					<b>기차역 연락처(*)</b><br /> <input type="text" name="contact"
						id="contact" onkeyup="addhyphen()" maxlength="9" />
				</p>
				<p>
					<button id="sbt" type="submit" style="width: 100%; height: 30px;">추가</button>
				</p>
			</form>
		</div>
	</div>
</div>
<script>
	function addhyphen() {
		var x = $("#contact").val();
		x = x.replace(/[^0-9]/g, '');
		var tmp = "";
		if (x.length > 4 && x.length <= 8) {
			tmp += x.substr(0, 4);
			tmp += "-";
			tmp += x.substr(4);
			$("#contact").val(tmp);
		}
	}
</script>
