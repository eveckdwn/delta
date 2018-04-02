<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<h2>
		<c:out value="${user.NICK }" />
		's PAGE
	</h2>
	<hr />
	<form method="post" action="/email/check">

		<div align="center">
			<p>
				<c:if test="${!empty su }">
					<a style="color: blue"><b>${su }</b></a>
				</c:if>
			</p>
			<p>
				<c:if test="${!empty f }">
					<a style="color: red"><b>${f }</b></a>
				</c:if>
			</p>
			<p>
			이메일 인증키 : <input type="text" name="key"/>
			</p>
			<p>
			<button type="submit">인 증</button>
			</p>
		</div>
	</form>
