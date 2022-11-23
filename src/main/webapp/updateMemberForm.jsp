<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>개인정보 수정</h1>
	<%
		if(request.getParameter("msg2") != null) {
	%>
		<div><%=request.getParameter("msg2") %></div>
	<%
		}
	%>
	<form action="<%=request.getContextPath()%>/updateMemberAction.jsp" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="memberId"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="memberPw"></td>
			</tr>
			<tr>
				<td>변경할 이름</td>
				<td><input type="text" name="memberName"></td>
			</tr>
		</table>
		<button type="submit">개인정보 수정</button>
	</form>
</body>
</html>