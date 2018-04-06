<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%
	long time = System.currentTimeMillis();
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

	String str = dayTime.format(new Date(time));

	String menu = (String) request.getParameter("menu");
%>
<!-- SmartEditor를 사용하기 위해서 다음 js파일을 추가 (경로 확인) -->
<script type="text/javascript" src="/SE2/js/service/HuskyEZCreator.js"
	charset="utf-8"></script>
<div class="banner">
	<h2>글 쓰 기</h2>
	<hr />
</div>
<div align="center">
	<div style="width:80%">
		<form id="frm" enctype="multipart/form-data" action="/board/write"
			method="post">
			<div align="center">
				<table class="table table-bordered" width="100%">
					<tr>
						<td align="right" style="padding-right: 10px;">게시판</td>
						<td><select name="menu" style="width: 100px">
								<%
									if (menu.equals("1")) {
								%>
								<option value="1">여행 가요</option>
								<%
									} else if (menu.equals("2")) {
								%>
								<option value="2">여행 후기</option>
								<%
									} else {
								%>
								<option value="3">Q&N</option>
								<%
									}
								%>
						</select></td>
					</tr>
					<tr>
						<td align="right" style="padding-right: 10px;">내용 유형</td>
						<td><select name="type"  style="width: 100px">
								<option id="type" value="일반">일반</option>
								<c:if test="${sessionScope.auth ne null }">
									<option id="type" value="이벤트">이벤트</option>
									<option id="type" value="공지">공지</option>
								</c:if>
						</select></td>
					</tr>

					<tr>
						<td align="right" style="padding-right: 10px;">기차역</td>
						<td><select name="tab" style="width: 100px">
								<c:if test="${sessionScope.auth ne null }">
									<option value="-" >-</option>
								</c:if>
								<c:forEach var="i" items="${station }">
									<option value="${i.NAME }">${i.NAME }</option>
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<td align="right" style="padding-right: 10px;">제목</td>
						<td><input type="text" id="title" name="title"
							style="width: 100%; min-width: 350px;" /></td>
					</tr>
					<tr>
						<td align="right">내용</td>
						<td><textarea rows="10" cols="30" id="ir1" name="context"
								style="width: 100%; min-width: 350px; height: 350px;"></textarea></td>
					</tr>
					<tr>
						<td align="right" style="padding-right: 10px;">첨부 사진</td>
						<td><input type="file" name="photos" id="p" multiple /></td>
					</tr>
					<tr>
						<td colspan="2" style="align-content: space-between; text-align: right;"><button type="submit" id="save">저장</button>
					<button type="button">취소</button></td>
					</tr>
				</table>
				<input type="hidden" name="mode" value="${mode }" />
			</div>
		</form>
	</div>
</div>
<script type="text/javascript">
	var oEditors = [];
	$(function() {
		nhn.husky.EZCreator.createInIFrame({
			oAppRef : oEditors,
			elPlaceHolder : "ir1", //textarea에서 지정한 id와 일치해야 합니다. 
			//SmartEditor2Skin.html 파일이 존재하는 경로
			sSkinURI : "/SE2/SmartEditor2Skin.html",
			htParams : {
				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseToolbar : true,
				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true,
				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : false,
				fOnBeforeUnload : function() {

				}
			},
			fOnAppLoad : function() {
				//기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
				oEditors.getById["ir1"].exec("PASTE_HTML", [ "" ]);
			},
			fCreator : "createSEditor2"
		});

		//저장버튼 클릭시 form 전송
		$("#save").click(function() {
			oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
			$("#frm").submit();
		});

	});
</script>
<script>
	document.getElementById("p").onchange = function() {
		console.log(this.files[0]);
		if (!this.files[0].type.startsWith("image")) {
			window.alert("jpg, gif, bmp, tif, png 형식의 파일만 첨부하실 수 있습니다.");
			this.value = "";
			return;
		}
	}
</script>