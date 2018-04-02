<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h4>Welcome to Together</h4>
<hr />
<ul class="nav nav-pills nav-stacked">
	<li class="dropdown"><a class="dropdown-toggle"
		data-toggle="dropdown" href="#">데이터 관리 <span class="caret"></span></a>
		<ul class="dropdown-menu">
			<li class="dropdown-header">- 기차역 관리하기 -</li>
			<li><a href="/admin/station_manage">기차역 조회 및 수정</a></li>
			<li><a href="/admin/station_add">기차역 추가하기</a></li>
			<li class="dropdown-header">- 여행지 관리하기 -</li>
			<li><a href="/admin/travel_manage?page=1">여행지 조회 및 수정</a></li>
			<li><a href="/admin/travel_add">여행지 추가하기</a></li>
		</ul></li>
	<li><a href="/admin/users">회원 관리</a></li>
</ul>
