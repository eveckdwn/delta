<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	long time = System.currentTimeMillis();
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

	String str = dayTime.format(new Date(time));

	String menu = (String) request.getParameter("menu");
%>

<!-- SmartEditor를 사용하기 위해서 다음 js파일을 추가 (경로 확인) -->
<script type="text/javascript" src="/SE2/js/service/HuskyEZCreator.js"
	charset="utf-8"></script>
<!-- jQuery를 사용하기위해 jQuery라이브러리 추가 -->
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.9.0.min.js"></script>



</head>
<body>

	<h2>글 쓰 기</h2>
	<hr />
	<form id="frm" enctype="multipart/form-data" action="/board/Bedit"
		method="post">
		<div align="center">
			<table width="100%">
				<tr>
					<td align="right" style="padding-right: 10px;">게시판</td>
					<td><select name="menu">
							<%
								if (menu.equals("1")) {
							%>
							<option value="1">여행 가요</option>
							<option value="2">여행 후기</option>
							<option value="3">Q&N</option>
							<%
								} else if (menu.equals("2")) {
							%>
							<option value="2">여행 후기</option>
							<option value="1">여행 가요</option>
							<option value="3">Q&N</option>
							<%
								} else {
							%>
							<option value="3">Q&N</option>
							<option value="1">여행 가요</option>
							<option value="2">여행 후기</option>
							<%
								}
							%>
					</select></td>
				</tr>
				<tr>
					<td align="right" style="padding-right: 10px;">내용 유형</td>
					<td><select name="type">
							<option id="type" value="일반">일반</option>
								<c:if test="${sessionScope.auth ne null }">
									<option id="type" value="이벤트">이벤트</option>
									<option id="type" value="공지">공지</option>
								</c:if>
					</select></td>
				</tr>

				<tr>
					<td align="right" style="padding-right: 10px;">기차역</td>
					<td><select name="tab">
							<c:forEach var="i" items="${station }">
								<option value="${i.NAME }">${i.NAME }</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td align="right" style="padding-right: 10px;">제목</td>
					<td><input type="text" id="title" name="title"
						style="width: 650px" value="${read.title }" escapeXml="false"/></td>
				</tr>
				<tr>
					<td align="right" style="padding-right: 10px;">내용</td>
					<td><textarea rows="10" cols="30" id="ir1" class="se2_inputarea" name="context"
							style="width: 650px; height: 350px;" ></textarea></td>
				</tr>
				<tr>
					<td align="right" style="padding-right: 10px;">등록된 사진</td>
					<td style="word-break: break-all;"><c:if
							test="${!empty read.photos }">
							<c:forEach var="photo" items="${read.photos }">
								<img
									src="<%=request.getContextPath() %>/board/${read.writer }/${photo }"
									style="width: 50px; height: 50px;" />
								<button type="button" class="p" value="${photo }">x</button>
							</c:forEach>
						</c:if></td>
				</tr>
				<tr style="margin: 30px;">
					<td align="right" style="padding-right: 10px;">첨부 사진</td>
					<td><input type="file" name="photos" id="p" multiple /></td>
				</tr>
			</table>
			<div align="center">
				<button type="submit" id="edit" onclick="doRemoveTag()">수정</button>
				<button type="submit"
					formaction="/board/main?menu=${read.menu }&page=1">취소</button>
			</div>
			<input type="hidden" name="id" value="${read.id }" />
		</div>
	</form>


</body>
</html>

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
		$("#edit").click(function() {
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

	edit();
		function edit() {
			$(".se2_inputarea").html("${read.context}");
		}
	
		
		$(".p").on("click", function() {
			var del = $(this).val();
			var idd = "${read.id}";
			
				$.post("/board/podel", {
					photos : del,
					id : idd
				}, function(rst) {
					if (rst) {
						alert("사진을 삭제 하였습니다.");
						location.replace("/board/bedit?id=${read.id}&menu=${read.menu}");
					}else{
						alert("삭제를 실패 하였습니다.");
						location.reload();
					}

				})
		});
	
	
</script>
<script>

function removeTag( html ) {
	return html.replace(/(<([^>]+)>)/gi, "");
}

function doRemoveTag() {
	var beforeText1 = $("#title").val();
	var beforeText2 = $("#ir1").val();
	var afterText1 = removeTag( beforeText1 );
	var afterText2 = removeTag( beforeText2 );
	$("#title").val( afterText1 );
	$("#ir1").val( afterText2 );
}

</script>