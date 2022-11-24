<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8"); // 인코딩
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertMemberForm</title>
</head>
<body>
	<h1>회원가입</h1>
	<form action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" name="memberId">
					<button type="submit">중복확인</button>
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="memberPw"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="memberName"></td>
			</tr>
		</table>
		<button type="submit">회원가입 완료</button>
	</form>
</body>
</html>