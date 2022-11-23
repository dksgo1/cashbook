<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인이 되어 있을때는 접근불가
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");		
		return;
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginFrom</title>
</head>
<body>
	<h1>로그인</h1>
	<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
		<div>
			ID:
			<input type="text" name="memberId">
		</div>
		<div>
			PW:
			<input type="password" name="memberPw">
		</div>
		<button type="submit">로그인</button>
		<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
		<%
			if(request.getParameter("msg") != null) {
		%>
				<div><%=request.getParameter("msg") %></div>
		<%
			}
		%>
	</form>	
</body>
</html>