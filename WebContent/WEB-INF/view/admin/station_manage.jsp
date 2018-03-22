<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<title>Spring - managed by GIT</title>
</head>
<style>
a {
	text-decoration: none;
}

input {
	padding: 5px;
	width: 100%;
}
</style>
<body>
	<div align="center">
		<div style="width: 980px;">
			<h2>기차역 관리하기</h2>
			<hr />
			<c:if test="${!empty info }">
				<script>
					alert('${info }');
				</script>
			</c:if>
		</div>
		<div class="row">
			<table id="example-table-1" width="100%"
				class="table table-bordered table-hover text-center">
				<colgroup>
					<col width="" />
					<col width="15%" />
					<col width="" />
					<col width="" />
					<col width="10%" />
				</colgroup>
				<thead>
					<tr>
						<th>선택</th>
						<th>역 이름</th>
						<th>네이버 지도상 링크
							<button type="button" onclick="howto()">?</button> <br /> <span
							class="howto" style="color: red; display: none">수정시 네이버
								지도에서 주소을 검색하고 주소부분을 우클릭하여 검사를 누르신 뒤, 영역표시 되어있는 부분을 복사(Ctrl +
								c)해서 넣어주세요.</span>
						</th>
						<th>주소</th>
						<th>연락처</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${station }" var="s" varStatus="sts">
						<tr class="data">
							<td class="rselect"><c:choose>
									<c:when test="${sts.index ==0 }">
										<input type="radio" name="select" class="select" checked />
									</c:when>
									<c:otherwise>
										<input type="radio" name="select" class="select" />
									</c:otherwise>
								</c:choose></td>
							<td>${s.NAME }</td>
							<td>${s.MAP }</td>
							<td>${s.ADDR }</td>
							<td>${s.CONTACT }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<button id="modify" type="button">수정</button>
			<button id="delete" type="button">삭제</button>
		</div>
	</div>
	<script>
		$(".data").click(function select() {
			//	테이블의 열을 클릭시 해당 열의 라디오 체크시키기
			for(var i = 0; i < $(".select").length; i++){
				var select = $(".select").eq(i);
				if(select.prop("checked")){
					select.attr("checked", false);
				}
			}
			var tr = $(this);
			var td = tr.children();
			var radio = td.eq(0).children();
			radio.attr("checked", true);
		});
		
		function howto() {
			//	지도  src 주소 가져오는 법 토글
			$(".howto").toggle();
		}
		
		function apply() {
			//	지도 주소 src 변환
			var src = $(".mapaddr").val();
			var srccommit = src.substring(src.indexOf('\"') + 1, src.indexOf("\"", 30));
			$(".mapaddr").val(srccommit);
		}
		
		$("#modify")
				.click(
						function() {
							if($(this).html() == "수정"){
								//	수정버튼 클릭시 작동
								for(var i = 0; i < $(".select").length; i++){
									var select = $(".select").eq(i);
									if(select.prop("checked")){
										var tr = select.parent().parent();
										var td = tr.children();
										
										td.each(function(i) {
											if($(this).attr("class") != "rselect"){
												$(this).html("<input type=\"text\" value=\""+$(this).text() +"\"/>");
											}
										});
									}
								}
								
								$(this).html("확인");
								$("#delete").html("취소");
							}else{
								//	확인 버튼 클릭시 작동
								for(var i = 0; i < $(".select").length; i++){
									var select = $(".select").eq(i);
									if(select.prop("checked")){
										var tr = select.parent().parent();
										var td = tr.children();
										
										$.post("/admin/station_update", {
											name : $(td[1]).children().val(),
											map : $(td[2]).children().val(),
											addr : $(td[3]).children().val(),
											contact : $(td[4]).children().val()
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
									}
								}
							}
						});
		
		$("#delete")
		.click(
				function() {
					//	삭제버튼 클릭시 동작
					if($(this).html() == "삭제"){
						for(var i = 0; i < $(".select").length; i++){
							var select = $(".select").eq(i);
							if(select.prop("checked")){
								var tr = select.parent().parent();
								var td = tr.children();
								
								$.post("/admin/station_delete", {
									name : td.eq(1).text(),
									},
										function(rst){
											console.log(rst);
											if(rst){
												alert("데이터 삭제에 성공했습니다.");
												location.reload();
											}else{
												alert("데이터 삭제에 실패했습니다. \\n같은 현상이 반복될 경우, 개발자에게 문의바랍니다.");
												location.reload();
											}
										});
								
							}
						}
					}else{
						//	취소버튼 클릭시 동작
						location.reload();
					}
				});
	</script>
</body>
</html>
