<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%
	Long time = System.currentTimeMillis();
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	String str = dayTime.format(new Date(time));
%>

<html>
<head>
<title>${read.title }</title>
</head>
<body>
	<div
		style="border-top: 1px groove; border-bottom: 1px groove; border-left: 1px groove; border-right: 1px groove; padding: 10px;">
		<b>${read.title }</b>
		<hr style="color: #E6E6E6;">
		<p align="right">글쓴이:${read.writer} | 조회수(${read.readnum }) |
			${read.wdate }</p>
		<p>${read.context }</p>
		<p align="right">이 작성자의 게시글 더보기</p>
		<hr style="color: #E6E6E6;" width="190px" align="right">
		<p align="center">
			<button style="width: 100px; height: 100px">
				<img src="/image/like2.jpg" style="width: 100%; height: 100%"
					align="top">${read.like }</button>
		</p>
		<p>
			<b><a style="color: #FE642E;">댓글(${length })</a></b>
		</p>
	</div>
	<p align="right">
		<c:if test="${sessionScope.logon} ">
			<input type="button" value="수정하기"
				onclick="location.href='/board/change?no=3';" />
		</c:if>
	</p>

	<form method="post">
		<table>
			<colgroup>
				<col width="80%"/>
				<col width="20%"/>
			</colgroup>
			<tr>
				<td colspan="2" align="center">
					<div>
						<textarea name="context" rows="4" cols="70" style="width: 100%;"
							placeholder="내용을 입력해주세요."></textarea>
					</div>
				</td>
				<td><input type="hidden" name="writer"
					value="${sessionScope.logon }" /> <input type="hidden" name="like"
					value="0" /> <input type="hidden" name="code" value="${read.id }" />
					<input type="hidden" name="wdate" value="<%=str%>" />
				</td>
				<td><button type="submit" style="widows: 300px; height: 90px">등록</button></td>
			</tr>
		</table>
	</form>
	<div>
	<c:forEach var="i" items="${reply }">
		<a>${i.writer }</a><p align="right">${i.wdate } |${i.like }<p>  <br/>
		<p>${i.context }</p>
	<hr color="black"/>
	</c:forEach>
		<hr style="color: #E6E6E6;">
	</div>

</body>
</html>



