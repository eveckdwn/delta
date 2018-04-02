<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<div>
		<h2>Warning Are You Administrator?</h2>
		<hr />
		<div>
			<p>
				관리자만 이용하실 수 있습니다. <br />관리자가 아니시라면 <a href="/">&lt;여기&gt;</a>를
				눌러주세요.
			</p>
			<form method="post">
				<input type="password" placeholder="비밀번호를 입력해주세요." name="pass"/>
				<button type="submit">확인</button>
			</form>
		</div>
	</div>
