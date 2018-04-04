<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
<form>

	<div align="center">
		<p>
			<c:if test="${user.PHOTO != null }">
				<img
					src="<%=request.getContextPath() %>/photo/${user.ID }/${user.PHOTO }"
					style="width: 200px; height: 200px; border-radius: 50%;"
					id="preview" />
			</c:if>
			<c:if test="${user.PHOTO == null }">
				<img src="<%=request.getContextPath()%>/photo/default.jpg"
					style="width: 200px; height: 200px; border-radius: 50%;"
					id="preview" />
			</c:if>
		</p>
		<table style="width: 300px; height: 150px; margin-bottom: 10px;"
			border="2px">
			<tr>
				<td align="center"><b>NICK</b></td>
				<td>${user.NICK }</td>
			</tr>
			<tr>
				<td align="center"><b>E-MAIL</b></td>
				<td>${user.EMAIL }</td>
			</tr>
			<tr>
				<td align="center"><b>LAST LOG</b></td>
				<td>${user.LASTLOG }</td>
			</tr>
		</table>
		<a href="message/rsend?receiver=${user.ID }"><button type="button">쪽지</button></a>
		<button type="button" id="report" onclick="declare();">신고</button>
	</div>
</form>
<script>
	function declare() {
		
		$.post("/board/report", {
			
			rid : "${sessionScope.logon}",
			reid : "${user.ID}"
			
			}, function(rst) {
				
				if (rst) {
					alert(${user.ID} + "님이 신고 되었습니다.");
				} else {
					alert("신고에 실패했습니다. 중복 신고를 하실 수 없습니다.");
				}
				
		});
		
	}
	
</script>
