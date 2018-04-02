<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
a {
	text-decoration: none;
}

input {
	padding: 5px;
	width: 100%;
}
</style>
	<div align="center">
		<div style="width: 980px;">
			<h2>여행지 관리하기</h2>
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
					<col width="5%" />
					<col width="5%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="7%" />
					<col width="7%" />
					<col width="15%" />
					<col width="7%" />
					<col width="10%" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th>선택</th>
						<th>등록번호</th>
						<th>주변 기차역</th>
						<th>여행지</th>
						<th>분류</th>
						<th>위도</th>
						<th>경도</th>
						<th>주소</th>
						<th>관리자</th>
						<th>연락처</th>
						<th>설명</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${travel }" var="t" varStatus="tra">
						<tr class="data">
							<td class="rselect"><c:choose>
									<c:when test="${tra.index ==0 }">
										<input type="radio" name="select" class="select" checked />
									</c:when>
									<c:otherwise>
										<input type="radio" name="select" class="select" />
									</c:otherwise>
								</c:choose></td>
							<td>${t.TID }</td>
							<td>${t.SNAME }</td>
							<td>${t.TNAME }</td>
							<td>${t.CATE }</td>
							<td>${t.LAT }</td>
							<td>${t.LNG }</td>
							<td>${t.TADDR }</td>
							<td><c:choose>
									<c:when test="${t.MANAGER ne null }">${t.MANAGER }</c:when>
									<c:otherwise>-</c:otherwise>
								</c:choose></td>
							<td><c:choose>
									<c:when test="${t.CONTACT ne null }">${t.CONTACT }</c:when>
									<c:otherwise>-</c:otherwise>
								</c:choose></td>
							<td><c:choose>
									<c:when test="${t.DETAIL ne null }">${t.DETAIL }</c:when>
									<c:otherwise>-</c:otherwise>
								</c:choose></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<table align="center">
				<tr>
					<td style="margin: 5px; padding: 5px"><a
						href="/travel/station?page=1">&lt;&lt;</a></td>
					<%
						for (int i = 1; i <= (int) session.getAttribute("all_page"); i++) {
					%>
					<td style="margin: 5px; padding: 5px"><a
						href="/travel/station?page=<%=i%>"><%=i%></a></td>
					<%
						}
					%>
					<td style="margin: 5px; padding: 5px"><a
						href="/travel/station?page=<%=(int) session.getAttribute("all_page")%>">&gt;&gt;</a></td>
				</tr>
			</table>
			<button id="modify" type="button">수정</button>
			<button id="delete" type="button">삭제</button>
		</div>
	</div>
	<script>
		$(".data").click(function select() {
			//	테이블의 열을 클릭시 해당 열의 라디오 체크시키기
			for (var i = 0; i < $(".select").length; i++) {
				var select = $(".select").eq(i);
				if (select.prop("checked")) {
					select.attr("checked", false);
				}
			}
			var tr = $(this);
			var td = tr.children();
			var radio = td.eq(0).children();
			radio.attr("checked", true);
		});

		$("#modify")
				.click(
						function() {
							if ($(this).html() == "수정") {
								//	수정버튼 클릭시 작동
								for (var i = 0; i < $(".select").length; i++) {
									var select = $(".select").eq(i);
									if (select.prop("checked")) {
										var tr = select.parent().parent();
										var td = tr.children();

										td
												.each(function(i) {
													if ($(this).attr("class") != "rselect") {
														if (i == 1) {
															$(this)
																	.html(
																			"<input type=\"text\" value=\""
																					+ $(
																							this)
																							.text()
																					+ "\" disabled/>");
														} else if (i == td.length - 1) {
															var text = "<textarea rows=\"5\">"
																	+ $(this)
																			.text()
																	+ "</textarea>";
															$(this).html(text);
														} else {
															$(this)
																	.html(
																			"<input type=\"text\" value=\""
																					+ $(
																							this)
																							.text()
																					+ "\"/>");
														}
													}
												});
									}
								}

								$(this).html("확인");
								$("#delete").html("취소");
							} else {
								//	확인 버튼 클릭시 작동
								for (var i = 0; i < $(".select").length; i++) {
									var select = $(".select").eq(i);
									if (select.prop("checked")) {
										var tr = select.parent().parent();
										var td = tr.children();
										var manager = $(td[8]).children().val();
										if (manager == "-") {
											manager = null;
										}
										var contact = $(td[9]).children().val();
										if (contact == "-") {
											contact = null;
										}
										var detail = $(td[10]).children().val();
										if (detail == "-") {
											detail = null;
										}
										console.log(manager + " / " + contact
												+ " / " + detail);
										$
												.post(
														"/admin/travel_update",
														{
															tid : $(td[1])
																	.children()
																	.val(),
															sname : $(td[2])
																	.children()
																	.val(),
															tname : $(td[3])
																	.children()
																	.val(),
															cate : $(td[4])
																	.children()
																	.val(),
															lat : $(td[5])
																	.children()
																	.val(),
															lng : $(td[6])
																	.children()
																	.val(),
															taddr : $(td[7])
																	.children()
																	.val(),
															manager : manager,
															contact : contact,
															detail : detail
														},
														function(rst) {
															if (rst) {
																alert("데이터 수정에 성공했습니다.");
																location
																		.reload();
															} else {
																alert("데이터 수정에 실패했습니다. \n같은 현상이 반복될 경우, 개발자에게 문의바랍니다.");
																location
																		.reload();
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
							if ($(this).html() == "삭제") {
								for (var i = 0; i < $(".select").length; i++) {
									var select = $(".select").eq(i);
									if (select.prop("checked")) {
										var tr = select.parent().parent();
										var td = tr.children();
										$
												.post(
														"/admin/travel_delete",
														{
															tid : td.eq(1)
																	.text(),
														},
														function(rst) {
															console.log(rst);
															if (rst) {
																alert("데이터 삭제에 성공했습니다.");
																location
																		.reload();
															} else {
																alert("데이터 삭제에 실패했습니다. \\n같은 현상이 반복될 경우, 개발자에게 문의바랍니다.");
																location
																		.reload();
															}
														});

									}
								}
							} else {
								//	취소버튼 클릭시 동작
								location.reload();
							}
						});
	</script>
