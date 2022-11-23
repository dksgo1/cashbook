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
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 1) 
	Member insertMember = new Member();
	insertMember.setMemberId(request.getParameter("memberId"));
	insertMember.setMemberPw(request.getParameter("memberPw"));
	insertMember.setMemberName(request.getParameter("memberName"));
	//System.out.println("memberId");
	//System.out.println("memberPw");
	//System.out.println("memberName");
	
	
	// 2)
	// 분리된M(모델)을 호출
	MemberDao memberDao = new MemberDao();
	
	int resultRow = memberDao.insertMember(insertMember);
	
	if(resultRow == 1) {
		//System.out.println("회원가입 성공");
		String msg = URLEncoder.encode("회원가입이 성공적으로 완료되었습니다 다시 로그인 해주세요", "utf8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
	} else {
		//System.out.println("회원가입 실패");
	}
	
	
%>	
	