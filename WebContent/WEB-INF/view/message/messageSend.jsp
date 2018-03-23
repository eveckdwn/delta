<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
	<c:if test="${!empty err }">
		<p style="color: red">${err }</p>
		
	</c:if>
	<form action="send" method="post"
		style="width: 330px; text-align: left; line-height: 34px;"
		autocomplete="off">
		<p>
			<b>받는 사람</b> <input type="text" id="t1" name="receiver" value="${reciever }">
		</p>
		<p>
			<textarea id="ta1" name="content" style="width: 500px; height: 300px;"></textarea> <!-- 키보드 입력시?내용 바뀔시? 계속 크기 가져와서 써줘야됨 -->
		</p>
		<p>
			<button id="sbt" type="submit">보내기</button>
		</p>
	</form>
</div>
