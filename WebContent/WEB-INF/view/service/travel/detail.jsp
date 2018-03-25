<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Travel Detail</title>
</head>
<body>
	<div align="center" style="width: 80%">
		<h2>${travel.TNAME }상세정보</h2>
		<hr />
		<table class="table table-bordered table-hover text-center">
			<colgroup>
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
				<col width="" />
				<col width="40%" />
			</colgroup>
			<tbody>
				<tr>
					<th>분류</th>
					<td colspan="3">${travel.CATE }</td>
					<th>지도</th>
				</tr>
				<tr>
					<th>여행지</th>
					<td colspan="3">${travel.TNAME }</td>
					<td id="map" rowspan="5"><script>
				function initMap() {
					var uluru = {lat: ${travel.LAT}, lng: ${travel.LNG}};
					var map = new google.maps.Map(document.getElementById("map"), {
						zoom: 14,
				          center: uluru
				        });
				        var marker = new google.maps.Marker({
				          position: uluru,
				          map: map
				        });
				      }
			</script> <script async defer
							src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA_R96Ncu_I2ntMuWfqXmvAsTKqklpj0JU&callback=initMap"></script>
					</td>
				</tr>
				<tr>
					<th>관리자</th>
					<td colspan="3"><c:choose>
							<c:when test="${travel.MANAGER ne null }">${travel.MANAGER }</c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td colspan="3"><c:choose>
							<c:when test="${travel.CONTACT ne null }">${travel.MANAGER }</c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose></td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3">${travel.TADDR }</td>
				</tr>
				<tr>
					<th>위도</th>
					<td>${travel.LAT }</td>
					<th>경도</th>
					<td>${travel.LNG }</td>
				</tr>
				<tr>
					<th colspan="5">설명
				</tr>

				<tr>
					<td colspan="5">
						<c:choose>
							<c:when test="${travel.DETAIL ne null }">${travel.MANAGER }</c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>

