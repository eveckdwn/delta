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

textarea {
	padding: 5px;
	width: 100%;
}

select {
	padding: 10px;
	margin-top: 10px;
	margin-left: 10px
}
</style>
<body>
	<div align="center">
		<div style="width: 980px;">
			<h2>여행지 추가하기</h2>
			<hr />
			<div style="font-size: 17pt; margin-top: 50px;">여행지 정보를 추가하기 위해
				(*) 표시가 있는 모든 항목을 입력해주세요.</div>
			<div>
				<c:if test="${!empty info }">
					<script>
						alert('${info }');
					</script>
				</c:if>
				<form action="/admin/travel_add" method="post"
					style="width: 400px; text-align: left; line-height: 34px;"
					autocomplete="off">
					<div>
						<b>주변 기차역(*)</b> <select name="sname">
							<c:forEach items="${station }" var="s" varStatus="sts">
								<c:choose>
									<c:when test="${sts.first }">
										<option value="${s.NAME }" selected>${s.NAME }</option>
									</c:when>
									<c:otherwise>
										<option value="${s.NAME }">${s.NAME }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>
					<div>
						<b>분류</b> <select name="cate">
							<option value="랜드마크" selected>랜드마크</option>
							<option value="관광지">관광지</option>
							<option value="공원/놀이시설">공원/놀이시설</option>
							<option value="음식점">음식점</option>
						</select>
					</div>
					<div>
						<b>여행지 이름(*)</b><br /> <input type="text" name="tname"
							autofocus="autofocus" />
					</div>
					<div>
						<b>위도(*)</b><br /> <input type="text" name="lat" />
					</div>
					<div>
						<b>경도(*)</b><br /> <input type="text" name="lng" />
					</div>
					<div>
						<b>여행지 주소(*)</b><br /> <input type="text" name="taddr" />
					</div>
					<div>
						<b>관리자</b><br /> <input type="text" name="manager" />
					</div>
					<div>
						<b>여행지 연락처</b>
						<button type="button" onclick="howto()">?</button>
						<br /> <input type="text" name="contact" id="contact" pattern="^\d{2,3}-\d{3,4}-\d{4}$"/><br />
						<span id="howto" style="color: red; display: none">번호만
							입력가능하며, 번호 사이에 하이픈(-)을 꼭 넣어주세요.</span>
					</div>
					<div>
						<b>설명</b><br />
						<textarea name="detail" id="detail" onkeyup='maxLengthCheck("detail", "설명")'></textarea>
						<div id="cnt" align="right">0 / 1000 BYTE</div>
					</div>
					<div>
						<button id="sbt" type="submit" style="width: 100%; height: 30px;">추가</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script>
		function howto() {
			$("#howto").toggle();
		}

		$("#contact").keyup(function(e) {
			//	console.log(e.originalEvent.key);
			var reg = /[^0-9\-]/g;
			if (reg.test($("#contact").val())) {
				$("#howto").css("display", "");
				$("#contact").val().replace($("#contact").val(), "");
			} else {
				var regEx = /\-+/g;
				if (regEx.test($("#contact").val())) {
					$("#howto").css("display", "none");
				} else {
					$("#howto").css("display", "");
				}
			}
		});
		
		/**
		 * 바이트 문자 입력가능 문자수 체크
		 * 
		 * @param id : tag id 
		 * @param title : tag title
		 * @param maxLength : 최대 입력가능 수 (byte)
		 * @returns {Boolean}
		 */
		function maxLengthCheck(id, title){
		     var obj = $("#"+id);
		     var maxLength = obj.attr("maxLength") != null ? obj.attr("maxLength") : 1000;
		     
		     $("#cnt").html(Number(byteCheck(obj)) + " / 1000 BYTE");
		     
		     if(Number(byteCheck(obj)) > Number(maxLength)) {
		         alert(title + "의 입력 가능한 문자수를 초과하였습니다.\n(영문, 숫자, 일반 특수문자 : " + maxLength + " \n/ 한글, 한자, 기타 특수문자 : " + parseInt(maxLength/2, 10) + ").");
		         obj.val(obj.val().substring(0,500));
		         $("#cnt").html(Number(byteCheck(obj)) + " / 1000 BYTE");
		         obj.focus();
		     }
		}
		 
		/**
		 * 바이트수 반환  
		 * 
		 * @param el : tag jquery object
		 * @returns {Number}
		 */
		function byteCheck(el){
		    var codeByte = 0;
		    for (var idx = 0; idx < el.val().length; idx++) {
		        var oneChar = escape(el.val().charAt(idx));
		        if ( oneChar.length == 1 ) {
		            codeByte ++;
		        } else if (oneChar.indexOf("%u") != -1) {
		            codeByte += 2;
		        } else if (oneChar.indexOf("%") != -1) {
		            codeByte ++;
		        }
		    }
		    return codeByte;
		}

	</script>
</body>
</html>
