<%@page import="java.awt.Window" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  
<html>
<head>
<title>게시판</title>
</head>
<body>
	<c:if test="${!empty suc }">
		<script>
			alert("${suc}");
		</script>
	</c:if>

	<h2>여행 Q&A</h2>

	<p>
	<hr style="border: solid 2px; color: #D8D8D8" />
	<p/>
	<div align="center">

		<table class="table table-striped table-bordered table-hover">
			<colgroup>
			<col width="25%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="25%"/>
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회</th>
					<th>추천</th>
				</tr>
				</thead>
		<c:forEach var="i" items="${find }">
			<tbody>
				<tr>
					<td></td>
					<td><a href="/board/read?id=${i.id }">${i.title }</a></td>
					<td>${i.writer }</td>
					<td>${i.wdate }</td>
					<td>${i.readnum }</td>
					<td>${i.like }</td>
				</tr>
			</tbody>	
		</c:forEach>
		</table>
		
	</div>
		<p>
		<hr style="border: solid 2px; color: #D8D8D8" />
		<p />
		<p>
		<a href="/board/write" class="btn btn-default"><button>글쓰기</button></a>
		</p>
		
		
	
	
	<div align="center">
	
	<select style="font-size: 15px;, height: 24px;">
		<option>제목만</option>
		<option>글작성자</option>
	</select>
	
	
	<input type="text" style="height: 24px;">	
	
	<button style="background-color: #2E64FE; font-family: 바탕; font-size: 15px; color: white;">검색</button>
	
	</div>

</body>
</html>

<script>

</script>

