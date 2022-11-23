<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %> 
<%
	//C
	if(session.getAttribute("loginMember") == null) {
	// 로그인 되지 않은 상태
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>가계부 수정</h1>
	<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post">
		<table>
			<tr>
				<td>categoryKind</td>
				<td><input type="text" name="categoryKind"></td>
			</tr>
			<tr>
				<td>categoryName</td>
				<td><input type="text" name="categoryName"></td>
			</tr>
			<tr>
				<td>cashPrice</td>
				<td><input type="number" name="cashPrice"></td>
			</tr>
			<tr>
				<td>cashMemo</td>
				<td><textarea rows="3" cols="50" name="cahsMemo"></textarea></td>
			</tr>
		</table>
		<button type="submit">가계부 수정</button>
	</form>
</body>
</html>