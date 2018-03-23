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
보낸 사람 : ${msg.MNICK }<br/> <!-- 프로필 띄울수 있게 만들어줘야됨 -->
보낸 시간 : ${msg.MDATE }<br/>
내용 : ${msg.CONTEXT }<br/>
</body>
</html>