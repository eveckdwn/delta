<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>

<style type='text/css'>
#slidebox {
	position: relative;
	width: 480px;
	height: 270px;
	overflow: hidden;
	white-space: nowrap;
	border: 1px solid #000;
}

#slidebox ul#slider {
	list-style: none;
	margin: 0;
	padding: 0;
}

#slidebox ul li {
	position: absolute;
	width: 480px;
	height: 270px;
}

#slidebox ul li img {
	width: 480px;
	height: 270px;
}
</style>

<%
	Long time = System.currentTimeMillis();
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	String str = dayTime.format(new Date(time));
%>
<div class="banner">
	<c:choose>
		<c:when test="${menu eq  1}">
			<c:if test="${!empty succ }">
				<script>
					alert("${succ}");
				</script>
			</c:if>
			<h2>여행 가요</h2>
		</c:when>
		<c:when test="${menu eq  2}">
			<c:if test="${!empty succ }">
				<script>
					alert("${succ}");
				</script>
			</c:if>
			<h2>여행 후기</h2>
		</c:when>
		<c:otherwise>
			<c:if test="${!empty succ }">
				<script>
					alert("${succ}");
				</script>
			</c:if>
			<h2>Q & A</h2>
		</c:otherwise>
	</c:choose>
	<hr style="border: solid 2px; color: #D8D8D8" />
</div>
<div
	style="border-top: 1px groove; border-bottom: 1px groove; border-left: 1px groove; border-right: 1px groove; padding: 10px;">
	<c:choose>
		<c:when test="${read.type eq '일반' }">
			<b><span style="color: gray">[${read.type}]</span>&nbsp;<span
				style="color: maroon;">[${read.tab}]</span>&nbsp;${read.title }</b>
		</c:when>
		<c:otherwise>
			<b><span style="color: red">[${read.type}]</span>&nbsp;${read.title }</b>
		</c:otherwise>
	</c:choose>
	<hr style="color: #E6E6E6;">
	<p align="right">글쓴이:${read.writer} | 조회수(${read.readnum }) |
		${read.wdate }</p>
	<c:if test="${!empty read.photos }">
		<div id="slidebox">
			<ul id="slider">
				<c:forEach var="photo" items="${read.photos }">
					<li><img
						src="<%=request.getContextPath() %>/board/${read.writer }/${photo }" />
					</li>
				</c:forEach>
			</ul>
		</div>
		<small style="color: #848484">[사진이 여러개 일경우 클릭하면 다음 사진으로
			넘어갑니다.]</small>
	</c:if>
	<p>${read.context }</p>
	<hr style="color: #E6E6E6;" width="190px" align="right">
	<p align="center">
		<button style="width: 100px; height: 100px" onclick="like()">
			<img src="/image/like2.jpg" style="width: 100%; height: 100%"
				align="top">${read.like }</button>
	</p>
	<form method="post">
		<div style="margin-top: 10px;" align="right">
			<c:if test="${sessionScope.logon == read.writer }">
				<input type="hidden" name="id" value="${read.id }" />
				<input type="hidden" name="menu" value="${read.menu }">
				<button type="submit" formaction="/board/bedit">수정</button>
				<button type="submit" formaction="/board/boardDel">삭제</button>
			</c:if>
		</div>
	</form>
	<p>
		<b><a style="color: #FE642E;">댓글(${length })</a></b>
	</p>
</div>
<p align="right">
	<c:if test="${sessionScope.logon} ">
		<input type="button" value="수정하기"
			onclick="location.href='/board/change?no=3';" />
	</c:if>
</p>
<c:choose>
	<c:when test="${sessionScope.logon ne null }">
		<form method="post">
			<table style="width: 700px;">
				<tr style="margin-top: 15px;">
					<td><textarea name="context" cols="70px" rows="4px;"
							style="width: 630px; height: 80px; margin-top: 4px; margin-right: 8px; resize: none;"
							placeholder="내용을 입력해주세요."></textarea></td>
					<td><input type="hidden" name="writer"
						value="${sessionScope.logon }" /> <input type="hidden"
						name="like" value="0" /> <input type="hidden" name="code"
						value="${read.id }" /> <input type="hidden" name="wdate"
						value="<%=str%>" />
						<button type="submit" style="width: 90px; height: 80px">등록</button>
					</td>
				</tr>
			</table>
		</form>
	</c:when>
	<c:otherwise>
		<p>로그인을 하시면 댓글을 입력하실 수 있습니다.</p>
	</c:otherwise>
</c:choose>
<div>
	<table class="table table-striped table-bordered table-hover">
	<colgroup>
		<col width="10%"/>
		<col width=""/>
		<col width="10%"/>
	</colgroup>
	<c:forEach var="i" items="${reply }">
		<tr>
			<td>${i.nick }(${i.writer })</td>
			<td>${i.context }<small>(${i.wdate })</small></td>
			<td><button type="button" id="report" style="width:100%;" onclick="declare(this);">신고하기</button></td>
		</tr>
	</c:forEach>
	</table>
</div>
<script>
function like() {
	if(${sessionScope.logon eq null}){
		alert('좋아요 버튼은 로그인 후 이용하실 수 있습니다.');
	}else{
		$.post("/board/like",{
			lid : "${sessionScope.logon}",
			likeid : "${read.id}"
		},function(rst){
			if(rst){
				alert('좋아요를 눌렀습니다.');
				location.reload();
			}else{
				alert('이미 추천하셨습니다.');
				location.reload();
			}
		});
 	}
}
</script>
<script>
	var x = 480;
	var slider = document.getElementById("slider");
	var slideArray = slider.getElementsByTagName("li");
	var slideMax = slideArray.length - 1;
	var curSlideNo = 0;

	for (i = 0; i <= slideMax; i++) {
		if (i == curSlideNo)
			slideArray[i].style.right = 0;
		else
			slideArray[i].style.right = -x + "px";
	}

	slider.addEventListener('click', function() {
		changeSlide();
	}, false);

	var aniStart = false;
	var next = 1;
	var changeSlide = function() {
		if (aniStart === true)
			return;
		next = curSlideNo + 1;
		if (next > slideMax)
			next = 0;
		aniStart = true;
		sliding();
	}

	function sliding() {
		var curX = parseInt(slideArray[curSlideNo].style.right, 10);
		var nextX = parseInt(slideArray[next].style.right, 10);
		var newCurX = curX + 10;
		var newNextX = nextX + 10;
		if (newCurX >= x) {
			slideArray[curSlideNo].style.right = -x + "px";
			slideArray[next].style.right = 0;
			curSlideNo = curSlideNo + 1;
			if (curSlideNo > slideMax)
				curSlideNo = 0;
			aniStart = false;
			return;
		}
		slideArray[curSlideNo].style.right = newCurX + "px";
		slideArray[next].style.right = newNextX + "px";
		setTimeout(function() {
			sliding();
		}, 20);
	}
</script>
<script>
function declare(target) {
	if(${sessionScope.logon eq null}) {
		alert("로그인 후 이용하실 수 있습니다.");
	}else{
		var button = $(target);
		var tr = $(button).parent().parent();
		var td = tr.children();
		var tdcontent = ($(td[0]).html());
		var id = tdcontent.substring(tdcontent.indexOf("(")+1,tdcontent.indexOf(")"));
		$.post("/board/report",{
			rid : "${sessionScope.logon}",
			reid : id,
			objectid : "${read.id}"
		},function(rst){
			if(rst){
				alert(id + "님이 신고 되었습니다.");
				location.reload();
			}else{
				alert("신고에 실패했습니다. 중복 신고를 하실 수 없습니다.");
				location.reload();
			}
		});
	} 
	
}
</script>