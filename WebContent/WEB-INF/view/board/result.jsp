<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<html>
<head>
<title>결과</title>
</head>
<body>

<%String number = request.getParameter("id");

	response.sendRedirect("/board/read?id="+number);
%>

</body>
</html>