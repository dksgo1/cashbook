<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("UTF-8"); // 인코딩
	
	if(session.getAttribute("loginMember") == null) {
	// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	// 1)
	Member updateMember = new Member();
	updateMember.setMemberId(request.getParameter("memberId"));
	updateMember.setMemberPw(request.getParameter("memberPw"));
	updateMember.setMemberName(request.getParameter("memberName"));
	

	//System.out.println("memberId");
	//System.out.println("memberPw");
	//System.out.println("memberName");
	
	// 2)
	MemberDao memberDao = new MemberDao();
	
	int resultRow = memberDao.updateMember(updateMember);
	System.out.println(resultRow);
	
	if(resultRow == 1) {
		System.out.println("개인정보 수정 성공");
		String msg = URLEncoder.encode("개인정보가 수정되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp?msg="+msg);
	} else {
		System.out.println("개인정보 수정 실패");
		String msg2 = URLEncoder.encode("아이디 또는 비밀번호가 일치하지 않습니다 다시 시도해주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg2="+msg2);
	}
	
%>