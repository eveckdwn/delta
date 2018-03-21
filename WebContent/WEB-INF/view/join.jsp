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
			<div>
				<h1>Spring Project</h1>
				<small>- ${ment } -</small>
			</div>
			<hr />
			<div style="font-size: 17pt; margin-top: 50px;">
				Create your personal account<br /> <span style="font-size: 11pt;">회원가입시
					모든 요소는 필수기입 항목입니다.</span>
			</div>
			<div>
				<c:if test="${!empty err }">
					<p style="color:red">${err }</p>
				</c:if>
				<form action="/join" method="post"
					style="width: 330px; text-align: left; line-height: 34px;" autocomplete="off">
					<p>
						<b>ID(*)</b> <small id="checkrst"></small><br /> <input
							type="text" name="id" id="id" value="${param.id }">
					</p>
					<p>
						<b>PASS(*)</b><br /> <input type="password" name="pass">
					</p>
					<p>
						<b>NICK(*)</b><br /> <input type="text" name="nick"  value="${param.nick }">
					</p>
					<p>
						<b>EMAIL(*)</b><br /> <input type="email" name="email"  value="${param.email }">
					</p>
					<p>
						<button id="sbt" type="submit" style="width: 100%; height: 30px;">가
							입 신 청</button>
					</p>
				</form>
			</div>
		</div>
	</div>
	<script>
		$("#id").blur(function(){
			if($("#id").val().length > 30){
				$("#checkrst").css("color", "red");
				$("#checkrst").html('아이디는 30자 이하로 만드실 수 있습니다.');
				$("#id").val("");
				$("#id").focus();
			}else{
				$.post("/join/confirm", {id: $("#id").val()},
					function(rst){
						console.log(rst);
						if(rst){
							$("#checkrst").css("color", "green");
							$("#checkrst").html("사용하실 수 있는 아이디입니다.");
						}else{
							$("#checkrst").css("color", "red");
							$("#checkrst").html("이미 사용중인 아이디입니다.");
						}
					});
			}
		});
		
		var ws2 = new WebSocket("ws://${pageContext.request.serverName}/alert");
		ws2.onmessage = function(rst) {
			console.log(rst);
		}
	</script>
</body>
</html>
