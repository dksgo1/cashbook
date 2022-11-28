<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %> 
<%@ page import = "java.net.*"%>
<%
	//Controller
	request.setCharacterEncoding("UTF-8"); // 인코딩
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 로그인상태 아니거나 관리자 레벨이 아니면 돌려보내기
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	if(request.getParameter("memberLevel") == null ||
		request.getParameter("memberLevel").equals("")) {
			response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
	}
	
	int memberLevel =Integer.parseInt(request.getParameter("memberLevel"));
	String memberId = request.getParameter("memberId");
	
	// 2 모델 호출
	MemberDao memberDao = new MemberDao();
	int row = memberDao.updateMemberLevel(memberLevel, memberId);
	
	if(row == 1) {
		System.out.println("레벨수정 성공");
	} else {
		System.out.println("레벨수정 실패");
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