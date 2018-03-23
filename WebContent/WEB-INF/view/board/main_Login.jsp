<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
					<td style="width: 10%">156164</td>
					<td><a href="/admin/users">어서오세요</a></td>
					<td>아무개</td>
					<td>03.22</td>
					<td>1</td>
					<td>0</td>
				</tr>
			</thead>
		</table>
		<p>
		<a href="/board/write"><button>글쓰기</button></a>
		</p>
		<p>
		<hr style="border: solid 2px; color: #D8D8D8" />
		<p />
		
		
	</div>
	
	
	<div align="center">
	
	<select style="font-size: 15px;, height: 24px;">
		<option>전체기간</option>
		<option>1일</option>
		<option>1주일</option>
		<option>1개월</option>
		<option>6개월</option>
		<option>1년</option>
	</select>
	
	<select style="font-size: 15px;, height: 24px;">
		<option>제목만</option>
		<option>글작성자</option>
		<option>댓글내용</option>
		<option>댓글작성자</option>
	</select>
	
	
	<input type="text" style="height: 24px;">	
	
	<button style="background-color: #58FA58; font-family: 바탕; font-size: 15px;">검색</button>
	
	
	
	</div>
	
	
	
</body>
</html>

<script>

</script>

