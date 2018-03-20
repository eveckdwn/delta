<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<style>

th{

align-self: center;

}







</style>
<title>관리자</title>
</head>
<body>




	<h2>관리자 모드</h2>

	<hr />

<!-- 신고 당한 횟수 많은 유저들  -->
	<div align="center">
		<h2><b>신고 당한 횟수 많은 유저들</b></h2>
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>비밀번호</th>
				<th>닉네임</th>
				<th>이메일</th>
				<th>레벨</th>
				<th>프로필 사진</th>
				<th>로그인 마지막 날짜</th>
				<th>사용 제한 날짜</th>
				<th>신고 당한 횟수</th>
				<th>차단 여부</th>
				<th>제재</th>
			</tr>
			<c:forEach var="i" items="${foul }">
				<tr>
					<th>${i.ID }</th>
					<th>${i.PASS }</th>
					<th>${i.NICK }</th>
					<th>${i.EMAIL }</th>
					<th>${i.LV }</th>
					<th>${i.PHOTO }</th>
					<th>${i.LASTLOG }</th>
					<th>${i.BAN }</th>
					<th>${i.FOUL }</th>
					<c:choose>
					<c:when test="${i.BAN == null }">
					<th>X</th>
					</c:when>
					<c:otherwise>
					<th>O</th>					
					</c:otherwise>
					</c:choose>
					
					
					<th><button type="submit">차단하기</button></th>
				</tr>
			</c:forEach>
		</table>
	</div>
<!-- 신고 당한 횟수 많은 유저들  -->
	
<!-- 전체 사용자  -->
	<div align="center">
		<h2><b>전체 목록</b></h2>
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>비밀번호</th>
				<th>닉네임</th>
				<th>이메일</th>
				<th>레벨</th>
				<th>프로필 사진</th>
				<th>로그인 마지막 날짜</th>
				<th>사용 제한 날짜</th>
				<th>신고 당한 횟수</th>
				<th>차단 여부</th>
			</tr>
			<c:forEach var="i" items="${select }">
				<tr>
					<th>${i.ID }</th>
					<th>${i.PASS }</th>
					<th>${i.NICK }</th>
					<th>${i.EMAIL }</th>
					<th>${i.LV }</th>
					<th>${i.PHOTO }</th>
					<th>${i.LASTLOG }</th>
					<th>${i.BAN }</th>
					<th>${i.FOUL }</th>
					<c:choose>
					<c:when test="${i.BAN == null }">
					<th>X</th>
					</c:when>
					<c:otherwise>
					<th>O</th>					
					</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>
		</table>
	</div>
<!-- 전체 사용자  -->



</body>
</html>


