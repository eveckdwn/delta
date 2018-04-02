<%@page import="java.awt.Window"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${menu eq  1}">
		<h2>여행 가요</h2>
	</c:when>
	<c:when test="${menu eq  2}">
		<h2>여행 후기</h2>
	</c:when>
	<c:otherwise>
		<h2>Q & A</h2>
	</c:otherwise>
</c:choose>
<p>
<hr style="border: solid 2px; color: #D8D8D8" />
<p />
<div align="center">
	<table class="table table-striped table-bordered table-hover">
		<colgroup>
			<col width="5%" />
			<col width="" />
			<col width="10%" />
			<col width="15%" />
			<col width="5%" />
			<col width="5%" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>추천수</th>
			</tr>
		</thead>
		<c:forEach items="${board }" var="b" varStatus="bs">
			<tbody>
				<tr>
					<td>${(division * (now_page-1)) + bs.index + 1 }</td>
					<td><a href="/board/read?id=${b.id }&code=${b.id }">${b.title }</a></td>
					<td>${b.writer }</td>
					<td>${b.wdate }</td>
					<td>${b.readnum }</td>
					<td>${b.like }</td>
				</tr>
			</tbody>
		</c:forEach>
	</table>
	<table align="center">
		<tr>
			<td style="margin: 5px; padding: 5px"><a
				href="/board/main?menu=${menu }&page=1">&lt;&lt;</a></td>
			<%
				for (int i = 1; i <= (int) session.getAttribute("all_page"); i++) {
					if (i == Integer.parseInt(request.getParameter("page"))) {
			%>
			<td style="margin: 5px; padding: 5px"><b><%=i%></b></td>
			<%
				} else {
			%>
			<td style="margin: 5px; padding: 5px"><a
				href="/board/main?menu=${menu }&page=<%=i%>"><%=i%></a></td>
			<%
				}
				}
			%>
			<td style="margin: 5px; padding: 5px"><a
				href="/board/main?menu=${menu }&page=<%=(int) session.getAttribute("all_page")%>">&gt;&gt;</a></td>
		</tr>
	</table>
</div>
<p>
<hr style="border: solid 2px; color: #D8D8D8" />
<p />
<p>
	<button onclick="checkId()">글쓰기</button>
</p>

<div align="center">
	<form action="/board/main" method="post">
		<input type="hidden" name="menu" value="${menu }"/>
		<select style="font-size: 15px; , height: 24px;" name="mode">
			<option value="title">제목만</option>
			<option value="writer">글작성자</option>
		</select> <input type="text" style="height: 24px" name="value">

		<button type="submit"
			style="background-color: #2E64FE; font-family: 바탕; font-size: 15px; color: white;">검색</button>
	</form>
</div>

<script>
	function checkId() {
		<c:choose>
		<c:when test="${sessionScope.logon eq null }">
		alert('로그인을 해야 이용하실 수 있습니다.');
		</c:when>
		<c:otherwise>
		location.href = "/board/write?menu=${menu}";
		</c:otherwise>
		</c:choose>
	}
</script>
