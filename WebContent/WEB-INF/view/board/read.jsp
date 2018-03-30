<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<c:forEach var="i" items="${read }">
	<title>${i.title }</title>
</c:forEach>
</head>
<body>
	<div
		style="border-top: 1px groove; border-bottom: 1px groove; border-left: 1px groove; border-right: 1px groove; padding: 10px;">
		<c:forEach var="i" items="${read }">
			<b>${i.title }</b>
			<hr style="color: #E6E6E6;">
			<p align="right">조회수(${i.readnum }) | ${i.wdate }</p>
			<c:if test="${!empty i.photos }">
				<c:forEach var="photo" items="${i.photos }">
					<img
						src="<%=request.getContextPath() %>/board/${i.writer }/${photo }"
						style="width: 200px; height: 200px;" />
				</c:forEach>
			</c:if>
			<p>${i.context }</p>
			<p align="right">이 작성자의 게시글 더보기</p>
			<hr style="color: #E6E6E6;" width="190px" align="right">
			<p align="center">
				<button style="width: 100px; height: 100px">
					<img src="/image/like2.jpg" style="width: 100%; height: 100%"
						align="top">${i.like }</button>
			</p>
			<p>
				<b><a style="color: #FE642E;">댓글()</a></b>
			</p>
		</c:forEach>
		<div style="background-color: #E6E6E6;">
			으아
			<hr style="color: #E6E6E6;">
		</div>
	</div>
	<p align="right">
		<c:if test="${sessionScope.logon }">
			<input type="button" value="수정하기"
				onclick="location.href='/board/change?no=3';" />
		</c:if>
	</p>

	<div>
		<textarea rows="10" cols="100" style="width: 100%;"></textarea>




	</div>


</body>
</html>



