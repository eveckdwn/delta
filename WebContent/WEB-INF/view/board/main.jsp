<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<html>
<head>

<style>
td {
	text-align: center;
}




</style>

<title>게시판</title>
</head>
<body>
	<h2>여행 Q&A</h2>

	<p>
	<hr style="border: solid 2px; color: #D8D8D8" />
	<p/>

	<div>
		<c:forEach var="i" items="${find }">
		<table border="1" style="width: 100%; height: 200px;">
			<thead>
				<tr>
					<th colspan="2">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회</th>
					<th>추천</th>
				</tr>
				<tr class="data">
					<td style="width: 10%"></td>
					<td><a href="/board/read?title=${i.title }">${i.title }</a></td>
					<td>${i.writer }</td>
					<td>${i.wdate }</td>
					<td>${i.readnum }</td>
					<td>${i.like }</td>
				</tr>
			</thead>
		</table>
		</c:forEach>
		<p>
		<a href="/board/write"><button>글쓰기</button></a>
		</p>
		<p>
		<hr style="border: solid 2px; color: #D8D8D8" />
		<p />
		
		
	</div>
	
	
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

