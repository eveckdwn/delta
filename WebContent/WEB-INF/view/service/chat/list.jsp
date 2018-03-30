<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA_R96Ncu_I2ntMuWfqXmvAsTKqklpj0JU&callback=initMap"></script>
<title>Chatting</title>
<h2>채팅하기</h2>
<hr />
<h3>기차역 정보</h3>
<hr />
<p>채팅방 입장 버튼을 누르시면 해당 기차역 채팅방으로 입장합니다.</p>
<div class="row">
	<table width="100%"
		class="table table-bordered table-hover">
		<colgroup>
			<col width="25%" />
			<col width="" />
			<col width="15%" />
		</colgroup>
		<thead>
			<tr>
				<th>기차역</th>
				<th>주소</th>
				<th>채팅방 입장</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${station }" var="s" varStatus="sts">
				<tr>
					<td>${s.NAME }</td>
					<td>${s.ADDR }</td>
					<td><a href="/chat/chatroom?id=${sts.index }"><button style="width:100%; cursor: pointer;">채팅방 입장하기</button></a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
