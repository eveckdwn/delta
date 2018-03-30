<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="/">WebSiteName</a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a href="/">Home</a></li>
      <li><a href="/travel/station?page=1">여행 정보</a></li>
      <li class="dropdown">
        <a class="dropdown-toggle" data-toggle="dropdown" href="#">여행모임
        <span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="#">여행 가요</a></li>
          <li><a href="#">여행 후기</a></li>
        </ul>
      </li>
      <li><a href="/chat">여행 후기</a></li>
      <li><a href="/board/main?page=1">여행 Q&A</a></li>
    </ul>
  </div>
</nav>