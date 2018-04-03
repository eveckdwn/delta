<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
a {
	text-decoration: none;
}

button {
	display: inline-block;
	outline: none;
	cursor: pointer;
	text-align: center;
	text-decoration: none;
	font: 14px/100% 맑은 고딕, Helvetica, sans-serif;
	padding: .5em 2em .55em;
	text-shadow: 0 1px 1px rgba(0, 0, 0, .3);
	-webkit-border-radius: .5em;
	-moz-border-radius: .5em;
	border-radius: .5em;
	-webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, .2);
	-moz-box-shadow: 0 1px 2px rgba(0, 0, 0, .2);
	box-shadow: 0 1px 2px rgba(0, 0, 0, .2);
	color: #585858;
	border: solid 1px #585858;
	background: #ffffff;
	background: -webkit-gradient(linear, left top, left bottom, from(#ffffff),
		to(#ffffff));
	background: -moz-linear-gradient(top, #faa51a, #f47a20);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#585858',
		endColorstr='#ffffff');
}

button:active {
	position: relative;
	top: 1px;
	color: #ffffff;
	background: -webkit-gradient(linear, left top, left bottom, from(#ffffff), to(#151515));
	background: -moz-linear-gradient(top,  #ffffff,  #151515);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#151515');
}

.arial{
	font-family: Arial Black;
}

input {
	padding: 3px;
	width: 100%;
}
</style>
	<div align="center">
		<div
			style="width: 800px; height: 550px; border-radius: 25px; border: 5px double #999; margin: 30px auto; font-family: 맑은 고딕;">
			<div style="font-family: fantasy;">
				<h1>TOGETHER</h1>
				<small>- ${ment } -</small>
			</div>
			<hr />
			<div style="font-size: 17pt; margin-top: 50px;">
				Log in your personal account<br /> <span style="font-size: 11pt;">로그인시
					모든 요소는 필수기입 항목입니다.</span>
			</div>
			<div>
				<c:if test="${!empty t }">
					<span style="color: blue">${t }</span>
				</c:if>
			</div>
			<div>
				<c:if test="${!empty err }">
					<span style="color: red">${err }</span>
				</c:if>
				<form action="/login" method="post"
					style="width: 330px; text-align: left; line-height: 34px;"
					autocomplete="off">
					<p>
						<b class="arial">ID(*)</b> <small id="checkrst"></small><br /> <input
							type="text" name="id" id="id" />
					</p>
					<p>
						<b class="arial">PASS(*)</b><br /> <input type="password" name="pass">
					</p>
					<p>
						<button id="sbt" type="submit" style="width: 100%; height: 30px;" >로
							그 인</button>
						<c:if test="${!empty err }">
							<a href="/findpass"><button type="button"
									style="width: 100%; height: 30px;">비밀번호 찾기</button></a>
						</c:if>
					</p>
				</form>

			</div>
		</div>
	</div>
	<script>
		var ws2 = new WebSocket("ws://${pageContext.request.serverName}/alert");
		ws2.onmessage = function(rst) {
			console.log(rst);
		}
	</script>
