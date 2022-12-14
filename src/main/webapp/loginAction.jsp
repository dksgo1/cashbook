<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="util.*" %>
<%@ page import="java.net.*" %>
<%
	request.setCharacterEncoding("utf-8");
	// 안전장치
	if(request.getParameter("memberId")== null || request.getParameter("memberPw")== null || request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("")){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// C
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	System.out.println(memberId);
	
	
	
	Member paramMember = new Member(); // 모델 호출시 매개값
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	System.out.println(paramMember.getMemberId());
	
	// 분리된M(모델)을 호출
	MemberDao memberDao = new MemberDao();
	Member resultMember = memberDao.login(paramMember);	

	
	String redirectUrl = "/loginForm.jsp";
	

	if(resultMember != null && resultMember.getMemberNo() !=0) {
		System.out.println("로그인 성공");
		session.setAttribute("loginMember", resultMember);	// session 안에 로그인ID, 이름 저장
		redirectUrl = "/cash/cashList.jsp";
	} 
	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
