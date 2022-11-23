<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="util.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>
<%
	request.setCharacterEncoding("UTF-8"); // 인코딩			
	
	
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	if(request.getParameter("memberPw") == null ||
	request.getParameter("memberPw").equals("")	||	
	request.getParameter("newMemberPw") == null ||
	request.getParameter("newMemberPw").equals("") ||
	request.getParameter("newMemberPw2") == null ||
	request.getParameter("newMemberPw2").equals("")) {
		String msg = URLEncoder.encode("빈칸을 입력해주세요", "utf-8"); 
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msg);
		return;
	} else if(!request.getParameter("newMemberPw").equals(request.getParameter("newMemberPw2"))) {
		String msg = URLEncoder.encode("변경할 비밀번호가 일치하지 않습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msg);
		return;
	}
	String newMemberPw = request.getParameter("newMemberPw");
	Member updateMemberPw = (Member)session.getAttribute("loginMember");
	updateMemberPw.setMemberPw(request.getParameter("memberPw"));
	//session id, pw ,name저장된 상태
	
	
	System.out.println(updateMemberPw.getMemberId());
	System.out.println(updateMemberPw.getMemberPw());
	
	MemberDao memberDao = new MemberDao();
	
	int resultRow = memberDao.updateMemberPw(updateMemberPw, newMemberPw);
	if(resultRow == 0) {
		System.out.println("비밀번호 수정실패");
	} else {
		System.out.println("비밀번호 수정성공");
		String msg = URLEncoder.encode("비밀번호가 성공적으로 수정됐습니다.", "utf-8"); 
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp?msg="+msg);
	}
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