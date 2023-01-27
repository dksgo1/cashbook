<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	//1)
	request.setCharacterEncoding("UTF-8"); // 인코딩
	
	if(session.getAttribute("loginMember") == null) { // 로그인 안됐으면 로그인 폼으로 돌려보내기	
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	// 2) Model 호출
	MemberDao memberDao = new MemberDao();
	int row = memberDao.deleteMember(memberId, memberPw);
	
	if(row != 1) {
		System.out.println("탈퇴실패");
	} else {
		System.out.println("탈퇴성공");
		response.sendRedirect(request.getContextPath()+"/logout.jsp");
		return;
	}
	
%>