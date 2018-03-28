<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
h3 {
	text-align: left;
}
</style>

<div align="center" style="width: 80%">
	<c:if test="${info ne null}">
		<script>
			alert('${info }');
		</script>
	</c:if>
	<h2>${travel[0].TNAME }상세정보</h2>
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
				<th style="vertical-align: middle; text-align: center;">분류</th>
				<td colspan="3" style="vertical-align: middle; text-align: center;">${travel[0].CATE }</td>
				<th>지도</th>
			</tr>
			<tr>
				<th style="vertical-align: middle; text-align: center;">여행지</th>
				<td colspan="3" style="vertical-align: middle; text-align: center;">${travel[0].TNAME }</td>
				<td id="map" rowspan="5" height="400px"><script>
				function initMap() {
					var uluru = {lat: ${travel[0].LAT}, lng: ${travel[0].LNG}};
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
				<th style="vertical-align: middle; text-align: center;">관리자</th>
				<td colspan="3" style="vertical-align: middle; text-align: center;"><c:choose>
						<c:when test="${travel[0].MANAGER ne null }">${travel[0].MANAGER }</c:when>
						<c:otherwise>-</c:otherwise>
					</c:choose></td>
			</tr>
			<tr>
				<th style="vertical-align: middle; text-align: center;">연락처</th>
				<td colspan="3" style="vertical-align: middle; text-align: center;"><c:choose>
						<c:when test="${travel[0].CONTACT ne null }">${travel[0].CONTACT }</c:when>
						<c:otherwise>-</c:otherwise>
					</c:choose></td>
			</tr>
			<tr>
				<th style="vertical-align: middle; text-align: center;">주소</th>
				<td colspan="3" style="vertical-align: middle; text-align: center;">${travel[0].TADDR }</td>
			</tr>
			<tr>
				<th style="vertical-align: middle; text-align: center;">위도</th>
				<td style="vertical-align: middle; text-align: center;">${travel[0].LAT }</td>
				<th style="vertical-align: middle; text-align: center;">경도</th>
				<td style="vertical-align: middle; text-align: center;">${travel[0].LNG }</td>
			</tr>
			<tr>
				<th colspan="5" style="vertical-align: middle; text-align: center;">설명





				
			</tr>

			<tr>
				<td colspan="5" style="vertical-align: middle; text-align: justify;">
					<c:choose>
						<c:when test="${travel[0].DETAIL ne null }">${travel[0].DETAIL }</c:when>
						<c:otherwise>-</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</tbody>
	</table>
	<h2>유저 평가</h2>
	<hr />
	<h3>
		평가하기
		<button onclick='$("#howto").toggle()'>?</button>
	</h3>
	<div id="howto" style="text-align: left; color: red; display: none;">평가내용을
		적으셔야 점수 평가와 등록 버튼이 활성화됩니다.</div>
	<br />
	<form method="POST">
		<table class="table table-bordered table-hover text-center">
			<colgroup>
				<col width="10%" />
				<col width="" />
				<col width="10%" />
			</colgroup>
			<tr>
				<td><input type="hidden" name="trano" value="${travel[0].TID }" />
					<input type="hidden" name="userid" value="${sessionScope.logon}" />
					<input id="score" type="number" min="1" max="5" value="5"
					name="trascore"
					style="padding: 12px; width: 100%; height: 100%; text-align: center;"
					disabled="disabled" /></td>
				<td><textarea name="tracomment"
						placeholder="명예훼손, 개인정보 유출, 분쟁 유발, 허위사실 유포 등의 글은 이용약관에 의해 제재는 물론 법률에 의해 처벌받을 수 있습니다. 건전한 커뮤니티를 위해 자제를 당부드립니다."
						style="width: 100%; height: 100%; resize: none"
						onclick="checkId()"></textarea></td>
				<td><button id="submit" type="submit"
						style="padding: 11px; width: 100%; min-height: auto; height: 100%;"
						onclick="checkId()" disabled="disabled">등록</button></td>
			</tr>
		</table>
	</form>

	<h3>평가 통계</h3>
	<br />
	<table class="table table-bordered table-hover text-center">
		<colgroup>
			<col width="50%" />
			<col width="" />
		</colgroup>
		<tr>
			<th>평균 점수</th>
			<th>평가 인원</th>
		</tr>
		<tr>
			<td id="avg"></td>
			<td id="avg_cnt"></td>
		</tr>
		<tr>
			<th colspan="2">점수별 평가</th>
		</tr>
		<tr>
			<th>평가 점수</th>
			<th>평가 인원</th>
		</tr>
		<tr>
			<td>☆☆☆☆☆</td>
			<td id="5"></td>
		</tr>
		<tr>
			<td>☆☆☆☆</td>
			<td id="4"></td>
		</tr>
		<tr>
			<td>☆☆☆</td>
			<td id="3"></td>
		</tr>
		<tr>
			<td>☆☆</td>
			<td id="2"></td>
		</tr>
		<tr>
			<td>☆</td>
			<td id="1"></td>
		</tr>
	</table>
	<h3>평가</h3>
	<br />
	<table class="table table-bordered table-hover text-center">
		<colgroup>
			<col width="5%" />
			<col width="20%" />
			<col width="20%" />
			<col width="" />
		</colgroup>
		<tr>
			<th style="display: none">No.</th>
			<th>점수</th>
			<th>닉네임</th>
			<th>평가</th>
		</tr>
		<c:forEach items="${travel }" var="t">
			<tr>
				<th style="display: none">${t.COMMENTNO }</th>
				<td class="score">${t.TRASCORE }</td>
				<td>${t.USERID }</td>
				<td style="text-align: left;">${t.TRACOMMENT }&nbsp;<small>(${t.LEFTDATE })</small>
					<c:if test="${t.USERID eq sessionScope.logon}">
						<br />
						<button type="button" onclick="commentProcess()">수정</button>&nbsp;<button
							type="button" onclick="commentProcess()">삭제</button>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
	<script>
		function commentProcess(){
			//	TODO: 처리하기
			var tr = $(this).parent();
			tr.html("??");
			console.log(tr);
			console.log($(tr));
			var td = tr.children();
			console.log(td);
			console.log($(td));
		}
	
		function checkId(){
			var id = "${sessionScope.logon}"; 
			if(id == ""){
				alert('로그인이 필요합니다.');
			}else{
				console.log(id);
				$("#submit").removeAttr("disabled");
				$("#score").removeAttr("disabled");
			}
		}
	
		var scores = [];
		var scorecnt = [0,0,0,0,0];
		for(var i = 0; i < $(".score").length; i++){
			var num = parseInt($($(".score")[i]).html());
			scores.push(num);
			var text = "";
			for(var j = 0; j < num; j++){
				text += "☆";
			}
			$($(".score")[i]).html(text);
		}
		avg(scores);
		
		function avg(target){
			var sum = 0;
			for(var i = 0; i < target.length; i++){
				sum += target[i];
				scorecnt[target[i]-1]++;
			}
			
			for(var i = 0; i < scorecnt.length; i++){
				var id = "#" + (i+1);
				$(id).html(scorecnt[i] + " 명");
			}
			var avg = sum / target.length;
			var text = "";
			for(var j = 0; j < avg; j++){
				text += "☆";
			}
			$("#avg").html(text);
			$("#avg_cnt").html(target.length + " 명");
			return avg;
		}
	</script>
</div>
