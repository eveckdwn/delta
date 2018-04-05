<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	var cws = new WebSocket("ws://${pageContext.request.serverName}/chat-ws?id=" + ${crid});
	
	function pop(id){
		window.open("/profile?id="+id,"profile","resizable=no,location=no,left=100,top=200,width=350,height=450");
	}
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
			$("#chatMessage").append("[<a onclick=\"pop('"+obj.id+"')\">" + obj.name + "</a>] (" + obj.time + ") : " + obj.message);
	        $("#chatMessage").append("<br />");
	        $("#chatMessage").scrollTop(99999999);
			break;
			
		case "userList" :
			console.log(obj.names);
			for (var i=0; i<obj.names.length; i++) {
				$("#online").append("<a onclick=\"pop('"+obj.ids[i]+"')\">" + obj.names[i] + "</a>");
	        	$("#online").append("<br />");
			}
			break;
		case "userAdd" :
			$("#online").append("<a onclick=\"pop('"+obj.id+"')\">" + obj.name + "</a>");
	        $("#online").append("<br />");
			break;
		case "userDel" :
			$("#online").html($("#online").html().replace("<a onclick=\"pop('"+obj.id+"')\">" + obj.name + "</a><br>", ""));
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
<div class="banner">
	<h2>${crname }</h2>
	<hr />
</div>
<div align="center">
	<div style="width: 80%; min-width: 800px">
		<table class="table table-bordered">
			<colgroup>
				<col width="80%" />
			</colgroup>
			<tr>
				<td><div id="chatMessage"
						style="overflow: auto; height: 500px;"></div></td>
				<td><div id="online" style="overflow: auto; height: 500px;"></div></td>
			</tr>
			<tr>
				<td colspan="2"><div>
						<input type="text" id="message" placeholder="메시지"
							style="width: 100%" />
					</div></td>
			</tr>
		</table>
	</div>
</div>
<script>
	$("#message").keydown(function(event) {
	    if(event.keyCode == 13){
	    	send();
	    }
	});
</script>

