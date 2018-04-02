<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<h2>WELCOME TO SPRING</h2>
	<hr/>
	<c:out value="${sessionScope.logon }"/>님 어서오세요.
