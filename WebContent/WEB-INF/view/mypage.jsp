<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<title>SPRING - by git</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<h2>
		<c:out value="${user.NICK }" />
		's PAGE
	</h2>
	<hr />

	<form method="post" enctype="multipart/form-data" action="/updateUser">

		<div align="center">
			<p>
				<c:if test="${!empty err }">
					<p style="color: red">${err }</p>
				</c:if>
				<c:if test="${!empty succ }">
					<p>
					<h4 style="color: blue">
						<b>${succ }</b>
					</h4>
			</p>
			</c:if>
			</p>
			<p>
				<c:if test="${user.PHOTO != null }">
					<img
						src="<%=request.getContextPath() %>/photo/${user.ID }/${user.PHOTO }"
						style="width: 200px; height: 200px; border-radius: 50%;"
						id="preview" onclick="document.getElementById('profile').click();" />
				</c:if>
				<c:if test="${user.PHOTO == null }">
					<img src="<%=request.getContextPath()%>/photo/default.jpg"
						style="width: 200px; height: 200px; border-radius: 50%;"
						id="preview" onclick="document.getElementById('profile').click();" />
				</c:if>
			</p>
			<p>
				<c:if test="${!empty ban }">
					<a style="color: red">제재 기간이 <b>${ban }</b>일 남았습니다.<br/>
					제재 기간동안에는 해당 서비스를 이용하실 수 없습니다.<br/>
					<fmt:formatDate var="d" value="${user.BAN}" pattern="yyyy년 MM월 dd일"/>
					제재가 풀리는 날은 <b>${d }</b> 입니다.
					</a>
				</c:if>
			</p>
			<p>
				<input type="file" name="photo" placeholder="변경할 사진" id="profile"
					style="display: none" />
			</p>
			<table style="width: 400px; height: 300px; margin-bottom: 10px;"
				border="2px">
				<tr>
					<td align="center"><b>ID</b></td>
					<td><c:out value="${user.ID }" /></td>
				</tr>
				<tr>
					<td align="center"><b>PASSWORD</b></td>
					<td><input style="width: 230px" type="password" name="pass"
						placeholder="변경 할 비밀번호를 입력하세요." /></td>
				</tr>
				<tr>
					<td align="center"><b>NICK</b></td>
					<td><input style="width: 230px" name="nick"
						placeholder="${user.NICK }" /></td>
				</tr>
				<tr>
					<td align="center"><b>E-MAIL</b></td>
					<td><input style="width: 230px" name="email"
						placeholder="${user.EMAIL }" /></td>
				</tr>
				<tr>
					<td align="center"><b>LV</b></td>
					<td><c:out value="${user.LV }" /></td>
				</tr>
				<tr>
					<td align="center"><b>LAST LOG</b></td>
					<td><c:out value="${user.LASTLOG }" /></td>
				</tr>
				<tr>
					<td align="center"><b>BAN</b></td>
					<td><c:out value="${user.BAN }" /></td>
				</tr>
				<tr>
					<td align="center"><b>FOUL</b></td>
					<td><c:out value="${user.FOUL }" /></td>
				</tr>
			</table>
			<div>
				<c:if test="${user.LV == 0 }">
					<small style="color: red">이메일 인증을 받아야 다양한 서비스를 이용할 수 있습니다.</small>
				</c:if>
				<c:if test="${user.LV == 1 }">
					<small style="color: blue">이메일 인증을 받은 사용자입니다. 다양한 서비스를 이용할
						수 있습니다.</small>
				</c:if>
			</div>
			<div>
				<c:if test="${!empty er }">
					<b><small style="color: red">${er }</small></b>
				</c:if>
			</div>
			<p>
				<button type="submit">프로필 수정</button>
				<c:if test="${user.LV == 0 }">
					<button type="submit" formaction="/emailConfirm" name="email"
						value="${user.EMAIL }">이메일 인증</button>
				</c:if>
			</p>
		</div>
	</form>
</body>
</html>

<script>
	document.getElementById("profile").onchange = function() {
		console.log(this.files[0]);
		if (!this.files[0].type.startsWith("image")) {
			window.alert("jpg, gif, bmp, tif, png 형식의 파일만 첨부하실 수 있습니다.");
			this.value = "";
			return;
		}
		var reader = new FileReader();
		reader.onload = function() {
			console.log(reader);
			document.getElementById("preview").src = this.result;
		}
		reader.readAsDataURL(this.files[0]);
	}
</script>