<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	//1) C
	request.setCharacterEncoding("UTF-8"); // 인코딩
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String memberId = request.getParameter("memberId");
	
	// 2) Model 호출
	MemberDao memberDao = new MemberDao();
	int row = memberDao.deleteMemberByactin(memberId);
	
	if(row == 1) {
		System.out.println("강제탈퇴 성공");
	} else {
		System.out.println("강제탈퇴 실패");
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>