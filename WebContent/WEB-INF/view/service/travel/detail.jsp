<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
h3 {
	text-align: left;
}
</style>

<div>
	<c:if test="${info ne null}">
		<script>
			alert('${info }');
		</script>
	</c:if>
	<h2>${travel[0].TNAME } 상세정보</h2>
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
				<th colspan="5" style="vertical-align: middle; text-align: center;">설명</th>
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
					<input type="hidden" name="userid"
					value="${sessionScope.logonNick}" /> <input id="score"
					type="number" min="1" max="5" value="5" name="trascore"
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
			<col width="5%" />
			<col width="10%" />
			<col width="" />
		</colgroup>
		<tr>
			<th style="display: none">No.</th>
			<th>점수</th>
			<th>닉네임(아이디)</th>
			<th>평가</th>
		</tr>
		<c:choose>
			<c:when test="${commentSize ne 0 }">
				<c:forEach items="${travel }" var="t">
					<tr>
						<td style="display: none">${t.COMMENTNO }</td>
						<td id="userscore" class="score" style="vertical-align: middle;">${t.TRASCORE }</td>
						<td id="userid" style="vertical-align: middle;">${t.NICK }(${t.USERID })</td>
						<td style="text-align: left; vertical-align: middle;">${t.TRACOMMENT }&nbsp;<small>(${t.LEFTDATE })</small>
							<c:if test="${t.USERID eq sessionScope.logon}">
								<br />
								<button type="button" onclick="commentProcess(this)">수정</button>&nbsp;<button
									type="button" onclick="commentProcess(this)">삭제</button>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="4" style="vertical-align: middle;">코멘트가 없습니다. 코멘트를 통해 다른 여행자가 참고할 수 있게 도와주세요.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
	<script>
		function commentProcess(target){
			var button = $(target);
			var tr = $(target).parent().parent();
			var td = $(tr).children();
			
			if(button.html() == "수정"){
				for(var i = 0; i < td.length; i++){
					switch(i){
					case 0:	//	commentno
						$(td[0]).html("<input type=\"text\" name=\"commentno\" value=\""+$(td[0]).text() +"\"/>");
						break;
					case 1:	//	userscore
						$(td[1]).html("<input type=\"text\" name=\"troscore\" value=\""+$(td[1]).text().length +"\"/>");
						break;
					case 2:	//	userid
						$(td[2]).html("<input type=\"text\" name=\"userid\" value=\""+$(td[2]).text() +"\" disabled/>");
						break;
					case 3:	//	comment
						$(td[3]).html("<input type=\"text\" name=\"tracomment\" value=\""+$(td[3]).text().substring(0, $(td[3]).text().indexOf("(")) +"\"/><button type=\"button\" onclick=\"commentProcess(this)\">확인</button>");
						break;
					default:
						break;
					}
				}
			}else if(button.html() == "확인"){
				$.post("/travel/comment_update", {
					commentno : $(td[0]).children().val(),
					trascore : $(td[1]).children().val(),
					tracomment : $(td[3]).children().val(),
					},
					function(rst){
						if(rst){
							alert("데이터 수정에 성공했습니다.");
							location.reload();
						}else{
							alert("데이터 수정에 실패했습니다. \n같은 현상이 반복될 경우, 개발자에게 문의바랍니다.");
							location.reload();
						}
					});
			}else{
				console.log($(td[0]).children().val());
				$.post("/travel/comment_delete", {
					commentno : $(td[0]).text(),
					},
					function(rst){
						if(rst){
							alert("데이터를 삭제했습니다.");
							location.reload();
						}else{
							alert("데이터 삭제에 실패했습니다. \n같은 현상이 반복될 경우, 개발자에게 문의바랍니다.");
							location.reload();
						}
					});
			}
			
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
