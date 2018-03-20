<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h4>Welcome to Spring</h4>
<hr/>
<ul class="nav nav-pills nav-stacked">
  <li class="dropdown">
    <a class="dropdown-toggle" data-toggle="dropdown" href="#">데이터 관리
    <span class="caret"></span></a>
    <ul class="dropdown-menu">
      <li><a href="/admin/station">기차역 관리</a></li>
      <li><a href="/admin/travel">여행지 관리</a></li>
    </ul>
  </li>
  <li><a href="/admin/user">회원 관리</a></li>
</ul>
<br>
<div class="input-group">
	<input type="text" class="form-control" placeholder="Search Blog..">
	<span class="input-group-btn">
		<button class="btn btn-default" type="button">
			<span class="glyphicon glyphicon-search"></span>
		</button>
	</span>
</div>
