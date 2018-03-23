<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<c:forEach items="${msgs}" var="msg">
    <tr>
    	<td>${msg.MNICK}</td> <!-- 여기도 프로필 띄우기 -->
        <td>${msg.CONTEXT}</td> <!-- 최대 길이 정해줘야됨. 나머지는 ...으로 표현. 새 창으로? 팝업으로? 띄우게 링크 넣어줘야됨-->
        <td>${msg.MDATE}</td>
        <td>${msg.STATUS}</td> <!-- status에 따라 폰트색 -->
    </tr>
</c:forEach>
</body>
</html>