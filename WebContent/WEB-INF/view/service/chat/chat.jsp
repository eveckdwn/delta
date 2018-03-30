<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${crname }</title>
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	var cws = new WebSocket("ws://${pageContext.request.serverName}/chat-ws?id=" + ${crid});
	// 연결이 됬을때. 
	cws.onopen = function() {
		$("#chatMessage").append("서버 연결 성공");
        $("#chatMessage").append("<br />");
        $("#chatMessage").scrollTop(99999999);
	}
	// 메시지가 들어올때. 
	cws.onmessage = function(resp) {
		var obj = JSON.parse(resp.data);
		switch (obj.type) {
		case "message" :
			$("#chatMessage").append("[" + obj.name + "] (" + obj.time + ") : " + obj.message);
	        $("#chatMessage").append("<br />");
	        $("#chatMessage").scrollTop(99999999);
	        //정리 필요. 내 닉네임이면 왼쪽 정렬.. 어떻게 하지
			break;
			
			
		// 그냥 유저 관련된걸 어디 변수에 저장해서 직접 뿌려주는게 더 나은가?
		// 그렇게 하면 근데 계속 업데이트해주는게 되나?
		case "userList" :
			for (var i=0; i<obj.names; i++) {
				$("#online").append(obj.names[i]);
	        	$("#online").append("<br />");
			}
			break;
		case "userAdd" :
			$("#online").append(obj.name);
	        $("#online").append("<br />");
			break;
		case "userDel" :
			// 흐음
			// 그냥 지워준다고 치면 '별빛'이 나가면 실제로 별빛<br/> 으로 닉네임을 지은 애가 사라지면?
			break;
		}
		
	}
	// 연결이 끊길때. 
	cws.onclose = function() {
		$("#chatMessage").append("서버에서 연결이 해제되었습니다.");
        $("#chatMessage").append("<br />");
        $("#chatMessage").scrollTop(99999999);
	}
	
	function send() {
		if( $("#message").val() != "") {
            cws.send($("#message").val());
            $("#message").val("");
        }
	}
	
</script>
</head>
<body>
	<div align="center" style="width: 80%; min-width: 800px">
		<table class="table table-bordered">
			<colgroup>
				<col width="80%" />
				<col width="" />
			</colgroup>
			<tr>
				<td><div id="chatMessage" style="overflow:auto; height: 500px;"></div></td>
				<td><div id="online" style="overflow:auto; height: 500px;"></div></td>
			</tr>
			<tr>
				<td colspan="2"><div>
						<input type="text" id="message" placeholder="메시지"
							style="width: 100%" />
					</div></td>
			</tr>
		</table>
	</div>
	<script>
	$("#message").keydown(function(event) {
	    if(event.keyCode == 13){
	    	send();
	    }
	});
	</script>
</body>
</html>

