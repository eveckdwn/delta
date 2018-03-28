<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>내용</title>
</head>
<body>
		<div
			style="border-top: 1px groove; border-bottom: 1px groove; border-left: 1px groove; border-right: 1px groove; padding: 10px;">
			<c:forEach var="i" items="${read }">
			<b>${i.title }</b>
			<hr style="color: #E6E6E6;">
			${i.context }
			<p align="right">이 작성자의 게시글 더보기</p>
			<hr style="color: #E6E6E6;" width="190px" align="right">
			<p>
				<b><a style="color: #FE642E;">댓글()</a></b> | <a>등록순</a> | <a>조회수(${i.readnum })</a>
				| <a>추천(${i.like })</a>
			</p>
			</c:forEach>
			<div style="background-color: #E6E6E6;">
				으아
				<hr style="color: #E6E6E6;">
			</div>
		</div>
		<p align="right">
			<c:if test="${sessionScope.logon == ${ }">
			<input type="button" value="수정하기" onclick="location.href='/board/change?no=3';"/>
			</c:if>
		</p>
		
		<div>
		<textarea rows="10" cols="100" style="width: 100%;"></textarea>
		
		
		
		
		</div>
		

</body>
</html>



