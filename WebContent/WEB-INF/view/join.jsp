<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);

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
	content: "";
	display: block;
	position: absolute;
	top: 50px;
	background-image: url('/image/background1.jpg');
	width: 100%;
	height: 100%;
	opacity: 0.4;
	z-index: -1;
}

a {
	text-decoration: none;
}

input {
	padding: 5px;
	width: 100%;
}
</style>
<div class="container-fluid">

	<div id="wrapper" class="font2" style="width: 48%; min-width: 350px; margin: auto; height:650px; float: left;">
		<h2 style="margin-top: 60px; margin-bottom: 50px">TOGETHER</h2>
		<hr />
		<p style="margin-top: 50px; margin-left: 10px">
			함께가자 Together !<br /> Together는 기차배낭여행을 꿈꾸는 여행자들이 모여<br /> 정보를 교환하는
			서비스입니다.
		</p>
	</div>
	<div align="center"
		style="min-width: 350px; width: 51%; height: 700px; border-radius: 25px; border: 5px double #999; margin: 30px auto; font-family: 맑은 고딕; float: right">
		<div>
			<h1>WELCOME TO TOGETHER</h1>
			<small>- ${ment } -</small>
		</div>
		<hr />
		<div style="font-size: 17pt; margin-top: 50px;">
			Create your personal account<br /> <span style="font-size: 11pt;">회원가입시
				모든 요소는 필수기입 항목입니다.</span>
		</div>
		<div>
			<c:if test="${!empty err }">
				<p style="color: red">${err }</p>
			</c:if>
			<form action="/join" method="post"
				style="width: 330px; text-align: left; line-height: 34px;"
				autocomplete="off">
				<p>
					<b>ID(*)</b> <small id="checkrst"></small><br /> <input
						type="text" name="id" id="id" value="${param.id }">
				</p>
				<p>
					<b>PASS(*)</b><br /> <input type="password" name="pass">
				</p>
				<p>
					<b>NICK(*)</b><br /> <input type="text" name="nick"
						value="${param.nick }">
				</p>
				<p>
					<b>EMAIL(*)</b><br /> <input type="email" name="email"
						value="${param.email }" placeholder="abcde@gmail.com">
				</p>
				<p>
					<button id="sbt" type="submit" style="width: 100%; height: 30px;" disabled>가
						입 신 청</button>
				</p>
			</form>
		</div>
	</div>
</div>

<script>
	$("#id").change(function() {
		if ($("#id").val().length > 30) {
			$("#checkrst").css("color", "red");
			$("#checkrst").html('아이디는 30자 이하로 만드실 수 있습니다.');
			$("#id").val("");
			$("#id").focus();
		} else {
			$.post("/join/confirm", {
				id : $("#id").val()
			}, function(rst) {
				console.log(rst);
				if (rst) {
					$("#checkrst").css("color", "green");
					$("#checkrst").html("사용하실 수 있는 아이디입니다.");
				} else {
					$("#checkrst").css("color", "red");
					$("#checkrst").html("이미 사용중인 아이디입니다.");
				}
			});
		}
	});
</script>