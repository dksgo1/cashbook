<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.sql.*" %>
<%
	// 1) C
	if(session.getAttribute("loginMember") == null) {
	// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// Controller : session, request
	//session에 지정된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");

	String memberId = request.getParameter("memberId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/header.jsp"></jsp:include>
	</div>
	<h1>문의글 등록게시판</h1>
	<form action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post">
		<table border="1">
			<tr>
				<td>memberId</td>
				<td><input type="text" name="memberId" value="<%=memberId%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>helpMemo</td>
				<td><textarea rows="5" cols="100" name="helpMemo"></textarea></td>
			</tr>
		</table>
		<button type="submit">등록</button>
	</form>
</body>
</html>