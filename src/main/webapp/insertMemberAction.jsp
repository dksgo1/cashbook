<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("utf-8"); // 인코딩

	// 안전장치
	if(request.getParameter("memberId")== null || request.getParameter("memberPw")== null || request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("")){
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
		return;
	}
	
	// 1) Controller
	request.setCharacterEncoding("utf-8"); // 인코딩
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	//System.out.println("memberId");
	//System.out.println("memberPw");
	//System.out.println("memberName");
	
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	member.setMemberName(memberName);
	
	// 2) Model 호출
	MemberDao memberDao = new MemberDao();
	if(memberDao.selectMemberIdCk(memberId)) {
		System.out.println("중복아이디");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
		return;
	}
	int row = memberDao.insertMember(member);
	System.out.println(row + " <-- insertMemberAciton row");
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>	
	