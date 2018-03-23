<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Travel</title>
</head>
<body>
	<h2>여행 정보</h2>
	<hr />
	<div class="row">
		<table width="100%"
			class="table table-bordered table-hover text-center">
			<colgroup>
				<col width="10%" />
				<col width="" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th>기차역</th>
					<th>주소</th>
					<th>연락처</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${station }" var="s" varStatus="sts">
					<tr class="data">
						<td>${s.NAME }</td>
						<td>${s.ADDR }</td>
						<td>${s.CONTACT }</td>
					</tr>
					<tr>
						<td colspan="3">
							<div id="map" style="width:100%; height:400px"></div>
							<script>
								function initMap() {
									var uluru = {
										lat : "${s.LAT}",
										lng : "${s.LNG}"
									};
									var map = new google.maps.Map(document
											.getElementById('map'), {
										zoom : 4,
										center : uluru
									});
									var marker = new google.maps.Marker({
										position : uluru,
										map : map
									});
								}
							</script>
							<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA_R96Ncu_I2ntMuWfqXmvAsTKqklpj0JU&callback=initMap"></script>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<table align="center">
			<tr>
				<td style="margin: 5px; padding: 5px""><a
					href="/travel/station?page=1">&lt;&lt;</a></td>
				<%
					for (int idx = 1; idx <= (int) session.getAttribute("all_page"); idx++) {
				%>
				<%
					if (idx == (int) session.getAttribute("now_page")) {
				%>
				<td style="margin: 5px; padding: 5px"><b><%=idx%></b></td>
				<%
					} else {
				%>
				<td style="margin: 5px; padding: 5px"><a
					href="/travel/station?page=<%=idx%>"><%=idx%></a></td>
				<%
					}
				%>
				<%
					}
				%>
				<td style="margin: 5px; padding: 5px"><a
					href="/travel/station?page=<%=(int) session.getAttribute("all_page")%>">&gt;&gt;</a></td>
			</tr>
		</table>
	</div>
	<br />
	<div class="row">
		<p>여행하고자하는 역정보를 클릭하시면 해당 역 주변 여행지가 나옵니다.</p>
		<table width="100%"
			class="table table-bordered table-hover text-center">
			<colgroup>
				<col width="10%" />
				<col width="" />
				<col width="10%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th>여행지</th>
					<th>주소</th>
					<th>담당자</th>
					<th>연락처</th>
				</tr>
			</thead>
			<tbody id="tbody">
			</tbody>
		</table>
	</div>
	<script>
		
	</script>
</body>
</html>

