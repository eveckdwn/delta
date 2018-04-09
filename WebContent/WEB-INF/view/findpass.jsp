<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div align="center" style="min-height: 550px">
	<div class="banner" align="left">
		<h2>비밀번호 찾기</h2>
		<hr />
	</div>
	<div align="center" style="vertical-align: middle; height: 100%">
		<form method="post" action="/findpass/confirm">
			<p>
				<c:if test="${!empty f}">
					<h4 style="color: red">${f }</h4>
				</c:if>
				<c:if test="${empty f}">
					<h4>임시 비밀번호를 받으실 가입시 사용한 아이디와 이메일 주소를 입력하여 주십시오.</h4>
				</c:if>
			</p>
			<p>
				아이디 : <input type="text" name="id" />
			</p>
			<p>
				이메일 : <input type="email" name="email" />
			</p>
			<p>
				<button type="submit">찾 기</button>
			</p>
		</form>
	</div>
</div>
