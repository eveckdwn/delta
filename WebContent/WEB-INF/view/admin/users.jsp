<%@page import="java.awt.Window"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
th {
	text-align: center;
}
</style>
<h2>회원 관리</h2>

<hr />

<!-- 신고 당한 횟수 많은 유저들  -->
<div align="center">
	<h2>
		<b>신고 당한 횟수 많은 유저들</b>
	</h2>
	<table border="1" class="table">
		<thead>
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
				<th>제재</th>
			</tr>
		</thead>
		<c:forEach var="i" items="${foul }">
			<tbody>
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
					<th><button type="button" class="btn1" value="${i.ID }">차단하기</button></th>
				</tr>
			</tbody>
		</c:forEach>
	</table>
</div>
<!-- 신고 당한 횟수 많은 유저들  -->

<!-- 전체 사용자  -->
<div align="center">
	<h2>
		<b>전체 목록</b>
	</h2>
	<table border="1" class="table">
		<thead>
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
			</tr>
		</thead>
		<c:forEach var="i" items="${select }">
			<tbody>
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
				</tr>
			</tbody>
		</c:forEach>
	</table>
</div>
<!-- 전체 사용자  -->

<script>
	$(".btn1").on("click", function() {

		var pass = "1111"
		var msg = prompt("비밀번호를 입력하세요.");
		if (msg != pass) {
			alert("틀렸습니다.");

		} else {
			alert("작업을 시작합니다.");
			$.post("/admin/ban", {
				id : $(this).val()
			}, function(rst) {
				if (rst) {
					location.reload();
				}

			});

		}
	});
</script>
