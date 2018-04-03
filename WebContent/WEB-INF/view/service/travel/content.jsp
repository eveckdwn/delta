<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA_R96Ncu_I2ntMuWfqXmvAsTKqklpj0JU&callback=initMap"></script>
<div class="banner">
	<h2>여행 정보</h2>
	<hr />
</div>
<h3>기차역 정보</h3>
<hr />
<p>여행하고자하는 역정보를 클릭하시면 해당 역 주변 여행지가 나옵니다.</p>
<div class="row">
	<table width="100%"
		class="table table-bordered table-hover text-center">
		<colgroup>
			<col width="25%" />
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
				<tr style="cursor: pointer;"
					onclick="$('#${sts.index}').toggle(); showTravel(this);">
					<td>${s.NAME }</td>
					<td>${s.ADDR }</td>
					<td>${s.CONTACT }</td>
				</tr>
				<tr id="${sts.index }" style="height: 300px; display: none;">
					<td id="${sts.index }${s.CONTACT}" colspan="3"></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<script>
			function initMap() {
				<c:forEach items="${station }" var="s" varStatus="sts">
				var uluru_${sts.index} = {
					lat : ${s.LAT},
					lng : ${s.LNG}
				};
				var map_${sts.index} = new google.maps.Map(document
						.getElementById("${sts.index}${s.CONTACT}"), {
						zoom : 17,
					center : uluru_${sts.index}
				});
				var marker = new google.maps.Marker({
					position : uluru_${sts.index},
					map : map_${sts.index}
					});
			</c:forEach>
			}
				
		</script>
	<table align="center">
		<tr>
			<td style="margin: 5px; padding: 5px"><a
				href="/travel/station?page=1">&lt;&lt;</a></td>
			<%
				for (int i = 1; i <= (int) session.getAttribute("all_page"); i++) {
					if (i == Integer.parseInt(request.getParameter("page"))) {
			%>
			<td style="margin: 5px; padding: 5px"><b><%=i%></b></td>
			<%
				} else {
			%>
			<td style="margin: 5px; padding: 5px"><a
				href="/travel/station?page=<%=i%>"><%=i%></a></td>
			<%
				}
				}
			%>
			<td style="margin: 5px; padding: 5px"><a
				href="/travel/station?page=<%=(int) session.getAttribute("all_page")%>">&gt;&gt;</a></td>
		</tr>
	</table>
</div>
<hr />
<h3 id="info">여행지 정보</h3>
<hr />
<div class="row">
	<p>
		여행하고자하는 <span style="text-decoration: underline; color: #4477FF">여행지</span>를
		클릭하시면 여행지에 대한 정보를 얻을 수 있습니다.
	</p>
	<table width="100%"
		class="table table-bordered table-hover text-center">
		<colgroup>
			<col width="15%" />
			<col width="15%" />
			<col width="" />
			<col width="10%" />
			<col width="15%" />
		</colgroup>
		<thead>
			<tr>
				<th>여행지</th>
				<th>분류</th>
				<th>주소</th>
				<th>관리자</th>
				<th>연락처</th>
			</tr>
		</thead>
		<tbody id="travel_tbody">

		</tbody>
	</table>
</div>
<script>
		function showTravel(target) {
			var tr = $(target);
			var td = $(target).children();
			var station = $(td.eq(0)).html();
			$("#info").html(station + " 여행지 정보");
			$.post("/travel/travel", {
				sname : station
			}, function(rst) {
				var text = "";
				for (var i = 0; i < rst.length; i++) {
					var manager = rst[i].MANAGER == undefined ? "-"
							: rst[i].MANAGER;
					var contact = rst[i].CONTACT == undefined ? "-"
							: rst[i].CONTACT;
					text += "<tr>" + "<td><a href=\"/travel/detail?tname="
					+ rst[i].TNAME + "\">" + rst[i].TNAME
					+ "</a></td>" + "<td>" + rst[i].CATE
					+ "</td>" + "<td>" + rst[i].TADDR + "</td>"
					+ "<td>" + manager + "</td>" + "<td>"
					+ contact + "</td>" + "</tr>";
				};
				$("#travel_tbody").html(text);
			});
		}
	</script>
