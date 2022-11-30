<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "vo.*" %>
<%

	if(session.getAttribute("loginMember") == null) {
	// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	// Controller : session, request
	//session에 지정된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	String memberId = loginMember.getMemberId();
%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Regal Admin</title>
	<!-- base:css -->
	<link rel="stylesheet" href="regal/vendors/mdi/css/materialdesignicons.min.css">
	<link rel="stylesheet" href="regal/vendors/feather/feather.css">
	<link rel="stylesheet" href="regal/vendors/base/vendor.bundle.base.css">
	<!-- endinject -->
	<!-- plugin css for this page -->
	<!-- End plugin css for this page -->
	<!-- inject:css -->
	<link rel="stylesheet" href="regal/css/style.css">
<title>updateMemberForm</title>
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
				<td><input type="text" name="memberId" value="<%=memberId%>" readonly="readonly"></td>
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