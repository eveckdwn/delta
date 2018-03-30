<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type='text/css'>
	#slidebox {
		position:relative;
		width:480px;
		height:270px;
		overflow:hidden;
		white-space:nowrap;
		border:1px solid #000;
	}
	#slidebox ul#slider {
		list-style:none;
		margin:0;
		padding:0;
	}
	#slidebox ul li {
		position:absolute;
		width:480px;
		height:270px;
	}
	#slidebox ul li img {
		width:480px;
		height:270px;
	}
</style>

<html>
<head>
<c:forEach var="i" items="${read }">
	<title>${i.title }</title>
</c:forEach>
</head>
<body>
	<div
		style="border-top: 1px groove; border-bottom: 1px groove; border-left: 1px groove; border-right: 1px groove; padding: 10px;">
		<c:forEach var="i" items="${read }">
			<b>${i.title }</b>
			<hr style="color: #E6E6E6;">
			<p align="right">조회수(${i.readnum }) | ${i.wdate }</p>

			<c:if test="${!empty i.photos }">
				<div id="slidebox">
					<ul id="slider">
						<c:forEach var="photo" items="${i.photos }">
							<li>
							<img
								src="<%=request.getContextPath() %>/board/${i.writer }/${photo }" />
							</li>
						</c:forEach>
					</ul>
				</div>
				<small style="color: #848484">[사진이 여러개 일경우 클릭하면 다음 사진으로 넘어갑니다.]</small>
			</c:if>
			<p>${i.context }</p>
			<p align="right">이 작성자의 게시글 더보기</p>
			<hr style="color: #E6E6E6;" width="190px" align="right">
			<p align="center">
				<button style="width: 100px; height: 100px">
					<img src="/image/like2.jpg" style="width: 100%; height: 100%"
						align="top">${i.like }</button>
			</p>
			<p>
				<b><a style="color: #FE642E;">댓글()</a></b>
			</p>
		</c:forEach>
		<div style="background-color: #E6E6E6;">
			으아
			<hr style="color: #E6E6E6;">
		</div>
	</div>
	<p align="right">
		<c:if test="${sessionScope.logon }">
			<input type="button" value="수정하기"
				onclick="location.href='/board/change?no=3';" />
		</c:if>
	</p>

	<div>
		<textarea rows="10" cols="100" style="width: 100%;"></textarea>
	</div>

</body>
</html>

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



