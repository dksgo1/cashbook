<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	// 1) C
	
	request.setCharacterEncoding("UTF-8"); // 인코딩
	if(session.getAttribute("loginMember") == null) {
	// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// Controller : session, request
	//session에 지정된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// helpMemo가 null이거나 공백일시 helpList로 돌려보내기
	if(request.getParameter("helpMemo") == null ||
		request.getParameter("helpMemo").equals("")) {
			response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
			return;
	}
	
	String memberId = request.getParameter("memberId");
	String helpMemo = request.getParameter("helpMemo");
	
	
	// 2) Model 호출
	HelpDao helpDao = new HelpDao();
	int row = helpDao.insertHelpMemo(memberId, helpMemo);
	
	if(row == 1) {
		System.out.println("문의등록 성공");
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
		return;
	} else {
		System.out.println("등록 실패");
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