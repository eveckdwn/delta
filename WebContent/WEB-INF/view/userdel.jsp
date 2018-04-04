<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<div align="center">
	<h3>회 원 탈 퇴</h3>
	<hr />
	<table style="width: 60%; height: 20%;" border="1">
		<tr>
			<td>아이디</td>
			<td><input type="text" class="id"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" class="pass"></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input type="email" class="email"></td>
		</tr>
	</table>
	<div style="margin-top: 30px;">
		<button type="submit" onclick="del();">회원탈퇴</button>
	</div>
</div>
<script>
	function del() {

		var agree = confirm("회원탈퇴를 진행 하시겠습니까?");
		if (agree) {
			var idd = $(".id").val();
			var pa = $(".pass").val();
			var e = $(".email").val();

			$.post("/userDel", {
				id : idd,
				pass : pa,
				email : e
			}, function(rst) {
				if (rst) {
					alert("회원탈퇴가 완료 되었습니다.");
					opener.parent.location="/";
					window.close();
				} else {
					alert("정보가 틀렸습니다. 다시 진행 해주세요.");
					opener.parent.location="/";
					window.close();
				}
			})
		} else {
			opener.location.reload();
			window.close();
		}
	};
</script>
