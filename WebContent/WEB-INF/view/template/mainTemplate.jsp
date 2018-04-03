<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<title><tiles:getAsString name="title" /></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
/* Set height of the grid so .sidenav can be 100% (adjust if needed) */
.row.content {
	height: 650px;
}

/* Set gray background color and 100% height */
.sidenav {
	background-color: #f1f1f1;
	height: 100%;
	border-radius : .5em;
}

/* Set black background color, white text and some padding */
footer {
	background-color: #555;
	color: white;
	padding: 15px;
}

/* On small screens, set height to 'auto' for sidenav and grid */
@media screen and (max-width: 20%) {
	.sidenav {
		height: auto;
		padding: 15px;
	}
	.row.content {
		height: auto;
	}
}
</style>
</head>
<body>
	<header class="container-fluid">
		<tiles:insertAttribute name="menu" />
	</header>
	<div class="container-fluid">
		<div class="row content">
			<div class="col-sm-12">
				<tiles:insertAttribute name="main" />
			</div>
		</div>
	</div>
	<footer class="container-fluid" style="text-align:right;">
		<h2>TOGETHER TEAM</h2>
		KG ITbank 자바 언어 기반 웹 개발자 과정 최종 프로젝트<br/>
		mail : ncs13master@gmail.com<br/>
		ⓒ 2018 Together Team : 김성헌, 문지범, 손창주, 이승휴 All Rights Reserved.
	</footer>
</body>
</html>


