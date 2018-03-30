<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%
	long time = System.currentTimeMillis();
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

	String str = dayTime.format(new Date(time));
%>
<html>
<head>
<title>글쓰기</title>

<c:if test="${find ne null }">
	<script>
		
	</script>
</c:if>
<!-- SmartEditor를 사용하기 위해서 다음 js파일을 추가 (경로 확인) -->
<script type="text/javascript" src="/SE2/js/service/HuskyEZCreator.js"
	charset="utf-8"></script>
<!-- jQuery를 사용하기위해 jQuery라이브러리 추가 -->
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.9.0.min.js"></script>
</head>
<body>
	<form id="frm" method="post">
		<div align="center">
			<table width="50%">
				<tr>
					<td>내용 유형</td>
					<td><select name="type">
							<option id="type" value="일반">일반</option>
							<option id="type" value="이벤트">이벤트</option>
							<option id="type" value="공지">공지</option>
					</select></td>
				</tr>
				<tr>
					<td>기차역</td>
					<td><select name="tab">
							<c:forEach var="i" items="${station }">
								<option value="${i.NAME }">${i.NAME }</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" id="title" name="title"
						style="width: 650px" /></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea rows="10" cols="30" id="ir1" name="context"
							style="width: 650px; height: 350px;"></textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="hidden"
						name="page" value="1" />
						<button type="submit" id="save">저장</button>
						<button type="button">취소</button></td>
				</tr>
			</table>
			<input type="hidden" name="writer" value="${sessionScope.logon }" />
			<input type="hidden" name="readnum" value="0" /> <input
				type="hidden" name="like" value="0" /> <input type="hidden"
				name="wdate" value="<%=str%>" />
				<input type="hidden" name="nick" value="${sessionScope.logonNick }" />
				<input type="hidden" name="type" value="${type }" />
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
		$("#save").click(function() {
			oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
			$("#frm").submit();

		});

	});
</script>
