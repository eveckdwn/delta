<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<div align="center">
	<h3>쪽 지 보 내 기</h3>
	<hr />
</div>
<c:if test="${!empty err }">
	<p style="color: red">${err }</p>

</c:if>
<form style="width: 330px; text-align: left; line-height: 34px;">
	<p>
		<b>받는 사람</b> <input type="text" id="t1" name="receiver"/>
	</p>
	<p>
		<textarea id="ta1" name="content" style="width: 500px; height: 300px;"></textarea>
		<!-- 키보드 입력시?내용 바뀔시? 계속 크기 가져와서 써줘야됨 -->
	</p>
	<p>
		<button id="sbt" type="button" onclick="send();">보내기</button>
	</p>
</form>
<script>
	function send(){
		var re = $("#t1").val();
		console.log($("#t1").val());
		var con = $("#ta1").val();
		
		$.post("/message/msend",{
			receiver : re,
			content : con			
		},function(rst){
			if(rst){
				alert("쪽지를 보냈습니다.");
				location.replace("/message/box");
			}else{
				alert("전송을 실패하였습니다.");
				location.reload();
			}
		})
	}

</script>