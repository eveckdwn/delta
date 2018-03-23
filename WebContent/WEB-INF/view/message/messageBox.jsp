<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<div align="center">
		<h3>쪽 지 함</h3>
		<hr />
		<div align="right" style="margin-bottom: 10px;">
			<button type="button" onclick="del();">삭제</button>
			<a href="/message/send"><button type="button">쪽지 보내기</button></a>
		</div>
		<table style="width: 80%; height: 20%;" border="1">
			<tr>
				<th colspan="2">보낸 사람</th>
				<th>내용</th>
				<th>보낸 날짜</th>
				<th>매세지 상태</th>
			</tr>
			<c:if test="${!empty msgs }">
				<c:forEach items="${msgs}" var="msg">
					<c:if test="${msg.STATUS == 0  }">
						<tr>
							<td><input type="checkbox" class="sel" name="mid"
								value="${msg.MID }" /></td>
							<td><b>${msg.MNICK}</b></td>
							<!-- 여기도 프로필 띄우기 -->
							<td><b><a href="/message/view?mid=${msg.MID }">${msg.CONTEXT}</a></b></td>
							<!-- 최대 길이 정해줘야됨. 나머지는 ...으로 표현. 새 창으로? 팝업으로? 띄우게 링크 넣어줘야됨-->
							<td><b>${msg.MDATE}</b></td>
							<td><b>읽지 않음</b></td>
						</tr>
					</c:if>
					<c:if test="${msg.STATUS == 1  }">
						<tr>
							<td><input type="checkbox" class="sel" name="mid"
								value="${msg.MID }" /></td>
							<td>${msg.MNICK}</td>
							<!-- 여기도 프로필 띄우기 -->
							<td><a href="/message/view?mid=${msg.MID }">${msg.CONTEXT}</a></td>
							<!-- 최대 길이 정해줘야됨. 나머지는 ...으로 표현. 새 창으로? 팝업으로? 띄우게 링크 넣어줘야됨-->
							<td>${msg.MDATE}</td>
							<td>읽음</td>
						</tr>
					</c:if>
				</c:forEach>
			</c:if>
			<c:if test="${empty msgs }">
				<tr>
					<td colspan="5" align="center">받은 쪽지가 없습니다.</td>
				</tr>
			</c:if>
		</table>
	</div>
</body>
<script>
	function del() {
		var vals = [];
		var items = $(".sel:checked");
		console.log(items);
		for (var i = 0; i < items.length; i++) {
			vals.push(items.eq(i).val());
			// 			console.log(items.eq(i).val());
			// 			console.log($(items.get(i)).val());
			// jquery group eq ==> jquery
			// jquery group get ==> htmlElement
		}
		$.post("/message/del", {
			mid : vals
		}, function(rst) {
			if (rst) {
				alert("쪽지를 삭제했습니다.");
				location.reload();
			} else {
				alert("삭제를 실패했습니다.");
				location.reload();
			}
		})
	};

	function send() {

	}
</script>
</html>
